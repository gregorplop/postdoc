#tag Class
Protected Class pdcontroller
Inherits ServiceApplication
	#tag Event
		Sub Pause()
		  // Only gets called on Windows.  We should pause.
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resume()
		  // Only gets called on Windows.  We should resume
		End Sub
	#tag EndEvent

	#tag Event
		Function Run(args() as String) As Integer
		  // This is the program//s main execution point
		  
		  // Note that on Windows, exiting the Run event
		  // does NOT terminate a service application.  The
		  // service won//t terminate until the Stop event
		  // occurs.  So to be consistent, let//s just call 
		  // quit with our exit code
		  
		  terminateFlag = false
		  MsgOut( "pdcontroller starting on " + getHostname)
		  
		  
		  dim tokenFile as FolderItem
		  if appFolder.Child("tokens").Count = 1 then 
		    tokenFile = appFolder.Child("tokens").Item(1)  // no parameters approach
		  else
		    tokenFile = appFolder.Child("tokens").Child(args(1))
		    if tokenFile = nil then quitFormal("Path to token file " + args(1) + " is invalid" , 1)
		    if tokenFile.Exists = false then quitFormal("Token file " + args(1) + " does not exist" , 2)
		  end if
		  
		  // password-protected tokens not supported
		  dim outcome as pdOutcome = pdservicetoken.Open(tokenFile)
		  if outcome.ok = False then quitFormal("Error opening token file: " + outcome.fatalErrorMsg , 3)
		  
		  dim token as pdservicetoken = outcome.returnObject
		  session = new pdsession_controller(token , "pdcontroller")
		  outcome = session.connect
		  if outcome.ok = false then quitFormal("Error connecting to " + token.host + " : " + outcome.fatalErrorMsg , 4)
		  
		  MsgOut("Connected to " + token.host + " on database " + token.database + " as " + token.username)
		  
		  do
		    
		    DoEvents
		    
		  loop Until terminateFlag = true
		  
		  
		  Quit(0)
		End Function
	#tag EndEvent

	#tag Event
		Sub Stop(shuttingDown as Boolean)
		  // This gets called on all platforms (but the
		  // shuttingDown parameter is only valid on Windows)
		  // We should do our cleanup
		  
		  MsgOut("pdcontroller is terminating")
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  Return defaultUnhandledExceptionHandler(error)
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub MsgOut(msg as string)
		  print msg
		  System.DebugLog(msg)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub quitFormal(msg as String , code as Integer)
		  print msg
		  System.DebugLog(msg)
		  Quit(code)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub terminate()
		  terminateFlag = true
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Overview
		pdcontroller is the backend application of a postdoc system.
		- it provices access to its local vfs, if one is present
		- it orchestrates processes that run under its supervision
		- if it is THE master controller, it provides some utility functionality such as a central authority for picking and locking batches
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private session As pdsession_controller
	#tag EndProperty

	#tag Property, Flags = &h21
		Private terminateFlag As Boolean = false
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
