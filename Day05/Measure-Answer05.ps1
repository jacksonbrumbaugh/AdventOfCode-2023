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

    $MinimumLocation = ConvertTo-Location $SeedArray[0]

    $ConversionArray = New-Object System.Collections.ArrayList

    foreach ( $ThisSeed in $SeedArray ) {
      $ConversionArray.Add( (ConvertTo-Location $ThisSeed) ) | Out-Null

      if ( $ConversionArray.Location -lt $MinimumLocation ) {
        $MinimumLocation = $ConversionArray.Location
      }

    } # End block:foreach Seed

    Write-Output $MinimumLocation

  } # End block:proces

} # End function
