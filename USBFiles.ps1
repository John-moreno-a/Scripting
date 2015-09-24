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


    $pathToFile = $assignUSBLetter + "\vhdmount.TXT"
    New-Item  $pathToFile -type file -force
    $fline = "`Select vdisk file =" + $pathToVHD 
    Add-Content $pathToFile $fline 
    Add-Content $pathToFile "`nAttach vdisk"
    <#
    $pathToFile2 = $assignUSBLetter + "\vhdmount2.TXT"

    Add-Content $pathToFile2 "`nSelect volume 3"
    Add-Content $pathToFile2 "`nAssign letter =J noerr"

    $pathToFile3 = $assignUSBLetter + "\vhdmount3.TXT"

    Add-Content $pathToFile3 "`nSelect volume 4"
    Add-Content $pathToFile3 "`nAssign letter =M noerr"
    #>




    #Add-Content $pathToFile $operatingSystemFolder