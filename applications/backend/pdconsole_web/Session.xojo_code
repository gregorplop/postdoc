#tag Class
Protected Class Session
Inherits WebSession
	#tag Event
		Sub Close()
		  System.DebugLog("session close event")
		  forceCleanup
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  ServiceTokens = pdservicetoken.loadFolderTokens(appFolder.Child("tokens") , true)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub clearServiceTokens()
		  ReDim ServiceTokens(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConsoleRunningOnDBserver() As Boolean
		  if dbSession = nil then return false
		  if dbSession.Host = "127.0.0.1" or dbSession.Host = "localhost" then return true
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub forceCleanup()
		  if IsNull(dbSession) = False then dbSession.Close
		  dbSession = nil
		  activeServiceToken = nil
		  ServiceTokens = nil
		  
		  // temporary
		  testSession.pgSessionClose
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getActiveDBbackends() As Dictionary()
		  dim output(-1) as Dictionary
		  dim row as new Dictionary
		  
		  dim dbdata as RecordSet = dbSession.SQLSelect("SELECT c.pid , c.application_name , c.usename , c.client_addr FROM pg_stat_activity c INNER JOIN resources.pgusers u ON c.usename = u.name")
		  
		  if dbSession.Error = true then
		    row.Value("error") = dbSession.ErrorMessage
		    output.Append row
		    return output
		  end if
		  
		  while not dbdata.EOF
		    row = new Dictionary
		    for i as integer = 1 to dbdata.FieldCount
		      row.Value(dbdata.IdxField(i).Name) = dbdata.IdxField(i).StringValue
		    next i
		    output.Append row
		    dbdata.MoveNext
		  wend
		  
		  Return output
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDBsession() As PostgreSQLDatabase
		  Return dbSession
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getServiceToken() As pdservicetoken
		  return activeServiceToken
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTokenByIDX(IDX as integer) As pdservicetoken
		  if IDX > ServiceTokens.Ubound then return nil
		  if IDX < 0 then return nil
		  
		  return ServiceTokens(IDX)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTokensFriendlyNames() As string()
		  dim output(-1) as string
		  
		  for i as integer = 0 to ServiceTokens.Ubound
		    output.Append ServiceTokens(i).friendlyName
		  next i
		  
		  return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function tryLogin(serviceToken as pdservicetoken , username as string , password as string) As pdOutcome
		  if serviceToken = nil then return new pdOutcome("No valid service token")
		  
		  dbSession = new PostgreSQLDatabase
		  dbSession.Host = serviceToken.host
		  dbSession.Port = serviceToken.port
		  dbSession.DatabaseName = serviceToken.database
		  dbSession.UserName = username
		  dbSession.Password = password
		  
		  dbSession.AppName = "pd//pdconsole_web//" + username 
		  
		  if dbSession.Connect = false then return new pdOutcome("Login failed: " + EndOfLine + dbSession.ErrorMessage)
		  
		  activeServiceToken = serviceToken
		  activeServiceToken.username = username
		  activeServiceToken.password = password.toBase64
		  
		  // create the backend session - this is temporary
		  dim backendToken as pdOutcome = pdservicetoken.Open(appFolder.Child("tokens").Child("pdbackend@mypostdoc@localhost.pdst"))
		  if backendToken.ok = false then 
		    System.DebugLog("Error loading backend service token: " + backendToken.fatalErrorMsg)
		  else
		    testSession = new pdsession(backendToken.returnObject , "pdconsole_web")
		    dim sessionConnect as pdOutcome = testSession.connect
		    if sessionConnect.ok = False then System.DebugLog("Error connecting to the backend service: " + sessionConnect.fatalErrorMsg)
		  end if
		  AddHandler testSession.RequestComplete , WeakAddressOf MainPage.event_requestComplete
		  AddHandler testSession.RequestTimeout , WeakAddressOf MainPage.event_requestTimeout
		  //  test code end ----
		  
		  
		  MainPage.init
		  
		  Return new pdOutcome(true)
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private activeServiceToken As pdservicetoken
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dbSession As PostgreSQLDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ServiceTokens(-1) As pdservicetoken
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			this is temporary
			
		#tag EndNote
		testSession As pdsession
	#tag EndProperty


	#tag Constant, Name = ErrorDialogCancel, Type = String, Dynamic = True, Default = \"Do Not Send", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorDialogMessage, Type = String, Dynamic = True, Default = \"This application has encountered an error and cannot continue.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorDialogQuestion, Type = String, Dynamic = True, Default = \"Please describe what you were doing right before the error occurred:", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorDialogSubmit, Type = String, Dynamic = True, Default = \"Send", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorThankYou, Type = String, Dynamic = True, Default = \"Thank You", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ErrorThankYouMessage, Type = String, Dynamic = True, Default = \"Your feedback helps us make improvements.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NoJavascriptInstructions, Type = String, Dynamic = True, Default = \"To turn Javascript on\x2C please refer to your browser settings window.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NoJavascriptMessage, Type = String, Dynamic = True, Default = \"Javascript must be enabled to access this page.", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="ActiveConnectionCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Browser"
			Group="Behavior"
			Type="BrowserType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Safari"
				"2 - Chrome"
				"3 - Firefox"
				"4 - InternetExplorer"
				"5 - Opera"
				"6 - ChromeOS"
				"7 - SafariMobile"
				"8 - Android"
				"9 - Blackberry"
				"10 - OperaMini"
				"11 - Epiphany"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="BrowserVersion"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Connection"
			Group="Behavior"
			Type="ConnectionType"
			EditorType="Enum"
			#tag EnumValues
				"0 - AJAX"
				"1 - WebSocket"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GMTOffset"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HashTag"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeaderCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageRightToLeft"
			Group="Behavior"
			Type="Boolean"
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
			Name="PageCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Platform"
			Group="Behavior"
			Type="PlatformType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Macintosh"
				"2 - Windows"
				"3 - Linux"
				"4 - Wii"
				"5 - PS3"
				"6 - iPhone"
				"7 - iPodTouch"
				"8 - Blackberry"
				"9 - WebOS"
				"10 - iPad"
				"11 - AndroidTablet"
				"12 - AndroidPhone"
				"13 - RaspberryPi"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Protocol"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RenderingEngine"
			Group="Behavior"
			Type="EngineType"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - WebKit"
				"2 - Gecko"
				"3 - Trident"
				"4 - Presto"
				"5 - EdgeHTML"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScaleFactor"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StatusMessage"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Timeout"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Title"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_baseurl"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_Expiration"
			Group="Behavior"
			InitialValue="-1"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_hasQuit"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mConnection"
			Group="Behavior"
			Type="ConnectionType"
			EditorType="Enum"
			#tag EnumValues
				"0 - AJAX"
				"1 - WebSocket"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
