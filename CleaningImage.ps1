$thispathMozilla = "D:\Mis documentos\Mozilla"
$thispathTrabajo = "D:\Mis documentos\Trabajo"
Try{
remove-item $thispathMozilla -Recurse -Force -ErrorAction Stop
}catch{}
Try{
remove-item $thispathTrabajo -Recurse -Force -ErrorAction Stop
}catch{
}