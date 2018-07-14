#tag Class
Protected Class pdstorage_session_maintenance
Inherits pdstorage_session
	#tag Method, Flags = &h0
		Sub Constructor(inputVFS as pdstorage_vfs, optional poolPasswords as Dictionary)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(inputVFS , poolPasswords)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  super.Destructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function public_createNewPool(newPool as pdstorage_pool) As pdOutcome
		  return createNewPool(newPool)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function public_createNextMedium(poolname as string) As pdOutcome
		  return createNextMedium(poolname)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function public_dumpContentList(poolname as string) As Dictionary
		  return dumpContentList(poolname)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function public_getMediaDetails(poolname as string) As pdstorage_medium()
		  return getMediaDetails(poolname)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function public_getPoolDetails(poolname as string) As pdstorage_pool
		  Return getPoolDetails(poolname)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function public_getVFSdetails() As pdstorage_vfs
		  return getVFSdetails
		End Function
	#tag EndMethod


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
