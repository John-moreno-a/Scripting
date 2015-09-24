$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("SCRIPTROOT")
$dpathfinalApp = "C:\Windows\Tulpep"
$dpathfinalxml1 = $dpath + "\Copiando Iconos y favoritos.xml"
$dpathfinalxml2 = $dpath + "\Tarea de instalacion de impresoras.xml"
$dpathfinalApp = $dpath + "\Tulpep.SiebelWebFix.exe"
try{
copy-Item $dpathfinalxml1 -Destination $dpathfinalApp -force
copy-Item $dpathfinalxml2 -Destination $dpathfinalApp -force
copy-Item $dpathfinalApp -Destination $dpathfinalApp -force
}catch{
}