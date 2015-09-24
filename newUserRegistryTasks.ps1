#reg load "HKLM\Temp" "C:\Users\Default\NTUSER.DAT"
#New-ItemProperty -Path "HKLM:Temp\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "CredVault" -PropertyType String -Value "cmdkey /generic:TERMSRV/VirtualXP-84053 /user:VirtualXP-84053\XPMUser /pass:123456"
#reg unload "HKLM\Temp"
New-Item -Path "HKCU:\Software\Adobe\Acrobat Reader\10.0\AVAlert\cCheckbox\cAcrobat\" –Force
New-ItemProperty -Path "HKCU:\Software\Adobe\Acrobat Reader\10.0\AVAlert\cCheckbox\cAcrobat\" -Name "iWarnScriptPrintAll" -Type DWord -Value 1 –Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Main" -Name "UseSWRender" -PropertyType DWord -Value 1 –Force
New-Item -Path "HKCU:\Software\Microsoft\Internet Explorer\Recovery"  –Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Internet Explorer\Recovery" -Name "AutoRecover" -Type DWord -Value 0 –Force


