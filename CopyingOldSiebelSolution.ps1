$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("DeployRoot")
$dpathfinal = $dpath + "\tools\x86\hostsold\Tulpep.CimSiebelFix.exe"
copy-Item $dpathfinal -Destination "C:\Windows\tulpep\" -force