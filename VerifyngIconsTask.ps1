$miIconsTaskPath = "D:\Mis Documentos\Trabajo\Iconos\*"
$miIconsPublicPath = "C:\Users\Public\Desktop"
#$userName = [system.environment]::UserName
#$miFavoritesLocation = "C:\Users\" + $userName + "\Favorites"
Try{
copy-Item $miIconsTaskPath -Destination $miIconsPublicPath -force
}catch{
}
<#$miIconsPath = "D:\Mis Documentos\Trabajo\Iconos\*"
$miIconsLocation = "D:\Mis Documentos\Escritorios\" + $userName + "\Escritorio"
try{
copy-Item $miIconsPath -Destination $miIconsLocation -force
}catch{
}
#>