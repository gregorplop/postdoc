#tag WebPage
Begin WebDialog newDatabaseWizard
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   322
   HelpTag         =   ""
   HorizontalCenter=   0
   Index           =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   MinHeight       =   0
   MinWidth        =   0
   Resizable       =   False
   Style           =   "None"
   TabOrder        =   0
   Title           =   "Create postdoc system"
   Top             =   0
   Type            =   2
   VerticalCenter  =   0
   Visible         =   True
   Width           =   389
   ZIndex          =   1
   _DeclareLineRendered=   False
   _HorizontalPercent=   0.0
   _IsEmbedded     =   False
   _Locked         =   False
   _NeedsRendering =   True
   _OfficialControl=   False
   _OpenEventFired =   False
   _ShownEventFired=   False
   _VerticalPercent=   0.0
   Begin WebLabel Label1
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   22
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "739364863"
      TabOrder        =   0
      Text            =   "Database on server"
      TextAlign       =   0
      Top             =   20
      VerticalCenter  =   0
      Visible         =   True
      Width           =   164
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebLabel Label4
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   38
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "1690316799"
      TabOrder        =   2
      Text            =   "Name"
      TextAlign       =   0
      Top             =   54
      VerticalCenter  =   0
      Visible         =   True
      Width           =   58
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebTextField nameField
      AutoCapitalize  =   True
      AutoComplete    =   True
      AutoCorrect     =   True
      CueText         =   "postdoc system name"
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   "Only lowercase letters, no spaces"
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   175
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      ReadOnly        =   False
      Scope           =   0
      Style           =   "-1"
      TabOrder        =   3
      Text            =   ""
      TextAlign       =   0
      Top             =   54
      Type            =   0
      VerticalCenter  =   0
      Visible         =   True
      Width           =   166
      ZIndex          =   1
      _NeedsRendering =   True
   End
   Begin WebButton createDatabase
      AutoDisable     =   False
      Caption         =   "Do it !"
      Cursor          =   0
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   229
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Scope           =   0
      Style           =   "0"
      TabOrder        =   4
      Top             =   277
      VerticalCenter  =   0
      Visible         =   True
      Width           =   112
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebLabel Label5
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   38
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      Style           =   "1690316799"
      TabOrder        =   2
      Text            =   "Character type"
      TextAlign       =   0
      Top             =   91
      VerticalCenter  =   0
      Visible         =   True
      Width           =   113
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebLabel Label6
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   38
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      Style           =   "1690316799"
      TabOrder        =   2
      Text            =   "Collation"
      TextAlign       =   0
      Top             =   128
      VerticalCenter  =   0
      Visible         =   True
      Width           =   113
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebPopupMenu chartypeMenu
      Cursor          =   0
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   175
      ListIndex       =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      Style           =   "-1"
      TabOrder        =   5
      Top             =   91
      VerticalCenter  =   0
      Visible         =   True
      Width           =   166
      ZIndex          =   1
      _NeedsRendering =   True
   End
   Begin WebPopupMenu collationMenu
      Cursor          =   0
      Enabled         =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   175
      ListIndex       =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      Style           =   "0"
      TabOrder        =   5
      Top             =   128
      VerticalCenter  =   0
      Visible         =   True
      Width           =   166
      ZIndex          =   1
      _NeedsRendering =   True
   End
   Begin WebLabel Label2
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   22
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "739364863"
      TabOrder        =   0
      Text            =   "Location on disk"
      TextAlign       =   0
      Top             =   165
      VerticalCenter  =   0
      Visible         =   True
      Width           =   143
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebLabel Label7
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   73
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   38
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      Style           =   "1690316799"
      TabOrder        =   2
      Text            =   "Root folder for tablespace and storage VFS"
      TextAlign       =   0
      Top             =   199
      VerticalCenter  =   0
      Visible         =   True
      Width           =   113
      ZIndex          =   1
      _DeclareLineRendered=   "False"
      _HorizontalPercent=   "0.0"
      _IsEmbedded     =   "False"
      _Locked         =   "False"
      _NeedsRendering =   True
      _OfficialControl=   "False"
      _OpenEventFired =   "False"
      _VerticalPercent=   "0.0"
   End
   Begin WebTextField tablespacerootField
      AutoCapitalize  =   True
      AutoComplete    =   True
      AutoCorrect     =   True
      CueText         =   "existing folder name"
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   175
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      ReadOnly        =   False
      Scope           =   0
      Style           =   "0"
      TabOrder        =   3
      Text            =   ""
      TextAlign       =   0
      Top             =   199
      Type            =   0
      VerticalCenter  =   0
      Visible         =   True
      Width           =   166
      ZIndex          =   1
      _NeedsRendering =   True
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From WebDialog
		  // Constructor() -- From WebControl
		  // Constructor() -- From WebObject
		  
		  instances = instances + 1
		  
		  //Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  instances = instances - 1
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared instances As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events createDatabase
	#tag Event
		Sub Action()
		  if me.Caption <> "DONE !" then
		    
		    
		    
		  else
		    
		    self.close
		    
		  end if
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events chartypeMenu
	#tag Event
		Sub Shown()
		  me.AddRow pdinit.pgDefaultCharacterType
		  me.AddRow "C"
		  me.AddRow "POSIX"
		  
		  me.ListIndex = 0
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events collationMenu
	#tag Event
		Sub Shown()
		  me.AddRow pdinit.pgDefaultCollation
		  me.AddRow "C"
		  me.AddRow "POSIX"
		  
		  me.ListIndex = 0
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="300"
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
		Group="ID"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Minimum Size"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Minimum Size"
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
		Name="Resizable"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"1 - Sheet"
			"2 - Palette"
			"3 - Modal"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="VerticalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="300"
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
		Name="_ShownEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_VerticalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
#tag EndViewBehavior
