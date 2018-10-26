#tag Class
Protected Class pdaccesstoken
	#tag Property, Flags = &h0
		active As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		applyToContent As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		friendlyname As String
	#tag EndProperty

	#tag Property, Flags = &h0
		name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		resourcename As string
	#tag EndProperty

	#tag Property, Flags = &h0
		resourcetype As ResourceTypes
	#tag EndProperty

	#tag Property, Flags = &h0
		right_Create As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		right_Delete As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		right_Execute As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		right_Features(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h0
		right_Read As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		right_Update As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		sysLog As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="name"
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
		#tag ViewProperty
			Name="active"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="description"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="friendlyname"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="applyToContent"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="resourcename"
			Group="Behavior"
			Type="string"
		#tag EndViewProperty
		#tag ViewProperty
			Name="resourcetype"
			Group="Behavior"
			Type="ResourceTypes"
		#tag EndViewProperty
		#tag ViewProperty
			Name="right_Create"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="right_Delete"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="right_Execute"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="right_Read"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="right_Update"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sysLog"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
