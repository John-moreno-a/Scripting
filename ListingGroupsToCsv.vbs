Dim filesys, filetxt, boolReturn,groupInfo,outFile
Dim fileAppend, filetoAppend, args

Set objShellPath = CreateObject("Wscript.Shell")
strPath = Wscript.ScriptFullName
Set objFS = CreateObject("Scripting.FileSystemObject")
Set objFilePath = objFS.GetFile(strPath)
strFolder = objFS.GetParentFolderName(objFilePath)

'x = msgbox(strFolder ,0, "Your Title Here")

'Set objShell = CreateObject("Shell.Application")
'args = "-F " & strFolder &"\groups.csv -r (&(objectClass=group)(cn=*)) -l dn,cn,member"

'objShell.ShellExecute "LDIFDE.exe", args, "", "open", 3

'strFolder = "C:"

x = msgbox(strFolder ,0, "Your Title Here")

arguments = "C:\windows\system32\ldifde.exe -F "  & chr(34) & strFolder & "\groups.csv"  & chr(34) & " -r (&(objectClass=group)(cn=*)) -l dn,cn,member "

x = msgbox(arguments ,0, "Your Title Here")

const DontWaitUntilFinished = false, ShowWindow = 1, DontShowWindow = 0, WaitUntilFinished = true
'set oShell = WScript.CreateObject("WScript.Shell") ' No execution LDIFDE
'command = arguments & args ' No execution LDIFDE
'oShell.Run command, DontShowWindow, WaitUntilFinished ' No execution LDIFDE

Const ForReading = 1, ForWriting = 2, ForAppending = 8 
Set objFSO=CreateObject("Scripting.FileSystemObject")
outFile= strFolder & "\GroupsInfo.csv"
Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.Close
set fileAppend = CreateObject("Scripting.FileSystemObject")
Set filetoAppend = fileAppend.OpenTextFile(strFolder & "\GroupsInfo.csv", ForAppending, True)
'Const ForReading = 1
Set filesys = CreateObject("Scripting.FileSystemObject")
filePrinterName = strFolder & "\groups.csv"

Set objFSOTextFile = CreateObject("Scripting.FileSystemObject")
Set objTextFile = objFSOTextFile.OpenTextFile(filePrinterName, ForReading)

Do Until objTextFile.AtEndOfStream
    strLine = objTextFile.Readline
    strLine = Trim(strLine)
    If Len(strLine) > 0 Then
        strNewContents = strNewContents & strLine & vbCrLf
		WScript.Echo strLine
    End If
Loop
objTextFile.Close

Set objTextFile = objTextFile.OpenTextFile(filePrinterName, ForWriting)
objTextFile.Write strNewContents
objTextFile.Close

 Set filetxt = filesys.OpenTextFile(filePrinterName, ForReading, True)

 
    Do While filetxt.AtEndOfStream <> True
	'filetxt.ReadLine
        TextLine = filetxt.ReadLine
	'boolReturn = IsBlank(TextLine)
	
		'Set objRE = New RegExp
		'With objRE
		'	.Pattern    = "\S"
		'	.IgnoreCase = True
		'	.Global     = False
		'End With
		
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
		'If objRE.Test( TextLine ) Then
			'WScript.Echo strEmail & " is a valid e-mail address"
			If objRE2.Test( TextLine ) Then
				'WScript.Echo strEmail & " es una linea invalida"
			
			Else
				'WScript.Echo strEmail & " es una linea valida"
				If objRE3.Test( TextLine ) Then
					groupInfo = TextLine & ";"
					WScript.Echo strEmail & groupInfo
				Else
					If objRE4.Test( TextLine ) Then
						groupInfo = groupInfo & TextLine & ";"
						WScript.Echo strEmail & groupInfo
					Else
  						findpos = InStr(TextLine, "member: CN=")
						findMid = InStr(TextLine, ",")

  						If findpos <> 0 Then
							If findMid <> 0 Then
								userNameSize = (findMid - findpos)
								userName = Mid(TextLine, findpos, userNameSize)
								'findCN = InStr(TextLine, "CN=")
								'findCN = InStr(TextLine, "CN=")
								'OUNameSize = (findMid - findpos)
								'OUName = Mid(realDNValue, findpos, OUNameSize)
								'cleaningCharacters = Replace(TextLine, Chr(13), "")
								'cleaningCharacters = Replace(cleaningCharacters, Chr(11), "")
								'cleaningCharacters = Replace(cleaningCharacters, Chr(10), "")
								'Dim objRegExp:Set objRegExp = New RegExp
								' objRegExp.Pattern = "^\s+|\s+$|\r\n"
								' objRegExp.Ignorecase = True
								' objRegExp.Global = True
								' SpecialTrim = objRegExp.Replace(TextLine, "")
								'x=msgbox(SpecialTrim ,0, "Your Title Here")
								filetoAppend.WriteLine(groupInfo & userName & ";" & cleaningCharacters) 

    								'Log.Message("A substring '" & aSubString & "' was found at position " & findpos)
  							Else
    								'Log.Message("There are no occurrences of '" & aSubString & "' in '" & aString & "'")
  							End If	



    							'Log.Message("A substring '" & aSubString & "' was found at position " & findpos)
  						Else
    							'Log.Message("There are no occurrences of '" & aSubString & "' in '" & aString & "'")
  						End If

						 
						'filetoAppend.WriteLine(groupInfo & TextLine) 
						

						'groupInfo = groupInfo & TextLine 
						'WScript.Echo strEmail & groupInfo'
					End If
					'WScript.Echo strEmail & " es una linea valida"
				End If
			End If
		'	x=msgbox(TextLine ,0, "Your Title Here")
		'	WScript.Echo TextLine & " is NOT a valid e-mail address"
		'Else
		'End If


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
	filetoAppend.Close 
	Set objRE = Nothing
	Set objRE2 = Nothing
	Set objShell = Nothing