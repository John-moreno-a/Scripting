$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("DeployRoot")
$dpathfinal = $dpath + "\tools\x86\hostsold\hosts"
copy-Item $dpathfinal -Destination "C:\Windows\System32\drivers\etc\" -force