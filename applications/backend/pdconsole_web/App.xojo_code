#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  Print "pdconsole_web starting..."
		  
		  ServiceTokens = pdservicetoken.loadFolderTokens(appFolder.Child("tokens") , true)
		  
		  if ServiceTokens.Ubound < 0 then print "error: no service tokens found in tokens folder"
		  
		  dim newTokenFolder as FolderItem = appFolder.Child("tokens.new")
		  if newTokenFolder.Exists = false then newTokenFolder.CreateAsFolder
		  
		  
		  dim localconf as FolderItem = pdlocalconf.check
		  if localconf = nil then 
		    dim initoutcome as pdOutcome = pdlocalconf.init
		    print "Creating localconf: " + if(initoutcome.ok = true , "OK" , initoutcome.fatalErrorMsg)
		  else
		    print "Found localconf"
		  end if
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function getTokenByIDX(IDX as integer) As pdservicetoken
		  if IDX > ServiceTokens.Ubound then return nil
		  if IDX < 0 then return nil
		  
		  return ServiceTokens(IDX)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTokensFriendlyNames() As string()
		  dim output(-1) as string
		  
		  for i as integer = 0 to ServiceTokens.Ubound
		    output.Append ServiceTokens(i).friendlyName
		  next i
		  
		  return output
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ServiceTokens(-1) As pdservicetoken
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
