$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment
$dpath = $tsenv.Value("DeployRoot")
$dpathfinal = $dpath + "\tools\x86\hostsold\VMItems\Virtual Machines"
copy-Item $dpathfinal -Destination "C:\Users\Default" -recurse -force