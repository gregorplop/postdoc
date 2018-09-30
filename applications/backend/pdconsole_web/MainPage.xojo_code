#tag WebPage
Begin WebPage MainPage
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   644
   HelpTag         =   ""
   HorizontalCenter=   0
   ImplicitInstance=   True
   Index           =   -2147483648
   IsImplicitInstance=   False
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   MinHeight       =   400
   MinWidth        =   600
   Style           =   "1422591999"
   TabOrder        =   0
   Title           =   "pdconsole_web"
   Top             =   0
   VerticalCenter  =   0
   Visible         =   True
   Width           =   1092
   ZIndex          =   1
   _DeclareLineRendered=   False
   _HorizontalPercent=   0.0
   _ImplicitInstance=   False
   _IsEmbedded     =   False
   _Locked         =   False
   _NeedsRendering =   True
   _OfficialControl=   False
   _OpenEventFired =   False
   _ShownEventFired=   False
   _VerticalPercent=   0.0
   Begin WebLabel StatusFooter_label
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   22
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      Style           =   "1985513471"
      TabOrder        =   0
      Text            =   "Status footer"
      TextAlign       =   2
      Top             =   622
      VerticalCenter  =   0
      Visible         =   False
      Width           =   1092
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
   Begin WebLabel appName_label
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   93
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   545
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      Style           =   "1170515967"
      TabOrder        =   1
      Text            =   "pdconsole_web"
      TextAlign       =   0
      Top             =   0
      VerticalCenter  =   0
      Visible         =   True
      Width           =   547
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
   Begin WebListBox AppletsList
      AlternateRowColor=   &cEDF3FE00
      ColumnCount     =   1
      ColumnWidths    =   "*"
      Cursor          =   0
      Enabled         =   True
      HasHeading      =   False
      HeaderStyle     =   "0"
      Height          =   590
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      InitialValue    =   ""
      Left            =   20
      ListIndex       =   -1
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MinimumRowHeight=   22
      Multiline       =   False
      PrimaryRowColor =   &cFFFFFF00
      Scope           =   0
      SelectionStyle  =   "0"
      Style           =   "807745535"
      TabOrder        =   -1
      Top             =   20
      VerticalCenter  =   0
      Visible         =   False
      Width           =   266
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
   Begin WebLink postdoc_link
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   False
      Height          =   42
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   625
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      Style           =   "807522303"
      TabOrder        =   3
      Target          =   2
      Text            =   "part of the postdoc edm project"
      TextAlign       =   3
      Top             =   91
      URL             =   "https://github.com/gregorplop/postdoc"
      VerticalCenter  =   0
      Visible         =   True
      Width           =   467
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
	#tag Event
		Sub Open()
		  myLoginDialog = new LoginDialog
		  myLoginDialog.Show
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub init()
		  refreshStateIndicators
		  
		  AppletsList.Visible = true
		  StatusFooter_label.Visible = true
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub refreshStateIndicators()
		  dim token as pdservicetoken = Session.getServiceToken
		  me.Title = "pdconsole_web  - " + token.username + "@" + token.database + "@" + token.host
		  StatusFooter_label.Text = "user " + token.username.Uppercase + " connected to database " + token.database.Uppercase + " on server " + token.host.Uppercase
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showApplets(appletName as string)
		  select case appletName
		    
		  case "SYSROLESINIT"
		    
		    if createRolesWizard.instances < 1 then
		      dim roleCreator as new createRolesWizard
		      roleCreator.Top = postdoc_link.Top + postdoc_link.Height
		      roleCreator.Left = AppletsList.Left + AppletsList.Width + 20
		      
		      roleCreator.Show
		    else
		      MsgBox "This wizard is already open"
		    end if
		    
		    
		  end select
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		myLoginDialog As LoginDialog
	#tag EndProperty


#tag EndWindowCode

#tag Events AppletsList
	#tag Event
		Sub Shown()
		  me.AddRow " setup postdoc on this server"
		  me.CellStyle(me.LastIndex,0) = textBold_style
		  
		  me.AddRow " create group and login roles"
		  me.RowTag(me.LastIndex) = "SYSROLESINIT"
		  
		  me.AddRow " initialize postdoc system"
		  me.RowTag(me.LastIndex) = "PDINIT"
		  
		  me.AddRow " create service tokens"
		  me.RowTag(me.LastIndex) = "SERVICETOKENBUILDER"
		  
		  
		  
		  me.AddRow " setup archives"
		  me.CellStyle(me.LastIndex,0) = textBold_style
		  
		  me.AddRow " create new storage pool"
		  me.RowTag(me.LastIndex) = "CREATEPOOL"
		  
		  me.AddRow " create new archive"
		  me.RowTag(me.LastIndex) = "CREATEARCHIVE"
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseDown(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  dim row as integer = me.ListIndex
		  if row < 0 then exit sub
		  
		  if me.CellStyle(row,0) = textBold_style then me.Selected(row) = false
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  dim row as integer = me.ListIndex
		  if row < 0 then exit sub
		  
		  showApplets(me.RowTag(row).StringValue.Uppercase)
		  
		  
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
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
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
		InitialValue="-2147483648 "
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsImplicitInstance"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Group="Position"
		InitialValue="0"
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
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
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
		Name="TabOrder"
		Group="Behavior"
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
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
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
		Name="_ImplicitInstance"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
