function Convert-GardeningSpec {
  [CmdletBinding(DefaultParameterSetName = "LoadFile")]
  param (
    [Parameter(
      Mandatory,
      Position = 0
    )]
    [int64]
    $Value,

    [Parameter(
      ParameterSetName = "LoadFile",
      Mandatory
    )]
    [ValidatePattern("csv$")]
    [ValidateScript(
      { Test-Path $_ }
    )]
    [string]
    $GuidePath,

    [Parameter(
      ParameterSetName = "InputGuide",
      Mandatory
    )]
    [PSCustomObject]
    $Guide
  ) # End block:param

  begin {
    $Guide = Import-GardenGuide -Guide $Guide -GuidePath $GuidePath
  } # End block:begin

  process {
    $To = $Value
    foreach ( $ThisRow in $Guide ) {
      $Start = $ThisRow.SourceStart -as [int64]
      $End = $Start + $ThisRow.Range

      if ( $Value -ge $Start -and $Value -lt $End ) {
        $To = ($ThisRow.DestStart -as [int64]) + $Value - $Start
      }
    }

    Write-Output $To

  } # End block:process

} # End function
