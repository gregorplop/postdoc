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

	#tag Method, Flags = &h1
		Protected Sub buildChannelNames()
		  channel_public = activeServiceToken.database.Lowercase + "_" + "public"
		  channel_private = activeServiceToken.database.Lowercase + "_" + lastPID
		  channel_service = activeServiceToken.database.Lowercase + "_" + "service"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function connect() As pdOutcome
		  if activeServiceToken = nil then return new pdOutcome(CurrentMethodName + ": Service token is invalid")
		  if pgsession = nil then return new pdOutcome(CurrentMethodName + ": Session has not been initialized properly")
		  if pgsession.AppName.Trim = empty then return new pdOutcome(CurrentMethodName + ": postdoc application name not defined")
		  if pdapp = empty then return new pdOutcome(CurrentMethodName + ": Application name cannot be empty")
		  
		  dim postConnectActions(-1) as string
		  dim outcome as pdOutcome
		  
		  // connect failed
		  if pgsession.Connect = False then  Return new pdOutcome(CurrentMethodName + ": Error opening postdoc session to " + pgsession.DatabaseName + " : " + pgsession.ErrorMessage)
		  
		  // connect success
		  connected = true
		  dim success as new pdOutcome(true)
		  success.returnObject = pgPID
		  
		  if success.returnObject.StringValue = empty then   // could not get a valid pid , fail
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Session seemingly open but failed to get session PID")
		  end if
		  
		  outcome = validateSession // validate the session
		  if outcome.ok = false then
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Error validating application: " + outcome.fatalErrorMsg)
		  elseif outcome.returnObject.BooleanValue = false then 
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Connected user cannot execute this application")
		  end if
		  
		  outcome = validatePDuser  // validate the postdoc user
		  if outcome.ok = false then
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Error validating postdoc user: " + outcome.fatalErrorMsg)
		  elseif outcome.returnObject.BooleanValue = false then 
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Postdoc user not validated")
		  end if
		  
		  // everything is validated
		  
		  postConnectActions.Append "LISTEN " + activeServiceToken.database.Lowercase + "_" + "public"
		  postConnectActions.Append "LISTEN " + activeServiceToken.database.Lowercase + "_" + success.returnObject.StringValue
		  
		  for i as integer = 0 to postConnectActions.Ubound
		    pgsession.SQLExecute(postConnectActions(i))
		    if pgsession.Error = true then 
		      dim fail as new pdOutcome(CurrentMethodName + ": Error initializing new postdoc session: " + pgsession.ErrorMessage)
		      pgSessionClose
		      return fail
		    end if
		  next i
		  
		  buildChannelNames
		  
		  ServiceVerifyPeriod = pdServiceVerifyPeriod
		  pgQueuePoll.Mode = timer.ModeMultiple
		  sysRequestThread.Run
		  
		  return success
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(serviceToken as pdservicetoken, appName as string, optional pdUsername as string = empty, optional pdPassword as string = empty)
		  // the developer needs to set the app name
		  // also, if applicable, the pdUsername is required. It can be followed by the pdusername password: it has to be pgMD5hash encoded
		  
		  if serviceToken = nil then return
		  
		  // initialize the PostgreSQL NOTIFY queue poll timer
		  pgQueuePoll = new Timer
		  pgQueuePoll.Mode = timer.ModeOff
		  pgQueuePoll.Period = pgQueueRefreshInterval
		  AddHandler pgQueuePoll.Action , WeakAddressOf pgQueuePoll_Action
		  
		  sysRequestThread = new Thread
		  sysRequestThread.Priority = 3  // low-to-average
		  AddHandler sysRequestThread.Run , WeakAddressOf sysRequestDispatcher
		  
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
		  pduser_password = pdPassword.Trim  // it has to be pgMD5hash encoded
		  
		  pgsession.AppName =  "pd//" + appName.Lowercase + "//" + if(pdUsername = empty , pgsession.UserName , pdUsername)
		  
		  activeServiceToken = serviceToken
		  connected = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createRequest(body as JSONItem) As pdOutcome
		  if body.HasName("requesttype") = false then Return new pdOutcome(CurrentMethodName + ": No request type defined")
		  
		  dim uuid as String = pgUUID
		  if uuid = empty then return new pdOutcome(CurrentMethodName + ": Error creating new request id")
		  
		  dim notifyCmd as String = "NOTIFY "
		  dim newRequest as new pdsysrequest
		  
		  newRequest.outcome = nil
		  newRequest.parameters = body
		  newRequest.timeoutPeriod = 60  // Default setting
		  newRequest.timestamp_issued = pgNOW
		  newRequest.uuid = uuid
		  newRequest.pid_requestor = lastPID.Val
		  newRequest.pid_handler = 0
		  newRequest.type = body.Value("requesttype").StringValue.sysRequestFromString
		  
		  // this information is filled in for the receiver, the sender already has it in the objects's properties
		  newRequest.parameters.Value("pid_requestor") = newRequest.pid_requestor
		  newRequest.parameters.Value("uuid") = newRequest.uuid
		  newRequest.parameters.Value("timestamp_issued") = newRequest.timestamp_issued.SQLDateTime
		  
		  // parameter checks
		  select case body.Value("requesttype").StringValue.sysRequestFromString
		    
		  case RequestTypes.ControllerAcknowledge
		    newRequest.ownRequestAwaitingResponse = true
		    if body.HasName("host") = False then return new pdOutcome(CurrentMethodName + ": ControllerAcknowledge request is missing host parameter")
		    if body.Value("host").StringValue.trim = empty then return new pdOutcome(CurrentMethodName + ": ControllerAcknowledge request does not specify host")
		    notifyCmd.Append(channel_service + " , ")
		    
		  else
		    Return new pdOutcome(CurrentMethodName + ": Request type not supported")
		  end select
		  
		  notifyCmd.Append(newRequest.parameters.ToString.sqlQuote)
		  
		  pgsession.SQLExecute(notifyCmd)
		  if pgsession.Error = true then return new pdOutcome(CurrentMethodName + ": Could not send " + body.Value("requesttype").StringValue + " request: " + pgsession.ErrorMessage.pgErrorSingleLine)
		  
		  // we need to keep it until it either receives a response or timeouts
		  if newRequest.ownRequestAwaitingResponse = true then requestQueue.Append newRequest
		  
		  return new pdOutcome(true)
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
		  
		  dim output(-1) as string
		  
		  if pdUser <> empty then
		    dim query as string = "SELECT groups FROM resources.pdusers WHERE name = "
		    query.Append(pdUser.sqlQuote)
		    
		    dim data as RecordSet = pgsession.SQLSelect(query)
		    if pgsession.Error = true then Return new pdOutcome(CurrentMethodName + ": Database error: " + pgsession.ErrorMessage)
		    if data.RecordCount <> 1 then return new pdOutcome(CurrentMethodName + ": User not found")
		    output = data.IdxField(1).StringValue.Split(",")
		  end if
		  
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
		  // fired when a message has arrived from the pg queuing mechanism
		  #If DebugBuild then
		    Print "pdsession: " + "name: " + Name + "  //  ID: " + str(ID) + "   //   extra: " + Extra
		  #Endif
		  
		  if str(ID) = lastPID then return  // own message, ignore
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub pgQueuePoll_Action(sender as Timer)
		  pgsession.CheckForNotifications
		  
		  ServiceCheckCounter = ServiceCheckCounter + 1
		  if ServiceCheckCounter = ServiceVerifyPeriod then
		    ServiceCheckCounter = 0
		    if pgPID = empty then
		      pgSessionClose
		      RaiseEvent ServiceDisconnected
		    end if
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub pgSessionClose()
		  pgQueuePoll.Mode = timer.ModeOff
		  connected = false
		  transactionActive = false
		  pgsession.Close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pgUUID() As String
		  if pgsession = nil or connected = false then return empty
		  dim rs as RecordSet = pgsession.SQLSelect("SELECT resources.gen_random_uuid()")
		  
		  if pgsession.Error = true then 
		    return empty
		  else
		    Return rs.IdxField(1).StringValue
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function rightsOnResource(resourcetype as ResourceTypes, resourceName as string, optional alsoContent as TriState = TriState.DoesntMatter) As pdOutcome
		  // pdOutcome.returnObject is an ORed pdaccesstoken
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub sysRequestDispatcher(sender as Thread)
		  do  // handler/dispatcher main loop
		    
		    
		    if requestQueue.Ubound > -1 then
		      print empty
		      for i as integer = 0 to requestQueue.Ubound
		        print requestQueue(i).uuid + "   :   " + requestQueue(i).type.toString
		      next i
		      print empty
		    end if
		    
		    
		    app.SleepCurrentThread(200)
		  loop until connected = False
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function validatePDuser() As pdOutcome
		  // to be implemented
		  
		  dim success as new pdOutcome(true)
		  success.returnObject = true
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function validateSession() As pdOutcome
		  // to be implemented
		  
		  dim success as new pdOutcome(true)
		  success.returnObject = true
		  return success
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event RequestComplete(request as pdsysrequest)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RequestTimeout(request as pdsysrequest)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event serviceCredentialsRequest(serviceName as string , serviceFriendlyname as string) As pair
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServiceDisconnected()
	#tag EndHook


	#tag Property, Flags = &h1
		Protected activeServiceToken As pdservicetoken
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected channel_private As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected channel_public As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected channel_service As string
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
		Protected pduser_password As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pgQueuePoll As Timer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pgsession As PostgreSQLDatabase
	#tag EndProperty

	#tag Property, Flags = &h0
		requestQueue(-1) As pdsysrequest
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ServiceCheckCounter As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected ServiceVerifyPeriod As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sysRequestThread As Thread
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
