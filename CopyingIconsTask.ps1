$miFavoritesPath = "D:\Mis Documentos\Trabajo\Favorites\*"
$userName = [system.environment]::UserName
$miFavoritesLocation = "C:\Users\" + $userName + "\Favorites"
Try{
copy-Item $miFavoritesPath -Destination $miFavoritesLocation -force
}catch{
}
$miIconsPath = "D:\Mis Documentos\Trabajo\Iconos\*"
$miIconsLocation = "D:\Mis Documentos\Escritorios\" + $userName + "\Escritorio"
try{
copy-Item $miIconsPath -Destination $miIconsLocation -force
}catch{
}