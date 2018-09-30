#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  Print "pdconsole_web starting..."
		  
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h21
		Private ServiceTokens(-1) As pdservicetoken
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
