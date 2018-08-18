#tag Class
Protected Class pdservicetoken
	#tag Method, Flags = &h21
		Private Sub Constructor(initPassword as string)
		  filePassword = initPassword.Trim.toBase64
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Create() As pdOutcome
		  if file = nil then return new pdOutcome(CurrentMethodName + ": No filename specified")
		  if file.Exists = true then return new pdOutcome(CurrentMethodName + ": File " + file.NativePath + " already exists")
		  if file.Extension <> "pdst" then return new pdOutcome(CurrentMethodName + ": Extension must be .pdst")
		  
		  if name.Trim = empty then return new pdOutcome(CurrentMethodName + ": Name not defined")
		  if name.Trim.InStr(" ") > 0  then return new pdOutcome(CurrentMethodName + ": Name cannot contain a space")
		  if friendlyName.Trim = empty then Return new pdOutcome(CurrentMethodName + ": Friendly name not defined")
		  tokenIssued = now
		  if organization.Trim = empty then return new pdOutcome(CurrentMethodName + ": organization not defined")
		  if host.Trim = empty then return new pdOutcome(CurrentMethodName + ": Host not defined")
		  if host.Trim.InStr(" ") > 0 then return new pdOutcome(CurrentMethodName + ": Host cannot contain a space")
		  if port <= 1024 then return new pdOutcome(CurrentMethodName + ": Invalid port")
		  
		  if password.Trim <> empty and username.Trim = empty then return new pdOutcome(CurrentMethodName  + ": Password is invalid without a username")
		  
		  if ssl_force = true then
		    if ssl_ca.Trim = empty then return new pdOutcome(CurrentMethodName + ": SSL CA not defined")
		    if ssl_key.Trim = empty then return new pdOutcome(CurrentMethodName + ": SSL Key not defined")
		    if ssl_certificate.Trim = empty then return new pdOutcome(CurrentMethodName + ": SSL Certificate not defined")
		  else
		    if ssl_ca.Trim <> empty then return new pdOutcome(CurrentMethodName + ": SSL CA carries content while SSL is disabled")
		    if ssl_key.Trim <> empty then return new pdOutcome(CurrentMethodName + ": SSL Key carries content while SSL is disabled")
		    if ssl_certificate.Trim <> empty then return new pdOutcome(CurrentMethodName + ": SSL Certificate carries content while SSL is disabled")
		  end if
		  
		  sqliteDB = new SQLiteDatabase
		  dim tokenRecord as new DatabaseRecord
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getNew(password as string) As pdservicetoken
		  // password is expected to be plaintext
		  return new pdservicetoken(password)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Open(tokenFile as FolderItem , password as string) As pdservicetoken
		  // password is exptected to be plaintext
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Update() As pdOutcome
		  
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
		filePassword As string
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
		sqliteDB As SQLiteDatabase
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
		tokenIssued As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		username As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="comments"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="description"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="filePassword"
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
			Name="host"
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
			Name="objidx"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="organization"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="password"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="port"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ssl_ca"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ssl_certificate"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ssl_force"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ssl_key"
			Group="Behavior"
			Type="string"
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
		#tag ViewProperty
			Name="username"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
