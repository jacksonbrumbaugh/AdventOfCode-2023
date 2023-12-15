function Test-Seed {
  param (
    [Parameter(
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    [int64]
    $Seed,

    [Parameter(
      ValueFromPipeline,
      ValueFromPipelineByPropertyName,
      ValueFromRemainingArguments
    )]
    $ExtraGardeningSpec
  ) # End block:param

  process {
    $ValidSeedArray = Get-SeedArray -Part B

    $isValidSeed = $false
    foreach ( $ThisRow in $ValidSeedArray ) {
      $StartValue = $ThisRow.Start -as [int64]
      $EndValue = $StartValue + $ThisRow.Range

      if ( $Seed -ge $StartValue -and $Seed -lt $EndValue ) {
        $isValidSeed = $true
        break
      }

    } # End block:foreach Seed Row

    Write-Output $isValidSeed

  } # End block:process

} # End function
