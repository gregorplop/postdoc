#tag Class
Protected Class pdsession
	#tag Method, Flags = &h0
		Function connect() As pdOutcome
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(serviceToken as pdservicetoken , appName as string)
		  // the developer needs to set the app name
		  
		  if serviceToken = nil then
		    System.DebugLog("postdoc session in " + appName + " : invalid service token")
		    exit sub // nothing is initialized
		  end if
		  
		  
		  // initialize the PostgreSQL NOTIFY queue poll timer
		  pgQueuePoll = new Timer
		  pgQueuePoll.Mode = timer.ModeOff
		  pgQueuePoll.Period = 500
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
		  
		  activeServiceToken = serviceToken
		  connected = false
		  
		  
		End Sub
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
		  
		  dim data as RecordSet = pgsession.SQLSelect("SELECT NOW()::TIMESTAMP WITHOUT TIME ZONE")
		  if pgsession.Error = true then 
		    Return new date
		  else
		    return data.IdxField(1).DateValue
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pgPID() As string
		  dim data as RecordSet = pgsession.SQLSelect("SELECT pg_backend_pid()")
		  if pgsession.Error = true then
		    return empty
		  else
		    return data.IdxField(1).StringValue
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub pgQueuePoll_Action(sender as Timer)
		  pgsession.CheckForNotifications
		  
		  ServiceCheckCounter = ServiceCheckCounter + 1
		  if ServiceCheckCounter = 200 then 
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
		Private connected As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pgQueuePoll As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pgsession As PostgreSQLDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ServiceCheckCounter As Integer = 0
	#tag EndProperty


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
			Name="pgsession"
			Group="Behavior"
			Type="Integer"
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
