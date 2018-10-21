#tag WebPage
Begin WebDialog newDatabaseWizard
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   366
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
   Title           =   "Create postdoc database"
   Top             =   0
   Type            =   2
   VerticalCenter  =   0
   Visible         =   True
   Width           =   377
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
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "739364863"
      TabOrder        =   0
      Text            =   "Database on postgres server"
      TextAlign       =   0
      Top             =   20
      VerticalCenter  =   0
      Visible         =   True
      Width           =   321
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
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
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
      HelpTag         =   "Only lowercase letters, no spaces , no freaky characters !"
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
      Password        =   False
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
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
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
      Top             =   321
      VerticalCenter  =   0
      Visible         =   True
      Width           =   112
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
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
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
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
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
      Text            =   ""
      Top             =   91
      VerticalCenter  =   0
      Visible         =   True
      Width           =   166
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
      Text            =   ""
      Top             =   128
      VerticalCenter  =   0
      Visible         =   True
      Width           =   166
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
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "739364863"
      TabOrder        =   0
      Text            =   "Location on server disk"
      TextAlign       =   0
      Top             =   165
      VerticalCenter  =   0
      Visible         =   True
      Width           =   321
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
   Begin WebLabel Label7
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
      Text            =   "Tablespace folder"
      TextAlign       =   0
      Top             =   199
      VerticalCenter  =   0
      Visible         =   True
      Width           =   134
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
   Begin WebTextField tablespaceFolderField
      AutoCapitalize  =   True
      AutoComplete    =   True
      AutoCorrect     =   True
      CueText         =   "folder should exist"
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   "The postdoc database resides on a separate tablespace. This is its path on the server."
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
      Password        =   False
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
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
   End
   Begin WebLabel Label9
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
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "739364863"
      TabOrder        =   0
      Text            =   "Access on completion"
      TextAlign       =   0
      Top             =   236
      VerticalCenter  =   0
      Visible         =   True
      Width           =   321
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
   Begin WebCheckbox autoCreateTokenCheck
      Caption         =   "Create access token for user"
      Cursor          =   1
      Enabled         =   True
      Height          =   22
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
      Scope           =   0
      Style           =   "-1"
      TabOrder        =   7
      Top             =   270
      Value           =   True
      VerticalCenter  =   0
      Visible         =   True
      Width           =   191
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
   Begin WebTextField accessTokenUserField
      AutoCapitalize  =   True
      AutoComplete    =   True
      AutoCorrect     =   True
      CueText         =   "<no user>"
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   25
      HelpTag         =   "If user is specified, connection is only possible through this user name."
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   229
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      Style           =   "0"
      TabOrder        =   3
      Text            =   "pdadmin"
      TextAlign       =   0
      Top             =   267
      Type            =   0
      VerticalCenter  =   0
      Visible         =   True
      Width           =   112
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
		    
		    dim createOutcome as pdOutcome
		    dim savepass2localOutcome as pdOutcome
		    dim tempSession as PostgreSQLDatabase = Session.getDBsession
		    
		    dim outcome as pdOutcome = pdinit.initDatabase(tempSession , nameField.Text.Trim.Lowercase , tablespaceFolderField.Text.Trim , chartypeMenu.Text , collationMenu.Text)
		    
		    if outcome.ok = false then // database init failed
		      
		      MsgBox outcome.fatalErrorMsg + EndOfLine + Join(outcome.warnings , EndOfLine)
		      
		    else  // database init went ok
		      
		      
		      if autoCreateTokenCheck.Value = true then 
		        dim token as pdservicetoken = pdservicetoken.getNew(empty) // no password
		        dim tokenFile as FolderItem
		        
		        if accessTokenUserField.Text.Trim = empty then // no user defined
		          tokenFile = appFolder.Child("tokens").Child(nameField.Text.Trim.Lowercase + "@" + "localhost.pdst")
		        else // user is defined
		          tokenFile = appFolder.Child("tokens").Child(accessTokenUserField.Text.Trim.Lowercase + "@" + nameField.Text.Trim.Lowercase + "@" + "localhost.pdst")
		        end if
		        
		        if tokenFile.Exists = False then  // we are free to create it
		          
		          token.file = tokenFile
		          token.name = tokenFile.Name.NthField("." , 1)
		          token.description = token.name
		          token.database = nameField.Text.Trim.Lowercase
		          token.friendlyName = token.Name
		          token.host = tempSession.Host
		          token.organization = "postdoc"
		          token.port = tempSession.Port
		          token.username = accessTokenUserField.Text.Trim.Lowercase
		          token.comments = "Autocreated by pdconsole_web after database initialization"
		          
		          dim createTokenOutcome as pdOutcome = token.Create
		          if createTokenOutcome.ok = false then MsgBox "Auto-created token " + tokenFile.Name + " failed: " + createTokenOutcome.fatalErrorMsg
		          
		        else  // just show an error message and do nothing
		          MsgBox "Auto-created token " + tokenFile.Name + " already exists!"
		        end if
		      end if
		      
		      MainPage.init
		      me.Caption = "DONE !"
		    end if
		    
		  else  // closing after successful execution
		    
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
