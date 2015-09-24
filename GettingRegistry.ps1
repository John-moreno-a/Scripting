$scriptBlock =
{
        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
        [System.Windows.Forms.MessageBox]::Show("Ha habido un Error Leyendo el Registro")
        $computerObtainedName = ""
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

        $objForm = New-Object System.Windows.Forms.Form 
        $objForm.Text = "Nombre Estacion W7"
        $objForm.Size = New-Object System.Drawing.Size(300,200) 
        $objForm.StartPosition = "CenterScreen"

        $objForm.KeyPreview = $True
        $objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
            {$newComputerName=$objTextBox.Text;$objForm.Close()}})
        $objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
            {$objForm.Close()}})

        
        $OKButton = New-Object System.Windows.Forms.Button
        $OKButton.Location = New-Object System.Drawing.Size(75,120)
        $OKButton.Size = New-Object System.Drawing.Size(75,23)
        $OKButton.Text = "OK"
        $OKButton.Add_Click{
        if(!$objTextBox.Text){
                    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                    [System.Windows.Forms.MessageBox]::Show("El Equipo debe tener un nombre por favor digitelo")
        
                }else{
                 $computerObtainedName = $objTextBox.Text
                        $arrayComputerName =  $computerObtainedName.ToCharArray()
                        $ourecognition = $arrayComputerName[0] +  $arrayComputerName[1]
                        $ouComputerLenght = $computerObtainedName.length
                        $computerADIdentifier = ($ouComputerLenght - 2)
                        $getLastTwoIdentifiers =  $computerObtainedName.substring($computerADIdentifier,2)
                        switch($ourecognition){
                            "AD" {
                                    switch ($getLastTwoIdentifiers){
		                        "01" {$joinToOu =  "OU=DirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                        "03" {$joinToOu =  "OU=DirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                        "02" {$joinToOu =  "OU=SubdirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                        "04" {$joinToOu =  "OU=SubdirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                        "05" {$joinToOu =  "OU=SubdirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                    }
                                 } 
                            "CJ" {$joinToOu =  "OU=CajaWin7,OU=Estaciones,DC=davivienda,DC=loc"} 
                            "PL" {$joinToOu =  "OU=InformadorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                            }
                     [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                     [System.Windows.Forms.MessageBox]::Show("El Computador tendra el nombre de: " + $computerObtainedName)
                     [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                     [System.Windows.Forms.MessageBox]::Show($joinToOu)
                     $tsenv.Value("MachineObjectOU") = $joinToOu
                     $settingFormat = $computerObtainedName + ";" + $joinToOu
                     $computerInfoFinal = $dpathfinal + "\migrationinfo.txt"
                     write-output $settingFormat | Out-File $computerInfoFinal
               
                }
                $objForm.Close()
        }

        $objForm.Controls.Add($OKButton)

        $objLabel = New-Object System.Windows.Forms.Label
        $objLabel.Location = New-Object System.Drawing.Size(10,20) 
        $objLabel.Size = New-Object System.Drawing.Size(280,20) 
        $objLabel.Text = "Escriba el Nuevo Nombre para el Computador:"
        $objForm.Controls.Add($objLabel) 

        $objTextBox = New-Object System.Windows.Forms.TextBox 
        $objTextBox.Location = New-Object System.Drawing.Size(10,40) 
        $objTextBox.Size = New-Object System.Drawing.Size(260,20) 
        $objForm.Controls.Add($objTextBox) 




        $objForm.Topmost = $True

        $objForm.Add_Shown({$objForm.Activate()})
        [void] $objForm.ShowDialog()
                        
}






$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("DeployRoot")
$dpathfinal = $dpath + "\tools\x86\hostsold\"
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
$loadingHive = $getLetterValue + "\windows\system32\config\software"
$argumentsRegedit = 'query "HKLM\TEMP\Microsoft\Windows\CurrentVersion\Group Policy\State\Machine" /f Distinguished-Name'
$pathToRegLogs = $dpathfinal + "\regoutput.txt"
$pathToRegErrorLogs = $dpathfinal + "\regErrors.txt"
$regLoadLogs = $dpathfinal + "\regLoadoutput.txt"
$regLoadLogsError = $dpathfinal + "\regLoadErrors.txt"
$regLoadArguments =  'load "HKLM\TEMP" ' + $loadingHive

Start-Process "reg.exe" -argumentlist $regLoadArguments -nonewwindow -redirectStandardoutput $regLoadLogs -redirectStandardError $regLoadLogsError -wait
Start-Process "reg.exe" -argumentlist $argumentsRegedit -nonewwindow -redirectStandardoutput $pathToRegLogs -redirectStandardError $pathToRegErrorLogs -wait

$filemeasure = ((get-childitem $pathToRegErrorLogs).length / 1KB)
if ($filemeasure -gt 0){
        & $scriptBlock
}else{
    $RegistryFilemeasure = ((get-childitem $pathToRegLogs).length / 1KB)
    if ($RegistryFilemeasure -gt 0){
        $readingComputerNameFromFile = get-content $pathToRegLogs
        ForEach ($regValues in $readingComputerNameFromFile){
               $objectWithName = $regvalues | Select-String -Pattern "Distinguished-Name" -quiet 
               if ($objectWithName){
                    $stringValue = $regvalues
               }
        }
      if ($stringValue){
        $gettingName = $stringvalue.IndexOf("CN=")
      }else{}

          if ($gettingName -lt 0){
               & $scriptBlock
          }else{
            $gettingComaPosition = $stringvalue.IndexOf(",OU")
            if ($gettingComaPosition -lt 0){
                & $scriptBlock
            }else{
                $namePositionExactly = $gettingName + 3
                $nameCount = ($gettingComaPosition - $namePositionExactly)
                if ($nameCount -gt 0){
                    $GettingDNName = $stringvalue.Substring($namePositionExactly,$nameCount)
                        if ([string]::IsNullOrEmpty($GettingDNName)){
                            & $scriptBlock
                        }else{
                            $arrayComputerName =  $GettingDNName.ToCharArray()
                            $ourecognition = $arrayComputerName[0] +  $arrayComputerName[1]
                            $ouComputerLenght = $GettingDNName.length
                            $computerADIdentifier = ($ouComputerLenght - 2)
                            $getLastTwoIdentifiers =  $GettingDNName.substring($computerADIdentifier,2)
                            $officeNumber = $GettingDNName.substring(2,4)
                            $newNameToSet = $ourecognition + $officeNumber + "W7" + $getLastTwoIdentifiers
                            $tsenv:OSDcomputername = $newNameToSet
                            switch($ourecognition){
                                "AD" {
                                        switch ($getLastTwoIdentifiers){
		                            "01" {$joinToOu =  "OU=DirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                            "03" {$joinToOu =  "OU=DirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                            "02" {$joinToOu =  "OU=SubdirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                            "04" {$joinToOu =  "OU=SubdirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                            "05" {$joinToOu =  "OU=SubdirectorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                        }
                                     } 
                                "CJ" {$joinToOu =  "OU=CajaWin7,OU=Estaciones,DC=davivienda,DC=loc"} 
                                "PL" {$joinToOu =  "OU=InformadorWin7,OU=Estaciones,DC=davivienda,DC=loc"}
                                }
                                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                                [System.Windows.Forms.MessageBox]::Show("El Computador tendra el nombre de: " + $tsenv.Value("OSDComputerName"))
                                $tsenv.Value("MachineObjectOU") = $joinToOu
                                $settingFormat = $tsenv.Value("OSDComputerName") + ";" + $joinToOu
                                $computerInfoFinal = $dpathfinal + "\migrationinfo.txt"
                                write-output $settingFormat | Out-File $computerInfoFinal
                        }
                }else{
                    & $scriptBlock
                }
          }
          }
          }else{
            & $scriptBlock
          }
      }
      
      
