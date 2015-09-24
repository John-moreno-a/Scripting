$currentlyMachineName = [system.environment]::MachineName
$nombreOficina = $currentlyMachineName.substring(2,4)
$fullServerName = "SP" + $nombreOficina + "OF00"
$findServerPrinters = "\\" + $fullServerName + "\printer$"
$printerToInstall = "\\" + $fullServerName +"\"
#try{
$findServerPrinters
cd $findServerPrinters
pwd
#}catch{}
$Class = "win32_printer"
$Printers = Get-WmiObject -class $Class -computername localhost
$alreadyExist= $false
$serverPrinter = Get-content "defaultPrinter.txt"
foreach ($line in $serverPrinter)
{
    $printerSharedName = $line
}
#try{

foreach ($printer in $Printers){
   if ($printerSharedName -eq $printer.SharedName ){
        $alreadyExist= $true
    }
}
#}catch{}
#try{
if ($alreadyExist -eq $false){
   
    $PrinterPath = $printerToInstall + $printerSharedName
    $net = new-Object -Com WScript.Network
    #$PrinterPath
    $net.AddWindowsPrinterConnection($PrinterPath)
    (New-Object -ComObject WScript.Network).SetDefaultPrinter($PrinterPath)
    
    
    
}else{

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [System.Windows.Forms.MessageBox]::Show("La impresora por defecto ya esta instalada")
    foreach ($printeradded in $Printers){
    if ($printerSharedName -eq $printeradded.ShareName ){
        (New-Object -ComObject WScript.Network).SetDefaultPrinter($printeradded.Name)
    }
    }
}
#}catch{
#[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#    [System.Windows.Forms.MessageBox]::Show("No tiene permiso para instalar impresoras")
    #}