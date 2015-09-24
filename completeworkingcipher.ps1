 <#$diskpartExe = 
{
param ($diskPartCmds)
 
 $diskpartParameters = "/S " + $diskPartCmds
 #[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
 #[System.Windows.Forms.MessageBox]::Show($diskpartParameters)
 #Start-Process "DISKPART.EXE" -argumentlist $diskpartParameters -nonewwindow -redirectStandardoutput "D:\deploy\tools\x86\hostsold\diskpartResult.txt" -redirectStandarderror "D:\deploy\tools\x86\hostsold\diskpartError.txt" -wait
 Start-Process "DISKPART.EXE" -argumentlist "/S d:\deploy\tools\x86\hostsold\diskpart.txt" -nonewwindow -redirectStandardoutput "D:\deploy\tools\x86\hostsold\diskpartResult.txt" -redirectStandarderror "D:\deploy\tools\x86\hostsold\diskpartError.txt" -wait
}
#>
$manageBDE = 
{
param ([String]$recoveryKey, [String]$stdoutput, [String]$bitlockerLetter)
 
 $manageBDEParameters = "-unlock " + $bitlockerLetter + " -recoverypassword " + $recoveryKey
 Start-Process "manage-bde.exe" -argumentlist $manageBDEParameters -nonewwindow -redirectStandardoutput $stdoutput -wait
}

#$ping = "-n 60"
#Start-Process "ping.exe " -argumentlist $ping -wait
#$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
#$dpath = $tsenv.Value("DeployRoot")
#$dpath = "D:\deploy"
#$vhdPath = "D:\os.vhd"




$joinPath = "C:", "D:", "E:", "F:", "G:"
$assignUSBLetter = ""
foreach($unit in $joinPath){
    #$pathToTest = $unit + "\deploy\Operating Systems\os.vhd"
    $pathToTest = $unit + "\os.vhd"
    $findUSB = Test-Path $pathToTest
    if ($findUSB){
        $assignUSBLetter = $unit
        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
        [System.Windows.Forms.MessageBox]::Show($assignUSBLetter)
    }
}

<#
$driveletter = Get-WMIObject Win32_Volume | select label, DriveLetter # | convertto-csv
foreach ($label in $driveletter){
    if ($label.label -eq "IMAGEN"){
        $imagenUSB = $label.DriveLetter
    }
}
#>
#$pathToVHD = '"' + $assignUSBLetter + "\deploy\Operating Systems\os.vhd" + '"'
$pathToVHD = $assignUSBLetter + "\os.vhd"
#$pathToVHD = "E:\os.vhd"
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($pathToVHD)
$findVHD = Test-Path $pathToVHD
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show("No se encontro el archivo VHD " + $findVHD)
if ($findVHD){
$before = (Get-Volume).DriveLetter
$mountedLetter = mount-diskimage -ImagePath $pathToVHD -StorageType VHD
$after = (Get-Volume).DriveLetter
$mountedVolume = compare $before $after -Passthru
$encryptedVolume = $mountedVolume + ":"
$manageBdeOutput = $assignUSBLetter + "\tools\x86\hostsold\manageBdeResult.txt"

$computerObtainedName = ""
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

        $objForm = New-Object System.Windows.Forms.Form 
        $objForm.Text = "Digite Clave de Cifrado"
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
                    [System.Windows.Forms.MessageBox]::Show("Debe ingresar una Clave")
                }else{
                    $manageBDEParameters = "-unlock " + $encryptedVolume + " -recoverypassword " + $objTextBox.Text
                    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                    [System.Windows.Forms.MessageBox]::Show($manageBDEParameters)
                    #Start-Process "manage-bde.exe" -argumentlist $manageBDEParameters -nonewwindow -redirectStandardoutput $manageBdeOutput -wait
                    Start-Process "manage-bde.exe" -argumentlist $manageBDEParameters -nonewwindow -wait
                    #& $manageBDE -RecoveryKey $objTextBox.Text -Stdoutput $manageBdeOutput -bitlockerLetter $encryptedVolume
                    
                }
                $objForm.Close()
        }

        $objForm.Controls.Add($OKButton)

        $objLabel = New-Object System.Windows.Forms.Label
        $objLabel.Location = New-Object System.Drawing.Size(10,20) 
        $objLabel.Size = New-Object System.Drawing.Size(280,20) 
        $objLabel.Text = "Escriba la clave:"
        $objForm.Controls.Add($objLabel) 

        $objTextBox = New-Object System.Windows.Forms.TextBox 
        $objTextBox.Location = New-Object System.Drawing.Size(10,40) 
        $objTextBox.Size = New-Object System.Drawing.Size(260,20) 
        $objForm.Controls.Add($objTextBox) 
        $objForm.Topmost = $True
        $objForm.Add_Shown({$objForm.Activate()})
        [void] $objForm.ShowDialog()

        $manageBDEDisableParameters = "-protectors -disable " + $encryptedVolume
        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
        [System.Windows.Forms.MessageBox]::Show($manageBDEDisableParameters)
             #Start-Process "manage-bde.exe" -argumentlist $manageBDEParameters -nonewwindow -redirectStandardoutput $manageBdeOutput -wait
        Start-Process "manage-bde.exe" -argumentlist $manageBDEDisableParameters -nonewwindow -wait
        
        $movetoUSBParameters = $assignUSBLetter + "\deploy\Operating Systems\"
        $moveItemsParameters = $encryptedVolume + "\Operating Systems\*" + $movetoUSBParameters
        Move-Item $moveItemsParameters -force

        $decryptResult = get-content $manageBdeOutput
        $result = $false
        foreach ($line in $decryptResult ){
            $result = $line | Select-String -Pattern "is now locked" -quiet
            if ($result){
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                [System.Windows.Forms.MessageBox]::Show("Correctamente Descifrado")
            }   
        }
        if ($result -eq $false){
            [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
            [System.Windows.Forms.MessageBox]::Show("Hubo un Error Descrifrando el archivo comience el proceso nuevamente")
            
        }

        }

<#
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
>#
<#
$diskPartCommands =  $dpath + "\tools\x86\hostsold\diskpart.txt"
$manageBdeOutput = $dpath + "\tools\x86\hostsold\manageBdeResult.txt"
#$diskPartVariables = "SELECT VDISK FILE=" + $vhdPath | Out-File $diskPartCommands
#$diskPartVariables = "ATTACH VDISK" | Out-File $diskPartCommands -Append
#$diskPartVariables = "SELECT PAR 1 " | Out-File $diskPartCommands -Append
#$diskPartVariables = "ASSIGN LETTER=T " | Out-File $diskPartCommands -Append
& $diskpartExe -DiskPartCmd $diskPartCommands

        $computerObtainedName = ""
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

        $objForm = New-Object System.Windows.Forms.Form 
        $objForm.Text = "Digite Clave de Cifrado"
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
                    [System.Windows.Forms.MessageBox]::Show("Debe ingresar una Clave")
                }else{
                    & $manageBDE -RecoveryKey $objTextBox.Text -Stdoutput $manageBdeOutput
                }
                $objForm.Close()
        }

        $objForm.Controls.Add($OKButton)

        $objLabel = New-Object System.Windows.Forms.Label
        $objLabel.Location = New-Object System.Drawing.Size(10,20) 
        $objLabel.Size = New-Object System.Drawing.Size(280,20) 
        $objLabel.Text = "Escriba la clave:"
        $objForm.Controls.Add($objLabel) 

        $objTextBox = New-Object System.Windows.Forms.TextBox 
        $objTextBox.Location = New-Object System.Drawing.Size(10,40) 
        $objTextBox.Size = New-Object System.Drawing.Size(260,20) 
        $objForm.Controls.Add($objTextBox) 
        $objForm.Topmost = $True
        $objForm.Add_Shown({$objForm.Activate()})
        [void] $objForm.ShowDialog()

        $decryptResult = get-content $manageBdeOutput
        $result = $false
        foreach ($line in $decryptResult ){
            $result = $line | Select-String -Pattern "is now locked" -quiet
            if ($result){
                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                [System.Windows.Forms.MessageBox]::Show("Correctamente Descifrado")
            }   
        }
        if ($result -eq $false){
            [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
            [System.Windows.Forms.MessageBox]::Show("Hubo un Error Descrifrando el archivo comience el proceso nuevamente")
            
        }
        #>