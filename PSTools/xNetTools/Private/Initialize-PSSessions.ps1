function Initialize-PSSessions {
  param
  (
    [Parameter(Mandatory)]
    [System.Management.Automation.Credential()]
    [pscredential]
    $ConnectionCredential,
  
    [Parameter(Mandatory)]
    [String]
    $LogFile,
    
    [Parameter(Mandatory)]
    [String]
    $ErrorFile,

    [Parameter(Mandatory)]
    [HashTable]
    $ServerList
  )
 
  Write-Verbose -Message 'Cleaning Up Any Old Sessions...'
  Get-PSSession | Remove-PSSession

  $SesErr = $ErrInfo = @()  
  
  foreach ($Pair in $ServerList.GetEnumerator()) {
    $Source = $Pair.Value
    #$key = $Pair.key #TODO: Is this needed?
    
    if (Get-Variable -Name SessionError -ErrorAction SilentlyContinue) {
      Clear-Variable -Name SessionError
    }

    Write-Verbose -Message "Creating Connection to $Source"

    $SessionOptions = New-PSSessionOption -OpenTimeout 4
    
    $null = New-PSSession `
    -ComputerName $Source `
    -SessionOption $SessionOptions `
    -Name $Source `
    -Credential $ConnectionCredential `
    -ErrorVariable SessionError
    

    if ($SessionError.Count -ne 0) {
      Write-Verbose -Message "Error Connecting to $Source"
      $SesErr += $Source
      $ErrInfo += "$SessionError`n"
      $ErrIdentifier = "$Source`n"
      
      Out-File -FilePath $ErrorFile -InputObject $ErrIdentifier -Append
      Out-File -FilePath $ErrorFile -InputObject "$ErrInfo" -Append
      
    } else {
    
      Write-Verbose -Message "Successfully connected to $Source"

    }
  }
    
  if ($SesErr.Count -gt 0)
  { 
    Write-Verbose -Message "Errors Connecting to $($SesErr.Count) Servers... See $ErrorFile for more information"
  } else {
    Write-Verbose -Message 'There were no errors creating remote sessions...' 
  }
}