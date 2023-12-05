function Measure-Answer05 {
  param (
    [Part]
    $Part = "A",

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
    $SeedArray = (Get-Content $Path -First 1) -replace "seeds: ","" -split " "

    $LocationArray = @()

    foreach ( $ThisSeed in $SeedArray ) {
      $Soil = Convert-PlantInfo -Type Seed-Soil -From $ThisSeed
      $Fertilizer = Convert-PlantInfo -Type Soil-Fertilizer -From $Soil
      $Water = Convert-PlantInfo -Type Fertilizer-Water -From $Fertilizer
      $Light = Convert-PlantInfo -Type Water-Light -From $Water
      $Temp = Convert-PlantInfo -Type Light-Temp -From $Light
      $Humidity = Convert-PlantInfo -Type Temp-Humidity -From $Temp
      $Location = Convert-PlantInfo -Type Humidity-Location -From $Humidity

      Write-Host $Location

      $LocationArray += $Location
    }

    Write-Output ($LocationArray | Measure-Object -Minimum).Minimum

  } # End block:proces

} # End function
