#tag Window
Begin Window MainWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   442
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   334008319
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "pdSQLiteStudio"
   Visible         =   True
   Width           =   866
   Begin Listbox MainList
      AutoDeactivate  =   True
      AutoHideScrollbars=   False
      Bold            =   False
      Border          =   True
      ColumnCount     =   1
      ColumnsResizable=   True
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   2
      GridLinesVertical=   4
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   384
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   True
      ScrollBarVertical=   True
      SelectionType   =   1
      ShowDropIndicator=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   16.0
      TextUnit        =   0
      Top             =   27
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   866
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin PopupMenu TableSelector
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   5
      ListIndex       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   415
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   225
   End
   BeginSegmented SegmentedControl DisplayModeSelector
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   685
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacControlStyle =   0
      Scope           =   0
      Segments        =   "Content\n\nTrue\rSchema\n\nFalse"
      SelectionType   =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      Top             =   415
      Transparent     =   True
      Visible         =   True
      Width           =   179
   End
   Begin PushButton refreshBtn
      AutoDeactivate  =   True
      Bold            =   True
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "⟳"
      Default         =   False
      Enabled         =   True
      Height          =   24
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   234
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   16.0
      TextUnit        =   0
      Top             =   415
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   40
   End
   Begin TextField SQLfield
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   "WHERE clause"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   436
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   428
   End
   Begin TextField encryptionKey
      AcceptTabs      =   False
      Alignment       =   1
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   "password"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   2
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   2
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   230
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  windowTitle = "pdSQLiteStudio"
		  DisplayMode = "CONTENT"
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			dim file2open as FolderItem = GetOpenFolderItem("")
			if file2open = nil then return true
			
			dim openOutcome as string = openDatabase(file2open)
			if openOutcome <> "OK" then 
			MsgBox openOutcome
			return true
			end if
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function listBlobFields(schema as RecordSet) As string()
		  dim blobs(-1) as String
		  
		  while not schema.EOF
		    if schema.Field("FieldType").IntegerValue = 14 then blobs.Append schema.Field("ColumnName").StringValue
		    schema.MoveNext
		  wend
		  
		  return Blobs
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function openDatabase(databaseFile as FolderItem) As string
		  dim db as new SQLiteDatabase
		  db.DatabaseFile = databaseFile
		  db.EncryptionKey = encryptionKey.Text.Trim
		  if db.Connect = false then return "Error opening database file : " + db.ErrorMessage
		  
		  db.MultiUser = true
		  
		  if isnull(activeDB) = false then activeDB.close
		  activeDB = db
		  me.Title = windowTitle + " - " + activeDB.DatabaseFile.Name
		  
		  dim tableSchema as RecordSet = activeDB.TableSchema
		  if activeDB.Error = true then return "Error getting table schema : " + activeDB.ErrorMessage
		  
		  MainList.DeleteAllRows
		  TableSelector.DeleteAllRows
		  while not tableSchema.EOF
		    TableSelector.AddRow tableSchema.IdxField(1).StringValue
		    tableSchema.MoveNext
		  wend
		  
		  TableSelector.ListIndex = 0
		  
		  return "OK"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function restrictBlobSize(tablename as string) As string
		  dim schema as RecordSet = activeDB.FieldSchema(tablename)
		  
		  dim fields(-1) as String
		  
		  fields.Append "rowid"
		  
		  while not schema.EOF
		    
		    if schema.Field("FieldType").IntegerValue = 14 then
		      fields.Append "SUBSTR(" + schema.Field("ColumnName").StringValue + ",1,15) AS " + schema.Field("ColumnName").StringValue
		    else
		      fields.Append schema.Field("ColumnName").StringValue
		    end if
		    
		    schema.MoveNext
		  wend
		  
		  return join(fields , " , ")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showRecordset(rs as RecordSet, fieldSchema as RecordSet)
		  dim fieldCount as integer = rs.FieldCount
		  MainList.DeleteAllRows
		  MainList.ColumnCount = fieldCount
		  
		  for i as integer = 1 to fieldCount
		    MainList.Heading(i-1) = rs.IdxField(i).Name
		  next i
		  
		  MainList.HasHeading = true
		  MainList.ColumnsResizable = true
		  
		  dim columnWidthsArray(-1) as string
		  for i as integer = 1 to fieldcount
		    columnWidthsArray.Append str(100 / FieldCount) + "%"
		  next i
		  MainList.ColumnWidths = join(columnWidthsArray , ",")
		  
		  dim row(-1) as string
		  redim row(fieldCount - 1)
		  
		  dim blobs(-1) as string
		  if isnull(fieldSchema) = false then blobs = listBlobFields(fieldSchema)
		  
		  while not rs.EOF
		    for i as Integer = 1 to fieldCount
		      
		      if rs.IdxField(i).Value.IsNull = true then
		        row(i-1) = "<null>"
		      else
		        row(i-1) = rs.IdxField(i).StringValue
		      end if
		      
		      
		    next i
		    MainList.AddRow row
		    rs.MoveNext
		  wend
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showTable(statement as string)
		  if activeDB = nil then exit sub
		  if TableSelector.Text = "" then exit sub
		  
		  dim rs as RecordSet 
		  
		  select case DisplayMode
		    
		  case "CONTENT"
		    
		    rs = activeDB.SQLSelect(statement)
		    
		    if activeDB.Error = true then
		      MsgBox activeDB.ErrorMessage
		    else
		      showRecordset(rs , activeDB.FieldSchema(TableSelector.Text))
		    end if
		    
		  case "SCHEMA"
		    
		    rs = activeDB.FieldSchema(TableSelector.Text)
		    
		    if activeDB.Error = true then
		      MsgBox activeDB.ErrorMessage
		    else
		      showRecordset(rs , nil)
		    end if
		    
		  end select
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		activeDB As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayMode As string
	#tag EndProperty

	#tag Property, Flags = &h0
		windowTitle As String
	#tag EndProperty


#tag EndWindowCode

#tag Events MainList
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  Dim row, column As Integer
		  row = Me.RowFromXY(x,y)
		  column = Me.ColumnFromXY(x,y)
		  
		  base.Append(new MenuItem("Copy cell content as is" , new pair("COPYNORMAL" , str(row)+","+str(column))))
		  base.Append(new MenuItem("Copy Base64 decoded cell content" , new pair("COPYBASE64DEC" , str(row)+","+str(column))))
		  
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  dim PairTag as Pair = hitItem.Tag
		  dim row,column as integer
		  
		  select case PairTag.Left
		  case "COPYNORMAL"
		    row = PairTag.Right.StringValue.NthField(",",1).Val
		    column = PairTag.Right.StringValue.NthField(",",2).Val
		    
		    dim c as new Clipboard
		    c.SetText(me.cell(row,column))
		    
		  case "COPYBASE64DEC"
		    row = PairTag.Right.StringValue.NthField(",",1).Val
		    column = PairTag.Right.StringValue.NthField(",",2).Val
		    
		    dim c as new Clipboard
		    c.SetText(DecodeBase64(me.cell(row,column)))
		    
		  end select
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events TableSelector
	#tag Event
		Sub Change()
		  showTable("SELECT "  + restrictBlobSize(TableSelector.Text) + " FROM " + TableSelector.Text)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DisplayModeSelector
	#tag Event
		Sub Action(itemIndex as integer)
		  select case itemIndex
		    
		  case 0
		    DisplayMode = "CONTENT"
		  case 1
		    DisplayMode = "SCHEMA"
		    
		  end select
		  
		  SQLfield.Text = ""
		  showTable("SELECT " + restrictBlobSize(TableSelector.Text) + " FROM " + TableSelector.Text)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events refreshBtn
	#tag Event
		Sub Action()
		  showTable("SELECT " + restrictBlobSize(TableSelector.Text) + " FROM " + TableSelector.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SQLfield
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  select case asc(key)
		    
		  case 3,13
		    
		    showTable("SELECT " + restrictBlobSize(TableSelector.Text) + " FROM " + TableSelector.Text + if(me.Text = "" , "" , " WHERE " + me.Text))
		    
		    
		    return true
		  else
		    return false
		    
		  end select
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events encryptionKey
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  select case asc(key)
		    
		  case 3,13
		    
		    showTable("SELECT " + restrictBlobSize(TableSelector.Text) + " FROM " + TableSelector.Text + if(me.Text = "" , "" , " WHERE " + me.Text))
		    
		    
		    return true
		  else
		    return false
		    
		  end select
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="windowTitle"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="DisplayMode"
		Group="Behavior"
		Type="string"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
