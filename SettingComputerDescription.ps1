$currentlyMachineName = [system.environment]::MachineName
try{
new-itemproperty -Path Registry::"HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\lanmanserver\parameters" -Name srvcomment -PropertyType String -Value $currentlyMachineName -ErrorAction Stop
}catch{
Set-ItemProperty -Path Registry::"HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\lanmanserver\parameters" -Name srvcomment -Value $currentlyMachineName
}