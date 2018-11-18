#tag Class
Protected Class pdWebListbox
Inherits WebListBox
	#tag Method, Flags = &h0
		Function uniqueValueExistsInList(uniqueValue as string) As integer
		  if uniqueColumn < 0 then raise new OutOfBoundsException
		  if uniqueColumn > ColumnCount - 1 then raise new OutOfBoundsException
		  
		  for i as integer = 0 to RowCount - 1
		    if Cell(i , uniqueColumn) = uniqueValue then return i
		  next i
		  
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateAddRow(row() as string)
		  if row.Ubound <> ColumnCount - 1 then Raise new OutOfBoundsException
		  if uniqueColumn < 0 then raise new OutOfBoundsException
		  if uniqueColumn > ColumnCount - 1 then raise new OutOfBoundsException
		  
		  // we need to decide whether to update or insert
		  
		  dim positionInList as Integer = uniqueValueExistsInList(row(uniqueColumn))
		  
		  if positionInList < 0 then // add
		    
		    if uniqueValueIDLastHandled < 0 then  // addrow
		      AddRow(row)
		    else  // InsertRow
		      InsertRow(uniqueValueIDLastHandled , row)
		    end if
		    
		  else // update
		    
		    for i as Integer = 0 to row.Ubound
		      cell(positionInList , i) = row(i)
		    next i
		    
		    uniqueValueIDLastHandled = positionInList
		    
		  end if
		  
		  if uniqueValuesAdded.IndexOf(row(uniqueColumn)) < 0 then uniqueValuesAdded.Append row(uniqueColumn)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateCleanup()
		  if uniqueColumn < 0 then raise new OutOfBoundsException
		  if uniqueColumn > ColumnCount - 1 then raise new OutOfBoundsException
		  if RowCount = 0 then return
		  
		  dim valuesToRemove(-1) as String
		  
		  for i as Integer = 0 to RowCount - 1
		    if uniqueValuesAdded.IndexOf(cell(i , uniqueColumn)) < 0 then valuesToRemove.Append cell(i , uniqueColumn)
		  next i
		  
		  dim idx as integer = 0
		  do
		    if valuesToRemove.IndexOf(cell(idx , uniqueColumn)) >= 0 then RemoveRow(idx)
		  loop until idx = RowCount - 1
		  
		  
		  redim uniqueValuesAdded(-1)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		uniqueColumn As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		uniqueValueIDLastHandled As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		uniqueValuesAdded(-1) As string
	#tag EndProperty

	#tag Property, Flags = &h0
		uniqueValueSelected As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AlternateRowColor"
			Visible=true
			Group="Behavior"
			InitialValue="&cEDF3FE"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Behavior"
			InitialValue="*"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cursor"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Automatic"
				"1 - Standard Pointer"
				"2 - Finger Pointer"
				"3 - IBeam"
				"4 - Wait"
				"5 - Help"
				"6 - Arrow All Directions"
				"7 - Arrow North"
				"8 - Arrow South"
				"9 - Arrow East"
				"10 - Arrow West"
				"11 - Arrow Northeast"
				"12 - Arrow Northwest"
				"13 - Arrow Southeast"
				"14 - Arrow Southwest"
				"15 - Splitter East West"
				"16 - Splitter North South"
				"17 - Progress"
				"18 - No Drop"
				"19 - Not Allowed"
				"20 - Vertical IBeam"
				"21 - Crosshair"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeading"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HorizontalCenter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
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
			Name="ListIndex"
			Visible=true
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinimumRowHeight"
			Visible=true
			Group="Behavior"
			InitialValue="22"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Multiline"
			Visible=true
			Group="Behavior"
			InitialValue="false"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PrimaryRowColor"
			Visible=true
			Group="Behavior"
			InitialValue="&cFFFFFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabOrder"
			Visible=true
			Group="Behavior"
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
			Name="VerticalCenter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ZIndex"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_DeclareLineRendered"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_HorizontalPercent"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_IsEmbedded"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_Locked"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_NeedsRendering"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_OfficialControl"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_OpenEventFired"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_VerticalPercent"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="uniqueColumn"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="uniqueValueSelected"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="uniqueValueIDLastHandled"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
