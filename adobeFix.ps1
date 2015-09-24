reg load "HKLM\Temp" "C:\Users\Default\NTUSER.DAT"
New-ItemProperty -Path "HKLM:Temp\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "AdobeFix" -PropertyType String -Value "D:\Mis documentos\Trabajo\Tareas Powershell\PSlogonRegistry.bat"
reg unload "HKLM\Temp"