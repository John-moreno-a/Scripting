reg load "HKLM\Temp" "C:\Users\Default\NTUSER.DAT"
New-ItemProperty -Path "HKLM:Temp\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "CredVault" -PropertyType String -Value "cmdkey /generic:TERMSRV/VirtualXP-84053 /user:VirtualXP-84053\XPMUser /pass:123456"
reg unload "HKLM\Temp"