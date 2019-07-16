function Write-InitialLogLines {
  param
  (
    [String]
    [Parameter(Mandatory)]
    $LogFile,

    [Parameter(Mandatory)][String]
    $ConnectionTimeout
  )

  $LineBreak = '-------------------------------------------------------------'
  $Date = Get-Date -Format 'MM-dd-yyyy'
  $Time = Get-Date -Format 'HH:mm:ss'
  $Start = "Starting Session`t|`t$Date`t$Time"
  $Settings = "Test Timeout:`t$ConnectionTimeout ms"
  Write-Output -InputObject $LineBreak | Out-File -FilePath $LogFile -Append -Force
  Write-Output -InputObject $Start | Out-File -FilePath $LogFile -Append -Force
  Write-Output -InputObject $Settings | Out-File -FilePath $LogFile -Append -Force
  Write-Output -InputObject $LineBreak | Out-File -FilePath $LogFile -Append -Force
}