$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("DeployRoot")
$dpathfinal = $dpath + "\tools\x86\hostsold\"
reg unload "HKLM\TEMP"
$driveletter = Get-WMIObject Win32_Volume | select label, DriveLetter | convertto-csv
$recipients = $driveletter -split ","
$arrayNumber = 0
$devicesId = @()
$letterId = @()
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
    $findOS = Test-Path $joinPath
    $findDeploy = Test-Path $deployPath
 
 if (($findOS -eq $true)-and ($pathSearch -ne "X:")){
        $getLetterValue=$pathSearch
    }

}
$hostPath = $getLetterValue + "\Windows\System32\drivers\etc\hosts"
copy-Item $hostPath -Destination $dpathfinal -force
<#$loadingHive = $getLetterValue + "\windows\system32\config\system"
reg load "HKLM\TEMP" $loadingHive
$regeditPath = "HKLM\TEMP\CONTROLSET001\Services\Eventlog /f Computer"
$computerRegName = REG QUERY $regeditPath
#>

$readingComputerNameFromFile = Get-Content "X:\NombreTemporal.txt"
#[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#[System.Windows.Forms.MessageBox]::Show($readingComputerNameFromFile)

ForEach ($regValues in $readingComputerNameFromFile){
   $objectWithName = $regvalues | Select-String -Pattern "ComputerName" -quiet 
   if ($objectWithName){
        $stringValue = $regvalues
   }
      }
      $stringValue = $stringValue.trim(" ")
      $positionValue = ($stringValue.IndexOf('SZ') + 6)
      $stringCountValue = $stringValue.length
      $computerNameCount = ($stringCountValue - $positionValue)
      $computerValue = $stringValue.substring($positionValue,$computerNameCount)
      $arrayComputerName =  $computerValue.ToCharArray()
      #[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
      #[System.Windows.Forms.MessageBox]::Show("Este es el nombre del computador" + $arrayComputerName)



      $ourecognition = $arrayComputerName[0] +  $arrayComputerName[1]
      #[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
      #[System.Windows.Forms.MessageBox]::Show($ourecognition)
      #$ourecognition = $computerValue.subtring(0,2)
      $ouComputerLenght = $computerValue.length
      $computerADIdentifier = ($ouComputerLenght - 2)
      $getLastTwoIdentifiers =  $computerValue.substring($computerADIdentifier,2)
      #[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
      #[System.Windows.Forms.MessageBox]::Show($getLastTwoIdentifiers)
      $officeNumber = $computerValue.substring(2,4)
      $newNameToSet = $ourecognition + $officeNumber + "W7" + $getLastTwoIdentifiers
      $tsenv:OSDcomputername = $newNameToSet
      

switch($ourecognition){
        "AD" {
                switch ($getLastTwoIdentifiers){
                    "01" {$joinToOu =  "OU=DirectorPrueba,OU=Estaciones,DC=davivienda,DC=loc"}
                    "03" {$joinToOu =  "OU=DirectorPrueba,OU=Estaciones,DC=davivienda,DC=loc"}
                    "02" {$joinToOu =  "OU=SubdirectorPrueba,OU=Estaciones,DC=davivienda,DC=loc"}
                    "04" {$joinToOu =  "OU=SubdirectorPrueba,OU=Estaciones,DC=davivienda,DC=loc"}
                    "05" {$joinToOu =  "OU=SubdirectorPrueba,OU=Estaciones,DC=davivienda,DC=loc"}
                }
             } 
        "CJ" {$joinToOu =  "OU=CajaPrueba,OU=Estaciones,DC=davivienda,DC=loc"} 
        "PL" {$joinToOu =  "OU=InformadorPrueba,OU=Estaciones,DC=davivienda,DC=loc"}
}
$tsenv.Value("MachineObjectOU") = $joinToOu
$settingFormat = $tsenv.Value("OSDComputerName") + ";" + $joinToOu
$computerInfoFinal = $dpathfinal + "\migrationinfo.txt"
write-output $settingFormat | Out-File $computerInfoFinal
