#tag WebPage
Begin WebDialog ActiveUsersMonitor
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   376
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
   Resizable       =   True
   Style           =   "None"
   TabOrder        =   0
   Title           =   "Active Sessions"
   Top             =   0
   Type            =   2
   VerticalCenter  =   0
   Visible         =   True
   Width           =   656
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
   Begin WebListBox UserList
      AlternateRowColor=   &cEDF3FE00
      ColumnCount     =   1
      ColumnWidths    =   "*"
      Cursor          =   0
      Enabled         =   True
      HasHeading      =   False
      HeaderStyle     =   "2005434367"
      Height          =   356
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   0
      ListIndex       =   -1
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      MinimumRowHeight=   19
      Multiline       =   False
      PrimaryRowColor =   &cFFFFFF00
      Scope           =   0
      SelectionStyle  =   "0"
      Style           =   "283168767"
      TabOrder        =   -1
      Top             =   0
      VerticalCenter  =   0
      Visible         =   True
      Width           =   656
      ZIndex          =   1
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
   End
   Begin WebTimer RefreshList
      Cursor          =   0
      Enabled         =   True
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Mode            =   0
      Period          =   2000
      Scope           =   0
      Style           =   "0"
      TabOrder        =   -1
      VerticalCenter  =   0
      ZIndex          =   1
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
   End
   Begin WebLabel noticeLabel
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   22
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "0"
      TabOrder        =   0
      Text            =   "Only showing postdoc sessions , refresh time is 2 seconds."
      TextAlign       =   0
      Top             =   354
      VerticalCenter  =   0
      Visible         =   True
      Width           =   616
      ZIndex          =   1
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
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
		  //Super.Constructor
		  instances = instances + 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  instances = instances - 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RefreshList(content() as Dictionary)
		  dim row(4) as String
		  
		  if content.Ubound < 0 then
		    if UserList.RowCount > 0 then UserList.DeleteAllRows
		    noticeLabel.Text = "No users"
		    Return
		  end if
		  
		  if content.Ubound = 0 and content(0).HasKey("error") then
		    if UserList.RowCount > 0 then UserList.DeleteAllRows
		    noticeLabel.Text = content(0).Value("error").StringValue.pgErrorSingleLine
		    Return
		  end if
		  
		  dim selectionIDX as Integer = UserList.ListIndex
		  
		  UserList.DeleteAllRows
		  for i as integer = 0 to content.Ubound
		    row(0) = str(i+1)
		    row(1) = content(i).Value("pid").StringValue
		    row(2) = content(i).Value("application_name").StringValue
		    row(3) = content(i).Value("usename").StringValue
		    row(4) = content(i).Value("client_addr").StringValue
		    UserList.AddRow row
		  next i
		  
		  if selectionIDX >= 0 and selectionIDX <= UserList.RowCount - 1 then UserList.ListIndex = selectionIDX
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared instances As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events UserList
	#tag Event
		Sub Open()
		  me.ColumnCount  = 5
		  me.Heading(0) = "#"
		  me.Heading(1) = "pgPID"
		  me.Heading(2) = "Session"
		  me.Heading(3) = "Postgres user"
		  me.Heading(4) = "IP Address"
		  
		  me.ColumnWidths = "5%,10%,35%,25%,25%"
		  
		  
		  
		  me.HasHeading = true
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Shown()
		  RefreshList(Session.getActiveDBbackends)
		  RefreshList.mode = timer.ModeMultiple
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events RefreshList
	#tag Event
		Sub Action()
		  RefreshList(Session.getActiveDBbackends)
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
		InitialValue="1"
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
