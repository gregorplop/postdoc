#tag Module
Protected Module ConsoleLib
	#tag Method, Flags = &h0
		Function findRowHavingValue(targetListbox as Listbox , column as integer , value as string) As integer
		  for i as integer = 0 to targetListbox.ListCount - 1
		    if targetListbox.cell(i,column) = value then Return i
		  next i
		  
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function importFolderContents2Pool(dataFolder as FolderItem , targetpool as string) As string
		  kill = false
		  progressCurrent = 0
		  
		  dim ReadOutcome as pdOutcome
		  dim PushOutcome as pdOutcome
		  dim data as MemoryBlock
		  
		  if dataFolder = nil then return "Invalid folder path"
		  if dataFolder.Exists = false then return "Folder does not exist"
		  if vfs = nil then return "No VFS loaded"
		  if targetpool = "" then return "No pool selected"
		  
		  
		  // we have a valid data folder at this point
		  
		  dim filecount as integer = dataFolder.Count
		  progressMax = filecount
		  dim filedata as MemoryBlock
		  
		  for i as integer = 1 to filecount
		    
		    if dataFolder.Item(i).Directory = true then Continue for i
		    
		    ReadOutcome = readBinaryFile(dataFolder.Item(i) , filedata)
		    
		    if ReadOutcome.ok = false then
		      Continue for i
		    end if
		    
		    PushOutcome = vfs.pushData(filedata , targetpool , dataFolder.Item(i).Name)
		    if PushOutcome.ok = false then
		      Continue for i
		    end if
		    
		    progressCurrent = progressCurrent + 1
		    
		    System.DebugLog(str(i))
		    
		    if kill = true then 
		      return "KILLED"
		    end if
		    
		  next i
		  
		  
		  return "OK"
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		kill As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		newPoolObj As pdstorage_pool
	#tag EndProperty

	#tag Property, Flags = &h0
		outcome As string
	#tag EndProperty

	#tag Property, Flags = &h0
		par1 As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		par2 As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		progressCurrent As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		progressMax As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		vfs As pdstorage_session_maintenance
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
			Name="kill"
			Group="Behavior"
			Type="Boolean"
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
			Name="outcome"
			Group="Behavior"
			Type="string"
		#tag EndViewProperty
		#tag ViewProperty
			Name="progressCurrent"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="progressMax"
			Group="Behavior"
			Type="Integer"
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
End Module
#tag EndModule
