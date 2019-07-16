function New-LogFile {
  param(
    [Parameter(Mandatory)]
    [String]
    $LogFilePath,
    [Switch]
    $Silent
  )
  
  Write-Verbose -Message 'Parsing Log File Name to Create Error File'
  $Ext = [io.path]::GetExtension($LogFilePath)
  $ErrFile = [io.path]::ChangeExtension($LogFilePath,('.errors{0}' -f $ext))
  
  $Paths = @{
    Log = $LogFilePath
    Error = $ErrFile
  }
  
  foreach ($Pair in $Paths.GetEnumerator()) {
    if (!(Test-Path -Path $Pair.Value)) {
      $Message = ('Creating {0} File at {1}' -f $Pair.Key,$Pair.Value)    
      Write-Verbose -Message $Message
      $Null = New-Item -ItemType File -Path $Pair.Value -Force
    } else {
      $Message = ('{0} File at {1} already exists...' -f $Pair.Key,$Pair.Value)
      Write-Verbose -Message $Message
      Write-Verbose -Message 'Data will be appended to existing file'
    }
  }
  
  if (!$Silent) {
    $ErrFile
  }    
}