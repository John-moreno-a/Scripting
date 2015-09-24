Dim filesys, filetxt, boolReturn,groupInfo,outFile
Dim fileAppend, filetoAppend, args

Set objShellPath = CreateObject("Wscript.Shell")
strPath = Wscript.ScriptFullName
Set objFS = CreateObject("Scripting.FileSystemObject")
Set objFilePath = objFS.GetFile(strPath)
strFolder = objFS.GetParentFolderName(objFilePath)

'x = msgbox(strFolder ,0, "Your Title Here")

'Set objShell = CreateObject("Shell.Application")
'args = "-F " & strFolder &"\groups.csv -r (&(objectClass=organizationalUnit)(cn=*)) -l dn"

'objShell.ShellExecute "LDIFDE.exe", args, "", "open", 3

'strFolder = "C:"

x = msgbox(strFolder ,0, "Your Title Here")

arguments = "C:\windows\system32\ldifde.exe -F "  & chr(34) & strFolder & "\OU.csv"  & chr(34) & " -r (&(objectClass=organizationalUnit)) -l dn"

x = msgbox(arguments ,0, "Your Title Here")

const DontWaitUntilFinished = false, ShowWindow = 0, DontShowWindow = 1, WaitUntilFinished = true
set oShell = WScript.CreateObject("WScript.Shell")
command = arguments & args
oShell.Run command, DontShowWindow, WaitUntilFinished



Const ForReading = 1, ForWriting = 2, ForAppending = 8 
'Set objFSO=CreateObject("Scripting.FileSystemObject")
'outFile= strFolder & "\OU.csv"
'Set objFile = objFSO.CreateTextFile(outFile,True)
'objFile.Close
'set fileAppend = CreateObject("Scripting.FileSystemObject")
'Set filetoAppend = fileAppend.OpenTextFile(strFolder & "\OU.csv", ForAppending, True)
''Const ForReading = 1
Set filesys = CreateObject("Scripting.FileSystemObject")
filePrinterName = strFolder & "\OU.csv"

 Set filetxt = filesys.OpenTextFile(filePrinterName, ForReading, True) 
    Do While filetxt.AtEndOfStream <> True
	'filetxt.ReadLine
        TextLine = filetxt.ReadLine
	'boolReturn = IsBlank(TextLine)
		Set objRE = New RegExp

		With objRE
			.Pattern    = "\S"
			.IgnoreCase = True
			.Global     = False
		End With
		
		Set objRE2 = New RegExp

		With objRE2
			.Pattern    = "changetype"
			.IgnoreCase = True
			.Global     = False
		End With
		
		Set objRE3 = New RegExp
		
		With objRE3
			.Pattern    = "dn: "
			.IgnoreCase = True
			.Global     = False
		End With
		
		Set objRE4 = New RegExp
		
		With objRE4
			.Pattern    = "cn: "
			.IgnoreCase = True
			.Global     = False
		End With
		
		

		' Test method returns TRUE if a match is found
		'x = msgbox(TextLine ,0, "Your Title Here")
		If objRE.Test( TextLine ) Then
			'WScript.Echo strEmail & " is a valid e-mail address"
			If objRE2.Test( TextLine ) Then
				'WScript.Echo strEmail & " es una linea invalida"
			
			Else
				'WScript.Echo strEmail & " es una linea valida"
				If objRE3.Test( TextLine ) Then
					x = msgbox(TextLine ,0, "Your Title Here")
					
					fromFourPos =  (Len(TextLine)-4)
					realDNValue = Right(TextLine, fromFourPos)
					arguments2 =  chr(34) & "C:\Program Files\Support Tools\dsacls.exe" & chr(34) & " " & chr(34) & realDNValue & chr(34)
					Set WshShell = CreateObject("WScript.Shell")
					Set WshShellExec = WshShell.Exec(arguments2)
					strOutput = WshShellExec.StdOut.ReadAll
					

					' > "& chr(34) & strFolder & "\" & TextLine & "-OU.csv"  & chr(34) 
					Set objFSO=CreateObject("Scripting.FileSystemObject")
					findpos = InStr(realDNValue, "OU=")
					findpos = findpos + 3
					findMid = InStr(realDNValue, ",")
					OUNameSize = (findMid - findpos)
					OUName = Mid(realDNValue, findpos, OUNameSize)
					
					
					'outFile= chr(34) & strFolder & "\" & OUName  & ".txt" & chr(34) 
					outFile=  OUName  & ".txt" 
					
					x = msgbox(outFile ,0, "Your Title Here")
					
					Set fs = CreateObject("Scripting.FileSystemObject")
					Set a = fs.CreateTextFile(outFile, True)
					a.WriteLine(strOutput)
					a.Close

					'const DontWaitUntilFinished = false, ShowWindow2 = 1, DontShowWindow2 = 0, WaitUntilFinished2 = true
					'set osShell = WScript.CreateObject("WScript.Shell")
					'command = arguments2 & args
					'osShell.Run command, DontShowWindow, WaitUntilFinished
					
					'Set objFSO=CreateObject("Scripting.FileSystemObject")
					'outFile= strFolder & "\OU.csv"
					'Set objFile = objFSO.CreateTextFile(outFile,True)
					'objFile.Close
					'set fileAppend = CreateObject("Scripting.FileSystemObject")
					'Set filetoAppend = fileAppend.OpenTextFile(strFolder & "\OU.csv", ForAppending, True)
					
					'groupInfo = TextLine & ";"
					'WScript.Echo strEmail & groupInfo
					
				Else
					'If objRE4.Test( TextLine ) Then
					'	groupInfo = groupInfo & TextLine & ";"
					'	WScript.Echo strEmail & groupInfo
					'Else
  					'	findpos = InStr(TextLine, "member: CN=")
					'	findMid = InStr(TextLine, ",")
					
  					'	If findpos <> 0 Then
					'		If findMid <> 0 Then
					'			userNameSize = (findMid - findpos)
					'			userName = Mid(TextLine, findpos, userNameSize)
					'			filetoAppend.WriteLine(groupInfo & userName & ";" & TextLine) 
					
    								'Log.Message("A substring '" & aSubString & "' was found at position " & findpos)
  					'		Else
    								'Log.Message("There are no occurrences of '" & aSubString & "' in '" & aString & "'")
  					'		End If	



    							'Log.Message("A substring '" & aSubString & "' was found at position " & findpos)
  					'	Else
    							'Log.Message("There are no occurrences of '" & aSubString & "' in '" & aString & "'")
  					'	End If

						 
						'filetoAppend.WriteLine(groupInfo & TextLine) 
						

						'groupInfo = groupInfo & TextLine 
						'WScript.Echo strEmail & groupInfo'
					'End If
					'WScript.Echo strEmail & " es una linea valida"
				End If
			End If
		Else
			WScript.Echo strEmail & " is NOT a valid e-mail address"
		End If


	'x = msgbox(boolReturn ,0, "Your Title Here")	
	'If (boolReturn)  Then
		
		'objFile.Write Printer.Name
		'Exit For
	'else
	'	x=msgbox(TextLine ,0, "Your Title Here")
		'End If
		
		'myfunction(TextLine)
	'x=msgbox(Subio ,0, "Your Title Here")	
    Loop
	'filetoAppend.Close 
	Set objRE = Nothing
	Set objRE2 = Nothing
	'Set objShell = Nothing