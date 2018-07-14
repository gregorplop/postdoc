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
   Height          =   536
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "pdVFS testing ground"
   Visible         =   True
   Width           =   1230
   Begin TextArea Log
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   True
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   505
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   448
      LimitText       =   0
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   762
   End
   Begin GroupBox MaintenanceFunctions
      AutoDeactivate  =   True
      Bold            =   True
      Caption         =   "Maintenance"
      Enabled         =   True
      Height          =   330
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   20
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   416
      Begin TextField createNextMedium_poolname
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Pool name"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   17
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "defaultpool"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   271
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   224
      End
      Begin PushButton createNextMedium_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Create Next Medium"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   16
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   270
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin CheckBox createNewPool_autoexpand
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Auto-create media"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   47
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   1
         TabIndex        =   14
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   198
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   131
      End
      Begin TextField createNewPool_threshold
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Media Max Size"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   304
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
         TabIndex        =   12
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "512"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   197
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField createNewPool_rootfolder
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Pool Root Folder"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   11
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "c:\\vfs"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   197
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField createNewPool_friendlyname
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Friendly name"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   304
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
         TabIndex        =   10
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "The Default Pool"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   161
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField createNewPool_poolname
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Pool name"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   9
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "defaultpool"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   161
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField open_file
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "VFS file"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "c:\\vfs\\vfs"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField initVFS_friendlyname
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Friendly name"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Test VFS"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   86
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField initVFS_name
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Name"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   304
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
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "testvfs"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField initVFS_file
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "VFS file"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "c:\\vfs\\vfs"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin PushButton createNewPool_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Create New Pool"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   8
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   160
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin PushButton pdvfs_session_open_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Open VFS"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   14.0
         TextUnit        =   0
         Top             =   123
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin PushButton initVFS_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Create new VFS"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   14.0
         TextUnit        =   0
         Top             =   56
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin TextField initVFS_password
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Password"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   304
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   86
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField open_password
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Password"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   304
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
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField createNewPool_password
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Pool media password"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   190
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
         TabIndex        =   13
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   230
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   224
      End
      Begin CheckBox createNewPool_autoclose
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Auto-close full media"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   47
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   1
         TabIndex        =   15
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   234
         Underline       =   False
         Value           =   True
         Visible         =   True
         Width           =   134
      End
      Begin PushButton closeActiveMedium_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Close Active Medium"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "MaintenanceFunctions"
         Italic          =   False
         Left            =   40
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   18
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   307
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
   End
   Begin GroupBox DataTransferFunctions
      AutoDeactivate  =   True
      Bold            =   True
      Caption         =   "Data Transfer"
      Enabled         =   True
      Height          =   141
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   13
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   21
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   375
      Underline       =   False
      Visible         =   True
      Width           =   416
      Begin PushButton ImportFolderBtn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Import Folder"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   33
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   418
         Underline       =   False
         Visible         =   True
         Width           =   252
      End
      Begin TextField ImportFolderField
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Import Folder"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   297
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
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "c:\\testdata2"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   419
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin PushButton pullData_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "Pull single file"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   33
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   455
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin TextField pulldata_targetfolder
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "target folder"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   297
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
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "c:\\vfs"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   455
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField pulldata_objidx
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "objidx"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   183
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
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   455
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
      Begin TextField pulldata_poolname
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "Pool name"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   22
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   144
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
         Text            =   "defaultpool"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   391
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   141
      End
      Begin PushButton exportpool_btn
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   "0"
         Cancel          =   False
         Caption         =   "export entire pool"
         Default         =   False
         Enabled         =   True
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   33
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   484
         Underline       =   False
         Visible         =   True
         Width           =   141
      End
      Begin TextField pulldata_exportfolder
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   False
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         CueText         =   "target folder"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   25
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "DataTransferFunctions"
         Italic          =   False
         Left            =   297
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
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "c:\\outdata"
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   484
         Underline       =   False
         UseFocusRing    =   True
         Visible         =   True
         Width           =   110
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function passwordHandler(sender as pdstorage_session, poolname as String) As string
		  dim pass as Variant = InputWindow.getInput("Password request for " + poolname , "Enter password for pool " + poolname)
		  
		  if pass = nil then
		    return ""
		  else
		    return pass.StringValue
		  end if
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		activeVFS As pdstorage_session_maintenance
	#tag EndProperty


#tag EndWindowCode

#tag Events createNextMedium_btn
	#tag Event
		Sub Action()
		  log.AppendText EndOfLine
		  log.AppendText "pdstorage_session.createNextMedium: " + EndOfLine
		  log.AppendText "   poolname = " + createNextMedium_poolname.Text + EndOfLine
		  
		  dim outcome as pdOutcome = activeVFS.public_createNextMedium(createNextMedium_poolname.Text)
		  
		  log.AppendText "Result: " + if(outcome.ok = true , "OK" , outcome.fatalErrorMsg) + EndOfLine
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events createNewPool_btn
	#tag Event
		Sub Action()
		  log.AppendText EndOfLine
		  log.AppendText "pdstorage_session.createNewPool: " + EndOfLine
		  log.AppendText "   poolname = " + createNewPool_poolname.Text + EndOfLine
		  log.AppendText "   friendlyname = " + createNewPool_friendlyname.Text + EndOfLine
		  log.AppendText "   rootfolder = " + createNewPool_rootfolder.Text + EndOfLine
		  log.AppendText "   threshold = " + createNewPool_threshold.Text + EndOfLine
		  log.AppendText "   autoexpand = " + str(createNewPool_autoexpand.Value) + EndOfLine
		  log.AppendText "   password = " + createNewPool_password.Text + EndOfLine
		  
		  dim newPool as new pdstorage_pool
		  newPool.name = createNewPool_poolname.Text
		  newPool.friendlyName = createNewPool_friendlyname.Text
		  newPool.rootFolder = GetFolderItem(createNewPool_rootfolder.Text)
		  newPool.mediumThreshold = createNewPool_threshold.Text.Val
		  newPool.autoExpand = createNewPool_autoexpand.Value
		  newPool.autoClose = createNewPool_autoclose.Value
		  newPool.comments = "test comments"
		  newPool.password = createNewPool_password.Text.Trim
		  
		  dim outcome as pdOutcome = activeVFS.public_createNewPool(newPool)
		  
		  log.AppendText "Result: " + if(outcome.ok = true , "OK" , outcome.fatalErrorMsg) + EndOfLine
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pdvfs_session_open_btn
	#tag Event
		Sub Action()
		  log.AppendText "pdstorage_session.open: " + EndOfLine
		  log.AppendText "   fsdbfile = " + open_file.Text + EndOfLine
		  
		  dim openVFS as new pdstorage_vfs
		  
		  openVFS.DBfile = GetFolderItem(open_file.Text)
		  openVFS.password = open_password.Text
		  
		  activeVFS = new pdstorage_session_maintenance(openVFS)
		  
		  log.AppendText "result: " + if(activeVFS.getInitOutcome.ok = true , "OK" , activeVFS.getInitOutcome.fatalErrorMsg) +  EndOfLine
		  
		  if activeVFS.getInitOutcome.ok = false then exit sub
		  
		  
		  log.AppendText "available pools: " + join(activeVFS.getPoolNames , " , ")
		  
		  AddHandler activeVFS.poolPasswordRequest , AddressOf passwordHandler
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events initVFS_btn
	#tag Event
		Sub Action()
		  log.AppendText empty
		  log.AppendText "pdfs_maintenance.initVFS :" + EndOfLine
		  log.AppendText "   newDBfile = " + initVFS_file.Text + EndOfLine
		  log.AppendText "   name = " + initVFS_name.Text + EndOfLine
		  log.AppendText "   friendlyname = " + initVFS_friendlyname.Text + EndOfLine
		  
		  dim newVFS as new pdstorage_vfs
		  newVFS.DBfile = GetFolderItem(initVFS_file.Text)
		  newVFS.description = "this is the description"
		  newVFS.name = initVFS_name.Text
		  newVFS.friendlyName = initVFS_friendlyname.Text
		  newVFS.password = initVFS_password.Text.Trim
		  
		  dim Outcome as pdOutcome = pdstorage_maintenance.initVFS(newVFS)
		  
		  log.AppendText "Result: " + if(outcome.ok = true , "OK" , Outcome.fatalErrorMsg) +  EndOfLine
		  
		  
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events closeActiveMedium_btn
	#tag Event
		Sub Action()
		  activeVFS.closeActiveMedium
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ImportFolderBtn
	#tag Event
		Sub Action()
		  log.AppendText EndOfLine
		  dim ReadOutcome as pdOutcome
		  dim PushOutcome as pdOutcome
		  dim data as MemoryBlock
		  
		  dim dataFolder as FolderItem = GetFolderItem(ImportFolderField.Text.Trim)
		  
		  if dataFolder = nil then 
		    MsgBox "Invalid folder path"
		    exit sub
		  end if
		  
		  if dataFolder.Exists = false then
		    MsgBox "Folder does not exist"
		    exit sub
		  end if
		  
		  // we have a valid data folder at this point
		  
		  dim filecount as integer = dataFolder.Count
		  dim filedata as MemoryBlock
		  
		  for i as integer = 1 to filecount
		    
		    if dataFolder.Item(i).Directory = true then Continue for i
		    
		    ReadOutcome = readBinaryFile(dataFolder.Item(i) , filedata)
		    
		    if ReadOutcome.ok = false then
		      log.AppendText ReadOutcome.fatalErrorMsg + EndOfLine
		      Continue for i
		    end if
		    
		    PushOutcome = activeVFS.pushData(filedata , pulldata_poolname.Text , dataFolder.Item(i).Name)
		    if PushOutcome.ok = false then
		      log.AppendText PushOutcome.fatalErrorMsg + EndOfLine
		      Continue for i
		    end if
		    
		    log.AppendText str(now.TotalSeconds) + " - pushed " + dataFolder.Item(i).NativePath + EndOfLine
		    
		    System.DebugLog(str(i))
		    
		  next i
		  
		  MsgBox "end"
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pullData_btn
	#tag Event
		Sub Action()
		  dim outcome as pdOutcome
		  dim data as MemoryBlock
		  
		  data = empty
		  
		  outcome = activeVFS.pullData(pulldata_poolname.Text , pulldata_objidx.Text.Val , data)
		  
		  if outcome.ok = true then 
		    MsgBox outcome.returnObject.StringValue
		  else
		    MsgBox outcome.fatalErrorMsg
		  end if
		  
		  dim targetfile as FolderItem = GetFolderItem(pulldata_targetfolder.Text).Child(pulldata_objidx.Text)
		  
		  dim writeOutcome as pdOutcome = writeBinaryFile(targetfile , data)
		  
		  if writeOutcome.ok = true then
		    MsgBox "OK"
		  else
		    msgbox writeOutcome.fatalErrorMsg
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events exportpool_btn
	#tag Event
		Sub Action()
		  dim outcome as pdOutcome
		  dim data as MemoryBlock
		  
		  
		  dim dump as Dictionary = activeVFS.public_dumpContentList(pulldata_poolname.Text)
		  
		  if dump = nil then 
		    log.AppendText(EndOfLine)
		    log.AppendText(activeVFS.getLastError)
		    exit sub
		  end if
		  
		  dim blobcount as Integer = dump.Count - 1
		  dim targetfile as FolderItem
		  dim objidx as Int64
		  dim name as string
		  dim writeOutcome as pdOutcome
		  for i as integer = 0 to blobcount
		    
		    data = empty
		    objidx = dump.key(i).Int64Value
		    name = dump.Value(str(objidx)).StringValue
		    
		    outcome = activeVFS.pullData(pulldata_poolname.Text , objidx , data)
		    
		    if outcome.ok = false then 
		      log.AppendText("failed to pull objidx = " + str(objidx))
		    end if
		    
		    targetfile = GetFolderItem(pulldata_exportfolder.Text).Child(name)
		    
		    if targetfile.Exists = true then Continue for i
		    
		    writeOutcome = writeBinaryFile(targetfile , data)
		    
		    if writeOutcome.ok = true then
		      System.DebugLog("pulled: " + str(i))
		    else
		      msgbox writeOutcome.fatalErrorMsg
		    end if
		    
		  next i
		  
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
