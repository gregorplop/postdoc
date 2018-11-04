#tag Class
Protected Class pdsession_controller
Inherits pdsession
	#tag Method, Flags = &h1
		Protected Sub buildChannelNames()
		  Super.buildChannelNames
		  
		  //channel_service = activeServiceToken.database.Lowercase + "_" + "service"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function connect() As pdOutcome
		  // do what the base class normally does
		  dim SuperOutcome as pdOutcome = Super.connect
		  if SuperOutcome.ok = False then return SuperOutcome
		  
		  // controller validation
		  dim outcome as pdOutcome = validateController
		  if outcome.ok = false then
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Error validating controller: " + outcome.fatalErrorMsg)
		  elseif outcome.returnObject.BooleanValue = false then 
		    pgSessionClose
		    return new pdOutcome(CurrentMethodName + ": Controller not validated")
		  end if
		  
		  // controller-specific post-connect actions
		  dim postConnectActions(-1) as string  // extra actions for backend initialization
		  postConnectActions.Append "LISTEN " + activeServiceToken.database.Lowercase + "_" + "service"
		  
		  for i as integer = 0 to postConnectActions.Ubound
		    pgsession.SQLExecute(postConnectActions(i))
		    if pgsession.Error = true then 
		      dim fail as new pdOutcome(CurrentMethodName + ": Error initializing new postdoc session: " + pgsession.ErrorMessage)
		      pgSessionClose
		      return fail
		    end if
		  next i
		  
		  // some other controller-specific tweaks
		  buildChannelNames
		  pgQueuePoll.Period = Round(pgQueueRefreshInterval / 2)  // refreshes twice as fast
		  ServiceVerifyPeriod = pdServiceVerifyPeriod * 2 // ...but period has to be the same
		  
		  
		  return SuperOutcome
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMasterController() As Boolean
		  Return master
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub pgQueueHandler(sender as PostgreSQLDatabase, Name as string, ID as integer, Extra as String)
		  if str(ID) = lastPID then return  // own message
		  Super.pgQueueHandler(sender , Name , ID , Extra)
		  
		  dim body as new JSONItem
		  try
		    body.Load(Extra)
		  Catch e as JSONException
		    return
		  end try
		  
		  if body.HasName("requesttype") = false then return
		  if body.HasName("pid_requestor") = false then return
		  if body.HasName("uuid") = false then return
		  if body.HasName("timestamp_issued") = false then return
		  
		  dim receivedRequest as new pdsysrequest
		  receivedRequest.ownRequestAwaitingResponse = false
		  receivedRequest.parameters = body
		  receivedRequest.pid_handler = lastPID.val
		  receivedRequest.pid_requestor = body.Value("pid_requestor").IntegerValue
		  receivedRequest.retries = 0
		  receivedRequest.timestamp_issued = body.Value("timestamp_issued").DateValue
		  receivedRequest.uuid = body.Value("uuid").StringValue
		  
		  select case body.Value("requesttype").StringValue.sysRequestFromString
		    
		  case RequestTypes.ControllerAcknowledge
		    if body.HasName("host") = false then return
		    if body.Value("host").StringValue.Uppercase <> getHostname then return
		    receivedRequest.type = RequestTypes.ControllerAcknowledge
		    
		    
		  else
		    return
		  end Select
		  
		  // add a request to be processed by the thread
		  requestQueue.Append receivedRequest
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function validateController() As pdOutcome
		  // to be implemented
		  
		  dim success as new pdOutcome(true)
		  success.returnObject = true
		  return success
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected master As Boolean = false
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
