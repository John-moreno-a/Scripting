
 $joinPath = "C:", "D:", "E:", "F:", "G:"
$assignUSBLetter = ""
foreach($unit in $joinPath){
    $pathToTest = $unit + "\os.vhd"
    $findUSB = Test-Path $pathToTest
    if ($findUSB){
        $assignUSBLetter = $unit
    }
}

if ($findVHD){
$misDocumentosFolder = $assignUSBLetter + "\Deploy\Operating Systems\D Drive Sucursales"
$misDocPath = "M:\*"
copy-Item $misDocPath -Destination $misDocumentosFolder -force
}