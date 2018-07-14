#tag Class
Protected Class pdstorage_maintenance
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // this class cannot be instantiated
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function getVFSsalt() As string
		  Dim Chars() As String = Array("s", "z", "W", "A", "x", "1", "p", "y", "t", "X", "F", "K", "U", "D", "4", "h", "n", "I", "l", "Z", "Q", "S", "V", "0", "M", "k", "T", "=", "N", "C", "d", "R")
		  Return DefineEncoding(DecodeBase64(Chars(11) + Chars(13) + Chars(17) + Chars(15) + Chars(28) + Chars(13) + Chars(31) + Chars(29) + Chars(31) + Chars(7) + Chars(24) + Chars(14) + Chars(24) + Chars(10) + Chars(30) + Chars(16) + Chars(21) + Chars(13) + Chars(3) + Chars(8) + Chars(28) + Chars(26) + Chars(12) + Chars(4) + Chars(17) + Chars(12) + Chars(19) + Chars(14) + Chars(28) + Chars(5) + Chars(12) + Chars(1) + Chars(19) + Chars(7) + Chars(6) + Chars(20) + Chars(21) + Chars(2) + Chars(18) + Chars(0) + Chars(22) + Chars(23) + Chars(8) + Chars(2) + Chars(19) + Chars(9) + Chars(17) + Chars(18) + Chars(24) + Chars(21) + Chars(25) + Chars(27)),Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function initVFS(initVFS as pdstorage_vfs) As pdOutcome
		  if initVFS = nil then return new pdOutcome(CurrentMethodName + ": Initialization VFS object is nul")
		  
		  if initVFS.DBfile = nil then Return new pdOutcome(CurrentMethodName + ": Invalid path")
		  if initVFS.DBfile.Exists = true then return new pdOutcome(CurrentMethodName + ": File already exists")
		  
		  initVFS.name = initVFS.name.ReplaceAll(" " , empty).Trim.Uppercase
		  initVFS.friendlyname = initVFS.friendlyname.ReplaceAll("'" , " ").Trim
		  
		  if initVFS.name = empty then return new pdOutcome(CurrentMethodName + ": No storage structure name")
		  if initVFS.friendlyname = empty then return new pdOutcome(CurrentMethodName + ": No storage structure friendly name")
		  
		  dim newDBobject as new SQLiteDatabase
		  newDBobject.DatabaseFile = initVFS.DBfile
		  
		  if initVFS.password <> empty then // encrypt VFS master table
		    if initVFS.password.Len < 6 then return new pdOutcome(CurrentMethodName + ": Password must be more than 5 characters")
		    if initVFS.password.len > 10 then return new pdOutcome(CurrentMethodName + ": Password must be maximum 10 characters")
		    newDBobject.EncryptionKey = getVFSsalt.left(16-(initVFS.password.len+3)) + initVFS.password + getVFSsalt.Right(3)
		  end if
		  
		  if newDBobject.CreateDatabaseFile = false then return new pdOutcome(CurrentMethodName + ": Error creating database: " + newDBobject.ErrorMessage)
		  
		  // database has been created
		  
		  dim statements(-1) as string
		  
		  statements.Append "CREATE TABLE pdvfs (key TEXT UNIQUE , value1 TEXT)"
		  statements.Append "CREATE TABLE pools (name TEXT UNIQUE NOT NULL , friendlyname TEXT NOT NULL , comments TEXT , rootfolder TEXT NOT NULL , sizelimit INTEGER NOT NULL , initstamp DATETIME NOT NULL , autoexpand BOOLEAN NOT NULL , autoclose BOOLEAN NOT NULL , salt TEXT)"
		  statements.Append "CREATE TABLE media (pool TEXT NOT NULL , idx INTEGER NOT NULL , folder TEXT NOT NULL , threshold INTEGER NOT NULL , initstamp DATETIME NOT NULL , open BOOLEAN NOT NULL , FOREIGN KEY(pool) REFERENCES pools(name) , CONSTRAINT uniquemedium UNIQUE (pool , idx))"
		  
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('name' , '" + initVFS.name + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('friendlyname' , '" + initVFS.friendlyname + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('pdversion' , '" + pdVersion + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('initstamp' , '" + now.SQLDateTime + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('description' , '" + initVFS.description + "')"
		  
		  dim dbinitOutcome(-1) as string = bulkSQLexecute(newDBobject , statements , false)
		  if getNonEmptyElements(dbinitOutcome).Ubound >= 0 then
		    
		    dim ErroneusStatementIDs(-1) as integer = getNonEmptyElements(dbinitOutcome)
		    dim dbinitErrorMsg as string = CurrentMethodName + ": " + EndOfLine
		    for i as integer = 0 to ErroneusStatementIDs.Ubound
		      dbinitErrorMsg = dbinitErrorMsg + statements(ErroneusStatementIDs(i)) + " --> " + dbinitOutcome(ErroneusStatementIDs(i)) + EndOfLine
		    next i
		    
		    newDBobject.Close
		    initVFS.DBfile.Delete
		    return new pdOutcome(dbinitErrorMsg)
		    
		  ElseIf dbinitOutcome.Ubound < 0 then
		    
		    newDBobject.close
		    initVFS.DBfile.Delete
		    return new pdOutcome(pdLastError)
		    
		  end if
		  
		  newDBobject.close
		  return new pdOutcome(true)
		  
		  
		  
		End Function
	#tag EndMethod


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
