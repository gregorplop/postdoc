#tag Class
Protected Class pdservicetoken
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getNew() As pdservicetoken
		  return new pdservicetoken
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Open(tokenFile as FolderItem , password as string) As pdservicetoken
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Save() As pdOutcome
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		comments As string
	#tag EndProperty

	#tag Property, Flags = &h0
		description As string
	#tag EndProperty

	#tag Property, Flags = &h0
		file As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		friendlyName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		host As string
	#tag EndProperty

	#tag Property, Flags = &h0
		name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		objidx As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		organization As string
	#tag EndProperty

	#tag Property, Flags = &h0
		password As string
	#tag EndProperty

	#tag Property, Flags = &h0
		port As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ssl_ca As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ssl_certificate As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ssl_force As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ssl_key As string
	#tag EndProperty

	#tag Property, Flags = &h0
		tokenCreated As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		username As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="file"
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
			Name="name"
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
