$driveletter = Get-WMIObject Win32_Volume | select label, DriveLetter | convertto-csv
$recipients = $driveletter -split ","
$arrayNumber = 0
$devicesId = @()
$letterId = @()
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
foreach ($drive in $recipients){
   $removeQuotes = $drive.Replace('"',"")
    $removedrive =  $removeQuotes.Contains("#TYPE Selected.System.Management.ManagementObject")
 
       if (($removedrive) -eq $false)
       {
            $devicesId+=$removeQuotes
       }

}
foreach ($rdrive in $devicesId){
    $removeletter =  $rdrive.Contains("DriveLetter")
 
       if (($removeletter) -eq $false)
       {
            $letterId+=$rdrive
       }

}

foreach ($pathSearch in $letterId){
    $joinPath = $pathSearch + "\Windows"
    $deployPath = $pathSearch + "\Deploy"
    $findDdisk =  $pathSearch + "\Mis documentos"
    $findOS = Test-Path $joinPath
    $findDeploy = Test-Path $deployPath
    $findDpartition = Test-Path $findDdisk

    
 
 if (($findOS -eq $true)-and ($pathSearch -ne "X:")){
        $getLetterValue=$pathSearch
    }
    If (($findOS -eq $false) -and ($pathSearch -ne "X:") -and ($findDpartition -eq $true)){
        $getDpartitionValue = $pathSearch
           
    }

}
$migrationdirectorypath = $getDpartitionValue + "\Mismigrations"
$migrationdirectorypathExist = Test-Path $migrationdirectorypath
    
if ($migrationdirectorypathExist -eq $true){
    Remove-Item $migrationdirectorypath -Force -Recurse
}

$tsenv.Value("misDocumentosVolumen") =  $getDpartitionValue