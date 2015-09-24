$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("DeployRoot")
$dpathfinal = $dpath + "\Out-of-Box Drivers\USB"
#$dpathfinal = "F:\USB"
$folders = get-childitem $dpathfinal | ?{ $_.PSIsContainer }
#try{
  #*USB* > c:\estatusdrivers.txt"
 try{
 Start-Process "D:\Mis documentos\Trabajo\Tareas Powershell\devcon.exe" -argumentlist "/status *USB3*" -nonewwindow -redirectStandardoutput "D:\Mis documentos\Trabajo\Tareas Powershell\USBstatus.txt" -redirectStandardError $true -wait
    #$driversNotFound = "D:\Mis documentos\Trabajo\Tareas Powershell\devcon.exe " | converto-csv
    #$driversNotFound
}catch{
}
$driverfilter = get-content "D:\Mis documentos\Trabajo\Tareas Powershell\USBstatus.txt"
#$drvFilter = $drvFilter.tostring()
$driverhwid =$driverfilter[0].substring(0,16)
$driverhwidparameters = "/hwids " + $driverhwid
Start-Process "D:\Mis documentos\Trabajo\Tareas Powershell\devcon.exe" -argumentlist $driverhwidparameters -nonewwindow -redirectStandardoutput "D:\Mis documentos\Trabajo\Tareas Powershell\USBHwids.txt" -redirectStandardError $true -wait
$hardwareIds = get-content "D:\Mis documentos\Trabajo\Tareas Powershell\USBHwids.txt"
$hardwareIdsList = [array]::indexOf($hardwareIds,"    Hardware IDs:")
$compatibleIds = [array]::indexOf($hardwareIds,"    Compatible IDs:")

$hardwareIdsList = $hardwareIdsList + 1
$compatibleIds = $compatibleIds -1

$allHwids = @()
for ($i=$hardwareIdsList; $i -le $compatibleIds; $i++)
{
    
    $allHwids += $hardwareIds[$i].trimstart()
}


foreach ($ids in $allHwids){
foreach ($folder in $folders){
$parameters = "/install "  + " $dpathfinal\" + $folder.name + "\"
$currentPath = $dpathfinal + "\" + $folder.name + "\*.*"

$infFile = get-childitem $currentPath -include "*.inf" -recurse

$parametersFinal = $parameters + $infFile.name + " " + $ids
$parametersFinal

#try{
 Start-Process "D:\Mis documentos\Trabajo\Tareas Powershell\devcon.exe" -argumentlist $parametersFinal -nonewwindow -redirectStandardoutput "D:\Mis documentos\Trabajo\Tareas Powershell\USBinstallStatus.txt" -redirectStandardError "D:\Mis documentos\Trabajo\Tareas Powershell\USBerrors" -wait
    #$driversNotFound = "D:\Mis documentos\Trabajo\Tareas Powershell\devcon.exe " | converto-csv
    #$driversNotFound
#}catch{
#}
    

}
}
#>