Function Get-ServerStatus{
    param ([String]$IPaddress)
    
            $secpasswd = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force 

            $mycreds = New-Object System.Management.Automation.PSCredential ("Administrator", $secpasswd)
    
            $Response = Test-Connection -ComputerName $IPaddress -Impersonation Impersonate -quiet

            #-Credential $mycreds
    
            return $Response
      
}