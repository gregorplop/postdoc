#tag Class
Protected Class pdservicetoken
	#tag Method, Flags = &h21
		Private Sub Constructor(initPassword as string)
		  // plaintext password expected
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
		  if database.Trim = empty then return new pdOutcome(CurrentMethodName + ": Database not defined")
		  
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
		  
		  dim sqliteDB as SQLiteDatabase = new SQLiteDatabase
		  dim error as string
		  
		  sqliteDB.DatabaseFile = file
		  if filePassword <> empty then sqliteDB.EncryptionKey = filePassword.fromBase64
		  
		  if sqliteDB.CreateDatabaseFile = false then return new pdOutcome(CurrentMethodName + ": Could not create token file: " + sqliteDB.ErrorMessage)
		  // we now have the token file created and ready 
		  
		  dim init as string = "CREATE TABLE services ("
		  init = init.Append("objidx INTEGER PRIMARY KEY AUTOINCREMENT , ")
		  init = init.Append("name TEXT NOT NULL , ")
		  init = init.Append("friendlyname TEXT NOT NULL , ")
		  init = init.Append("description TEXT , ")
		  init = init.Append("comments TEXT , ")
		  init = init.Append("tokenissued DATETIME NOT NULL , ")
		  init = init.Append("organization TEXT NOT NULL , ")
		  init = init.Append("host TEXT NOT NULL , ")
		  init = init.Append("port INTEGER NOT NULL , ")
		  init = init.Append("database TEXT NOT NULL , ")
		  init = init.Append("username TEXT , ")
		  init = init.Append("password TEXT , ")
		  init = init.Append("secure BOOLEAN NOT NULL , ")
		  init = init.Append("ssl_key TEXT , ")
		  init = init.Append("ssl_certificate TEXT , ")
		  init = init.Append("ssl_ca TEXT )")
		  
		  sqliteDB.SQLExecute(init)
		  if sqliteDB.Error = true then
		    error = sqliteDB.ErrorMessage
		    sqlitedb.Close
		    file.Delete
		    return new pdOutcome(CurrentMethodName + ": Error initializing token file: " + error)
		  end if
		  
		  dim tokenRecord as new DatabaseRecord
		  
		  tokenRecord.Column("name") = name
		  tokenRecord.Column("friendlyname") = friendlyName
		  tokenRecord.Column("description") = description
		  tokenRecord.Column("comments") = comments
		  tokenRecord.DateColumn("tokenIssued") = tokenIssued
		  tokenRecord.Column("organization") = organization
		  tokenRecord.Column("host") = host
		  tokenRecord.IntegerColumn("port") = port
		  tokenRecord.Column("database") = database
		  tokenRecord.Column("username") = username
		  tokenRecord.Column("password") = password
		  tokenRecord.BooleanColumn("secure") = ssl_force
		  tokenRecord.Column("ssl_key") = ssl_key
		  tokenRecord.Column("ssl_certificate") = ssl_certificate
		  tokenRecord.Column("ssl_ca") = ssl_ca
		  
		  sqliteDB.InsertRecord("services" , tokenRecord)
		  if sqliteDB.Error = true then 
		    error = sqliteDB.ErrorMessage
		    sqlitedb.Close
		    file.Delete
		    return new pdOutcome(CurrentMethodName + ": Error writing token data: " + error)
		  end if
		  
		  sqliteDB.close
		  return new pdOutcome(true)
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getNew(password as string) As pdservicetoken
		  // password is expected to be plaintext
		  return new pdservicetoken(password)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function loadFolderTokens(tokensFolder as FolderItem) As pdservicetoken()
		  // this method will only open unencrypted tokens and will not return any error messages
		  
		  dim output(-1) as pdservicetoken
		  dim outcome as pdOutcome
		  
		  if tokensFolder  = nil then return output
		  if tokensFolder .Exists = False then Return output
		  
		  dim tokensFolderCount as Integer = tokensFolder .Count
		  
		  for i as integer = 1 to tokensFolderCount
		    if tokensFolder .Item(i).Extension = "PDST" then
		      outcome = pdservicetoken.Open(tokensFolder .Item(i))
		      if outcome.ok then output.Append outcome.returnObject
		    end if
		    
		  next i
		  
		  Return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Open(tokenFile as FolderItem , optional password as string = "") As pdOutcome
		  // password is exptected to be base64-encoded
		  // pdservicetoken is expected in pdOutcome.returnObject if pdOutcome.ok
		  
		  if tokenFile = nil then return new pdOutcome(CurrentMethodName + ": Invalid token path")
		  if tokenFile.Exists = false then return new pdOutcome(CurrentMethodName + ": Token file does not exist")
		  if tokenFile.Extension <> "pdst" then return new pdOutcome(CurrentMethodName + ": Extension is not .pdst")
		  
		  dim db as new SQLiteDatabase
		  if password.Trim <> empty then db.EncryptionKey = password.Trim.fromBase64
		  db.DatabaseFile = tokenFile
		  
		  if db.Connect = false then return new pdOutcome(CurrentMethodName + ": Error opening token")
		  
		  dim tokendata as RecordSet = db.SQLSelect("SELECT * FROM services")
		  if db.Error = true then Return new pdOutcome(CurrentMethodName + ": Error getting token data: " + db.ErrorMessage)
		  if tokendata.RecordCount <> 1 then Return new pdOutcome(CurrentMethodName + ": Invalid token data records: " + str(tokendata.RecordCount))
		  
		  dim token as new pdservicetoken(password.fromBase64)
		  
		  token.comments = tokendata.Field("comments").StringValue
		  token.description = tokendata.Field("description").StringValue
		  token.file = tokenFile
		  token.friendlyName = tokendata.Field("friendlyname").StringValue
		  token.host = tokendata.Field("host").StringValue
		  token.name = tokendata.Field("name").StringValue
		  token.objidx = tokendata.Field("objidx").IntegerValue
		  token.organization  = tokendata.Field("organization").StringValue
		  token.password = tokendata.Field("password").StringValue   // base64-encoded
		  token.port = tokendata.Field("port").IntegerValue
		  token.database = tokendata.Field("database").StringValue
		  token.ssl_ca = tokendata.Field("ssl_ca").StringValue // base64-encoded
		  token.ssl_certificate = tokendata.Field("ssl_certificate").StringValue // base64-encoded
		  token.ssl_key = tokendata.Field("ssl_key").StringValue // base64-encoded
		  token.ssl_force = tokendata.Field("secure").BooleanValue
		  token.tokenIssued = tokendata.Field("tokenIssued").DateValue
		  token.username = tokendata.Field("username").StringValue
		  
		  dim success as new pdOutcome(true)
		  success.returnObject = token
		  return success
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		comments As string
	#tag EndProperty

	#tag Property, Flags = &h0
		database As string
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
			Name="database"
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
