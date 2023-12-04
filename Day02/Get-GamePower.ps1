function Get-GamePower {
  param (
    [Parameter(
      Mandatory,
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    $Game
  ) # End block:param

  process {
    $GameStat = Get-GameStat $Game

    $Power = 1
    foreach ( $ThisColor in ("blue", "green", "red") ) {
      $Power *= ($GameStat.Drawing.$ThisColor | Measure-Object -Maximum).Maximum
    }

    Write-Output $Power

  } # End block:process

} # End function
