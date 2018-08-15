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
   Height          =   438
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
   Width           =   672
   Begin PagePanel MainPagePanel
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   438
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
      Value           =   0
      Visible         =   True
      Width           =   672
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
         Left            =   261
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
         Top             =   154
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
         Width           =   632
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
         Left            =   261
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
         Top             =   220
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
         Left            =   572
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
         Height          =   351
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
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   67
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   632
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
         Left            =   368
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
		    MainPagePanel.Value = 1
		    
		  case WindowModes.EditingNew
		    
		    PasswordProtectedLabel.Text = if(activeToken.filePassword = empty , "Not password protected" , "Password protected")
		    MainPagePanel.Value = 0
		    
		    
		  end select
		  
		  state = newState
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tokenToList(token as pdservicetoken , list as Listbox)
		  if list.ColumnCount <> 2 or list.Heading(0) <> "Field name" or list.Heading(1) <> "Field value" then
		    list.ColumnCount = 2
		    list.Heading(0) = "Field name"
		    list.Heading(1) = "Field value"
		    list.HasHeading = true
		    list.HeaderType(-1) = Listbox.HeaderTypes.NotSortable
		    list.ColumnWidths = "30%,70%"
		  end if
		  
		  
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
	#tag EndEnum


#tag EndWindowCode

#tag Events PasswordOKbtn
	#tag Event
		Sub Action()
		  select case state
		    
		  case WindowModes.RequestingPasswordForNew
		    
		    dim inputPass as String = TokenPasswordField.Text.Trim
		    activeToken = pdservicetoken.getNew(inputPass)
		    tokenToList(activeToken , TokenContentsList)
		    
		    SetState(WindowModes.EditingNew)
		    
		  end select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events NewBtn
	#tag Event
		Sub Action()
		  dim s as string
		  
		  s = "!@#test"
		  
		  MsgBox s.QND_extractTypes
		End Sub
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
