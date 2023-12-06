function Get-WinWindow {
  param (
    [int64]
    $TimeAllowed,

    [int64]
    $ValueToBeat
  ) # End block:param

  process {
    $Discriminant = [math]::Sqrt($TimeAllowed * $TimeAllowed - 4 * $ValueToBeat)

    $Lower = [math]::Ceiling( 0.5 * ($TimeAllowed - $Discriminant) )
    $Upper = [math]::Floor( 0.5 * ($TimeAllowed + $Discriminant) )

    $WinWindow = [PSCustomObject]@{
      Lower = $Lower
      Upper = $Upper
      Count = 1 + $Upper - $Lower
    }

    Write-Output $WinWindow

  } # End block:process

} # End function
