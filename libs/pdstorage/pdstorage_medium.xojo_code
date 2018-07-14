#tag Class
Protected Class pdstorage_medium
	#tag Method, Flags = &h0
		Sub Constructor(optional initialErrorMessage as string)
		  if initialErrorMessage.Trim = empty then
		    error = False
		    errorMessage = empty
		    
		  else
		    
		    error = true
		    errorMessage = initialErrorMessage
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		error As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		errorMessage As String
	#tag EndProperty

	#tag Property, Flags = &h0
		file As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		folder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		idx As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		initStamp As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		open As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		pool As String
	#tag EndProperty

	#tag Property, Flags = &h0
		threshold As int64
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="error"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="idx"
			Group="Behavior"
			Type="Integer"
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
			Name="open"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="pool"
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
			Name="threshold"
			Group="Behavior"
			Type="int64"
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
