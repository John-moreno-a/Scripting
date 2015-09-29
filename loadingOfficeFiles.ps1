import-module .\pwsTestConnection.psm1
import-module .\readingCSVFileToForm.psm1


$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$rootPath = $tsenv.Value("DeployRoot")
$localFile = $false

            [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
            [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

            $objForm = New-Object System.Windows.Forms.Form 
            $objForm.Text = "Digite Direccion IP"
            $objForm.Size = New-Object System.Drawing.Size(400,200) 
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
            $OKButton.Add_Click({
            if(!$objTextBox.Text){
                        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                        [System.Windows.Forms.MessageBox]::Show("Ingrese una direccion IP valida")
                    }else{
                        
                         
                        
                        $manageBDEParameters = "-unlock W: -recoverypassword " + $objTextBox.Text
                        $netshParameters = " interface ip set address Ethernet static " +  $objTextBox.Text

                        

                        Start-Process "netsh.exe" -argumentlist $netshParameters -wait

                        
                        
                        
                        
                        $objForm.Close()
                        
                        
                        
                        <#
                        $decryptResult = get-content $manageBdeOutput
                        
                        foreach ($line in $decryptResult){
                            $result = $line | Select-String -Pattern "successfully unlocked" -quiet

                            if ($result){
                                [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                                [System.Windows.Forms.MessageBox]::Show("Correctamente Descifrado")
                                #$global:hasBeenDecoded = $True
                                #set-variable -name hasBeenDecoded -value $true -scope global
                                $hasBeenDecoded = $true
                                $objForm.Close()
                                
                            }   
                        }
                        if ($result -eq $false){
                            [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                            [System.Windows.Forms.MessageBox]::Show("Hubo un Error Descrifrando el archivo comience el proceso nuevamente")
            
                        }
                        #>
                        }
                        }
                         
                        )

            $objForm.Controls.Add($OKButton)

            $objLabel = New-Object System.Windows.Forms.Label
            $objLabel.Location = New-Object System.Drawing.Size(10,20) 
            $objLabel.Size = New-Object System.Drawing.Size(360,60) 
            $objLabel.Text = "Escriba direccion IP en formato: `n'Direccion IP' 'Mascara de Red' 'puerta de enlace' `n`n EJ. 10.0.0.9 255.0.0.0 127.0.0.1"
            $objForm.Controls.Add($objLabel) 

            $objTextBox = New-Object System.Windows.Forms.TextBox 
            $objTextBox.Location = New-Object System.Drawing.Size(10,90) 
            $objTextBox.Size = New-Object System.Drawing.Size(360,20) 
            $objForm.Controls.Add($objTextBox) 
            $objForm.Topmost = $True
            $objForm.Add_Shown({$objForm.Activate()})
            [void] $objForm.ShowDialog()



            $isServerOnline = Get-ServerStatus -IPaddress "192.168.0.40"

            if ($isServerOnline -eq $true){
                try{

                   
                    $fullServerPath = "\\192.168.0.30\Orquestrator"
                    cd $fullServerPath
                    pwd

                    $fullServerFilePath = "\\192.168.0.30\Orquestrator\Oficinas.txt"

                    $miServerPath = $rootPath + "\SettingUP"


                    if(!(Test-Path -Path $miServerPath )){
                        New-Item -ItemType directory -Path $miServerPath
                    }
                        $fileMyServerPathFile = $miServerPath + "\ServerFileOffices.csv"
                        copy-Item $fullServerFilePath -Destination $fileMyServerPathFile -force

                     }catch{
                        [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                        [System.Windows.Forms.MessageBox]::Show("Existio un error Durante la descarga del archivo, utilizando archivo local") 
                        $localFile = $True 
                        $fileMyServerPathFile = $miServerPath + "\staticFile.csv"
                    }
            
            }else{
                    $localFile = $True
                     [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
                     [System.Windows.Forms.MessageBox]::Show("No se puede acceder al servidor, utilizando archivo local") 
            }
            
            Get-OfficeInfo -localFile $localFile -deployPath $fileMyServerPathFile

            [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
            [System.Windows.Forms.MessageBox]::Show($isServerOnline)