function ConvertTo-Seed {
  param (
    [int64]
    $Location
  ) # End block:param

  process {
    $ConversionTrack = [ordered]@{}

    $PriorSpecValue = $Location
    foreach ( $ThisSpec in ("Humidity", "Temp", "Light", "Water", "Fertilizer", "Soil", "Seed") ) {
      $ConversionParam = @{
        Value     = $PriorSpecValue
        GuidePath = Join-Path $PSScriptRoot "$($ThisSpec)*csv"
        Reverse   = $true
      }

      $ConvertedSpecValue = Convert-GardeningSpec @ConversionParam
      $ConversionTrack[$ThisSpec] = $ConvertedSpecValue

      $PriorSpecValue = $ConvertedSpecValue

    } # End block:foreach Gardening Spec

    Write-Output $ConversionTrack

  } # End block:process

} # End function
