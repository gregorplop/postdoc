#tag Class
Protected Class pdinit
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // class cannot be instantiated
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function initAdmins(byref activeSession as PostgreSQLDatabase , adminPassword as string) As pdOutcome
		  // 1st step of an initialization
		  if activeSession = nil then return new pdOutcome(CurrentMethodName + ": No session to a PostgreSQL database")
		  if adminPassword.Trim = empty then return new pdOutcome(CurrentMethodName + ": Administrator password cannot be empty")
		  if activeSession.Connect = false then return new pdOutcome(CurrentMethodName + ": Could not open the session to the PostgreSQL database: " + activeSession.ErrorMessage)
		  
		  dim statements(-1) as string
		  dim passwdString as String = "md5" + EncodeHex(MD5(adminPassword + "pdadmin")).Lowercase
		  
		  statements.Append "CREATE ROLE pd_admins SUPERUSER CREATEDB CREATEROLE REPLICATION VALID UNTIL 'infinity'"
		  statements.Append "CREATE ROLE pdadmin LOGIN ENCRYPTED PASSWORD '" + passwdString + "' VALID UNTIL 'infinity'"
		  statements.Append "GRANT pd_admins TO pdadmin"
		  
		  dim failure as new pdOutcome(CurrentMethodName +  ": Failed to create administrative group or role - No cleanup has been performed")
		  
		  for i as integer = 0 to statements.Ubound
		    activeSession.SQLExecute(statements(i))
		    if activeSession.Error = true then
		      failure.warnings.Append activeSession.ErrorMessage
		      return failure
		    end if
		  next i
		  
		  return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function initTablespace(name as string , folder as FolderItem) As pdOutcome
		  if service = nil then return new pdOutcome(CurrentMethodName + ": Service token is invalid"
		  if service.username <> "pdadmin" then Return new pdOutcome(CurrentMethodName + ": Token user is not pdadmin: You can only connect with this user")
		  if name.Trim = empty then return new pdOutcome(CurrentMethodName + ": Tablespace is empty")
		  if folder = nil then return new pdOutcome(CurrentMethodName + ": Tablespace folder path is invalid")
		  if folder.Exists = true end folder.Directory = true and folder.Count > 0 then Return new pdOutcome(CurrentMethodName + ": Target folder is not empty")
		  
		  if folder.Exists = false then 
		    folder.CreateAsFolder
		    if folder.LastErrorCode <> 0 then return new pdOutcome(CurrentMethodName + ": Could not create folder " + folder.NativePath)
		  end if
		  
		  dim db as new PostgreSQLDatabase
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			a valid service token for an system administrator should be loaded here for most initialization operations
			
		#tag EndNote
		Shared service As pdservicetoken
	#tag EndProperty


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
