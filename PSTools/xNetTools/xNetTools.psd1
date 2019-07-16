# Module manifest for module 'xNetTools'

@{

  # Script module or binary module file associated with this manifest.
  RootModule = 'xNetTools.psm1'

  # Version number of this module.
  ModuleVersion = '2.2'

  # Supported PSEditions
  # CompatiblePSEditions = @()

  # ID used to uniquely identify this module
  GUID = 'e808acfb-f74c-4b22-a9b2-172a01f6f72c'

  # Author of this module
  Author = 'Robert Bleattler'

  # Company or vendor of this module
  CompanyName = 'Coast Technologies LLC'

  # Copyright statement for this module
  Copyright = '(c) 2019 Coast Technologies LLC. All rights reserved.'

  # Description of the functionality provided by this module
  Description = "
    This tool tests connections to specified destinations, from specified hosts, over specified ports.
    The tool returns data in a variety of ways.
  "

  # Minimum version of the Windows PowerShell engine required by this module
  PowerShellVersion = '3.0'

  # Name of the Windows PowerShell host required by this module
  # PowerShellHostName = ''

  # Minimum version of the Windows PowerShell host required by this module
  # PowerShellHostVersion = ''

  # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # DotNetFrameworkVersion = ''

  # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # CLRVersion = ''

  # Processor architecture (None, X86, Amd64) required by this module
  # ProcessorArchitecture = ''

  # Modules that must be imported into the global environment prior to importing this module
  RequiredModules = @(
    'NetAdapter', 
    'NetTCPIP'
  )

  # Assemblies that must be loaded prior to importing this module
  # RequiredAssemblies = @()

  # Script files (.ps1) that are run in the caller's environment prior to importing this module.
  ScriptsToProcess = @(
    'Private\Initialize-PSSessions.ps1', 
    'Private\New-LogFile.ps1', 
    'Private\Test-ServerConnections.ps1', 
    'Private\Write-InitialLogLines.ps1', 
    'Exported\Test-xNetConnection.ps1'
  )

  # Type files (.ps1xml) to be loaded when importing this module
  # TypesToProcess = @()

  # Format files (.ps1xml) to be loaded when importing this module
  # FormatsToProcess = @()

  # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
  NestedModules = @(
    'Private\Initialize-PSSessions.ps1', 
    'Private\New-LogFile.ps1', 
    'Private\Test-ServerConnections.ps1', 
    'Private\Write-InitialLogLines.ps1', 
    'Exported\Test-xNetConnection.ps1'
  )

  # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
  FunctionsToExport = '*'

  # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
  CmdletsToExport = '*'

  # Variables to export from this module
  VariablesToExport = '*'

  # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
  AliasesToExport = '*'

  # DSC resources to export from this module
  # DscResourcesToExport = @()

  # List of all modules packaged with this module
  # ModuleList = @()

  # List of all files packaged with this module
  FileList = @(
    'Private\Initialize-PSSessions.ps1', 
    'Private\New-LogFile.ps1', 
    'Private\RemoteScript.ps1', 
    'Private\Test-ServerConnections.ps1', 
    'Private\Write-InitialLogLines.ps1', 
    'Exported\Test-xNetConnection.ps1'
  )

  # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
  PrivateData = @{

    PSData = @{

      # Tags applied to this module. These help with module discovery in online galleries.
      # Tags = @()

      # A URL to the license for this module.
      # LicenseUri = ''

      # A URL to the main website for this project.
      # ProjectUri = ''

      # A URL to an icon representing this module.
      # IconUri = ''

      # ReleaseNotes of this module
      # ReleaseNotes = ''

    } # End of PSData hashtable

  } # End of PrivateData hashtable

  # HelpInfo URI of this module
  # HelpInfoURI = ''

  # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
  # DefaultCommandPrefix = ''

}

