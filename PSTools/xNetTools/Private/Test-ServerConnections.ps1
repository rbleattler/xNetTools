function Test-ServerConnections
{
  param
  (
    [Parameter(Mandatory, ValueFromPipeline, HelpMessage='PSSession Data')]
    [Object]
    $InputObject,
    [Parameter(Mandatory, ValueFromPipeline, HelpMessage='Connection Timeout')]
    [Alias('TO')]
    [int]
    $ConnectionTimeout
      
  )
  process
  {
    [ScriptBlock]$SendFunction = (Get-Item -Path 'Function:Test-xNetConnection').ScriptBlock
    $ScriptBlock = Get-Content -Raw -Path "$PSScriptRoot\RemoteScript.ps1"
    $ScriptBlock = [scriptblock]::Create($ScriptBlock)
    Write-Verbose -Message 'Starting'
    $null = Invoke-Command -Session $InputObject -ScriptBlock $ScriptBlock -OutVariable JResults -ArgumentList $SendFunction,$ConnectionTimeout -Verbose
    Write-Verbose -Message 'Done'
    Write-Output -InputObject $Jresults | Out-File -FilePath $LogFile -Append -Force
      
  }
}
