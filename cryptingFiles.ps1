$joinPath = "C:", "D:", "E:", "F:", "G:"
$assignUSBLetter = ""
foreach($unit in $joinPath){
    $pathToTest = $unit + "\os.vhd"
    $findUSB = Test-Path $pathToTest
    if ($findUSB){
        $assignUSBLetter = $unit
    }
}



$pathToVHD = $assignUSBLetter + "\os.vhd"

$findVHD = Test-Path $pathToVHD

if ($findVHD){
   
    $scriptFile = "/s " + $assignUSBLetter + "\vhdmount.TXT"
    
    Start-Process "diskpart.exe" -argumentlist $scriptFile -wait 
   
  }
    