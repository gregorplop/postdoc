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
   Height          =   508
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "pdServiceTokenStudio - new"
   Visible         =   True
   Width           =   742
   Begin PagePanel MainPagePanel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   508
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   0
      Value           =   1
      Visible         =   True
      Width           =   742
      Begin TextField TokenPasswordField
         AcceptTabs      =   False
         Alignment       =   2
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   ""
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   296
         LimitText       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Password        =   True
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   161
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   150
      End
      Begin Label PasswordLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   2
         Text            =   "Password for Service Token"
         TextAlign       =   1
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   16.0
         TextUnit        =   0
         Top             =   101
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   702
      End
      Begin PushButton PasswordOKbtn
         AutoDeactivate  =   True
         Bold            =   True
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "OK"
         Default         =   False
         Enabled         =   True
         Height          =   35
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   296
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   216
         Underline       =   False
         Visible         =   True
         Width           =   150
      End
      Begin PushButton NewBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "New"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   0
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin PushButton OpenBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Open"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   99
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   0
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin PushButton SaveBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Save"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   198
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   0
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin PushButton QuitBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Quit"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   642
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   0
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Listbox TokenContentsList
         AutoDeactivate  =   True
         AutoHideScrollbars=   True
         Bold            =   False
         Border          =   True
         ColumnCount     =   1
         ColumnsResizable=   False
         ColumnWidths    =   ""
         DataField       =   ""
         DataSource      =   ""
         DefaultRowHeight=   -1
         Enabled         =   True
         EnableDrag      =   False
         EnableDragReorder=   False
         GridLinesHorizontal=   0
         GridLinesVertical=   0
         HasHeading      =   False
         HeadingIndex    =   -1
         Height          =   421
         HelpTag         =   ""
         Hierarchical    =   False
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         InitialValue    =   ""
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollBarVertical=   True
         SelectionType   =   0
         ShowDropIndicator=   False
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   16.0
         TextUnit        =   0
         Top             =   69
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   702
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   1
         Text            =   "Current Limitation: One service token per file"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   37
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   302
      End
      Begin Label PasswordProtectedLabel
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MainPagePanel"
         Italic          =   False
         Left            =   438
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   7
         TabPanelIndex   =   1
         Text            =   "Not password protected"
         TextAlign       =   2
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   37
         Transparent     =   True
         Underline       =   False
         Visible         =   True
         Width           =   284
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  dim args(-1) as String = getGUIappArguments
		  
		  if args.Ubound < 0 then // no file to open
		    
		    SetState(WindowModes.RequestingPasswordForNew)
		    
		    
		    
		  else  // try to open file
		    
		    
		    
		    
		    
		  end if 
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub SetState(newState as WindowModes)
		  select case newState
		    
		  case WindowModes.RequestingPasswordForNew
		    
		    Title = "pdServiceTokenStudio - new"
		    TokenPasswordField.Text = empty
		    MainPagePanel.Value = 1
		    TokenPasswordField.SetFocus
		    
		  case WindowModes.EditingNew
		    
		    PasswordProtectedLabel.Text = if(activeToken.filePassword = empty , "Not password protected" , "Password protected")
		    MainPagePanel.Value = 0
		    SaveBtn.Enabled = true
		    TokenContentsList.EnableD = true
		    
		  case WindowModes.SavedOK
		    SaveBtn.Enabled = false
		    TokenContentsList.EnableD = false
		    
		    
		  case WindowModes.RequestingPasswordForOpening
		    
		    
		    
		    
		    
		  end select
		  
		  state = newState
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tokenToList(token as pdservicetoken , list as Listbox)
		  if list.ColumnCount <> 2 or list.Heading(0) <> "Field name" or list.Heading(1) <> "Field value" then
		    list.DeleteAllRows
		    list.ColumnCount = 2
		    list.Heading(0) = "Field name"
		    list.Heading(1) = "Field value"
		    list.HasHeading = true
		    list.HeaderType(-1) = Listbox.HeaderTypes.NotSortable
		    list.ColumnWidths = "40%,60%"
		    
		    list.AddRowWithTag("Name *" , "!name")  // mandatory
		    list.AddRowWithTag("Friendly name *", "!friendlyname")
		    list.AddRowWithTag("Description" , "description")
		    list.AddRowWithTag("Comments" , "comments")
		    list.AddRowWithTag("(Read Only) Token issued on" , "^tokenissued")  // not editable
		    list.AddRowWithTag("Organization *" , "!organization")
		    list.AddRowWithTag("Server address *" , "!host")
		    list.AddRowWithTag("Server port *" , "!#port")
		    list.AddRowWithTag("User name *" , "!username")
		    list.AddRowWithTag("Password" , "password")
		    list.AddRowWithTag("Secure Connection *" , "%secure")  // Boolean
		    list.AddRowWithTag("SSL Private key (if secure)" , "$ssl_key") // pick file
		    list.AddRowWithTag("SSL Public certificate (if secure)" , "$ssl_certificate") // pick file
		    list.AddRowWithTag("SSL CA certificate (if secure)" , "$ssl_ca") // pick file
		    
		    list.CellType(list.RowHavingTag("%secure") , 1) = Listbox.TypeCheckbox
		    
		  end if
		  
		  
		  
		  list.CellCheck(list.RowHavingTag("%secure") , 1) = token.ssl_force
		  list.Cell(list.RowHavingTag("!name") , 1) = token.name
		  list.Cell(list.RowHavingTag("!friendlyname") , 1)  = token.friendlyName
		  list.Cell(list.RowHavingTag("description") , 1)  = token.description
		  list.Cell(list.RowHavingTag("comments") , 1)  = token.comments
		  
		  if IsNull(token.tokenIssued) = false then
		    list.Cell(list.RowHavingTag("^tokenissued") , 1)  = token.tokenIssued.SQLDateTime
		  else
		    list.Cell(list.RowHavingTag("^tokenissued") , 1)  = "Not issued yet"
		  end if
		  
		  list.Cell(list.RowHavingTag("!organization") , 1)  = token.organization
		  list.Cell(list.RowHavingTag("!host") , 1)  = token.host
		  list.Cell(list.RowHavingTag("!#port") , 1)  = str(token.port)
		  list.Cell(list.RowHavingTag("!username") , 1)  = token.username
		  list.Cell(list.RowHavingTag("password") , 1)  = token.password.toBase64
		  
		  
		  list.Cell(list.RowHavingTag("$ssl_key") , 1)  = token.ssl_key
		  list.Cell(list.RowHavingTag("$ssl_certificate") , 1)  = token.ssl_certificate
		  list.Cell(list.RowHavingTag("$ssl_ca") , 1)  = token.ssl_ca
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		activeToken As pdservicetoken
	#tag EndProperty

	#tag Property, Flags = &h0
		State As WindowModes
	#tag EndProperty


	#tag Enum, Name = WindowModes, Type = Integer, Flags = &h0
		RequestingPasswordForOpening
		  EditingNew
		  EditingOpened
		  RequestingPasswordForNew
		  VerifyingPasswordForNew
		SavedOK
	#tag EndEnum


#tag EndWindowCode

#tag Events PasswordOKbtn
	#tag Event
		Sub Action()
		  select case state
		    
		  case WindowModes.RequestingPasswordForNew
		    
		    dim inputPass as String = TokenPasswordField.Text
		    activeToken = pdservicetoken.getNew(inputPass)
		    tokenToList(activeToken , TokenContentsList)
		    
		    SetState(WindowModes.EditingNew)
		    
		    
		  case WindowModes.RequestingPasswordForOpening
		    
		    
		    
		    
		    
		  end select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NewBtn
	#tag Event
		Sub Action()
		  SetState(WindowModes.RequestingPasswordForNew)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OpenBtn
	#tag Event
		Sub Action()
		  
		  SetState(WindowModes.RequestingPasswordForOpening)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SaveBtn
	#tag Event
		Sub Action()
		  select case state
		    
		  case WindowModes.EditingNew
		    
		    dim target as FolderItem = GetSaveFolderItem("*.*" , activeToken.name + ".pdst")
		    if target = nil then exit sub
		    
		    activeToken.file = target
		    
		    dim outcome as pdOutcome = activeToken.Create
		    if outcome.ok then 
		      SetState(WindowModes.SavedOK)
		    else
		      MsgBox outcome.fatalErrorMsg
		    end if
		    
		  case WindowModes.EditingOpened
		    
		    // in progress
		    
		    
		  end select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events QuitBtn
	#tag Event
		Sub Action()
		  quit
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TokenContentsList
	#tag Event
		Sub DoubleClick()
		  Dim row, column As Integer
		  row = Me.RowFromXY(System.MouseX - Me.Left - Self.Left, System.MouseY - Me.Top - Self.Top)
		  column = Me.ColumnFromXY(System.MouseX - Me.Left - Self.Left, System.MouseY - Me.Top - Self.Top)
		  
		  if state <> WindowModes.EditingNew then exit sub
		  if me.RowTag(row).StringValue.QND_extractTypes.Contains("%") = true then exit sub
		  if me.RowTag(row).StringValue.QND_extractTypes.Contains("^") = true then exit sub
		  
		  if me.RowTag(row).StringValue.QND_extractTypes.Contains("$") = false then 
		    
		    me.EditCell(row,1)
		    // cont'd at cellaction event
		    
		  else  // file contents
		    
		    dim ff as FolderItem = GetOpenFolderItem("*.*")
		    if ff = nil then exit sub
		    if ff.Length > 4096 or ff.Length < 128 then
		      MsgBox "This file is probably not a certificate, will not read it"
		      exit sub
		    end if
		    
		    dim textStream as TextInputStream
		    textStream = TextInputStream.Open(ff)
		    dim contents as string = textStream.ReadAll
		    textStream.Close
		    
		    
		    contents = contents.ReplaceAll(EndOfLine.Windows , empty)
		    contents = contents.ReplaceAll(EndOfLine.UNIX , empty)
		    me.CellTag(row , 1) = contents
		    me.cell(row,1) = ff.NativePath
		    
		    select case me.RowTag(row).StringValue.QND_extractFieldname
		    case "ssl_key"
		      activeToken.ssl_key = me.CellTag(row,1).StringValue.toBase64
		    case "ssl_certificate"
		      activeToken.ssl_certificate = me.CellTag(row,1).StringValue.toBase64
		    case "ssl_ca"
		      activeToken.ssl_ca = me.CellTag(row,1).StringValue.toBase64
		    end select
		    
		    activeToken.ssl_force = true
		    me.CellState(me.RowHavingTag("%secure") , 1) = CheckBox.CheckedStates.Checked
		    
		    
		  end if
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  
		  
		  select case me.RowTag(row).StringValue.QND_extractFieldname
		    
		  case "secure"
		    activeToken.ssl_force = me.CellCheck(row,1)
		    if activeToken.ssl_force = false then
		      activeToken.ssl_certificate = empty
		      activeToken.ssl_ca = empty
		      activeToken.ssl_key = empty
		    end if
		    
		    
		  case "name"
		    activeToken.name = me.cell(row,column).Trim
		  case "friendlyname"
		    activeToken.friendlyName = me.cell(row,column).Trim
		  case "description"
		    activeToken.description = me.cell(row,column).Trim
		  case "comments"
		    activeToken.comments = me.cell(row,column).Trim
		  case "organization"
		    activeToken.organization = me.cell(row,column).Trim
		  case "host"
		    activeToken.host = me.cell(row,column).Trim
		  case "port"
		    activeToken.port = me.cell(row,column).Trim.Val
		  case "username"
		    activeToken.username = me.cell(row,column).Trim
		  case "password"
		    activeToken.password = me.cell(row,column).Trim.toBase64
		    
		  else
		    MsgBox "error assigning field to token object"
		  end select
		  
		  tokenToList(activeToken , me)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PasswordProtectedLabel
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  if activeToken.filePassword <> empty then MsgBox "Password is " + EndOfLine + activeToken.filePassword.fromBase64
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
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
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
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
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
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
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
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
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
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
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="State"
		Group="Behavior"
		Type="WindowModes"
		EditorType="Enum"
		#tag EnumValues
			"0 - RequestingPasswordForOpening"
			"1 - EditingNew"
			"2 - EditingOpened"
			"3 - RequestingPasswordForNew"
			"4 - VerifyingPasswordForNew"
			"5 - SavedOK"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
