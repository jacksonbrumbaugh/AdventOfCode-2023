function Measure-Answer02 {
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
    $GameArray = Get-Content $Path
    
    $Answer = 0
    foreach ( $ThisGame in $GameArray ) {
      $Answer += if ( $Part -eq "A" ) {
        Test-Game $ThisGame
      } else {
        Get-GamePower $ThisGame
      }

    } # End block:foreach Game

    Write-Output $Answer

  } # End block:process

} # End function
