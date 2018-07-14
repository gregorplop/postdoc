#tag Class
Protected Class pdstorage_session
	#tag Method, Flags = &h0
		Sub clearPoolPasswordCache()
		  poolPasswords = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Close()
		  Destructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub closeActiveMedium()
		  if IsNull(activeMedium) = false then activeMedium.Close
		  activeMediumFilename = empty
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(inputVFS as pdstorage_vfs, optional initPoolPasswords as Dictionary)
		  if inputVFS = nil then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Invalid VFS object")
		    exit sub
		  end if
		  
		  if inputVFS.DBfile = nil then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Invalid path to VFS file")
		    exit sub
		  end if
		  
		  if inputVFS.DBfile.Exists = false then 
		    initOutcome =  new pdOutcome(CurrentMethodName + ": VFS file does not exist")
		    exit sub
		  end if
		  
		  if inputVFS.DBfile.Directory = true then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": VFS file is really a directory")
		    exit sub
		  end if
		  
		  if inputVFS.DBfile.IsWriteable = false then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": VFS file is not Writeable")
		    exit sub
		  end if
		  
		  if inputVFS.DBfile.IsReadable = false then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": VFS file is not Readable")
		    exit sub
		  end if
		  
		  dim okOutcome as pdOutcome = new pdOutcome(true)
		  activeVFS = new SQLiteDatabase
		  activeVFS.DatabaseFile = inputVFS.DBfile
		  
		  inputVFS.password = inputVFS.password.Trim
		  if inputVFS.password <> empty then
		    if inputVFS.password.Len < 6 then 
		      initOutcome =  new pdOutcome(CurrentMethodName + ": Password must be more than 5 characters")
		      activeVFS = nil
		      exit sub
		    end if
		    
		    if inputVFS.password.len > 10 then 
		      initOutcome =  new pdOutcome(CurrentMethodName + ": Password must be maximum 10 characters")
		      activeVFS = nil
		      exit sub
		    end if
		    
		    activeVFS.EncryptionKey = getVFSsalt.left(16-(inputVFS.password.len+3)) + inputVFS.password + getVFSsalt.Right(3)
		  end if
		  
		  if activeVFS.Connect = false then
		    initOutcome =  new pdOutcome(CurrentMethodName + ": Error connecting to " + inputVFS.DBfile.name + ": " + activeVFS.ErrorMessage)
		    activeVFS = nil
		    exit sub
		  end if
		  
		  activeVFS.MultiUser = true
		  
		  dim testvalue as variant 
		  testvalue = getVFSparameter("name")
		  if testvalue = nil then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Loaded file is not a valid VFS: " + ErrorMsg)
		    activeVFS.Close
		    activeVFS = nil
		    exit sub
		  end if
		  
		  if testvalue.StringValue = empty then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Loaded file is not a valid VFS: No VFS name")
		    activeVFS.Close
		    activeVFS = nil
		    exit sub
		  end if
		  
		  okOutcome.returnObject = testvalue  // return object of initOutcome is the name of the vfs opened
		  
		  testvalue = getVFSparameter("pdversion")
		  if testvalue = nil then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Loaded file is not a valid VFS: " + ErrorMsg)
		    activeVFS.Close
		    activeVFS = nil
		    exit sub
		  end if
		  
		  if testvalue.StringValue = empty then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Loaded file is not a valid VFS: No VFS version") 
		    activeVFS.Close
		    activeVFS = nil
		    exit sub
		  end if
		  
		  
		  
		  testvalue = getVFSparameter("initstamp")
		  if testvalue = nil then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Loaded file is not a valid VFS: " + ErrorMsg)
		    activeVFS.Close
		    activeVFS = nil
		    exit sub
		  end if
		  
		  if testvalue.StringValue = empty then 
		    initOutcome = new pdOutcome(CurrentMethodName + ": Loaded file is not a valid VFS: No init date")
		    activeVFS.Close
		    activeVFS = nil
		    exit sub
		  end if
		  
		  poolPasswords = new Dictionary
		  // passwords are stored in base64 in cache
		  if IsNull(initPoolPasswords) = false then // user has supplied pool passwords
		    dim poolnames(-1) as string = getPoolNames
		    for i as integer = 0 to initPoolPasswords.Count - 1
		      if poolnames.IndexOf(initPoolPasswords.Key(i).StringValue) < 0 then
		        initOutcome = new pdOutcome(CurrentMethodName + ": No pool named <" + initPoolPasswords.Key(i).StringValue + "> found in VFS")
		        activeVFS.Close
		        activeVFS = nil
		        exit sub
		      end if
		      poolPasswords.Value(initPoolPasswords.Key(i).StringValue) = poolPasswords.Value(initPoolPasswords.Key(i).StringValue).StringValue.toBase64
		    next i
		  end if
		  
		  initOutcome = okOutcome
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function createNewPool(newPool as pdstorage_pool) As pdOutcome
		  if newPool.password <> empty then
		    if newPool.password.Len < 6 then return new pdOutcome(CurrentMethodName + ": Password must be more than 5 characters")
		    if newPool.password.len > 10 then return new pdOutcome(CurrentMethodName + ": Password must be maximum 10 characters")
		  end if
		  
		  dim newPoolOutcome as pdOutcome = initPool(newPool)
		  if newPoolOutcome.ok = false then return newPoolOutcome // something went wrong creating the pool in the VFS: fail
		  
		  // at this point 3 things have completed successfully:
		  // 1. a table called newPool.name has been created
		  // 2. a record newPool.name has been inserted in the pools table
		  // 3. if a user has set a password, the pool-password pair has been added to the poolPasswords dictionary
		  
		  // we are going to create the first medium of the pool: we cannot have a pool without at least 1 medium,
		  // especially a password-pretected pool: the medium db is the only place where the password is applied and can be compared against: it exists nowhere else
		  
		  dim rollbackOutcome as pdOutcome
		  dim poolInfo as pdstorage_pool = getPoolDetails(newPool.name)  // read details of the pool that has just been created
		  if poolInfo.error = true then 
		    rollbackOutcome = rollbackInitPool(newPool.name)
		    return new pdOutcome(CurrentMethodName + ": Error retrieving info on the newly created pool: " + poolInfo.errorMessage + _
		    if(rollbackOutcome.ok = true , " : Creation rollback OK" , " : Creation rollback failed: " + rollbackOutcome.fatalErrorMsg))
		  end if
		  
		  dim salt as string = empty 
		  dim saltedPassword as string = empty
		  
		  if poolInfo.encrypted = true then 
		    salt = getPoolSalt(poolInfo.name)
		    if salt = "error" then 
		      rollbackOutcome = rollbackInitPool(newPool.name)
		      return new pdOutcome(CurrentMethodName + ": Error retrieving salt of the newly created pool: " + ErrorMsg + _
		      if(rollbackOutcome.ok = true , " : Creation rollback OK" , " : Creation rollback failed: " + rollbackOutcome.fatalErrorMsg))
		    end if
		    salt = salt.fromBase64
		    // we do not check poolPasswords.HasKey(poolInfo.name) because it has to be there: it was just added
		    saltedPassword = salt.Left(16-(poolPasswords.Value(poolInfo.name).StringValue.fromBase64.len +3)) + poolPasswords.Value(poolInfo.name).StringValue.fromBase64 + salt.Right(3)
		  end if
		  
		  dim firstMediumCreateOutcome as pdOutcome = initMedium(poolInfo.name , 1 , poolInfo.rootFolder , poolInfo.mediumThreshold , saltedPassword)
		  if firstMediumCreateOutcome.ok = false then
		    rollbackOutcome = rollbackInitPool(newPool.name)
		    return new pdOutcome(CurrentMethodName + ": Error creating first medium of the newly created pool: " + poolInfo.errorMessage + _
		    if(rollbackOutcome.ok = true , " : Pool creation rollback OK" , " : Pool creation rollback failed: " + rollbackOutcome.fatalErrorMsg))
		  end if
		  
		  
		  return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function createNextMedium(poolname as string) As pdOutcome
		  if getPoolNames.IndexOf(poolname) < 0 then return new pdOutcome(CurrentMethodName + ": Error verifying pool name: " + ErrorMsg)
		  
		  dim poolLock as new Mutex(poolname)
		  if poolLock.TryEnter = false then 
		    dim lockedOutcome as new pdOutcome(CurrentMethodName + ": Maintenance lock on pool " + poolname)
		    lockedOutcome.fatalErrorCode = 2  // this is meant to signify "maybe someone else is doing what you're trying to do", rather than "infrastructure fail"
		    return lockedOutcome
		  end if
		  
		  // at this point we have successfully locked the pool for maintenance
		  
		  dim nextFreeID as integer = getFreeMediumID(poolname)
		  if nextFreeID < 0 then 
		    poolLock.Leave
		    return new pdOutcome(CurrentMethodName + ": Error getting free medium ID: " + ErrorMsg)
		  end if
		  
		  // we have a free id and we know nobody else is going to reserve it
		  
		  dim poolInfo as pdstorage_pool = getPoolDetails(poolname)
		  if poolInfo.error = true then
		    poolLock.Leave
		    return new pdOutcome(CurrentMethodName + ": Error getting pool info: " + poolInfo.errorMessage)
		  end if
		  
		  if poolInfo.autoExpand = False then 
		    poolLock.Leave
		    return new pdOutcome(CurrentMethodName + ": This pool is not set to auto-expand")
		  end if
		  
		  dim saltedPassword as string = empty
		  dim unsaltedPassword as String
		  if poolInfo.encrypted = true then // we need to find the user password
		    dim salt as string = getPoolSalt(poolname) // first get the salt
		    if salt = "error" then 
		      poolLock.Leave
		      return new pdOutcome(CurrentMethodName + ": Error retrieving salt from encrypted pool " + poolname + " : " + ErrorMsg)
		    end if
		    salt = salt.fromBase64
		    
		    if poolPasswords.HasKey(poolname) = true then // exists in cache
		      unsaltedPassword = poolPasswords.Value(poolname).StringValue.fromBase64
		      dim testOutcome as pdOutcome = testPoolPassword(poolname , unsaltedPassword)
		      if testOutcome.ok = true then  // exists in cache and it's correct
		        saltedPassword = salt.Left(16-(unsaltedPassword.len + 3)) + unsaltedPassword + salt.Right(3)
		      else  // exists in cache and couldn't be verified
		        select case testOutcome.fatalErrorCode
		        case 1  // infrastructure fail
		          poolLock.Leave
		          Return new pdOutcome(CurrentMethodName + ": Error verifying cached password : " + testOutcome.fatalErrorMsg)
		        case 2 // wrong password , no need to keep it in cache
		          poolPasswords.Remove(poolname) // remove the stored password-it's wrong
		        end select
		      end if
		    end if
		    
		    if saltedPassword = empty then // if password not cached or cached value failed the test
		      unsaltedPassword = RaiseEvent poolPasswordRequest(poolname)
		      if unsaltedPassword.Len < 6 then 
		        poolLock.Leave
		        return new pdOutcome(CurrentMethodName + ": Password must be more than 5 characters")
		      end if
		      if unsaltedPassword.len > 10 then 
		        poolLock.Leave
		        return new pdOutcome(CurrentMethodName + ": Password must be maximum 10 characters")
		      end if
		      dim testOutcome as pdOutcome = testPoolPassword(poolname , unsaltedPassword)
		      if testOutcome.ok = true then  // user-supplied password is correct
		        saltedPassword = salt.Left(16-(unsaltedPassword.len + 3)) + unsaltedPassword + salt.Right(3)
		        poolPasswords.Value(poolname) = unsaltedPassword.toBase64 // cache it
		      else  // user-supplied password couldn't be verified
		        select case testOutcome.fatalErrorCode
		        case 1  // infrastructure fail
		          poolLock.Leave
		          Return new pdOutcome(CurrentMethodName + ": Error verifying password : " + testOutcome.fatalErrorMsg)
		        case 2 // wrong password
		          poolLock.Leave
		          Return new pdOutcome(CurrentMethodName + ": Password incorrect: " + testOutcome.fatalErrorMsg)
		        end select
		      end if
		    end if
		  end if
		  
		  dim createMediumOutcome as pdOutcome = initMedium(poolname , nextFreeID , poolInfo.rootFolder , poolInfo.mediumThreshold , saltedPassword)
		  poolLock.Leave // release the pool maintenance lock
		  if createMediumOutcome.ok = true then createMediumOutcome.returnObject = nextFreeID // return the the id that was just created
		  return createMediumOutcome
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  if isnull(activeMedium) = False then activeMedium.close
		  if isnull(activeVFS) = false then activeVFS.close
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dumpContentList(poolname as string) As Dictionary
		  // key = objidx , value = metadata
		  // if error then output = nil and look in ErrorMsg for error message
		  
		  ErrorMsg = empty
		  
		  if getPoolNames.IndexOf(poolname) < 0 then 
		    ErrorMsg = CurrentMethodName + ": Error verifying pool name: " + ErrorMsg
		    return nil
		  end if
		  
		  dim output as new Dictionary
		  
		  dim singleFragmentDocs as RecordSet = activeVFS.SQLSelect("SELECT objidx , metadatum FROM " + poolname + " WHERE firstpart = 0 ORDER BY objidx ASC")
		  if activeVFS.Error = true then 
		    ErrorMsg = CurrentMethodName + ": Error querying for single-fragment documents: " + activeVFS.ErrorMessage
		    return nil
		  end if
		  
		  while not singleFragmentDocs.EOF
		    output.Value(singleFragmentDocs.Field("objidx").StringValue) = singleFragmentDocs.Field("metadatum").StringValue
		    singleFragmentDocs.MoveNext
		  wend
		  
		  dim multipleFragmentDocs as RecordSet = activeVFS.SQLSelect("SELECT DISTINCT firstpart , metadatum FROM " + poolname + " WHERE firstpart <> 0 ORDER BY firstpart ASC")
		  if activeVFS.Error = true then 
		    ErrorMsg = CurrentMethodName + ": Error querying for multiple-fragment documents: " + activeVFS.ErrorMessage
		    return nil
		  end if
		  
		  while not multipleFragmentDocs.EOF
		    output.Value(multipleFragmentDocs.Field("firstpart").StringValue) = multipleFragmentDocs.Field("metadatum").StringValue
		    multipleFragmentDocs.MoveNext
		  wend
		  
		  return output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getDocumentDetails(poolname as string, objidx as integer) As pdstorage_document
		  if isnull(activeVFS) = true then return new pdstorage_document(CurrentMethodName + ": VFS database is no longer active")
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT * FROM " + poolname + " WHERE objidx = " + str(objidx))
		  if activeVFS.Error = true then return new pdstorage_document(CurrentMethodName + ": Error while searching for document ID: " + activeVFS.ErrorMessage)
		  if rs.RecordCount <> 1 then return new pdstorage_document(CurrentMethodName + ": Document ID " + str(objidx) + " does not exist in pool " + poolname)
		  
		  if rs.Field("firstpart").IntegerValue <> 0 and rs.field("firstpart").IntegerValue <> objidx then
		    return new pdstorage_document(CurrentMethodName + ": ID " + str(objidx) + " is an intermediate fragment of document " + rs.Field("firstpart").StringValue)
		  end if
		  
		  dim output as new pdstorage_document
		  dim fragment as pdstorage_fragment
		  dim medium as pdstorage_medium
		  dim mediumInfo as new pdstorage_medium
		  
		  output.objidx = rs.Field("objidx").Int64Value
		  output.metadatum = rs.Field("metadatum").StringValue
		  output.creationStamp = rs.Field("creationstamp").DateValue
		  output.lastChangeStamp = rs.Field("lastchange").DateValue
		  output.deleted = rs.Field("deleted").BooleanValue
		  output.pool = poolname
		  output.hash = rs.Field("hash").StringValue
		  
		  if rs.Field("firstpart").IntegerValue = 0 then  // document consists of 1 fragment
		    output.fragmented = false
		    fragment = new pdstorage_fragment
		    fragment.objidx = rs.Field("objidx").Int64Value
		    fragment.mediumidx = rs.Field("mediumidx").IntegerValue
		    fragment.size = rs.Field("size").Int64Value
		    output.size = fragment.size
		    fragment.locked = rs.Field("locked").BooleanValue
		    
		    mediumInfo = getMediumDetails(poolname , fragment.mediumidx)
		    if mediumInfo.error = true then return new pdstorage_document(CurrentMethodName + ": Error getting medium info: " + mediumInfo.errorMessage)
		    fragment.mediumFile = mediumInfo.folder.Child(getFixedMediumFilename)
		    
		    output.fragments.Append fragment
		    
		  else  // document consists of multiple fragments
		    
		    output.fragmented = true
		    
		    rs = activeVFS.SQLSelect("SELECT * FROM " + poolname + " WHERE firstpart = " + str(objidx) + " ORDER BY objidx ASC")
		    if activeVFS.Error = true then return new pdstorage_document(CurrentMethodName + ": Error while searching for document ID: " + activeVFS.ErrorMessage)
		    if rs.RecordCount = 0 then return new pdstorage_document(CurrentMethodName + ": No fragments found for fragmented document " + str(objidx))
		    dim documentSize as Int64 = 0
		    
		    while not rs.EOF
		      fragment = new pdstorage_fragment
		      fragment.objidx = rs.Field("objidx").Int64Value
		      fragment.mediumidx = rs.Field("mediumidx").IntegerValue
		      fragment.size = rs.Field("size").Int64Value
		      documentSize = documentSize + fragment.size
		      fragment.locked = rs.Field("locked").BooleanValue
		      
		      if mediumInfo.pool = poolname and mediumInfo.idx = fragment.mediumidx then  // fragment belongs to the last inquired medium
		        fragment.mediumFile = mediumInfo.folder.Child(getFixedMediumFilename)
		      else  //  we need to get medium details
		        mediumInfo = new pdstorage_medium
		        mediumInfo = getMediumDetails(poolname , fragment.mediumidx)
		        if mediumInfo.error = true then return new pdstorage_document(CurrentMethodName + ": Error getting medium info: " + mediumInfo.errorMessage)
		        fragment.mediumFile = mediumInfo.folder.Child(getFixedMediumFilename)
		      end if
		      
		      output.fragments.Append fragment
		      rs.MoveNext
		    wend
		    output.size = documentSize
		    
		    if output.fragments(0).objidx <> objidx then // the objidx inquired is not the first fragment of the document: this practice is forbidden
		      return new pdstorage_document(CurrentMethodName + ": Document ID " + str(objidx) + " is belongs to a document fragment that is not the first")
		    end if
		    
		  end if
		  
		  return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getFixedMediumFilename() As string
		  return "pdstorage_medium"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getFreeMediumID(poolname as string) As integer
		  ErrorMsg = empty
		  
		  if getPoolNames.IndexOf(poolname) < 0 then 
		    ErrorMsg = CurrentMethodName + ": Error verifying pool name: " + ErrorMsg
		    return -1
		  end if
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT idx FROM media WHERE pool = '" + poolname + "' ORDER BY idx ASC")
		  
		  if activeVFS.Error = true then 
		    ErrorMsg = CurrentMethodName + ": Database error while looking for a free medium ID: " + activeVFS.ErrorMessage
		    return -1
		  end if
		  
		  dim counter as integer = 1
		  while not rs.EOF
		    if rs.IdxField(1).IntegerValue <> counter then exit while
		    counter = counter + 1
		    rs.MoveNext
		  wend
		  
		  return counter
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getInitOutcome() As pdOutcome
		  return initOutcome
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLastError() As String
		  return ErrorMsg
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getLastInsertedRowID() As Int64
		  ErrorMsg = empty
		  if activeVFS = nil then 
		    ErrorMsg = CurrentMethodName + ": VFS database is no longer open"
		    return -1
		  end if
		  
		  return activeVFS.LastRowID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getMediaDetails(poolname as string) As pdstorage_medium()
		  //does NOT perform checks on pool name - make sure it's valid!
		  ErrorMsg = empty
		  dim output(-1) as pdstorage_medium
		  dim currentMedium as pdstorage_medium
		  
		  if IsNull(activeVFS) = true then
		    ErrorMsg = CurrentMethodName + ": VFS Database is no longer connected"
		    return output
		  end if
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT idx , folder , threshold FROM media WHERE pool = '" _
		  + poolname + "' ORDER BY idx ASC")  // ASC will try older media , check if someting fits , DESC will go for the new one
		  if activeVFS.Error = true then 
		    ErrorMsg = CurrentMethodName + ": Error surveying media files: " + activeVFS.ErrorMessage
		    return output
		  end if
		  
		  while not rs.EOF
		    currentMedium = getMediumDetails(poolname , rs.Field("idx").IntegerValue)
		    if currentMedium.error = true then
		      ErrorMsg = currentMedium.errorMessage
		      ReDim output(-1)
		      return output
		    end if
		    output.Append currentMedium
		    rs.MoveNext
		  wend
		  
		  return output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getMediumDetails(poolname as string, mediumID as integer) As pdstorage_medium
		  if activeVFS = nil then return new pdstorage_medium(CurrentMethodName + ": VFS not initialized")
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT * FROM media WHERE pool = '" + poolname + "' AND idx = " + str(mediumID))
		  if activeVFS.Error = true then return new pdstorage_medium(CurrentMethodName + ": " + activeVFS.ErrorMessage)
		  if rs.RecordCount <> 1 then return new pdstorage_medium(CurrentMethodName + ": Invalid medium record count: " + str(rs.RecordCount))
		  
		  dim output as pdstorage_medium = new pdstorage_medium
		  
		  output.pool = rs.Field("pool").StringValue
		  output.idx = rs.Field("idx").IntegerValue
		  output.folder = GetFolderItem(rs.Field("folder").StringValue)
		  if output.folder = nil then return new pdstorage_medium(CurrentMethodName + ": Folder path " + rs.Field("folder").StringValue + " does not exist")
		  if output.folder.Exists = false then return new pdstorage_medium(CurrentMethodName + ": Folder " + rs.Field("folder").StringValue + " does not exist")
		  output.file = output.folder.Child(getFixedMediumFilename)
		  if output.file.Exists = false then return new pdstorage_medium(CurrentMethodName + ": Medium file in " + rs.Field("folder").StringValue + " does not exist")
		  output.threshold = rs.Field("threshold").IntegerValue
		  output.initStamp = rs.Field("initstamp").DateValue
		  output.open = rs.Field("open").BooleanValue
		  
		  
		  
		  return output
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getPoolDetails(poolname as string) As pdstorage_pool
		  if activeVFS = nil then return new pdstorage_pool(CurrentMethodName + ": VFS not initialized")
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT * FROM pools WHERE name = '" + poolname + "'")
		  if activeVFS.Error = true then return new pdstorage_pool(CurrentMethodName + ": " + activeVFS.ErrorMessage)
		  
		  if rs.RecordCount <> 1 then return new pdstorage_pool(CurrentMethodName + ": Invalid pool record count: " + str(rs.RecordCount))
		  
		  dim output as pdstorage_pool = new pdstorage_pool
		  
		  output.name = rs.Field("name").StringValue
		  output.friendlyName = rs.Field("friendlyname").StringValue
		  output.comments = rs.Field("comments").StringValue
		  output.rootFolder = GetFolderItem(rs.Field("rootfolder").StringValue)
		  output.mediumThreshold = rs.Field("sizelimit").IntegerValue
		  output.initStamp = rs.Field("initstamp").StringValue
		  output.autoExpand = rs.Field("autoexpand").BooleanValue
		  output.autoClose = rs.Field("autoclose").BooleanValue
		  
		  if rs.Field("salt").StringValue = empty then
		    output.encrypted = false
		  else
		    output.encrypted = true
		  end if
		  
		  return output
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPoolNames() As string()
		  dim output(-1) as String
		  ErrorMsg = empty
		  
		  if activeVFS = nil then
		    ErrorMsg = CurrentMethodName + ": VFS not initialized"
		    return output
		  end if
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT name FROM pools ORDER BY name ASC")
		  if activeVFS.Error = true then
		    ErrorMsg = activeVFS.ErrorMessage
		    return output
		  end if
		  
		  while not rs.EOF
		    output.Append rs.Field("name").StringValue
		    rs.MoveNext
		  wend
		  
		  return output
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getPoolSalt(poolname as string) As string
		  ErrorMsg = empty
		  
		  if activeVFS = nil then
		    ErrorMsg = CurrentMethodName + ": VFS not initialized"
		    return "error"
		  end if
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT salt FROM pools WHERE name = '" + poolname + "'")
		  if activeVFS.Error = true then
		    ErrorMsg = CurrentMethodName + ": " + activeVFS.ErrorMessage
		    return "error"
		  end if
		  
		  if rs.RecordCount <> 1 then
		    ErrorMsg = CurrentMethodName + ": Invalid pool record count: " + str(rs.RecordCount)
		    return "error"
		  end if
		  
		  return rs.Field("salt").StringValue  // returns the base64 encoded salt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getVFSdetails() As pdstorage_vfs
		  if activeVFS = nil then return new pdstorage_vfs(CurrentMethodName + ": VFS not initialized")
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT * FROM pdvfs")
		  if activeVFS.Error = true then return new pdstorage_vfs(CurrentMethodName + ": " + activeVFS.ErrorMessage)
		  
		  dim output as new pdstorage_vfs
		  dim systemFieldCounter as integer = 0
		  
		  while not rs.EOF
		    
		    select case rs.Field("key").StringValue
		    case "name"
		      output.name = rs.Field("value1").StringValue
		      systemFieldCounter = systemFieldCounter + 1
		    case "friendlyname"
		      output.friendlyName = rs.Field("value1").StringValue
		      systemFieldCounter = systemFieldCounter + 1
		    case "pdVersion"
		      output.pdVersion = rs.Field("value1").StringValue
		      systemFieldCounter = systemFieldCounter + 1
		    case "initstamp"
		      output.initStamp = rs.Field("value1").DateValue
		      systemFieldCounter = systemFieldCounter + 1
		    case "description"
		      output.description = rs.Field("value1").StringValue
		      systemFieldCounter = systemFieldCounter + 1
		    end select
		    
		    rs.MoveNext
		  wend
		  
		  if systemFieldCounter <> 5 then return new pdstorage_vfs(CurrentMethodName + ": Invalid VFS info record count: " + str(rs.RecordCount))
		  
		  return output
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getVFSparameter(parameter as string) As variant
		  dim output as Variant
		  ErrorMsg = empty
		  
		  if parameter.Trim = empty then
		    ErrorMsg = CurrentMethodName + ": Parameter name is empty"
		    return nil
		  end if
		  
		  if activeVFS = nil then 
		    ErrorMsg = CurrentMethodName + ": VFS is no longer valid"
		    return nil
		  end if
		  
		  dim rs as RecordSet = activeVFS.SQLSelect("SELECT * FROM pdvfs WHERE key = '" + parameter + "'")
		  if activeVFS.Error = true then 
		    ErrorMsg = CurrentMethodName + ": Database error: " + activeVFS.ErrorMessage 
		    return nil
		  end if
		  
		  if rs.RecordCount = 0 then
		    ErrorMsg = CurrentMethodName + ": No parameter <" + parameter + "> found"
		    return nil
		  end if
		  
		  output = rs.Field("value1").StringValue
		  return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function getVFSsalt() As string
		  Dim Chars() As String = Array("s", "z", "W", "A", "x", "1", "p", "y", "t", "X", "F", "K", "U", "D", "4", "h", "n", "I", "l", "Z", "Q", "S", "V", "0", "M", "k", "T", "=", "N", "C", "d", "R")
		  Return DefineEncoding(DecodeBase64(Chars(11) + Chars(13) + Chars(17) + Chars(15) + Chars(28) + Chars(13) + Chars(31) + Chars(29) + Chars(31) + Chars(7) + Chars(24) + Chars(14) + Chars(24) + Chars(10) + Chars(30) + Chars(16) + Chars(21) + Chars(13) + Chars(3) + Chars(8) + Chars(28) + Chars(26) + Chars(12) + Chars(4) + Chars(17) + Chars(12) + Chars(19) + Chars(14) + Chars(28) + Chars(5) + Chars(12) + Chars(1) + Chars(19) + Chars(7) + Chars(6) + Chars(20) + Chars(21) + Chars(2) + Chars(18) + Chars(0) + Chars(22) + Chars(23) + Chars(8) + Chars(2) + Chars(19) + Chars(9) + Chars(17) + Chars(18) + Chars(24) + Chars(21) + Chars(25) + Chars(27)),Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function initMedium(poolname as string , mediumID as integer , rootfolder as FolderItem , threshold as Int64 , password as string) As pdOutcome
		  if getPoolNames.IndexOf(poolname) < 0 then return new pdOutcome(CurrentMethodName + ": Pool <" + poolname + "> does not exist")
		  if mediumID <= 0 then return new pdOutcome(CurrentMethodName + ": Invalid medium ID")
		  
		  dim mediuminfo as pdstorage_medium = getMediumDetails(poolname , mediumID)
		  if mediuminfo.error = false then return new pdOutcome(CurrentMethodName + ": Error creating medium " + str(mediumID) + ": Probaly already exists")
		  
		  if rootfolder = nil then return new pdOutcome(CurrentMethodName + ": Invalid root path")
		  if rootfolder.Exists = false then return new pdOutcome(CurrentMethodName + ": Root folder does not exist")
		  if rootfolder.Directory = False then return new pdOutcome(CurrentMethodName + ": Root folder name is not a directory")
		  
		  if threshold < 512 then return new pdOutcome(CurrentMethodName + ": Size threshold is lower than 512 MB")
		  if activeVFS = nil then return new pdOutcome(CurrentMethodName + ": Active VFS is no longer valid")
		  
		  dim mediumFolder as FolderItem = rootfolder.Child(poolname.trim.Lowercase + "." + str(mediumID))
		  if mediumFolder.Exists = true then return new pdOutcome(CurrentMethodName + ": <" + mediumFolder.NativePath + "> already exists")
		  
		  mediumFolder.CreateAsFolder
		  if mediumFolder.LastErrorCode <> 0 then return new pdOutcome(CurrentMethodName + ": <" + mediumFolder.NativePath + "> could not be created")
		  if mediumFolder.IsWriteable = false then return new pdOutcome(CurrentMethodName + ": <" + mediumFolder.NativePath + "> is not writeable")
		  if mediumFolder.IsReadable = false then return new pdOutcome(CurrentMethodName + ": <" + mediumFolder.NativePath + "> is  not readable")
		  
		  dim VFSname as Variant
		  dim VFSversion as Variant
		  dim mediumTimestamp as new date
		  
		  VFSname = getVFSparameter("name")
		  if isnull(VFSname) = true then return new pdOutcome(ErrorMsg)
		  VFSversion = getVFSparameter("pdversion")
		  if isnull(VFSname) = true then return new pdOutcome(ErrorMsg)
		  
		  dim mediumDBfile as FolderItem = mediumFolder.Child(getFixedMediumFilename)
		  dim mediumDB as new SQLiteDatabase
		  mediumDB.DatabaseFile = mediumDBfile
		  
		  // input password is as-provided: no verifications and cross-checks are made here
		  mediumDB.EncryptionKey = password
		  
		  if mediumDB.CreateDatabaseFile = False then  // attempt to create the database file
		    mediumFolder.Delete
		    return new pdOutcome(CurrentMethodName + ": Error creating medium database file: " + mediumDB.ErrorMessage)
		  end if
		  
		  // at this point we have the medium db file created
		  
		  dim statements(-1) as string
		  statements.Append "CREATE TABLE pdvfs (key TEXT UNIQUE , value1 TEXT)"
		  statements.Append "CREATE TABLE content (objidx INTEGER PRIMARY KEY , firstpart INTEGER NOT NULL , content BLOB)"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('vfsname' , '" + VFSname.StringValue + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('vfsversion' , '" + VFSversion + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('initstamp' , '" + mediumTimestamp.SQLDateTime + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('pool' , '" + poolname + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('idx' , '" + str(mediumID) + "')"
		  statements.Append "INSERT INTO pdvfs (key , value1) VALUES ('threshold' , '" + str(threshold) + "')"
		  
		  dim mediumInitOutcome(-1) as string = bulkSQLexecute(mediumDB , statements , false)
		  if getNonEmptyElements(mediumInitOutcome).Ubound >= 0 then
		    dim ErroneusStatementIDs(-1) as integer = getNonEmptyElements(mediumInitOutcome)
		    dim mediumInitErrorMsg as string = CurrentMethodName + ": " + EndOfLine
		    for i as integer = 0 to ErroneusStatementIDs.Ubound
		      mediumInitErrorMsg = mediumInitErrorMsg + statements(ErroneusStatementIDs(i)) + " --> " + mediumInitOutcome(ErroneusStatementIDs(i)) + EndOfLine
		    next i
		    mediumDB.Close
		    mediumDBfile.Delete
		    mediumFolder.Delete
		    return new pdOutcome(mediumInitErrorMsg)
		  ElseIf mediumInitOutcome.Ubound < 0 then
		    mediumDB.Close
		    mediumDBfile.Delete
		    mediumFolder.Delete
		    return new pdOutcome(pdLastError)
		  end if
		  
		  // at this point the medium database file is ready
		  // all we have to do is declare it to the vfs database
		  
		  ReDim statements(-1)
		  ReDim mediumInitOutcome(-1)
		  statements.Append "INSERT INTO media (pool , idx , folder , threshold , initstamp , open) VALUES ('" + _
		  poolname + "' , " + str(mediumID) + " , '" + mediumFolder.NativePath + "' , " + _ 
		  str(threshold) + " , '" + mediumTimestamp.SQLDateTime + "' , 'true')"
		  
		  mediumInitOutcome = bulkSQLexecute(activeVFS , statements , false)
		  if mediumInitOutcome.Ubound < 0 then // infrastructure error
		    mediumDB.Close
		    mediumDBfile.Delete
		    mediumFolder.Delete
		    return new pdOutcome(CurrentMethodName + ": Error registering medium datafile: " + pdLastError)
		  ElseIf mediumInitOutcome(0) <> empty then  // sql statement execute error
		    mediumDB.Close
		    mediumDBfile.Delete
		    mediumFolder.Delete
		    return new pdOutcome(CurrentMethodName + ": Error registering medium datafile: " + mediumInitOutcome(0))
		  end if
		  
		  // at this point everything went well
		  mediumDB.close
		  return new pdOutcome(true)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function initPool(newPool as pdstorage_pool) As pdOutcome
		  if IsNull(newPool) = true then return new pdOutcome(CurrentMethodName + ": New pool object is null")
		  if getPoolNames.IndexOf(newPool.name) >= 0 or ErrorMsg <> empty then return new pdOutcome(CurrentMethodName + ": Error verifying eligibility for pool: " + ErrorMsg)
		  if newPool.friendlyName.Trim = empty then return new pdOutcome(CurrentMethodName + ": Pool friendly name is empty")
		  if isnull(newPool.rootfolder) = true then return new pdOutcome(CurrentMethodName + ": Pool root folder path is invalid")
		  if newPool.rootfolder.Exists = false then return new pdOutcome(CurrentMethodName + ": Root folder does not exist")
		  if newPool.rootfolder.Directory = False then return new pdOutcome(CurrentMethodName + ": Root folder name is not a directory")
		  if newPool.rootfolder.IsWriteable = false then return new pdOutcome(CurrentMethodName + ": Root folder is not Writeable")
		  if newPool.rootfolder.IsReadable = false then return new pdOutcome(CurrentMethodName + ": Root folder is not Readable")
		  if newPool.mediumThreshold < 512 then return new pdOutcome(CurrentMethodName + ": Size threshold is lower than 512 MB")
		  if activeVFS = nil then return new pdOutcome(CurrentMethodName + ": Active VFS is no longer valid")
		  
		  dim statements(-1) as string
		  dim insert as string
		  
		  statements.Append "CREATE TABLE " + newPool.name + " (objidx INTEGER PRIMARY KEY , mediumidx INTEGER NOT NULL , firstpart INTEGER NOT NULL , metadatum TEXT , size INTEGER NOT NULL , hash TEXT NOT NULL , creationstamp DATETIME NOT NULL , lastchange DATETIME NOT NULL , deleted BOOLEAN NOT NULL , locked BOOLEAN NOT NULL)"
		  
		  insert = "INSERT INTO pools (name , friendlyname , comments , rootfolder , sizelimit , initstamp , autoexpand , autoclose , salt) VALUES ("
		  insert = insert + newPool.Name.sqlQuote + ","
		  insert = insert + newPool.friendlyName.sqlQuote + ","
		  insert = insert + newPool.comments.sqlQuote + ","
		  insert = insert + newPool.rootFolder.NativePath.sqlQuote + ","
		  insert = insert + str(newPool.mediumThreshold) + ","
		  insert = insert + now.SQLDateTime.sqlQuote + ","
		  insert = insert + newPool.autoExpand.sqlQuote + ","
		  insert = insert + newPool.autoClose.sqlQuote + ","
		  if newPool.password.Trim = empty then
		    insert = insert + " null )"
		  else // user has supplied a password - a salt will be created and the password will be stored for the current session
		    dim salt as string = makeSalt(32)
		    insert = insert + salt.toBase64.sqlQuote + ")"
		  end if
		  
		  statements.Append insert
		  
		  dim poolInitOutcome(-1) as string = bulkSQLexecute(activeVFS , statements , true)
		  if getNonEmptyElements(poolInitOutcome).Ubound >= 0 then // error in statements
		    
		    dim ErroneusStatementIDs(-1) as integer = getNonEmptyElements(poolInitOutcome)
		    dim initErrorMsg as string = CurrentMethodName + ": " + EndOfLine
		    for i as integer = 0 to ErroneusStatementIDs.Ubound
		      initErrorMsg = initErrorMsg + statements(ErroneusStatementIDs(i)) + " --> " + poolInitOutcome(ErroneusStatementIDs(i)) + EndOfLine
		    next i
		    
		    return new pdOutcome(initErrorMsg)
		    
		  ElseIf poolInitOutcome.Ubound < 0 then  // error in infrastructure
		    return new pdOutcome(pdLastError)
		    
		  end if
		  
		  // store the password in the cache
		  if newPool.password.Trim <> empty then poolPasswords.Value(newPool.name) = newPool.password.Trim.toBase64  // store the password for the current session
		  
		  return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function pickSuitableMedium(Media() as pdstorage_medium, contentSize as int64) As integer
		  // returns -1 if no suitable medium found
		  dim freeSpaceInMedium as Int64
		  for i as Integer = 0 to Media.Ubound  // go through all media for pool
		    
		    if Media(i) = nil then Continue for i
		    if Media(i).open = false then Continue for i // not interested in closed media
		    
		    freeSpaceInMedium = Media(i).threshold * MByte - Media(i).file.Length
		    
		    if freeSpaceInMedium < 0 then Continue for i  // limit has been exceeded for some reason
		    if freeSpaceInMedium >= contentSize then return Media(i).idx
		    
		  next i
		  
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pullData(poolname as string , objidx as integer , byref targetBlock as MemoryBlock) As pdOutcome
		  if IsNull(targetBlock) = true then Return new pdOutcome(CurrentMethodName + ": Data block is null")
		  if getPoolNames.IndexOf(poolname) < 0 then return new pdOutcome(CurrentMethodName + ": Pool " + poolname + " does not exist")
		  targetBlock = empty
		  
		  // preliminary data gathering
		  dim poolInfo as pdstorage_pool = getPoolDetails(poolname)  // get pool properties
		  if poolInfo.error = true then Return new pdOutcome(CurrentMethodName + ": Error getting pool info: " + poolInfo.errorMessage)
		  
		  dim docInfo as pdstorage_document = getDocumentDetails(poolname , objidx)
		  if docInfo.error = true then return new pdOutcome(CurrentMethodName + ": Error getting document " + str(objidx) + " details: " + docInfo.errorMessage)
		  if docInfo.deleted = true then return new pdOutcome(CurrentMethodName + ": Document " + str(objidx) + " was deleted on " + docInfo.lastChangeStamp.SQLDateTime)
		  if docInfo.isLocked = true then return new pdOutcome(CurrentMethodName + ": Document " + str(objidx) + " is locked")
		  
		  // if pool is encrypted, we need to look for the password
		  if poolInfo.encrypted = true then 
		    dim password as string
		    dim passwordVerify as pdOutcome = new pdOutcome("default fail") // so as it's not null when we test it
		    if poolPasswords.HasKey(poolname) = true then
		      passwordVerify = testPoolPassword(poolname , poolPasswords.Value(poolname).StringValue.fromBase64)
		      if passwordVerify.fatalErrorCode = 2 then poolPasswords.Remove(poolname) // failed verifying password in cache, it doesn't need to be there anymore
		    end if
		    
		    if passwordVerify.fatalErrorCode > 0 then // go into this if no password is cached (or cached wrong password)
		      password = RaiseEvent poolPasswordRequest(poolname)  // ask the outside world for a password
		      passwordVerify = testPoolPassword(poolname , password)
		      select case passwordVerify.fatalErrorCode
		      case 0  // all good, we have the password
		        poolPasswords.Value(poolname) = password.toBase64 // any subsequent password requests will be served by the cache
		      case 1  // infrastructure error
		        return new pdOutcome(CurrentMethodName + ": Error verifying password: " + passwordVerify.fatalErrorMsg)
		      case 2 // probably wrong password
		        return new pdOutcome(CurrentMethodName + ": Password not verified")
		      end select
		    end if
		  end if
		  
		  // at this point, we either have a verified pool password in cache or this pool is not password protected
		  
		  dim fragmentStream as SQLiteBlob
		  dim targetStream as new BinaryStream(targetBlock)
		  dim md5calculator as new MD5Digest
		  dim content as string
		  
		  for i as integer = 0 to docInfo.fragments.Ubound // go through all the fragments
		    
		    if setActiveMedium(poolname , docInfo.fragments(i).mediumidx) = false then 
		      if IsNull(fragmentStream) = false then fragmentStream.close
		      targetStream.close
		      targetBlock = empty
		      Return new pdOutcome(CurrentMethodName + ": Error opening medium " + poolname + "." + str(docInfo.fragments(i).mediumidx) + " : " + getLastError)
		    end if
		    
		    fragmentStream = activeMedium.OpenBlob("content" , "content" , docInfo.fragments(i).objidx , false)
		    if isnull(fragmentStream) = true then 
		      targetStream.close
		      targetBlock = empty
		      Return new pdOutcome(CurrentMethodName + ": Error finding fragment " + str(docInfo.fragments(i).objidx) + " on medium " + poolname + "." + str(docInfo.fragments(i).mediumidx))
		    end if 
		    
		    while not fragmentStream.EOF
		      content = fragmentStream.Read(maxRecordSize / 2)  // notice that reading happens in double the steps
		      targetStream.Write(content)
		      
		      if fragmentStream.ReadError = true then
		        if IsNull(fragmentStream) = false then fragmentStream.close
		        targetStream.close
		        targetBlock = empty
		        Return new pdOutcome(CurrentMethodName + ": Error reading fragment " + str(docInfo.fragments(i).objidx) + " on medium " + poolname + "." + str(docInfo.fragments(i).mediumidx))
		      end if
		      
		      md5calculator.Process(content)
		      
		    wend
		    
		  next i
		  
		  if IsNull(fragmentStream) = false then fragmentStream.close
		  targetStream.close
		  
		  if EncodeHex(md5calculator.Value) <> docInfo.hash then 
		    targetBlock = empty
		    Return new pdOutcome(CurrentMethodName + ": Error verifying MD5 hash of document " + str(objidx) + " in pool " + poolname)
		  end if
		  
		  dim okOutcome as new pdOutcome(true)
		  okOutcome.returnObject = docInfo.metadatum
		  return okOutcome
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pushData(byref dataBlock as MemoryBlock , poolname as string , metadatum as string) As pdOutcome
		  if IsNull(dataBlock) = true then Return new pdOutcome(CurrentMethodName + ": Data block is null")
		  if getPoolNames.IndexOf(poolname) < 0 then return new pdOutcome(CurrentMethodName + ": Pool " + poolname + " does not exist")
		  if dataBlock.Size = MemoryBlock.SizeUnknown then return new pdOutcome(CurrentMethodName + ": Data block size could not be defined")
		  
		  // preliminary data gathering
		  dim dataLength as Int64 = dataBlock.Size   // this is the input block total size
		  dim poolInfo as pdstorage_pool = getPoolDetails(poolname)  // get pool properties
		  if poolInfo.error = true then Return new pdOutcome(CurrentMethodName + ": Error getting pool info: " + poolInfo.errorMessage)
		  
		  // if pool is encrypted, we need to look for the password
		  if poolInfo.encrypted = true then 
		    dim password as string
		    dim passwordVerify as pdOutcome = new pdOutcome("default fail") // so as it's not null when we test it
		    if poolPasswords.HasKey(poolname) = true then
		      passwordVerify = testPoolPassword(poolname , poolPasswords.Value(poolname).StringValue.fromBase64)
		      if passwordVerify.fatalErrorCode = 2 then poolPasswords.Remove(poolname) // failed verifying password in cache, it doesn't need to be there anymore
		    end if
		    
		    if passwordVerify.fatalErrorCode > 0 then // go into this if no password is cached (or cached wrong password)
		      password = RaiseEvent poolPasswordRequest(poolname)  // ask the outside world for a password
		      passwordVerify = testPoolPassword(poolname , password)
		      select case passwordVerify.fatalErrorCode
		      case 0  // all good, we have the password
		        poolPasswords.Value(poolname) = password.toBase64 // any subsequent password requests will be served by the cache
		      case 1  // infrastructure error
		        return new pdOutcome(CurrentMethodName + ": Error verifying password: " + passwordVerify.fatalErrorMsg)
		      case 2 // probably wrong password
		        return new pdOutcome(CurrentMethodName + ": Password not verified")
		      end select
		    end if
		  end if
		  
		  // at this point, we either have a verified pool password in cache or this pool is not password protected
		  
		  dim Media(-1) as pdstorage_medium
		  dim newDocument as new pdstorage_document // log of new records in pool & medium tables for the case of failure and rollback
		  dim newFragment as pdstorage_fragment // log of new records in pool & medium tables for the case of failure and rollback
		  dim readStream as new BinaryStream(dataBlock)  // create the read stream
		  dim fragmentData as string
		  dim PickedMedium as integer
		  dim md5calculator as new MD5Digest
		  dim firstObjidx as Int64 = -1
		  dim newlyCreatedObjidx as int64
		  dim newPoolCatalogueRecord as DatabaseRecord
		  dim newMediumRecord as DatabaseRecord
		  dim trimmedMetadatum as string = metadatum.Trim
		  dim creationDate as new date
		  dim finalHash as string = "pending"
		  dim rollbackNewDocumentOutcome as pdOutcome
		  dim objidxs(-1) as string
		  dim createMediumOutcome as pdOutcome
		  dim mediumPickTimeout as integer
		  
		  newDocument.pool = poolname
		  
		  do until readStream.EOF
		    
		    fragmentData = readStream.Read(maxRecordSize)  // get a fragment
		    
		    // we need to decide which medium to write it to
		    mediumPickTimeout = 0
		    do
		      Media = getMediaDetails(poolname)
		      if Media.Ubound < 0 then   // getMediaDetails failed
		        rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		        return new pdOutcome(CurrentMethodName + ": Failed to get media info: " + ErrorMsg +" : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		      end if
		      PickedMedium = pickSuitableMedium(Media , fragmentData.LenB) // pick a medium 
		      
		      if PickedMedium = -1 then 
		        createMediumOutcome = createNextMedium(poolname)
		        
		        select case createMediumOutcome.fatalErrorCode
		        case 1  // infrastructure error
		          rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		          return new pdOutcome(CurrentMethodName + ": Failed to create new medium (" + createMediumOutcome.fatalErrorMsg + "): Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		        case 2  // maintenance lock on this pool
		          app.SleepCurrentThread(2000)
		          mediumPickTimeout = mediumPickTimeout + 1
		        end select
		        
		        if mediumPickTimeout = 10 then
		          rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		          return new pdOutcome(CurrentMethodName + ": Timeout while retrying to create new medium (" + createMediumOutcome.fatalErrorMsg + "): Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		        end if
		      end if
		    loop until PickedMedium > 0
		    
		    
		    if setActiveMedium(poolname , PickedMedium) = false then  // failed to change medium
		      rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		      return new pdOutcome(CurrentMethodName + ": Failed to open medium: " + poolname + str(PickedMedium) + " : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		    end if
		    
		    md5calculator.Process(fragmentData)
		    
		    newPoolCatalogueRecord = new DatabaseRecord
		    newPoolCatalogueRecord.IntegerColumn("mediumidx") = PickedMedium
		    newPoolCatalogueRecord.Int64Column("size") = fragmentData.LenB
		    newPoolCatalogueRecord.DateColumn("creationstamp") = creationDate
		    newPoolCatalogueRecord.DateColumn("lastchange") = creationDate
		    newPoolCatalogueRecord.BooleanColumn("deleted") = false
		    newPoolCatalogueRecord.BooleanColumn("locked") = true
		    if trimmedMetadatum <> empty then newPoolCatalogueRecord.Column("metadatum") = trimmedMetadatum
		    
		    if firstObjidx = -1 and readStream.EOF = true then firstObjidx = 0  // this is the first and only fragment
		    if readStream.EOF = true then finalHash = EncodeHex(md5calculator.Value)  // this is the final fragment
		    
		    newPoolCatalogueRecord.Int64Column("firstpart") = firstObjidx
		    newPoolCatalogueRecord.Column("hash") = finalHash
		    
		    activeVFS.InsertRecord(poolname , newPoolCatalogueRecord)  // create the record in the pool catalogue
		    if activeVFS.Error = true then 
		      rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		      return new pdOutcome(CurrentMethodName + ":  Error creating pool table record: " + activeVFS.ErrorMessage + "  : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		    end if
		    
		    newlyCreatedObjidx = activeVFS.LastRowID
		    
		    newFragment = new pdstorage_fragment
		    newFragment.objidx = newlyCreatedObjidx  // necessary for rollback
		    newFragment.mediumidx = PickedMedium     // necessary for rollback
		    newDocument.fragments.Append newFragment
		    
		    if firstObjidx = -1 then   // first part of a fragmented document has just been stored - it's missing the correct firstpart field value
		      newDocument.fragmented = true
		      firstObjidx = newlyCreatedObjidx
		      activeVFS.SQLExecute("UPDATE " + poolname + " SET firstpart = " + str(firstObjidx) + " WHERE objidx = " + str(firstObjidx))  // update the firstpart field of the first record of a fragmented document
		      if activeVFS.Error = true then  // 
		        rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		        return new pdOutcome(CurrentMethodName + ":  Error updating first fragment record: " + activeVFS.ErrorMessage + "  : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		      end if
		    end if
		    
		    if firstObjidx > 0 and readStream.EOF = true then  // the last part of a fragmented document, all past records are missing the correct hash
		      activeVFS.SQLExecute("UPDATE " + poolname + " SET hash = '" + finalHash + "' WHERE firstpart = " + str(firstObjidx))
		      if activeVFS.Error = true then  // 
		        rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		        return new pdOutcome(CurrentMethodName + ":  Error updating document hash: " + activeVFS.ErrorMessage + "  : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		      end if
		    end if
		    
		    // at this point we have created/updated entries in the pool master table
		    // we are ready to write content into the selected medium
		    
		    newMediumRecord = new DatabaseRecord
		    newMediumRecord.Int64Column("objidx") = newlyCreatedObjidx
		    newMediumRecord.Int64Column("firstpart") = firstObjidx
		    newMediumRecord.BlobColumn("content") = fragmentData
		    // the correct medium has already been opened
		    activeMedium.InsertRecord("content" , newMediumRecord)
		    
		    if activeMedium.Error = true then
		      rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		      return new pdOutcome(CurrentMethodName + ":  Error creating content table record: " + activeMedium.ErrorMessage + "  : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		    end if
		    
		  loop  // get next fragment if any
		  
		  // we need to unlock newly created fragment records
		  for i as integer = 0 to newDocument.fragments.Ubound
		    objidxs.Append str(newDocument.fragments(i).objidx)
		  next i
		  
		  activeVFS.SQLExecute("UPDATE " + poolname + " SET locked = 'false' WHERE objidx IN (" + join(objidxs , ",") + ")")
		  if activeVFS.Error = true then  // 
		    rollbackNewDocumentOutcome = rollbackPushData(newDocument)
		    return new pdOutcome(CurrentMethodName + ":  Error unlocking document fragments: " + activeVFS.ErrorMessage + "  : Rollback outcome: " + if(rollbackNewDocumentOutcome.ok = true , "DONE" , rollbackNewDocumentOutcome.fatalErrorMsg))
		  end if
		  
		  // all went well, return the document objidx in the outcome
		  
		  dim okOutcome as new pdOutcome(true)
		  okOutcome.returnObject = newDocument.fragments(0).objidx
		  return okOutcome
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function rollbackInitPool(poolname as string) As pdOutcome
		  if IsNull(activeVFS) = true then return new pdOutcome(CurrentMethodName + ": VFS session is no longer active")
		  
		  activeVFS.SQLExecute("DROP TABLE " + poolname)
		  if activeVFS.Error = true then return new pdOutcome(CurrentMethodName + ": Rollback pool init fail: "+ activeVFS.ErrorMessage)
		  
		  activeVFS.SQLExecute("DELETE FROM pools WHERE name = '" + poolname + "'")
		  if activeVFS.Error = true then return new pdOutcome(CurrentMethodName + ": Rollback pool init fail: "+ activeVFS.ErrorMessage)
		  
		  if IsNull(poolPasswords) = false then
		    if poolPasswords.HasKey(poolname) = true then poolPasswords.Remove(poolname)
		  end if
		  
		  Return new pdOutcome(true)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function rollbackPushData(targetDoc as pdstorage_document) As pdOutcome
		  dim errors(-1) as string
		  
		  for i as integer = 0 to targetDoc.fragments.Ubound
		    
		    activeVFS.SQLExecute("DELETE FROM " + targetDoc.pool + " WHERE objidx = " + str(targetDoc.fragments(i).objidx))
		    if activeVFS.Error = true then Errors.Append "Error deleting fragment record " + str(targetDoc.fragments(i).objidx) + " : " + activeVFS.ErrorMessage
		    
		    if setActiveMedium(targetDoc.pool , targetDoc.fragments(i).mediumidx) = false then errors.Append "Error loading medium " + targetDoc.pool + "." + str(targetDoc.fragments(i).mediumidx) + " : " + getLastError
		    activeMedium.SQLExecute("DELETE FROM content WHERE objidx = " + str(targetDoc.fragments(i).objidx))
		    if activeMedium.Error = true then Errors.Append "Error deleting fragment content " + targetDoc.pool + "." + str(targetDoc.fragments(i).mediumidx) + " : " + activeMedium.ErrorMessage
		    
		  next i
		  
		  if Errors.Ubound < 0 then
		    return new pdOutcome(true)
		  else
		    Return new pdOutcome(CurrentMethodName + " : " + join(errors , " // "))
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function setActiveMedium(poolname as string , idx as integer) As Boolean
		  // important: if the medium is encrypted then the password is searched ONLY IN CACHE
		  ErrorMsg = empty
		  
		  dim mediumInfo as pdstorage_medium = getMediumDetails(poolname , idx)
		  if mediumInfo.error = true then
		    ErrorMsg = mediumInfo.errorMessage
		    return false
		  end if
		  
		  if IsNull(activeMedium) = false then
		    if isnull(activeMedium.DatabaseFile) = false then
		      if activeMedium.DatabaseFile.NativePath = activeMediumFilename then
		        if activeMediumFilename = mediumInfo.file.NativePath then return true  // already connected to the medium, no need to reconnect
		      end if
		    end if
		  end if
		  
		  dim poolInfo as pdstorage_pool = getPoolDetails(poolname)
		  if poolInfo.error = true then
		    ErrorMsg = poolInfo.errorMessage
		    return false
		  end if
		  
		  dim saltedPassword , unsaltedPassword as string
		  if poolInfo.encrypted = true then
		    if poolPasswords.HasKey(poolname) = false then 
		      ErrorMsg = "No cached password for pool " + poolname
		      return false
		    end if
		    dim salt as string = getPoolSalt(poolname)
		    if salt = "error" then 
		      ErrorMsg = CurrentMethodName + ": Error verifying password for pool <" +poolname + "> : " + ErrorMsg
		      return false
		    end if
		    salt = salt.fromBase64
		    unsaltedPassword = poolPasswords.Value(poolname).StringValue.fromBase64
		    saltedPassword = salt.left(16-(unsaltedPassword.len + 3)) + unsaltedPassword + salt.Right(3)
		  end if
		  
		  if mediumInfo.folder.Name.NthField(".",1) <> poolname or mediumInfo.folder.Name.NthField(".",2) <> str(idx) then
		    ErrorMsg = CurrentMethodName + ": Inconsistent medium folder for medium " + poolname + "." + str(idx)
		    return false
		  end if
		  
		  closeActiveMedium
		  
		  activeMedium = new SQLiteDatabase
		  activeMedium.DatabaseFile = mediumInfo.file
		  if poolInfo.encrypted = true then activeMedium.EncryptionKey = saltedPassword
		  
		  if activeMedium.Connect = false then
		    ErrorMsg = CurrentMethodName + ": Failed to connect to medium " + poolname + str(idx) + " : " + activeMedium.ErrorMessage
		    activeMedium = nil
		    return false
		  end if
		  
		  activeMedium.MultiUser = true
		  activeMediumFilename = activeMedium.DatabaseFile.NativePath
		  
		  // verify that medium file descriptor is consistent with pool/idx info queried
		  // we test: 1.medium belongs to this vfs - 2.medium belongs to this pool - 3.medium is this idx
		  dim mVFSname , mPoolname , mIdx as string
		  dim rs as RecordSet = activeMedium.SQLSelect("SELECT * FROM pdvfs WHERE key = 'vfsname' OR key = 'pool' OR key = 'idx'")
		  if activeMedium.Error = true then  
		    ErrorMsg = "Error getting medium " + poolname + "." + str(idx) + " descriptor: " + activeMedium.ErrorMessage
		    closeActiveMedium
		    return false
		  end if
		  
		  if rs.RecordCount <> 3 then 
		    ErrorMsg = "Error validating descriptor for medium "  + poolname + "." + str(idx) + " : Missing descriptor fields"
		    closeActiveMedium
		    return false
		  end if
		  
		  while not rs.EOF
		    if rs.Field("key").StringValue = "vfsname" then mVFSname = rs.Field("value1").StringValue
		    if rs.Field("key").StringValue = "pool" then mPoolname = rs.Field("value1").StringValue
		    if rs.Field("key").StringValue = "idx" then mIdx = rs.Field("value1").StringValue
		    rs.MoveNext
		  wend
		  
		  if mVFSname <> getInitOutcome.returnObject.StringValue then 
		    ErrorMsg = "Error validating descriptor for medium "  + poolname + "." + str(idx) + " : inconsistent VFS name"
		    closeActiveMedium
		    return false
		  end if
		  
		  if mPoolname <> poolname then
		    ErrorMsg = "Error validating descriptor for medium "  + poolname + "." + str(idx) + " : inconsistent pool name"
		    closeActiveMedium
		    return false
		  end if
		  
		  if mIdx <> str(idx) then
		    ErrorMsg = "Error validating descriptor for medium "  + poolname + "." + str(idx) + " : inconsistent medium ID"
		    closeActiveMedium
		    return false
		  end if
		  
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function testPoolPassword(poolname as string  , unsaltedPassword as string) As pdOutcome
		  if unsaltedPassword.Len < 6 then return new pdOutcome(CurrentMethodName + ": Password must be more than 5 characters")
		  if unsaltedPassword.len > 10 then return new pdOutcome(CurrentMethodName + ": Password must be maximum 10 characters")
		  
		  dim mediumInfo as pdstorage_medium = getMediumDetails(poolname , 1)
		  if mediumInfo.error = true then return new pdOutcome(CurrentMethodName + ": Error verifying password for pool <" + poolname + "> : " + mediumInfo.errorMessage)
		  
		  dim salt as string = getPoolSalt(poolname)
		  if salt = "error" then return new pdOutcome(CurrentMethodName + ": Error verifying password for pool <" +poolname + "> : " + ErrorMsg)
		  salt = salt.fromBase64
		  dim saltedPassword as string = salt.left(16-(unsaltedPassword.len + 3)) + unsaltedPassword + salt.Right(3)
		  
		  dim testDB as new SQLiteDatabase
		  testDB.DatabaseFile = mediumInfo.folder.Child(getFixedMediumFilename)
		  testDB.EncryptionKey = saltedPassword
		  
		  if testDB.DatabaseFile = nil then return new pdOutcome(CurrentMethodName + ": Invalid medium file path while verifying password for pool <" + poolname + ">")
		  if testDB.DatabaseFile.Exists = false then return new pdOutcome(CurrentMethodName + ": Missing medium file while verifying password for pool <" + poolname + ">")
		  
		  if testDB.Connect = False then 
		    dim outcome as new pdOutcome(CurrentMethodName + ": Error verifying password")
		    outcome.fatalErrorCode = 2 // this is what differentiates infrastructure errors from *most probably* incorrect password: infrastructure errors are code 1
		    testDB.Close
		    return outcome
		  else // connection ok, password is correct
		    testDB.close
		    return new pdOutcome(true)
		  end if
		  
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event poolPasswordRequest(poolname as string) As string
	#tag EndHook


	#tag Property, Flags = &h21
		Private activeMedium As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private activeMediumFilename As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private activeVFS As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ErrorMsg As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private initOutcome As pdOutcome
	#tag EndProperty

	#tag Property, Flags = &h21
		Private poolPasswords As Dictionary
	#tag EndProperty


	#tag Constant, Name = maxRecordSize, Type = Double, Dynamic = False, Default = \"67108864", Scope = Private
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
