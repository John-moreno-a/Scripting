reg load "HKLM\Temp" "C:\Users\Default\NTUSER.DAT"
New-ItemProperty -Path "HKLM:Temp\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "AdobeFIX" -PropertyType String -Value "C:\Windows\Tulpep\Tulpep.AdobeFix.exe"
reg unload "HKLM\Temp"