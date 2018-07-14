#tag Class
Protected Class pdOutcome
	#tag Method, Flags = &h0
		Sub Constructor(okValue as Boolean)
		  if okValue = true then
		    ok = true
		    fatalErrorMsg = empty
		    fatalErrorCode = 0
		  else
		    ok = false
		    fatalErrorMsg = "Undefined error"
		    fatalErrorCode = 1
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(errorMsgValue as string)
		  ok = false
		  fatalErrorMsg = errorMsgValue.Trim
		  fatalErrorCode = 1
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		fatalErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		fatalErrorMsg As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ok As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		returnHandle As String
	#tag EndProperty

	#tag Property, Flags = &h0
		returnObject As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		warnings(-1) As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="fatalErrorCode"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="fatalErrorMsg"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="ok"
			Group="Behavior"
			InitialValue="false"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="returnHandle"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
