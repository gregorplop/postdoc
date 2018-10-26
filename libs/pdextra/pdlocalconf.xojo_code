#tag Class
Protected Class pdlocalconf
	#tag Method, Flags = &h0
		Shared Function check() As FolderItem
		  // looks for the localconf file , returns it as a FolderItem, else returns nil
		  // typical location is appdata\roaming\postdoc\localconf
		  
		  dim ApplicationData as FolderItem = SpecialFolder.ApplicationData
		  if ApplicationData = nil then return nil
		  dim postdocFolder as FolderItem = ApplicationData.Child(localconf_Folder)
		  
		  if postdocFolder = nil then return nil
		  if postdocFolder.Exists = false then return nil
		  if postdocFolder.Directory = false then return nil
		  
		  dim localconf as FolderItem = postdocFolder.Child(localconf_File)
		  
		  if localconf = nil then return nil
		  if localconf.Exists = false then return nil
		  
		  if localconf.Length = 0 then
		    localconf.Delete
		    Return nil
		  end if
		  
		  return localconf
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // abstract class, no instantiation
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function encryptionkey() As string
		  // replace with your own if needed
		  // Output: "12lOcAlCoNFFpassworD@!!!"
		  Dim Chars() As String = Array("N", "J", "A", "S", "M", "k", "T", "h", "2", "d", "z", "G", "c", "E", "R", "I", "B", "b", "v", "Z", "F", "3", "s")
		  Return DefineEncoding(DecodeBase64(Chars(4) + Chars(6) + Chars(1) + Chars(22) + Chars(6) + Chars(8) + Chars(0) + Chars(16) + Chars(17) + Chars(13) + Chars(0) + Chars(18) + Chars(6) + Chars(5) + Chars(19) + Chars(11) + Chars(12) + Chars(11) + Chars(20) + Chars(10) + Chars(12) + Chars(21) + Chars(9) + Chars(18) + Chars(12) + Chars(5) + Chars(14) + Chars(2) + Chars(15) + Chars(3) + Chars(13) + Chars(7)),Encodings.UTF8)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getconf(service as String , section as string , key as string , optional valueidx as integer = -1) As pdOutcome
		  if service.Trim = empty then return new pdOutcome(CurrentMethodName + ": No service name")
		  if section.Trim = empty then return new pdOutcome(CurrentMethodName + ": No section name")
		  if key.Trim = empty then return new pdOutcome(CurrentMethodName + ": No key name")
		  if valueidx < 0 or valueidx > 4 then return new pdOutcome(CurrentMethodName + ": Invalid value index")
		  
		  dim localconf as FolderItem = check
		  if localconf = nil then 
		    dim initoutcome as pdOutcome = init
		    if initoutcome.ok = false then return new pdOutcome(CurrentMethodName + ": " + initoutcome.fatalErrorMsg)
		  end if
		  
		  // localconf is there
		  
		  dim localconfDB as new SQLiteDatabase
		  localconfDB.DatabaseFile = localconf
		  localconfDB.EncryptionKey = encryptionkey
		  
		  if localconfDB.Connect = false then
		    return new pdOutcome(CurrentMethodName + ": localconf probably corrupted: " + localconfDB.ErrorMessage)
		  end if
		  
		  // connected to localconf
		  
		  dim query as string = "SELECT * FROM localconf WHERE "
		  query.Append("service = " + service.sqlQuote + " AND ")
		  query.Append("section = " + section.sqlQuote + " AND ")
		  query.Append("key = " + key.sqlQuote)
		  
		  dim rs as RecordSet = localconfDB.SQLSelect(query)
		  if localconfDB.Error = true then return new pdOutcome(CurrentMethodName + ": Error getting conf data : " + localconfDB.ErrorMessage)
		  // no records found produces an error code -1
		  if rs.RecordCount = 0 then return new pdOutcome(CurrentMethodName + ": No conf data found" , -1)
		  if rs.RecordCount > 1 then return new pdOutcome(CurrentMethodName + ": Improper record count for conf data: " + str(rs.RecordCount))
		  
		  
		  dim values(4) as string
		  dim success as new pdOutcome(true)
		  
		  if valueidx = -1 then 
		    
		    for i as integer = 0 to 4
		      values(i) = rs.Field("value" + str(i)).StringValue.Trim
		    next i
		    
		    success.returnObject = values
		  else
		    success.returnObject = rs.Field("value" + str(valueidx)).StringValue.Trim
		  end if
		  
		  return success
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function getpasswd(vfs as String , pool as string) As pdOutcome
		  if vfs.Trim = empty then return new pdOutcome(CurrentMethodName + ": No vfs name")
		  // empty pool means: password for the entire vfs
		  
		  dim localconf as FolderItem = check
		  if localconf = nil then 
		    dim initoutcome as pdOutcome = init
		    if initoutcome.ok = false then return new pdOutcome(CurrentMethodName + ": " + initoutcome.fatalErrorMsg)
		  end if
		  
		  // localconf is there
		  
		  dim localconfDB as new SQLiteDatabase
		  localconfDB.DatabaseFile = localconf
		  localconfDB.EncryptionKey = encryptionkey
		  
		  if localconfDB.Connect = false then
		    return new pdOutcome(CurrentMethodName + ": localconf probably corrupted: " + localconfDB.ErrorMessage)
		  end if
		  
		  // connected to localconf
		  
		  dim query as string = "SELECT password FROM storagepass WHERE "
		  query.Append("vfs = " + vfs.sqlQuote + " AND ")
		  query.Append("pool " + if(pool = empty , "IS NULL" , "= '" + pool + "'"))
		  
		  dim rs as RecordSet = localconfDB.SQLSelect(query)
		  if localconfDB.Error = true then return new pdOutcome(CurrentMethodName + ": Error getting passwd data : " + localconfDB.ErrorMessage)
		  
		  // no records found produces an error code -1
		  if rs.RecordCount = 0 then return new pdOutcome(CurrentMethodName + ": No passwd data found" , -1)
		  if rs.RecordCount > 1 then return new pdOutcome(CurrentMethodName + ": Improper record count for passwd data: " + str(rs.RecordCount))
		  
		  dim success as new pdOutcome(true)
		  
		  success.returnObject = rs.IdxField(1).StringValue
		  
		  return success
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function init(optional reset as Boolean = false) As pdOutcome
		  dim localconf as FolderItem = check
		  dim ApplicationData as FolderItem
		  dim postdocFolder as FolderItem
		  
		  if IsNull(localconf) = false and reset = true then
		    localconf.Delete
		    if localconf.LastErrorCode <> 0 then return new pdOutcome(CurrentMethodName + ": Could not reset localconf: " + str(localconf.LastErrorCode))
		    localconf = nil
		  end if
		  
		  dim db as SQLiteDatabase
		  dim initStatements(-1) as string
		  initStatements.Append "CREATE TABLE storagepass (vfs TEXT NOT NULL , pool TEXT , password TEXT , UNIQUE (vfs , pool))"
		  initStatements.Append "CREATE TABLE localconf (service TEXT , section TEXT , key TEXT , value0 TEXT , value1 TEXT , value2 TEXT , value3 TEXT , value4 TEXT , UNIQUE (service , section , key))"
		  initStatements.Append "INSERT INTO localconf (service , section , key , value0 , value1) VALUES (NULL , NULL , NULL , 'init' , 'ok')"
		  
		  if localconf = nil then  // handle possibility of folder or file not there
		    ApplicationData = SpecialFolder.ApplicationData
		    if ApplicationData = nil then return new pdOutcome(CurrentMethodName + ": Could not initialize localconf file: No path to ApplicationData")
		    if ApplicationData.exists = false then return new pdOutcome(CurrentMethodName + ": Could not initialize localconf file: No path to ApplicationData")
		    
		    postdocFolder = ApplicationData.Child(localconf_Folder)
		    if postdocFolder.Exists = false then
		      postdocFolder.CreateAsFolder
		      if postdocFolder.LastErrorCode <> 0 then Return new pdOutcome(CurrentMethodName + ": Error while creating localconf folder: " + str(postdocFolder.LastErrorCode))
		    else
		      if postdocFolder.Directory = false then // folder does not exist, but a file with that name does
		        postdocFolder.CreateAsFolder
		        if postdocFolder.LastErrorCode <> 0 then Return new pdOutcome(CurrentMethodName + ": Error while creating localconf folder: " + str(postdocFolder.LastErrorCode))
		      end if
		    end if
		    
		    localconf = postdocFolder.Child(localconf_File)
		    if localconf = nil then return new pdOutcome(CurrentMethodName + ": Error while verifying newly created postdoc folder")
		    
		    db = new SQLiteDatabase
		    db.DatabaseFile = localconf
		    db.EncryptionKey = encryptionkey
		    
		    if localconf.Exists = false then
		      dim createOutcome as Boolean = db.CreateDatabaseFile
		      if createOutcome = false then return new pdOutcome(CurrentMethodName + ": Could not create localconf file: " + db.ErrorMessage)
		      // db is open now
		      dim buildOutcome(-1) as string = bulkSQLexecute(db , initStatements , false)
		      dim buildErrors(-1) as integer = getNonEmptyElements(buildOutcome)
		      dim buildErrorMsgs(-1) as string
		      for i as integer = 0 to buildErrors.Ubound
		        buildErrorMsgs.Append buildOutcome(buildErrors(i))
		      next i 
		      
		      db.close
		      
		      if buildErrors.Ubound >= 0 then
		        localconf.Delete
		        return new pdOutcome(CurrentMethodName + ": Could not build localconf file: " + Join(buildErrorMsgs , " // "))
		      end if
		      
		    end if
		    
		  end if
		  
		  Return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function setconf(service as String , section as string , key as string , values() as string) As pdOutcome
		  if service.Trim = empty then return new pdOutcome(CurrentMethodName + ": No service name")
		  if section.Trim = empty then return new pdOutcome(CurrentMethodName + ": No section name")
		  if key.Trim = empty then return new pdOutcome(CurrentMethodName + ": No key name")
		  if values.Ubound < 0 or values.Ubound > 4 then return new pdOutcome(CurrentMethodName + ": Invalid values array")
		  
		  dim localconf as FolderItem = check
		  if localconf = nil then 
		    dim initoutcome as pdOutcome = init
		    if initoutcome.ok = false then return new pdOutcome(CurrentMethodName + ": " + initoutcome.fatalErrorMsg)
		  end if
		  
		  // localconf is there
		  
		  dim localconfDB as new SQLiteDatabase
		  localconfDB.DatabaseFile = localconf
		  localconfDB.EncryptionKey = encryptionkey
		  
		  if localconfDB.Connect = false then
		    return new pdOutcome(CurrentMethodName + ": localconf probably corrupted: " + localconfDB.ErrorMessage)
		  end if
		  
		  dim query as string = "SELECT COUNT(*) FROM localconf WHERE "
		  query.Append("service = " + service.sqlQuote + " AND ")
		  query.Append("section = " + section.sqlQuote + " AND ")
		  query.Append("key = " + key.sqlQuote)
		  
		  dim rs as RecordSet = localconfDB.SQLSelect(query)
		  if localconfDB.Error = true then return new pdOutcome(CurrentMethodName + ": Error surveying conf data : " + localconfDB.ErrorMessage)
		  
		  dim valueFields(-1) as string
		  for i as integer =0 to values.Ubound
		    valueFields.Append "value" + str(i)
		  next i
		  
		  select case rs.IdxField(1).IntegerValue
		  case 0 // insert
		    query = "INSERT INTO localconf (service , section , key , "
		    query.Append(Join(valueFields , " , ") + ") ")
		    query.Append("VALUES ( " + service.sqlQuote + " , " + section.sqlQuote + " , " + key.sqlQuote + " , " + join(values.sqlQuote , " , ") + ")")
		  case 1 // update
		    for i as Integer = 0 to valueFields.Ubound
		      valueFields(i) = "value" + str(i) + " = " + values(i).sqlQuote
		    next i
		    query = "UPDATE localconf SET " + join(valueFields , " , ") + " WHERE "
		    query.Append("service = " + service.sqlQuote + " AND ")
		    query.Append("section = " + section.sqlQuote + " AND ")
		    query.Append("key = " + key.sqlQuote)
		    
		  else // invalid
		    return new pdOutcome(CurrentMethodName + ": Multiple entries for service/section/key combination: file probably tampered with")
		  end select
		  
		  localconfDB.SQLExecute(query)
		  if localconfDB.Error = true then return new pdOutcome(CurrentMethodName + ": Error writing conf data : " + localconfDB.ErrorMessage)
		  
		  localconfDB.close
		  return new pdOutcome(true)
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function setpasswd(vfs as String , pool as string , passwd as string) As pdOutcome
		  // input password is expected to be plaintext. it is stored base64-encoded
		  // if password if empty for an existing vfs/pool then this pair is removed
		  
		  if vfs.Trim = empty then return new pdOutcome(CurrentMethodName + ": No vfs name")
		  // an empty pool means password is for the vfs
		  
		  dim localconf as FolderItem = check
		  if localconf = nil then 
		    dim initoutcome as pdOutcome = init
		    if initoutcome.ok = false then return new pdOutcome(CurrentMethodName + ": " + initoutcome.fatalErrorMsg)
		  end if
		  
		  // localconf is there
		  
		  dim localconfDB as new SQLiteDatabase
		  localconfDB.DatabaseFile = localconf
		  localconfDB.EncryptionKey = encryptionkey
		  
		  if localconfDB.Connect = false then
		    return new pdOutcome(CurrentMethodName + ": localconf probably corrupted: " + localconfDB.ErrorMessage)
		  end if
		  
		  
		  dim query as string = "SELECT COUNT(*) FROM storagepass WHERE "
		  query.Append("vfs = " + vfs.sqlQuote + " AND ")
		  query.Append("pool " + if(pool = empty , "IS NULL" , "= " + pool.sqlQuote))
		  
		  dim rs as RecordSet = localconfDB.SQLSelect(query)
		  if localconfDB.Error = true then return new pdOutcome(CurrentMethodName + ": Error surveying passwd data : " + localconfDB.ErrorMessage)
		  
		  select case rs.IdxField(1).IntegerValue
		  case 0 // insert
		    if passwd.Trim = empty then return new pdOutcome(true) // empty password for a pool that doesn't exist - do nothing
		    query = "INSERT INTO storagepass (vfs , pool , password) "
		    query.Append("VALUES ( " + vfs.sqlQuote + " , " + pool.sqlQuote + " , " + passwd.toBase64.sqlQuote + ")")
		    
		  case 1 // update
		    if passwd.Trim <> empty then
		      query = "UPDATE storagepass SET password = " + passwd.toBase64.sqlQuote + " WHERE "
		      query.Append("vfs = " + vfs.sqlQuote + " AND ")
		      query.Append("pool " + if(pool = empty , "IS NULL" , "= " + pool.sqlQuote))
		    else  // no password supplied - delete the record
		      query = "DELETE FROM storagepass WHERE "
		      query.Append("vfs = " + vfs.sqlQuote + " AND ")
		      query.Append("pool " + if(pool = empty , "IS NULL" , "= " + pool.sqlQuote))
		    end if
		    
		  else // invalid
		    return new pdOutcome(CurrentMethodName + ": Multiple entries for vfs/pool combination: file probably tampered with")
		  end select
		  
		  localconfDB.SQLExecute(query)
		  if localconfDB.Error = true then return new pdOutcome(CurrentMethodName + ": Error writing passwd data : " + localconfDB.ErrorMessage)
		  
		  localconfDB.close
		  return new pdOutcome(true)
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = localconf_File, Type = String, Dynamic = False, Default = \"localconf", Scope = Public
	#tag EndConstant

	#tag Constant, Name = localconf_Folder, Type = String, Dynamic = False, Default = \"postdoc", Scope = Public
	#tag EndConstant


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
