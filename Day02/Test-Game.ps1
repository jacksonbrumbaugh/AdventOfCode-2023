function Test-Game {
  param (
    [Parameter(
      Mandatory,
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    [string]
    $Game,

    [hashtable]
    $ColorMax = @{
      blue  = 14
      green = 13
      red   = 12      
    }
  ) # End block:param

  process {
    $GameStat = Get-GameStat $Game

    $isImpossible = $false
    :ColorLoop foreach ( $ThisColor in $ColorMax.Keys ) {
      foreach ( $ThisDrawing in $GameStat.Drawing ) {
        if ( $ThisDrawing.$ThisColor -gt ($ColorMax.$ThisColor -as [double]) ) {
          $isImpossible = $true
          break ColorLoop
        }
      } # End block:foreach Drawing

    } # End block:foreach Color

    $GamePossibleCode = if ( $isImpossible ) {
      0
    } else {
      $GameStat.GameID
    }

    Write-Output $GamePossibleCode

  } # End block:process

} # End function
