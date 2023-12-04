function Measure-Answer03 {
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
    $Path = (Resolve-Path $PSScriptRoot/Input*)
  ) # End block:param

  process {
    $SchematicArray = Get-Content $Path

    $PartNumberArray = @()
    $GearRatioArray = @()

    $i = -1
    foreach ( $ThisLine in $SchematicArray ) {
      $i++

      $LineParam = @{
        Focus = $ThisLine
        Above = if ( $i -ne 0 ) { $SchematicArray[$i - 1] } else { $null }
        Below = $SchematicArray[$i + 1]
      }

      if ( $Part -eq "A" ) {
        $PartNumberArray += Search-Schematic @LineParam
      } else {
        $GearRatioArray += Search-GearRatio @LineParam
      }

    } # End block:foreach Schematic Line

    $ArrayToSum = if ( $Part -eq "A" ) {
      $PartNumberArray
    } else {
      $GearRatioArray
    }

    $Total = ($ArrayToSum | Measure-Object -Sum).Sum

    Write-Output $Total

  } # End block:process

} # End function
