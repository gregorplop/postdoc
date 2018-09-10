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
		  
		  dim serviceDatabase as string = activeSession.DatabaseName  // will reconnect for dropping the database in case of a rollback
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
		  
		  
		  dim failure as new pdOutcome(CurrentMethodName +  ": Failed to create database or system tables")
		  
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
		  
		  if fail = False then // reconfigure connection to db and create system tables
		    activeSession.Close
		    activeSession.DatabaseName = pdSystemName
		    
		    dim buildTablesOutcome as pdOutcome = InitSystemTables(activeSession)
		    if buildTablesOutcome.ok = false then
		      failure.warnings.Append "Error creating system tables"
		      for i as integer = 0 to buildTablesOutcome.warnings.Ubound
		        failure.warnings.Append buildTablesOutcome.warnings(i)
		      next i
		      fail = true
		    end if
		  end if
		  
		  if fail = true then  // something went wrong
		    
		    if activeSession.DatabaseName <> serviceDatabase then // we currently have a connection to the new database, we need to conect to the service database back
		      activeSession.Close
		      activeSession.DatabaseName = serviceDatabase
		      if activeSession.Connect = False then  // could not get the initial connection back
		        failure.warnings.Append "ROLLBACK: Could not reconnect back to " + serviceDatabase
		        failure.fatalErrorMsg = failure.fatalErrorMsg.Append(": Rollback FAIL")
		        Return failure
		      end if
		    end if
		    
		    for i as integer = 0 to rollback.Ubound
		      activeSession.SQLExecute(rollback(i))
		      if activeSession.Error = true then
		        failure.warnings.Append "ROLLBACK: " + activeSession.ErrorMessage
		        rollbackOK = false
		      end if
		    next i
		    app.SleepCurrentThread(200)
		    dbFolder.Delete  // try deleting the folder if empty
		    failure.fatalErrorMsg = failure.fatalErrorMsg.Append(if(rollbackOK = true , ": Rollback SUCCESS" , ": Rollback FAIL"))
		    Return failure
		  end if
		  
		  
		  return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function InitSystemTables(byref activeSession as PostgreSQLDatabase) As pdOutcome
		  // 3rd step of an initialization
		  // initDatabase should run it automatically
		  
		  if activeSession = nil then return new pdOutcome(CurrentMethodName + ": No session to a PostgreSQL database")
		  if activeSession.Connect = false then return new pdOutcome(CurrentMethodName + ": Could not open the session to the PostgreSQL database: " + activeSession.ErrorMessage)
		  
		  dim statements(-1) as string
		  
		  // a minor housekeeping thing first: remove the public schema (if it exists)
		  statements.Append "DROP SCHEMA public"
		  
		  //  create storage schema and tables
		  statements.Append "CREATE SCHEMA storage AUTHORIZATION pdadmin"
		  statements.Append "COMMENT ON SCHEMA storage IS 'Coordination facilites for the external binary storage backend'"
		  statements.Append "REVOKE ALL ON SCHEMA storage FROM public"
		  statements.Append "GRANT ALL ON SCHEMA storage TO GROUP pd_admins"
		  statements.Append "GRANT USAGE ON SCHEMA storage TO GROUP pd_backends"
		  statements.Append "GRANT USAGE ON SCHEMA storage TO GROUP pd_users"
		  
		  statements.Append "CREATE TABLE storage.request_types(type TEXT PRIMARY KEY , description TEXT NOT NULL)"
		  statements.Append "INSERT INTO storage.request_types VALUES ('PUSH' , 'Push a Large Object into the pool and get a storage ID back for pulling it back')"
		  statements.Append "INSERT INTO storage.request_types VALUES ('PULL' , 'Pull a storage ID out of a pull and load it into a Large Object')"
		  statements.Append "INSERT INTO storage.request_types VALUES ('CLEARLO' , 'Delete this Large Object')"
		  statements.Append "REVOKE ALL ON TABLE storage.request_types FROM public"
		  statements.Append "GRANT SELECT ON TABLE storage.request_types TO GROUP pd_users"
		  
		  statements.Append "CREATE TABLE storage.request_states(state TEXT PRIMARY KEY , description TEXT NOT NULL)"
		  statements.Append "INSERT INTO storage.request_states VALUES ('NEW' , 'This is a new request, waiting to be handled')"
		  statements.Append "INSERT INTO storage.request_states VALUES ('INPROGRESS' , 'Request is being worked on')"
		  statements.Append "INSERT INTO storage.request_states VALUES ('DONE' , 'Request has been fulfilled')"
		  statements.Append "INSERT INTO storage.request_states VALUES ('ERROR' , 'There was an error while handling the request')"
		  statements.Append "INSERT INTO storage.request_states VALUES ('INVALID' , 'Request has been invalidated and should be removed')"
		  statements.Append "REVOKE ALL ON TABLE storage.request_states FROM public"
		  statements.Append "GRANT SELECT ON TABLE storage.request_states TO GROUP pd_users"
		  
		  statements.Append "CREATE TABLE storage.requests (reqid BIGINT PRIMARY KEY , register_stamp TIMESTAMP WITHOUT TIME ZONE , complete_stamp TIMESTAMP WITHOUT TIME ZONE , handlerpid INTEGER NOT NULL , type TEXT REFERENCES storage.request_types(type) , state TEXT REFERENCES storage.request_states(state) , pgpid INTEGER NOT NULL , pguser TEXT NOT NULL , pduser TEXT NOT NULL , pool TEXT NOT NULL , storageid BIGINT NOT NULL , loid INTEGER NOT NULL , errormsg TEXT)"
		  statements.Append "REVOKE ALL ON TABLE storage.requests FROM public"
		  statements.Append "GRANT ALL ON TABLE storage.requests TO GROUP pd_admins"
		  statements.Append "GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE storage.requests TO GROUP pd_backends"
		  statements.Append "GRANT SELECT, INSERT ON TABLE storage.requests TO GROUP pd_users"
		  statements.Append "ALTER TABLE storage.requests ALTER COLUMN register_stamp SET DEFAULT now()::TIMESTAMP WITHOUT TIME ZONE"
		  
		  statements.Append "CREATE SEQUENCE storage.requests_reqid_seq CYCLE INCREMENT 1 START 1 MINVALUE 1 NO MAXVALUE CACHE 1 OWNED BY storage.requests.reqid"  
		  statements.Append "REVOKE ALL ON SEQUENCE storage.requests_reqid_seq FROM public"
		  statements.Append "GRANT ALL ON SEQUENCE storage.requests_reqid_seq TO GROUP pd_users"
		  statements.Append "ALTER TABLE storage.requests ALTER COLUMN reqid SET DEFAULT nextval('storage.requests_reqid_seq'::regclass)"
		  
		  dim failure as new pdOutcome(CurrentMethodName +  ": Failed to create system tables")
		  
		  for i as integer = 0 to statements.Ubound
		    activeSession.SQLExecute(statements(i))
		    if activeSession.Error = true then
		      failure.warnings.Append activeSession.ErrorMessage
		      Return failure  // one error is enough + the calling method will take care of rollback
		    end if
		  next i
		  
		  
		  
		  Return new pdOutcome(true)
		  
		End Function
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
		  dim adminPasswd as String = pgMD5hash("pdadmin" , adminPassword)
		  dim backendPasswd as string = pgMD5hash("pdbackend" , backendPassword)
		  
		  statements.Append "CREATE ROLE pd_admins SUPERUSER CREATEDB CREATEROLE REPLICATION VALID UNTIL 'infinity'"   // administrators go into this group
		  statements.Append "CREATE ROLE pd_users VALID UNTIL 'infinity'"  // add all postdoc users to this group: it gives them the proper access rights for the base functionality
		  statements.Append "CREATE ROLE pd_backends VALID UNTIL 'infinity'"  // this is for users used for backend services to log in
		  
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
