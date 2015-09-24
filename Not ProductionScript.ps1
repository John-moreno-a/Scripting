$readingComputerNameFromFile = Get-Content "c:\NombreTemporal.txt"
#[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#[System.Windows.Forms.MessageBox]::Show($readingComputerNameFromFile)

ForEach ($regValues in $readingComputerNameFromFile){
   $objectWithName = $regvalues | Select-String -Pattern "Distinguished-Name" -quiet 
   if ($objectWithName){
        $stringValue = $regvalues
   }
      }
      #$stringvalue
      $gettingName = $stringvalue.IndexOf("CN=")
      #gettingName
      $gettingComaPosition = $stringvalue.IndexOf(",OU")
      #$gettingComaPosition
      $nameCount = (($gettingComaPosition - $gettingName) - 3)
      #$nameCount
      $nameStart = ($gettingName + 3)
      $GettingDNName = $stringvalue.Substring($nameStart,$nameCount)
      #$GettingDNName
      <#$stringValue = $stringValue.trim(" ")
      $positionValue = ($stringValue.IndexOf('SZ') + 6)
      $stringCountValue = $stringValue.length
      $computerNameCount = ($stringCountValue - $positionValue)
      $computerValue = $stringValue.substring($positionValue,$computerNameCount)
      #>
      $arrayComputerName =  $GettingDNName.ToCharArray()
      $arrayComputerName