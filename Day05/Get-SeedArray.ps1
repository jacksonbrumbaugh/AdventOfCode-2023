function Get-SeedArray {
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
    $SeedInfo = (Get-Content $Path -First 1) -replace "seeds: ","" -split " "

    $SeedArray = switch ( $Part ) {
      "A" {
        foreach ( $ThisSeed in $SeedInfo ) {
          [PSCustomObject]@{
            Start = $ThisSeed
            Range = 1
          }
        } # End block:foreach Seed

      } # End case:A

      "B" {
        for ( $n = 0; $n -lt ($SeedInfo.Count / 2); $n++ ) {
          [PSCustomObject]@{
            Start = $SeedInfo[2 * $n]
            Range = $SeedInfo[1 + 2 * $n]
          }
        } # End block:foreach Seed

      } # End case:B

    } # End block:switch on Part

    Write-Output $SeedArray

  } # End block:process

} # End function
