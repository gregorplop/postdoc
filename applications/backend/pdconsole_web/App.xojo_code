#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  Print "pdconsole_web starting..."
		  
		  if appFolder.Child("temp").Exists = false then appFolder.Child("temp").CreateAsFolder
		  
		  
		  dim localconf as FolderItem = pdlocalconf.check
		  if localconf = nil then 
		    dim initoutcome as pdOutcome = pdlocalconf.init
		    print "Creating localconf: " + if(initoutcome.ok = true , "OK" , initoutcome.fatalErrorMsg)
		  else
		    print "Found localconf"
		  end if
		End Sub
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
