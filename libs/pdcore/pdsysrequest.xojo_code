#tag Class
Protected Class pdsysrequest
	#tag Property, Flags = &h0
		#tag Note
			if true then this request is actually a response to a request with the same uuid
			
		#tag EndNote
		isResponse As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		outcome As pdOutcome
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			if true then it is a request that the client sent out to be handled and it is expecting a response
			
		#tag EndNote
		ownRequest As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		parameters As Dictionary
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
	#tag EndViewBehavior
End Class
#tag EndClass
