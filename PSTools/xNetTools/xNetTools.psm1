function Test-xConnection
{
  <#
      .SYNOPSIS
      The purpose of this function is to validate connections to key sites and hosts 
      from MHS/CHC servers.

      .DESCRIPTION
      The function achieves it's goal by creating remote sessions to the target servers, 
      and executing Test-NetConnection to the target hosts over the specified ports from 
      those hosts. The output is then captured, and formatted into an easily readable 
      text file. 

      .PARAMETER LogFile
      Where to save the output data.

      .PARAMETER ServerList
      The list of hosts FROM which to test (the remote servers). This must be a hashtable in the format below:
      @{
      '1.1.1.1' = 'SomeServer.MyDomain.Net'
      '2.2.2.2' = 'DifferentServer.YourDomain.local'
      ...
      }

      .PARAMETER TestHosts
      The list of sites and hosts to validate connectivity TO from the remote servers. 
      This must be a hashtable in the format below:
      @{
      # Host or IP = Port Number
      'Site.Domain.Qualifier' = 443
      '8.8.8.8' = 80
      ...
      }

      .EXAMPLE
      Test-xConnection -LogFile 'C:\Test.txt' -ServerList $ServerHashTable -TestHosts $HostHashTable
      This will validate connectivity for each server in $ServerHashTable to each Host/IP in $HostHashTable over the designated ports, and report the results out in 'C:\Test.txt'

      .NOTES
      NONE

      .LINK
      NONE

      .INPUTS
      String, Hashtable

      .OUTPUTS
      String, File
  #>


  [CmdletBinding(SupportsShouldProcess)]
  param
  (
    [parameter(Mandatory,HelpMessage='Where to Save the Output Data. I.E. C:\Test.txt')]
    [string]
    $LogFile,
    [parameter(Mandatory,HelpMessage='List of Servers to Test Connections FROM.')]
    [Hashtable]
    $ServerList,  
    [Hashtable]
    $TestHosts = [Ordered]@{
      'nuget.org' = 443
      'notepad-plus-plus.org' = 443
      'github.com' = 443
      'bitbucket.org' = 443
      'visualstudio.microsoft.com' = 443
      'java.com' = 443
      'quest.com' = 443
      'google.com' = 443
      'gstatic.com' = 443
    },
    [Parameter(Mandatory)]
    [PSCredential]
    $ConnectionCredential,
    [Parameter(Mandatory)]
    [int]
    $ConnectionTimeout
  
  )

  $ErrorFile = New-LogFile -LogFilePath $LogFile -Verbose
  
  Write-Verbose -Message 'Creating Remote Sessions'
  Initialize-PSSessions -ServerList $ServerList -ConnectionCredential $ConnectionCredential -LogFile $LogFile -ErrorFile $ErrorFile -Verbose
  $sessions = Get-PSSession
   
  Write-InitialLogLines -LogFile $LogFile -ConnectionTimeout $ConnectionTimeout
  
  $sessions | Test-ServerConnections -ConnectionTimeout $ConnectionTimeout -Verbose

  $sessions | Remove-PSSession 
}
