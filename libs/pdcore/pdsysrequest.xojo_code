#tag Class
Protected Class pdsysrequest
	#tag Method, Flags = &h0
		Shared Function ControllerAcknowledge(host as String) As JSONItem
		  dim output as new Dictionary
		  
		  output.Value("requesttype") = RequestTypes.ControllerAcknowledge.toString
		  output.Value("host") = host.Trim
		  
		  return output
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ownRequestAwaitingResponse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		parameters As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h0
		pid_handler As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		pid_requestor As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		response_channel As String
	#tag EndProperty

	#tag Property, Flags = &h0
		response_content As String
	#tag EndProperty

	#tag Property, Flags = &h0
		response_errorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		retries As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		timeoutPeriod As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		timestamp_issued As date
	#tag EndProperty

	#tag Property, Flags = &h0
		timestamp_response As date
	#tag EndProperty

	#tag Property, Flags = &h0
		type As RequestTypes
	#tag EndProperty

	#tag Property, Flags = &h0
		uuid As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ownRequestAwaitingResponse"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="timeoutPeriod"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="type"
			Group="Behavior"
			Type="RequestTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - ControllerAcknowledge"
				"1 - Invalid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="uuid"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="pid_handler"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="pid_requestor"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="retries"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="response_content"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="response_errorMessage"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
