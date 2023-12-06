$ModuleRootDir = $PSScriptRoot
$ModuleName = Split-Path $ModuleRootDir -Leaf

enum Part {
  A
  B
}

enum GardeningSpec {
  Seed
  Soil
  Fertilizer
  Water
  Light
  Temp
  Humidity
  Location  
}

$DirToCheckArray = @(
  $ModuleRootDir
)

$DirToCheckArray += Get-ChildItem $ModuleRootDir -Directory

$NoExportKeywordArray = @()

foreach ( $ThisDir in $DirToCheckArray ) {
  $GetFromDir = if ( $ThisDir -ne $ModuleRootDir ) {
    Join-Path $ModuleRootDir $ThisDir
  } else {
    $ModuleRootDir
  }

  foreach ( $ThisScript in (Get-ChildItem -Path $GetFromDir -Include "*.ps1" -Recurse) ) {
    $ThisScriptItem = Get-Item $ThisScript
    $ThisScriptFullName = $ThisScriptItem.FullName

    # Dot-Sourcing; loads the function as part of the module
    . $ThisScriptFullName

    $ThisDirName = Split-Path (Split-Path $ThisScriptFullName) -Leaf
    $FunctionName = (Split-Path $ThisScriptFullName -Leaf).replace( '.ps1', '' )

    $doExport = $true
    foreach ( $ThisKeyword in $NoExportKeywordArray ) {
      if ( $ThisDirName -match $ThisKeyword ) {
        $doExport = $false
      }
    }

    if ( $doExport ) {
      # Lets users use / see the function
      Export-ModuleMember $FunctionName
    }

  } # End block:foreach ThisScript

} # End block:foreach Dir to check

$Aliases = (Get-Alias).Where{ $_.Source -eq $ModuleName }
$AliasNames = $Aliases.Name -replace "(.*) ->.*","`$1"
foreach ( $Alias in $AliasNames ) {
  # Lets users use / see the alias
  Export-ModuleMember -Alias $Alias
}
