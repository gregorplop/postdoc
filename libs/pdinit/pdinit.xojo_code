#tag Class
Protected Class pdinit
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // class cannot be instantiated
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function initDatabase(byref activeSession as PostgreSQLDatabase , pdSystemName as string , dbFolderRoot as FolderItem , charType as string , collation as string) As pdOutcome
		  // 2nd step of an initialization
		  // you need to be connected to a service database as a server administrator, eg user postgres
		  if activeSession = nil then return new pdOutcome(CurrentMethodName + ": No session to a PostgreSQL database")
		  if pdSystemName.Trim = empty then return new pdOutcome(CurrentMethodName + ": Postdoc system name cannot be empty")
		  if dbFolderRoot = nil then return new pdOutcome(CurrentMethodName + ": Tablespace root folder path is invalid")
		  if dbFolderRoot.Exists = false then return new pdOutcome(CurrentMethodName + ": Tablespace root folder does not exist")
		  
		  dim tablespaceName as string = pdSystemName + "_tablespace"
		  dim dbFolder as FolderItem = dbFolderRoot.Child(tablespaceName)
		  if dbFolder.Exists = true then return new pdOutcome(CurrentMethodName + ": Tablespace folder " + dbFolder.NativePath + " already exists")
		  
		  dbFolder.CreateAsFolder
		  if dbFolder.LastErrorCode <> 0 then return new pdOutcome(CurrentMethodName + ": Could not create " + dbFolder.NativePath)
		  
		  dim dbFolderName as string = dbFolder.NativePath.ReplaceAll("\" , "\\")   // this will only work for windows!
		  
		  if activeSession.Connect = false then return new pdOutcome(CurrentMethodName + ": Could not open the session to the PostgreSQL database: " + activeSession.ErrorMessage)
		  
		  dim statements(-1) as string
		  dim rollback(-1) as string
		  dim fail as Boolean = false
		  dim rollbackOK as Boolean = true
		  
		  if charType = empty then charType = pgDefaultCharacterType
		  if collation = empty then collation = pgDefaultCharacterType
		  
		  statements.Append "CREATE TABLESPACE " + tablespaceName + " OWNER pdadmin LOCATION E'" +dbFolderName + "'"
		  statements.Append "CREATE DATABASE " + pdSystemName + " WITH ENCODING='UTF8' OWNER=pdadmin LC_COLLATE='" + collation + "' LC_CTYPE='" + charType + "' CONNECTION LIMIT=-1 TABLESPACE=" + tablespaceName
		  statements.Append "COMMENT ON DATABASE " + pdSystemName + " IS '" + projectURL + "'"
		  statements.Append "GRANT ALL ON DATABASE postdoc TO GROUP pd_admins"
		  statements.Append "GRANT ALL ON DATABASE postdoc TO GROUP pd_backends"
		  statements.Append "GRANT CONNECT ON DATABASE postdoc TO GROUP pd_users"
		  statements.Append "REVOKE ALL ON DATABASE postdoc FROM public"
		  
		  
		  dim failure as new pdOutcome(CurrentMethodName +  ": Failed to create administrative group or role")
		  
		  rollback.Append "DROP DATABASE " + pdSystemName
		  rollback.Append "DROP TABLESPACE " + tablespaceName
		  
		  for i as integer = 0 to statements.Ubound
		    activeSession.SQLExecute(statements(i))
		    if activeSession.Error = true then
		      failure.warnings.Append activeSession.ErrorMessage
		      fail =true
		      exit for i
		    end if
		  next i
		  
		  if fail = true then
		    for i as integer = 0 to rollback.Ubound
		      activeSession.SQLExecute(rollback(i))
		      if activeSession.Error = true then
		        failure.warnings.Append "ROLLBACK: " + activeSession.ErrorMessage
		        rollbackOK = false
		      end if
		    next i
		    dbFolder.Delete  // try deleting the folder if empty
		    failure.fatalErrorMsg = failure.fatalErrorMsg.Append(if(rollbackOK = true , ": Rollback SUCCESS" , ": Rollback FAIL"))
		    Return failure
		    
		  end if
		  
		  return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub InitSystemTables()
		  // 3rd step of an initialization
		  // you need to be connected to the postdoc database as user pdadmin
		  // run it immediatelly after initDatabase
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function initSystemUsers(byref activeSession as PostgreSQLDatabase , adminPassword as string , backendPassword as string) As pdOutcome
		  // 1st step of an initialization
		  // you need to be connected to a service database as a server administrator, eg user postgres
		  if activeSession = nil then return new pdOutcome(CurrentMethodName + ": No session to a PostgreSQL database")
		  if adminPassword.Trim = empty then return new pdOutcome(CurrentMethodName + ": Administrator password cannot be empty")
		  if backendPassword.Trim = empty then return new pdOutcome(CurrentMethodName + ": Backend password cannot be empty")
		  if activeSession.Connect = false then return new pdOutcome(CurrentMethodName + ": Could not open the session to the PostgreSQL database: " + activeSession.ErrorMessage)
		  
		  dim statements(-1) as string
		  dim rollback(-1) as string
		  dim fail as Boolean = false
		  dim rollbackOK as Boolean = true
		  dim adminPasswd as String = "md5" + EncodeHex(MD5(adminPassword + "pdadmin")).Lowercase
		  dim backendPasswd as string = "md5" + EncodeHex(MD5(backendPassword + "pdbackend")).Lowercase
		  
		  statements.Append "CREATE ROLE pd_admins SUPERUSER CREATEDB CREATEROLE REPLICATION VALID UNTIL 'infinity'"
		  statements.Append "CREATE ROLE pd_users VALID UNTIL 'infinity'"
		  statements.Append "CREATE ROLE pd_backends VALID UNTIL 'infinity'"
		  
		  statements.Append "CREATE ROLE pdadmin LOGIN ENCRYPTED PASSWORD '" + adminPasswd + "' VALID UNTIL 'infinity'"
		  statements.Append "GRANT pd_admins TO pdadmin"
		  statements.Append "GRANT pd_users TO pdadmin"
		  
		  statements.Append "CREATE ROLE pdbackend LOGIN ENCRYPTED PASSWORD '" + backendPasswd + "' VALID UNTIL 'infinity'"
		  statements.Append "GRANT pd_backends TO pdbackend"
		  statements.Append "GRANT pd_users TO pdbackend"
		  
		  dim failure as new pdOutcome(CurrentMethodName +  ": Failed to create administrative group or role")
		  
		  rollback.Append "DROP ROLE pdbackend"
		  rollback.Append "DROP ROLE pdadmin"
		  rollback.Append "DROP ROLE pd_backends"
		  rollback.Append "DROP ROLE pd_users"
		  rollback.Append "DROP ROLE pd_admins"
		  
		  for i as integer = 0 to statements.Ubound
		    activeSession.SQLExecute(statements(i))
		    if activeSession.Error = true then
		      failure.warnings.Append activeSession.ErrorMessage
		      fail =true
		      exit for i
		    end if
		  next i
		  
		  if fail = true then
		    for i as integer = 0 to rollback.Ubound
		      activeSession.SQLExecute(rollback(i))
		      if activeSession.Error = true then
		        failure.warnings.Append "ROLLBACK: " + activeSession.ErrorMessage
		        rollbackOK = false
		      end if
		    next i
		    
		    failure.fatalErrorMsg = failure.fatalErrorMsg.Append(if(rollbackOK = true , "Rollback SUCCESS" , "Rollback FAIL"))
		    Return failure
		    
		  end if
		  
		  return new pdOutcome(true)
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = pgDefaultCharacterType, Type = String, Dynamic = False, Default = \"Greek_Greece.1253", Scope = Public
	#tag EndConstant

	#tag Constant, Name = pgDefaultCollation, Type = String, Dynamic = False, Default = \"Greek_Greece.1253", Scope = Public
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
