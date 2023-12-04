function Get-MatchCount {
  param (
    [string]
    $Card
  ) # End block:param

  process {
    $MatchCount = 0

    $WinningNumberArray = ($Card -replace ".*:(.*)\|.*",'$1' -split " ").where{ -not [string]::IsNullOrEmpty($_) }

    $PlayNumberArray = ($Card -replace ".*\|(.*)",'$1' -split " ").where{ -not [string]::IsNullOrEmpty($_) }

    foreach ( $ThisPlay in $WinningNumberArray ) {
      if ( $ThisPlay -in $PlayNumberArray ) {
        $MatchCount++
      }
    }

    Write-Output $MatchCount
  
  } # End block:process

} # End function
