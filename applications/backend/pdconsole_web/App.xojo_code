#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		ServiceTokens(-1) As pdservicetoken
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
