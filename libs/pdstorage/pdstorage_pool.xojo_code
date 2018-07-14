#tag Class
Protected Class pdstorage_pool
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
		autoClose As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		autoExpand As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		comments As string
	#tag EndProperty

	#tag Property, Flags = &h0
		encrypted As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		error As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		errorMessage As string
	#tag EndProperty

	#tag Property, Flags = &h0
		friendlyName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		initStamp As string
	#tag EndProperty

	#tag Property, Flags = &h0
		mediumThreshold As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		name As string
	#tag EndProperty

	#tag Property, Flags = &h0
		password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		rootFolder As FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="autoClose"
			Group="Behavior"
			InitialValue="true"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="autoExpand"
			Group="Behavior"
			InitialValue="true"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="comments"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="encrypted"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="error"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="errorMessage"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="friendlyName"
			Group="Behavior"
			Type="string"
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
			Name="initStamp"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mediumThreshold"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="password"
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
