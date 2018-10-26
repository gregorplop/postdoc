#tag Class
Protected Class pdsession
	#tag Method, Flags = &h0
		Shared Function accessToken_OR(tokenCollection() as pdaccesstoken, optional applyToContent as Boolean = true) As pdaccesstoken
		  // this method is not sensitive to applytoContent
		  
		  dim output as new pdaccesstoken
		  dim features(-1) as string
		  if tokenCollection.Ubound < 0 then return output // its active = false  to signify no tokens to OR
		  
		  output.active = true
		  
		  output.resourcename = tokenCollection(0).resourcename
		  output.resourcetype = tokenCollection(0).resourcetype
		  
		  for i as Integer = 0 to tokenCollection.Ubound
		    if tokenCollection(i).active = false then Continue for i
		    if tokenCollection(i).applyToContent <> applyToContent then Continue for i
		    
		    if tokenCollection(i).resourcename <> output.resourcename then output.resourcename = empty // resource name is empty if tokens do not refer to the same resource
		    if tokenCollection(i).resourcetype <> output.resourcetype then output.resourcetype = ResourceTypes.Invalid // invalid if collection is not about the same resource type
		    
		    if tokenCollection(i).right_Read = true then output.right_Read = true
		    if tokenCollection(i).right_Create = true then output.right_Create = true
		    if tokenCollection(i).right_Delete = true then output.right_Delete = true
		    if tokenCollection(i).right_Execute = true then output.right_Execute = true
		    if tokenCollection(i).right_Update = true then output.right_Update = true
		    
		    features.Append_ifNotExists(tokenCollection(i).right_Features)
		    
		  next i
		  
		  output.right_Features = features
		  return output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function approveConnection() As pdOutcome
		  // verify pguser , pduser exists
		  // verify application exists
		  // verify pguser/pduser have the right to connect using this application
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function connect() As pdOutcome
		  if activeServiceToken = nil then return new pdOutcome(CurrentMethodName + ": Service token is invalid")
		  if pgsession = nil then return new pdOutcome(CurrentMethodName + ": Session has not been initialized properly")
		  if pgsession.AppName.Trim = empty then return new pdOutcome(CurrentMethodName + ": postdoc application name not defined")
		  
		  dim postConnectActions(-1) as string
		  
		  if pgsession.Connect = False then  // error connecting
		    
		    Return new pdOutcome(CurrentMethodName + ": Error opening postdoc session to " + pgsession.DatabaseName + " : " + pgsession.ErrorMessage)
		    
		  else  // connected
		    connected = true
		    dim success as new pdOutcome(true)
		    success.returnObject = pgPID
		    
		    if success.returnObject.StringValue = empty then return new pdOutcome(CurrentMethodName + ": Session seemingly open but failed to get session PID")
		    
		    postConnectActions.Append "LISTEN " + activeServiceToken.database.Lowercase + "_" + "public"
		    postConnectActions.Append "LISTEN " + activeServiceToken.database.Lowercase + "_" + success.returnObject.StringValue
		    // more if needed
		    
		    for i as integer = 0 to postConnectActions.Ubound
		      pgsession.SQLExecute(postConnectActions(i))
		      System.DebugLog(postConnectActions(i))
		      if pgsession.Error = true then 
		        dim fail as new pdOutcome(CurrentMethodName + ": Error initializing new postdoc session: " + pgsession.ErrorMessage)
		        pgsession.Close
		        connected = false
		        return fail
		      end if
		    next i
		    
		    ServiceVerifyPeriod = pdServiceVerifyPeriod
		    pgQueuePoll.Mode = timer.ModeMultiple
		    
		    return success
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(serviceToken as pdservicetoken, appName as string, optional pdUsername as string = empty)
		  // the developer needs to set the app name
		  // also, if applicable, the pdUsername is required
		  
		  if serviceToken = nil then exit sub
		  
		  // initialize the PostgreSQL NOTIFY queue poll timer
		  pgQueuePoll = new Timer
		  pgQueuePoll.Mode = timer.ModeOff
		  pgQueuePoll.Period = pgQueueRefreshInterval
		  AddHandler pgQueuePoll.Action , WeakAddressOf pgQueuePoll_Action
		  
		  // initialize the PostgreSQL database session
		  // certificates and SSL encryption not supported at this point
		  pgsession = new PostgreSQLDatabase
		  pgsession.MultiThreaded = true
		  pgsession.Host = serviceToken.host
		  pgsession.Port = serviceToken.port
		  pgsession.DatabaseName = serviceToken.database
		  
		  if serviceToken.username = empty then
		    dim outsideCredentials as pair  // left = username , right = password
		    outsideCredentials = RaiseEvent serviceCredentialsRequest(serviceToken.name , serviceToken.friendlyName)
		    pgsession.UserName = outsideCredentials.Left.StringValue
		    pgsession.Password = outsideCredentials.Right.StringValue
		  else
		    pgsession.UserName = serviceToken.username
		    pgsession.Password = serviceToken.password
		  end if
		  
		  AddHandler pgsession.ReceivedNotification , WeakAddressOf pgQueueHandler
		  
		  pdapp = appName.Trim
		  pduser = pdUsername.Trim
		  
		  pgsession.AppName =  "pd//" + appName.Lowercase + "//" + if(pdUsername = empty , pgsession.UserName , pdUsername)
		  
		  activeServiceToken = serviceToken
		  connected = false
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getAccessTokens(ResourceType as ResourceTypes, optional forActiveUser as Boolean = true) As pdOutcome
		  if isConnected = false then return new pdOutcome(CurrentMethodName + ": Session not connected")
		  if inTransaction = true then return new pdOutcome(CurrentMethodName + ": Could not get access tokens at this point: Session in transaction" , 2)
		  dim output(-1) as pdaccesstoken
		  dim token as pdaccesstoken
		  dim data as RecordSet
		  
		  dim tokenNames(-1) as string
		  dim query as String = "SELECT * FROM resources.accesstokens WHERE active = TRUE "
		  
		  if ResourceType <> ResourceTypes.Any or forActiveUser = true then query.Append("WHERE ")
		  
		  if forActiveUser = true then // gather token names for user and groups the user participates in
		    
		    if pduser <> empty then  // we ought to check pduser also
		      
		    end if
		    
		    
		    
		    
		  end if
		  
		  
		  if ResourceType = ResourceTypes.Any and forActiveUser = False then  // just get them all
		    query.Append("ORDER BY resourcetype ASC")
		  ElseIf ResourceType <> ResourceTypes.Any and forActiveUser = false then //get them all for this type
		    query.Append("AND resourcetype = " + ResourceType.toString.sqlQuote)
		  ElseIf ResourceType = ResourceTypes.Any and forActiveUser = true  then // get all tokens for active user
		    
		  ElseIf ResourceType <> ResourceTypes.Any and forActiveUser = true then // get all tokens for this type of resource for active user
		    
		  end if
		  
		  
		  data = pgsession.SQLSelect(query)
		  if pgsession.Error = true then return new pdOutcome(CurrentMethodName + ": Error querying for access tokens: " + pgsession.ErrorMessage.pgErrorSingleLine)
		  
		  while not data.EOF
		    token = new pdaccesstoken
		    
		    token.name = data.Field("name").StringValue
		    token.friendlyname = data.Field("friendlyname").StringValue
		    token.description = data.Field("description").StringValue
		    token.active = data.Field("active").BooleanValue
		    token.resourcetype = data.Field("resourcetype").StringValue.fromString
		    token.resourcename = data.Field("resourcename").StringValue
		    token.right_Create =  data.Field("createnew").BooleanValue
		    token.right_Read = data.Field("read").BooleanValue
		    token.right_Update = data.Field("update").BooleanValue
		    token.right_Delete = data.Field("delete").BooleanValue
		    token.right_Execute = data.Field("execute").BooleanValue
		    token.right_Features = data.Field("features").StringValue.Split(",")
		    token.applyToContent = data.Field("content").BooleanValue
		    token.sysLog = data.Field("syslog").StringValue
		    
		    output.Append token
		    data.MoveNext
		  wend
		  
		  dim success as new pdOutcome(true)
		  success.returnObject = output
		  Return success
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getRightsOnResource(resourcetype as ResourceTypes, resourceName as string) As pdOutcome
		  // for the current pduser/pguser
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function inTransaction() As Boolean
		  Return transactionActive
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isConnected() As Boolean
		  Return connected
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pdGroups(pdUser as string) As pdOutcome
		  // returns string array in returnobject
		  if isConnected = false then return new pdOutcome(CurrentMethodName + ": Session not connected")
		  if inTransaction = true then return new pdOutcome(CurrentMethodName + ": Operation aborted: Session in transaction" , 2)
		  
		  dim query as string = "SELECT groups FROM resources.pdusers WHERE name = "
		  query.Append(pdUser.sqlQuote)
		  
		  dim data as RecordSet = pgsession.SQLSelect(query)
		  if pgsession.Error = true then Return new pdOutcome(CurrentMethodName + ": Database error: " + pgsession.ErrorMessage)
		  if data.RecordCount <> 1 then return new pdOutcome(CurrentMethodName + ": User not found")
		  
		  dim output(-1) as string = data.IdxField(1).StringValue.Split(",")
		  dim success as new pdOutcome(true)
		  success.returnObject = output
		  
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pgGroups(pgUser as string) As pdOutcome
		  // returns string array in returnobject
		  if isConnected = false then return new pdOutcome(CurrentMethodName + ": Session not connected")
		  if inTransaction = true then return new pdOutcome(CurrentMethodName + ": Operation aborted: Session in transaction" , 2)
		  
		  dim query as string = "select rolname from pg_user join pg_auth_members on (pg_user.usesysid = pg_auth_members.member) join pg_roles on (pg_roles.oid = pg_auth_members.roleid)"
		  query.Append(" where pg_user.usename = " + pgUser.sqlQuote)
		  
		  dim data as RecordSet = pgsession.SQLSelect(query)
		  if pgsession.Error = true then Return new pdOutcome(CurrentMethodName + ": Database error: " + pgsession.ErrorMessage)
		  
		  dim output(-1) as string
		  dim success as new pdOutcome(true)
		  while data.EOF = False
		    output.Append data.IdxField(1).StringValue
		    data.MoveNext
		  wend
		  
		  success.returnObject = output
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pgNOW() As date
		  // returns the server current time
		  // if service is unavailable then returns local current time
		  
		  if pgsession = nil or connected = false then return new date
		  
		  dim data as RecordSet = pgsession.SQLSelect("SELECT NOW()::TIMESTAMP WITHOUT TIME ZONE")
		  if pgsession.Error = true then 
		    Return new date  // return local datetime if database is unreachable
		  else
		    return data.IdxField(1).DateValue  // return the server datetime
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pgPID() As string
		  if connected = false or pgsession = nil then return empty
		  dim data as RecordSet = pgsession.SQLSelect("SELECT pg_backend_pid()")
		  if pgsession.Error = true then
		    return empty
		  else
		    lastPID = data.IdxField(1).StringValue
		    return lastPID
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub pgQueueHandler(sender as PostgreSQLDatabase, Name as string, ID as integer, Extra as String)
		  // we're expecting messages from 2 channels here:
		  //  (database name)_public  and  (database name)_(pid number)
		  
		  dim publicChannel as String = activeServiceToken.database.Lowercase + "_" + "public"
		  dim privateChannel as string = activeServiceToken.database.Lowercase + "_" + lastPID
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub pgQueuePoll_Action(sender as Timer)
		  pgsession.CheckForNotifications
		  
		  ServiceCheckCounter = ServiceCheckCounter + 1
		  if ServiceCheckCounter = ServiceVerifyPeriod then
		    ServiceCheckCounter = 0
		    if pgPID = empty then
		      pgQueuePoll.Mode = timer.ModeOff
		      connected = False
		      RaiseEvent ServiceDisconnected
		    end if
		  end if
		  
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event serviceCredentialsRequest(serviceName as string , serviceFriendlyname as string) As pair
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServiceDisconnected()
	#tag EndHook


	#tag Property, Flags = &h0
		activeServiceToken As pdservicetoken
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected connected As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected lastPID As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pdapp As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pduser As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pgQueuePoll As Timer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pgsession As PostgreSQLDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ServiceCheckCounter As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ServiceVerifyPeriod As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected transactionActive As Boolean = false
	#tag EndProperty


	#tag Constant, Name = pdServiceVerifyPeriod, Type = Double, Dynamic = False, Default = \"200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = pgQueueRefreshInterval, Type = Double, Dynamic = False, Default = \"300", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
