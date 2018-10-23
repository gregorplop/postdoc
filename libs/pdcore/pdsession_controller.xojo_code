#tag Class
Protected Class pdsession_controller
Inherits pdsession
	#tag Method, Flags = &h0
		Function connect() As pdOutcome
		  dim outcome as pdOutcome = Super.connect
		  if outcome.ok = False then return outcome
		  
		  // dim 
		  // dim data as RecordSet = pgsession.SQLSelect("
		  
		  
		  dim postConnectActions(-1) as string  // extra actions for backend initialization
		  postConnectActions.Append "LISTEN " + activeServiceToken.database.Lowercase + "_" + "service"
		  // more if needed
		  
		  for i as integer = 0 to postConnectActions.Ubound
		    pgsession.SQLExecute(postConnectActions(i))
		    if pgsession.Error = true then 
		      dim fail as new pdOutcome(CurrentMethodName + ": Error initializing new postdoc session: " + pgsession.ErrorMessage)
		      pgsession.Close
		      connected = false
		      return fail
		    end if
		  next i
		  
		  pgQueuePoll.Period = Round(pgQueueRefreshInterval / 2)
		  ServiceVerifyPeriod = ServiceVerifyPeriod * 2
		  
		  //RemoveHandler pgsession.ReceivedNotification , WeakAddressOf pgsession_ReceivedNotification
		  //AddHandler pgsession.ReceivedNotification , WeakAddressOf pgsession_ReceivedNotification
		  
		  return outcome
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub pgQueueHandler(sender as PostgreSQLDatabase, Name as string, ID as integer, Extra as String)
		  // we're expecting messages from 2 channels here:
		  //  (database name)_public  and  (database name)_(pid number)
		  
		  dim publicChannel as String = activeServiceToken.database.Lowercase + "_" + "public"
		  dim privateChannel as string = activeServiceToken.database.Lowercase + "_" + lastPID
		  dim serviceChannel as String = activeServiceToken.database.Lowercase + "_" + "service"
		  
		  //System.DebugLog("name: " + Name + "  //  ID: " + str(ID) + "   //   extra: " + Extra)
		  Print "pdsession: " + "name: " + Name + "  //  ID: " + str(ID) + "   //   extra: " + Extra
		  
		  print Object(me).whatClass
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validateHost()
		  
		End Sub
	#tag EndMethod


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
