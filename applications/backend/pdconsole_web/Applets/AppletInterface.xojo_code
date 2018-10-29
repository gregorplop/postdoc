#tag Interface
Protected Interface AppletInterface
	#tag Method, Flags = &h0
		Sub AppletClose()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppletRefresh()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppletShow(x as integer, y as integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AppletType() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AppletUsesTables() As String()
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Interface
#tag EndInterface
