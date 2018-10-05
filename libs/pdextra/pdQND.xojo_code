#tag Class
Protected Class pdQND
	#tag Method, Flags = &h21
		Private Sub Constructor()
		  // abstract class
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function QND_extractFieldname(input as string) As string
		  dim char as string
		  dim nameStart as integer
		  
		  for i as integer = 1 to input.Len
		    char = input.Mid(i , 1)
		    
		    if QNDtypes.InStr(char) = 0 then 
		      nameStart = i
		      exit for i
		    end if
		    
		  next i
		  
		  return  input.Right(input.len - nameStart + 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function QND_extractTypes(input as string) As string
		  dim output as string = empty
		  dim char as string
		  
		  for i as integer = 1 to input.Len
		    char = input.Mid(i , 1)
		    
		    if QNDtypes.InStr(char) > 0 then 
		      output = output + char
		    else
		      exit for i
		    end if
		    
		  next i
		  
		  return output
		  
		End Function
	#tag EndMethod


	#tag Note, Name = QND
		QND types or Quick N' Dirty types are is a postdoc-specific notation for specifying datatypes and other properties when declaring field names
		just use them as a prefix to your field names
		goes whithout saying that field names cannot start with any of these characters
		
		! = mandatory
		@ = 
		# = numeric
		$ = reference to file contents
		% = boolean
		^ = read-only
		& = 
		* = 
		+ = 
		~ = 
		? = 
		
	#tag EndNote


	#tag Constant, Name = QNDtypes, Type = String, Dynamic = False, Default = \"!@#$%^&*+-~\?", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
