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

$operatingSystemsFolder = $assignUSBLetter + "\Deploy\Operating Systems\3202015\*"
#$copyingScripts = $assignUSBLetter + "\Deploy\Operating Systems\3202015\*.ps1"

#$scriptsFolder = $assignUSBLetter + "\Deploy\Scripts"

#Copy-Item $copyingScripts -Destination $scriptsFolder -Force


Try{
remove-item $operatingSystemsFolder -Recurse -Force -ErrorAction Stop
}catch{}