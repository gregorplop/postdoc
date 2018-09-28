#tag Module
Protected Module pdcoreLib_GUI
	#tag Method, Flags = &h0
		Sub AddRowWithTag(extends list as listbox , rowText as string , tag as Variant)
		  list.AddRow rowText
		  list.RowTag(list.LastIndex) = tag
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowHavingTag(extends list as listbox , tag as string) As integer
		  for i as integer =0 to list.ListCount
		    if list.RowTag(i).StringValue = tag then return i
		  next i
		  
		  return -1
		  
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
End Module
#tag EndModule
