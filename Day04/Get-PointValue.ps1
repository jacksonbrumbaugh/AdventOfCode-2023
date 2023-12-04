function Get-PointValue {
  param (
    [string]
    $Card
  ) # End block:param

  process {
    $WinningNumberArray = ($Card -replace ".*:(.*)\|.*",'$1' -split " ").where{ -not [string]::IsNullOrEmpty($_) }

    $PlayNumberArray = ($Card -replace ".*\|(.*)",'$1' -split " ").where{ -not [string]::IsNullOrEmpty($_) }

    $WonNumberArray = @()

    foreach ( $ThisPlay in $WinningNumberArray ) {
      if ( $ThisPlay -in $PlayNumberArray ) {
        $WonNumberArray += $ThisPlay
      }
    }

    $PointValue = if ( $WonNumberArray.Count -gt 0 ) {
      [math]::Pow(2, $WonNumberArray.Count -1)
    } else {
      0
    }

    Write-Output $PointValue

  } # End block:process

} # End function
