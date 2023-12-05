function Convert-PlantInfo {
  param (
    [ValidateSet(
      "Seed-Soil",
      "Soil-Fertilizer",
      "Fertilizer-Water",
      "Water-Light",
      "Light-Temp",
      "Temp-Humidity",
      "Humidity-Location"
    )]
    $Type,

    [int64]
    $From
  ) # End block:param

  process {
    $GuideName = $Type -replace "-","*"

    $Guide = Import-CSV "./$GuideName*"

    $To = $From
    foreach ( $ThisRow in $Guide ) {
      $Start = $ThisRow.SourceStart -as [int64]
      $End = $Start + $ThisRow.Range

      if ( $From -ge $Start -and $From -lt $End ) {
        $To = ($ThisRow.DestStart -as [int64]) + $From - $Start
      }
    }

    Write-Output $To

  } # End block:process

} # End function
