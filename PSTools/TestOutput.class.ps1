class TestOutput
{
  # private 
  hidden $OSWMI = (Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property *)
  hidden $NETWMI = (Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress})
  hidden $VersionTable = $OSWMI.version.tostring().split('.',3)
  hidden [string]$VisibleMemory = ('{0} GB' -f [Math]::Round($OSWMI.TotalVisibleMemorySize/1mb))
  hidden $OSVersion = ('{0}.{1}.{2}' -f $this.VersionTable[0],$this.VersionTable[1],$this.VersionTable[2])
  hidden $DefaultTimeout = 10000
  hidden $LineBreak = ('-'*61)
  # public Properties
  hidden [string]$Host = $OSWMI.PSComputerName
  hidden [string]$Caption = $OSWMI.caption
  hidden [string]$IPAddress = ($NETWMI | Where-Object {$_.DefaultIPGateway[0].StartsWith('10')} | Select-Object -ExpandProperty IPAddress)[0]
  static [string]$Date = (Get-Date -Format 'MM-dd-yyyy')
  static [string]$Time = (Get-Date -Format 'HH:mm:ss')
  static [String]$InstalledRAM = $VisibleMemory 
  
  hidden [int]$Timeout
  [string]$SiteName
  [int]$Port
  [string]$Result
  
   
  # Constructors
  
  TestOutput ([string]$S,[int]$P,[string]$Res,[int]$TO) {
    $this.SiteName = $S
    $this.Port = $P
    $this.Result = $Res
    $This.Timeout = $TO
  }

  TestOutput ([string]$S,[int]$P,[string]$Res) {
    $this.SiteName = $S
    $this.Port = $P
    $this.Result = $Res
    $This.Timeout = $this.DefaultTimeout
  }
  
  TestOutput([object]$ArgsList) {
    $this.SiteName = $ArgsList.SiteName
    $this.Port = $ArgsList.Port
    $this.Result = $ArgsList.Result
    if ($null -ne $ArgsList.Timeout) {
      $this.Timeout = $ArgsList.Timeout
    } else {
      $this.Timeout = $this.DefaultTimeout
    }
  } 

  # Methods
  
  [string] WriteHeader() {
    $Line1 = ("Host:`t`t{0}`t`t`tIP:`t`t{1}" -f $this.Host,$this.IPAddress)
    $Line2 = ("OS Version:`t{0}" -f $this.OSVersion)
    $Line3 = $this.Caption
    $Line4 = ("{0}$("`t"*7){3}`t{1}`t{3}`t{2}`t{3}" -f 'SiteName','Port','Result','|')
    Return ("{3}`n{0}`n{1}`n{2}`n{3}`n{4}`n{3}" -f $Line1,$Line2,$Line3,$this.LineBreak,$Line4)
  }

  [string] WriteResultLine() {
    $OutMessage = ("{0,-32}`t{3,-6}`t{1}`t{3}`t{2}`t{3}" -f $this.SiteName,$this.Port,$this.Result,'|')
    Return $OutMessage
  }

  [string] NewTest () {
    $Line1 = $this.LineBreak
    $Line2 = ("Starting Session`t|`t{0}`t{1}" -f $this::Date,$this::Time)
    $Line3 = ("Test Timeout:`t{0}" -f $this.Timeout)
    $OutMessage = ("{0}`n{1}`n{2}" -f $Line1,$Line2,$line3)
    Return $OutMessage
  }

  [void] SetStartTimeNow() {
    $this::Time = (Get-Date -Format 'HH:mm:ss')
  }

}

# instantiate class

$TestArgs = @{
  SiteName = 'localhost.mydomain.com'
  Port = 80
  Result = 'Pass'
  Timeout = 5000
}

$TO = [TestOutput]::new($testargs)
$To.NewTest()
$TO.WriteHeader()
$TO.WriteResultLine()

