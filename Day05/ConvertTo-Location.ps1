function ConvertTo-Location {
  [CmdletBinding(DefaultParameterSetName = "LoadFile")]
  param (
    [int64]$Seed
  )

  process {

    $ConversionTrack = [PSCustomObject]@{
      Seed       = $Seed
      Soil       = Convert-GrowingInfo -Type Seed-Soil -From $Seed
      Fertilizer = $null
      Water      = $null
      Light      = $null
      Temp       = $null
      Humidity   = $null
      Location   = $null
    }
    
    $ConversionTrack.Fertilizer = Convert-GrowingInfo -Type Soil-Fertilizer -From $ConversionTrack.Soil
    $ConversionTrack.Water = Convert-GrowingInfo -Type Fertilizer-Water -From $ConversionTrack.Fertilizer
    $ConversionTrack.Light = Convert-GrowingInfo -Type Water-Light -From $ConversionTrack.Water
    $ConversionTrack.Temp = Convert-GrowingInfo -Type Light-Temp -From $ConversionTrack.Light
    $ConversionTrack.Humidity = Convert-GrowingInfo -Type Temp-Humidity -From $ConversionTrack.Temp
    $ConversionTrack.Location = Convert-GrowingInfo -Type Humidity-Location -From $ConversionTrack.Humidity
    
    Write-Output $ConversionTrack

  } # End block:process

} # End function
