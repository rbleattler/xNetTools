function Test-xNetConnection
{
  Param(
    [Parameter(Mandatory)][string]
    $Server,
    [Int]
    $Port = 135,
    [Int]
    $Timeout=3000
  )

  # Opens a TCP connection on specified port (135 by default)
  $ErrorActionPreference = 'SilentlyContinue'
  Write-Verbose -Message "Testing Connection to: $Server on port: $Port with a timeout of: $Timeout ms"

  # Create TCP Client
  $TCPClient = New-Object -TypeName System.Net.Sockets.TcpClient
  
  # Set RequestCallBack & State
  $RequestCallBack = $State = $null
 
  # Tell TCP Client to connect to machine on Port
  $IASyncResult = $TCPClient.BeginConnect($Server,$Port,$RequestCallBack,$State)
  #$TCPClient.Connect($Server,$port)
 
  # Set the Wait time
  $Wait = $IASyncResult.AsyncWaitHandle.WaitOne($Timeout,$false)
 
  # Check to see if the connection is done
  if (!$Wait)
  {
    # Close the connection and report timeout to verbose stream
    $TCPClient.Close()
    Write-Verbose -Message 'Connection Timeout'
    $Failed = 'Timeout'
  } else {
    # Close the connection and report the error if there is one
    $Error.Clear()
    $Null = $TCPClient.EndConnect($IASyncResult)
    
    if($Error[0]) {
      write-Verbose -Message $Error[0].Exception.InnerException
      $Failed = 'Fail'
    }
    
  }
 
  $TCPClient.Close()

  # Return $true if connection Establish else $False
  if($null -ne $Failed) {
    $Failed
  } else {
    'Pass'
  }
}
  