function Measure-Answer01 {
  param (
    [Part]
    $Part = "B",

    [Parameter(
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    [ValidateScript(
      { Test-Path $_ }
    )]
    [SupportsWildcards()]
    [string]
    $Path = (Resolve-Path $PSScriptRoot/Input*)
  ) # End block:param

  process {
    $Total = 0

    foreach ( $ThisLine in (Get-Content $Path) ) {
      $PartLine = switch ( $Part ) {
        "A" { $ThisLine }

        "B" { Convert-Calibration $ThisLine }

      } # End block:switch on Part

      $Total += Get-CalibrationValue $PartLine

    } # End block:foreach Line

    Write-Output $Total

  } # End block:process

} # End function
