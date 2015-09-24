$currentlyMachineName = [system.environment]::MachineName
$volumeLabelC = $currentlyMachineName + "-C"
$volumeLabelD = $currentlyMachineName + "-D"
$drive = gwmi win32_volume -Filter "DriveLetter = 'C:'"
$drive.Label = $volumeLabelC
$drive.put() 
$drive = gwmi win32_volume -Filter "DriveLetter = 'D:'"
$drive.Label = $volumeLabelD
$drive.put()