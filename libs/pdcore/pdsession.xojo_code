#tag Class
Protected Class pdsession
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
		    
		    connected = true
		    pgQueuePoll.Mode = timer.ModeMultiple
		    
		    return success
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(serviceToken as pdservicetoken , appName as string , optional pdUsername as string = "")
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
		    pgsession.Password = serviceToken.password.fromBase64
		  end if
		  
		  AddHandler pgsession.ReceivedNotification , WeakAddressOf pgsession_ReceivedNotification
		  
		  pdapp = appName.Trim
		  pduser = pdUsername.Trim
		  
		  pgsession.AppName = "postdoc//" + appName + "//" + if(pdUsername = empty , pgsession.UserName , pdUsername)
		  
		  activeServiceToken = serviceToken
		  connected = false
		  
		  
		End Sub
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

	#tag Method, Flags = &h21
		Private Sub pgQueuePoll_Action(sender as Timer)
		  pgsession.CheckForNotifications
		  
		  ServiceCheckCounter = ServiceCheckCounter + 1
		  if ServiceCheckCounter = 200 then // this deterines the service verify period
		    ServiceCheckCounter = 0
		    if pgPID = empty then
		      
		      pgQueuePoll.Mode = timer.ModeOff
		      connected = False
		      RaiseEvent ServiceDisconnected
		      
		    end if
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub pgsession_ReceivedNotification(sender as PostgreSQLDatabase, Name as string, ID as integer, Extra as String)
		  // we're expecting messages from 2 channels here:
		  //  (database name)_public  and  (database name)_(pid number)
		  
		  dim publicChannel as String = activeServiceToken.database.Lowercase + "_" + "public"
		  dim privateChannel as string = activeServiceToken.database.Lowercase + "_" + lastPID
		  
		  //System.DebugLog("name: " + Name + "  //  ID: " + str(ID) + "   //   extra: " + Extra)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event serviceCredentialsRequest(serviceName as string , serviceFriendlyname as string) As pair
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ServiceDisconnected()
	#tag EndHook


	#tag Property, Flags = &h21
		Private activeServiceToken As pdservicetoken
	#tag EndProperty

	#tag Property, Flags = &h21
		Private connected As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastPID As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pdapp As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pduser As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pgQueuePoll As Timer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pgsession As PostgreSQLDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ServiceCheckCounter As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private transactionActive As Boolean = false
	#tag EndProperty


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
