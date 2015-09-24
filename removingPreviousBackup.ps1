$removeOldWim = "%deployroot%\Operating Systems\UserBackup\Misdocumentos.wim"
Try{
remove-item $removeOldWim -Recurse -Force -ErrorAction Stop
}catch{}