param(
  $FunctionCall,
  $ConnectionTimeOUt
)
$VerbosePreference = 'Continue'
$TempDir = "$Env:USERPROFILE\AppData\Temp\TestFirewall"

$WMIObject = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property *
$Caption = $WMIObject.caption
$VersionTable = $WMIObject.version.tostring().split('.',3) 
$OSVersion = [decimal]('{0}.{1}' -f $VersionTable[0],$VersionTable[1])
$SupportedVersion = ($OSVersion -ge 6.2)

    
if (!$SupportedVersion) {
  $outmessage = @()
  $outmessage += $LineBreak        
  $outmessage += "Host:`t$env:COMPUTERNAME`t`t`t"
  $outmessage += "OS Version: $OSVersion"
  $outmessage += "$Caption"
  $outmessage += 'This OS Version does not natively support the tools used by this script.'
  $outmessage += 'Terminating this test.'   
  $outmessage      
} else {
  $string1 = 'function Test-xNetConnection'
  $string2 = '{'
  $string3 = '}'
  $TestxNetConnection = ("{0}`n{1}{2}{3}" -f $string1,$string2,$FunctionCall,$string3)
  Write-Verbose -Message 'Creating Temp Script'
  $TempScript = New-Item -ItemType File -Name 'Test-xNetConnection.ps1' -Path $TempDir -Value $TestxNetConnection -Force 

  . "$TempDir\Test-xNetConnection.ps1"
  $LineBreak = '-'*61
  $SectionBreak = $LineBreak.Replace('-','*')
  $ip = (Get-NetAdapter | Select-Object -ExpandProperty Name).split('-',2)[1].replace(' ','') 
  $outmessage = @()
  $outmessage += $LineBreak        
  $outmessage += "Host:`t$env:COMPUTERNAME`t`t`tIP:`t$ip"
  $outmessage += "OS Version: $OSVersion"
  $outmessage += "$Caption"
  $outmessage += $LineBreak
        
  # Store the data from the TestHosts variable locally on remote machine
  # This allows us to call particular values in the Hashtable by key name
  $UTestHosts = $using:TestHosts

  $outmessage += "Sitename`t`t`t`t`t`t`t|`tPort`t|`tResult"
  $outmessage += $LineBreak

  foreach($sitename in $UTestHosts.keys) {
    $SitenamePorts = $UTestHosts[$sitename]
    foreach ($port in $SitenamePorts)
    {
      $results = Test-xNetConnection -Server $sitename -Port $port -Timeout $ConnectionTimeout
      $message = "{0,-32}`t|`t{1,-6}`t:`t{2}" -f $sitename,$port,$results
      $outmessage += "$message"
    }         
  }
      
  $outmessage += $LineBreak
  $outmessage += $SectionBreak
      
  Remove-Item $TempScript -Verbose
       
  $outmessage
}
