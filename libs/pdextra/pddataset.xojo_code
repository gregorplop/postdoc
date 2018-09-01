#tag Class
Protected Class pddataset
	#tag Method, Flags = &h0
		Sub addRecord(newRecord as Dictionary)
		  if container = nil then Raise newException(7 , "pddataset: Dataset is not initialized")
		  if newRecord = nil then Raise newException(4 , "pddataset: No data to add to dataset")
		  if newRecord.Count = 0 then Raise newException(4 , "pddataset: No data to add to dataset")
		  
		  dim inputFields(-1) as String
		  dim inputValues(-1) as String
		  
		  dim keys(-1) as Variant = newRecord.Keys
		  dim values(-1) as Variant = newRecord.Values
		  
		  for i as integer = 0 to keys.Ubound
		    inputFields.Append keys(i).stringvalue
		    inputValues.Append nullTransform(values(i).stringvalue)
		  next i
		  
		  dim auxrs as RecordSet
		  
		  for i as integer = 0 to inputFields.Ubound
		    if fieldNames_native.IndexOf(inputFields(i)) < 0 then raise newException(5 , "pddataset: Input record field " + inputFields(i) + " does not exist in dataset")
		  next i
		  
		  if uniqueField <> empty then // we have a unique constraint to consider
		    if inputFields.IndexOf(uniqueField) < 0 then raise newException(6 , "pddataset: Unique field " + uniqueField + " does not exist in input record")
		    auxrs = container.SQLSelect("SELECT COUNT(*) FROM dataset WHERE " + uniqueField + " = '" + newRecord.Value(uniqueField).StringValue + "'")
		    checkDBforError
		    if auxrs.IdxField(1).IntegerValue > 0 then raise newException(9 , "pddataset: Unique constraint violation for value: " + newRecord.Value(uniqueField).StringValue)
		  end if
		  
		  dim insertStatement as string = "INSERT INTO dataset (" + join(inputFields , ",") + ") VALUES (" + join(inputValues , ",") + ")"
		  container.SQLExecute(insertStatement)
		  if container.Error = true then raise newException(10 , "pddataset: Error inserting data: " + container.ErrorMessage)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addRecord(inputValues() as string)
		  // work in progress
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub checkDBforError()
		  if container.error = true then raise newException(8 , "pddataset: Data query error: " + container.ErrorMessage)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fieldNames() as string , initDescription as string , optional uniqueFieldname as string)
		  if fieldNames.Ubound < 0 then raise newException(1 , "pddataset: No dataset init info")
		  
		  if uniqueFieldname.trim <> empty then
		    if fieldNames.IndexOf(uniqueFieldname) < 0 then raise newException(2 , "pddataset: unique field name " + uniqueFieldname + " is not amonst field names")
		    uniqueField = uniqueFieldname.Trim
		  end if
		  
		  container = new SQLiteDatabase  // create in-memory database
		  call container.Connect
		  
		  for i as integer = 0 to fieldNames.Ubound
		    fieldNames_native.append fieldNames(i)
		  next i
		  
		  description = initDescription.Trim
		  
		  for i as integer = 0 to fieldNames.Ubound
		    fieldNames(i) = fieldNames(i).trim + " TEXT "
		  next i
		  
		  container.SQLExecute("CREATE TABLE dataset (" + Join(fieldNames , ",") + " )")
		  if container.Error = true then raise newException(3 , "pddataset: Could not initialize dataset: " + container.ErrorMessage)
		  
		  
		  if uniqueField <> empty then 
		    // create an index on the unique column, since WE will be enforcing the unique constraint and not the RDBMS, we'll be doing a lot of searching on it.
		    container.SQLExecute("CREATE INDEX unique_index ON dataset(" + uniqueField + ")")
		    if container.Error = true then raise newException(3 , "pddataset: Could not initialize dataset: " + container.ErrorMessage)
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  if IsNull(container) = false then container.Close  // maybe redundant but it never hurts...
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDescription() As string
		  return description
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function newException(errorNumber as integer , message as string) As RuntimeException
		  dim auxException as new RuntimeException
		  auxException.ErrorNumber = errorNumber
		  auxException.Message = message
		  return auxException
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function nullTransform(value as String) As string
		  if value = empty then
		    return "null"
		  else
		    return "'" + value + "'"
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFriendlynames(inputFriendlynames() as string)
		  if inputFriendlynames.Ubound <> fieldNames_native.Ubound then raise newException(11 , "pddataset: Inconsistent field friendly names")
		  
		  ReDim fieldNames_friendly(-1)
		  for i as integer = 0 to inputFriendlynames.Ubound
		    fieldNames_friendly.Append inputFriendlynames(i)
		  next i
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub write2Listbox(targetList as Listbox , optional useFriendlyNames as Boolean = false)
		  if useFriendlyNames = true and fieldNames_friendly.Ubound <> fieldNames_native.Ubound then raise newException(11 , "pddataset: Inconsistent field friendly names")
		  
		  dim fieldCount as integer = fieldNames_native.Ubound
		  
		  targetList.DeleteAllRows
		  targetList.ColumnCount = fieldCount + 1
		  
		  for i as integer = 0 to fieldCount
		    targetList.Heading(i) = if(useFriendlyNames , fieldNames_friendly(i) , fieldNames_native(i))
		    targetList.ColumnTag(i) = fieldNames_native(i)
		  next i
		  
		  targetList.HasHeading = true
		  targetList.ColumnsResizable = true
		  
		  dim row(-1) as string
		  dim auxrs as RecordSet = container.SQLSelect("SELECT * FROM dataset ORDER BY rowid ASC")
		  checkDBforError  // will generate exception if database error
		  
		  do
		    ReDim row(-1)
		    
		    for i as integer = 0 to fieldCount
		      row.Append auxrs.Field(fieldNames_native(i)).StringValue
		    next i
		    
		    targetList.AddRow row
		    auxrs.MoveNext
		  loop until auxrs.EOF
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = LICENSE
		
		                                 Apache License
		                           Version 2.0, January 2004
		                        http://www.apache.org/licenses/
		
		   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
		
		   1. Definitions.
		
		      "License" shall mean the terms and conditions for use, reproduction,
		      and distribution as defined by Sections 1 through 9 of this document.
		
		      "Licensor" shall mean the copyright owner or entity authorized by
		      the copyright owner that is granting the License.
		
		      "Legal Entity" shall mean the union of the acting entity and all
		      other entities that control, are controlled by, or are under common
		      control with that entity. For the purposes of this definition,
		      "control" means (i) the power, direct or indirect, to cause the
		      direction or management of such entity, whether by contract or
		      otherwise, or (ii) ownership of fifty percent (50%) or more of the
		      outstanding shares, or (iii) beneficial ownership of such entity.
		
		      "You" (or "Your") shall mean an individual or Legal Entity
		      exercising permissions granted by this License.
		
		      "Source" form shall mean the preferred form for making modifications,
		      including but not limited to software source code, documentation
		      source, and configuration files.
		
		      "Object" form shall mean any form resulting from mechanical
		      transformation or translation of a Source form, including but
		      not limited to compiled object code, generated documentation,
		      and conversions to other media types.
		
		      "Work" shall mean the work of authorship, whether in Source or
		      Object form, made available under the License, as indicated by a
		      copyright notice that is included in or attached to the work
		      (an example is provided in the Appendix below).
		
		      "Derivative Works" shall mean any work, whether in Source or Object
		      form, that is based on (or derived from) the Work and for which the
		      editorial revisions, annotations, elaborations, or other modifications
		      represent, as a whole, an original work of authorship. For the purposes
		      of this License, Derivative Works shall not include works that remain
		      separable from, or merely link (or bind by name) to the interfaces of,
		      the Work and Derivative Works thereof.
		
		      "Contribution" shall mean any work of authorship, including
		      the original version of the Work and any modifications or additions
		      to that Work or Derivative Works thereof, that is intentionally
		      submitted to Licensor for inclusion in the Work by the copyright owner
		      or by an individual or Legal Entity authorized to submit on behalf of
		      the copyright owner. For the purposes of this definition, "submitted"
		      means any form of electronic, verbal, or written communication sent
		      to the Licensor or its representatives, including but not limited to
		      communication on electronic mailing lists, source code control systems,
		      and issue tracking systems that are managed by, or on behalf of, the
		      Licensor for the purpose of discussing and improving the Work, but
		      excluding communication that is conspicuously marked or otherwise
		      designated in writing by the copyright owner as "Not a Contribution."
		
		      "Contributor" shall mean Licensor and any individual or Legal Entity
		      on behalf of whom a Contribution has been received by Licensor and
		      subsequently incorporated within the Work.
		
		   2. Grant of Copyright License. Subject to the terms and conditions of
		      this License, each Contributor hereby grants to You a perpetual,
		      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
		      copyright license to reproduce, prepare Derivative Works of,
		      publicly display, publicly perform, sublicense, and distribute the
		      Work and such Derivative Works in Source or Object form.
		
		   3. Grant of Patent License. Subject to the terms and conditions of
		      this License, each Contributor hereby grants to You a perpetual,
		      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
		      (except as stated in this section) patent license to make, have made,
		      use, offer to sell, sell, import, and otherwise transfer the Work,
		      where such license applies only to those patent claims licensable
		      by such Contributor that are necessarily infringed by their
		      Contribution(s) alone or by combination of their Contribution(s)
		      with the Work to which such Contribution(s) was submitted. If You
		      institute patent litigation against any entity (including a
		      cross-claim or counterclaim in a lawsuit) alleging that the Work
		      or a Contribution incorporated within the Work constitutes direct
		      or contributory patent infringement, then any patent licenses
		      granted to You under this License for that Work shall terminate
		      as of the date such litigation is filed.
		
		   4. Redistribution. You may reproduce and distribute copies of the
		      Work or Derivative Works thereof in any medium, with or without
		      modifications, and in Source or Object form, provided that You
		      meet the following conditions:
		
		      (a) You must give any other recipients of the Work or
		          Derivative Works a copy of this License; and
		
		      (b) You must cause any modified files to carry prominent notices
		          stating that You changed the files; and
		
		      (c) You must retain, in the Source form of any Derivative Works
		          that You distribute, all copyright, patent, trademark, and
		          attribution notices from the Source form of the Work,
		          excluding those notices that do not pertain to any part of
		          the Derivative Works; and
		
		      (d) If the Work includes a "NOTICE" text file as part of its
		          distribution, then any Derivative Works that You distribute must
		          include a readable copy of the attribution notices contained
		          within such NOTICE file, excluding those notices that do not
		          pertain to any part of the Derivative Works, in at least one
		          of the following places: within a NOTICE text file distributed
		          as part of the Derivative Works; within the Source form or
		          documentation, if provided along with the Derivative Works; or,
		          within a display generated by the Derivative Works, if and
		          wherever such third-party notices normally appear. The contents
		          of the NOTICE file are for informational purposes only and
		          do not modify the License. You may add Your own attribution
		          notices within Derivative Works that You distribute, alongside
		          or as an addendum to the NOTICE text from the Work, provided
		          that such additional attribution notices cannot be construed
		          as modifying the License.
		
		      You may add Your own copyright statement to Your modifications and
		      may provide additional or different license terms and conditions
		      for use, reproduction, or distribution of Your modifications, or
		      for any such Derivative Works as a whole, provided Your use,
		      reproduction, and distribution of the Work otherwise complies with
		      the conditions stated in this License.
		
		   5. Submission of Contributions. Unless You explicitly state otherwise,
		      any Contribution intentionally submitted for inclusion in the Work
		      by You to the Licensor shall be under the terms and conditions of
		      this License, without any additional terms or conditions.
		      Notwithstanding the above, nothing herein shall supersede or modify
		      the terms of any separate license agreement you may have executed
		      with Licensor regarding such Contributions.
		
		   6. Trademarks. This License does not grant permission to use the trade
		      names, trademarks, service marks, or product names of the Licensor,
		      except as required for reasonable and customary use in describing the
		      origin of the Work and reproducing the content of the NOTICE file.
		
		   7. Disclaimer of Warranty. Unless required by applicable law or
		      agreed to in writing, Licensor provides the Work (and each
		      Contributor provides its Contributions) on an "AS IS" BASIS,
		      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
		      implied, including, without limitation, any warranties or conditions
		      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
		      PARTICULAR PURPOSE. You are solely responsible for determining the
		      appropriateness of using or redistributing the Work and assume any
		      risks associated with Your exercise of permissions under this License.
		
		   8. Limitation of Liability. In no event and under no legal theory,
		      whether in tort (including negligence), contract, or otherwise,
		      unless required by applicable law (such as deliberate and grossly
		      negligent acts) or agreed to in writing, shall any Contributor be
		      liable to You for damages, including any direct, indirect, special,
		      incidental, or consequential damages of any character arising as a
		      result of this License or out of the use or inability to use the
		      Work (including but not limited to damages for loss of goodwill,
		      work stoppage, computer failure or malfunction, or any and all
		      other commercial damages or losses), even if such Contributor
		      has been advised of the possibility of such damages.
		
		   9. Accepting Warranty or Additional Liability. While redistributing
		      the Work or Derivative Works thereof, You may choose to offer,
		      and charge a fee for, acceptance of support, warranty, indemnity,
		      or other liability obligations and/or rights consistent with this
		      License. However, in accepting such obligations, You may act only
		      on Your own behalf and on Your sole responsibility, not on behalf
		      of any other Contributor, and only if You agree to indemnify,
		      defend, and hold each Contributor harmless for any liability
		      incurred by, or claims asserted against, such Contributor by reason
		      of your accepting any such warranty or additional liability.
		
		   END OF TERMS AND CONDITIONS
		
		   APPENDIX: How to apply the Apache License to your work.
		
		      To apply the Apache License to your work, attach the following
		      boilerplate notice, with the fields enclosed by brackets "[]"
		      replaced with your own identifying information. (Don't include
		      the brackets!)  The text should be enclosed in the appropriate
		      comment syntax for the file format. We also recommend that a
		      file or class name and description of purpose be included on the
		      same "printed page" as the copyright notice for easier
		      identification within third-party archives.
		
		   Copyright 2018 Georgios Poulopoulos
		
		   Licensed under the Apache License, Version 2.0 (the "License");
		   you may not use this file except in compliance with the License.
		   You may obtain a copy of the License at
		
		       http://www.apache.org/licenses/LICENSE-2.0
		
		   Unless required by applicable law or agreed to in writing, software
		   distributed under the License is distributed on an "AS IS" BASIS,
		   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
		   See the License for the specific language governing permissions and
		   limitations under the License.
	#tag EndNote

	#tag Note, Name = README
		This class is part of the pdcore library of postdoc, the PostgreSQL-based Electronic Document Management framework for Xojo
		https://github.com/gregorplop/postdoc
		-----------------------------------------------------------------------------------------------------------------------------
		
		Description
		-----------
		pddataset provides the functionality of a general purpose table data container.
		Its internal storage mechanism is an in-memory SQLite database.
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private container As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h21
		Private description As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fieldNames_friendly(-1) As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fieldNames_native(-1) As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uniqueField As String
	#tag EndProperty


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
