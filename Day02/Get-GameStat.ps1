function Get-GameStat {
  param (
    [Parameter(
      Mandatory,
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    [string]
    $Game
  ) # End block:param

  process {
    $GameStat = [PSCustomObject]@{
      GameID  = $Game -replace "Game (\d+):.*",'$1'
      Drawing = @()
    }

    $ErrorDetails = @{
      Message     = $null
      ErrorAction = "Stop"
    }

    if ( -not $GameStat.GameID ) {
      $ErrorDetails.Message = "Failed to find the ID for the game. "
      Write-Error @ErrorDetails
    }

    $DrawingArray = $Game.split(":")[1].split(";")
    
    foreach ( $ThisGame in $DrawingArray ) {
      $Hash_ColorCount += @{}
      
      foreach ( $ThisColor in ("blue", "green", "red") ) {
        $Hash_ColorCount[$ThisColor] = Get-ColorCount -Game $ThisGame -Color $ThisColor
      }  
      
      $GameStat.Drawing += $Hash_ColorCount
      
    } # End block:foreach Game  

    if ( $GameStat.Drawing.Count -eq 0 ) {
      $ErrorDetails.Message = "The game does not have any data about which cubes were drawn. "
      Write-Error @ErrorDetails
    }

    Write-Output $GameStat

  } # End block:process

} # End function
