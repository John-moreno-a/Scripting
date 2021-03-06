$acl = Get-Acl "d:\Mis documentos"
$acl.SetAccessRuleProtection($True, $False)
$objUser = New-Object System.Security.Principal.NTAccount("ADMINISTRADOR")
$acl.SetOwner($objUser)
Set-Acl -aclobject $acl "d:\Mis documentos"
#$rule = New-Object System.Security.AccessControl.FileSystemAccessRule(Ädministrators","FullControl", "ContainerInherit, ObjectInherit", "None", Ällow")
#$acl.AddAccessRule($rule)


$acl = Get-Acl "d:\Mis documentos"
$acl.SetAccessRuleProtection($True, $False)
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("usuarios","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$rule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("usuarios autentificados","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$rule3 = New-Object System.Security.AccessControl.FileSystemAccessRule("administrador","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$rule4 = New-Object System.Security.AccessControl.FileSystemAccessRule("administradores","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$rule5 = New-Object System.Security.AccessControl.FileSystemAccessRule("system","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")

$acl.AddAccessRule($rule)
$acl.AddAccessRule($rule2)
$acl.AddAccessRule($rule3)
$acl.AddAccessRule($rule4)
$acl.AddAccessRule($rule5)
Set-Acl -aclobject $acl "d:\Mis documentos"
