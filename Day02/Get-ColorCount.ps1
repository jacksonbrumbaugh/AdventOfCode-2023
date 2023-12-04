function Get-ColorCount {
  param (
    [Parameter(
      Mandatory
    )]
    [string]
    $Game,

    [Parameter(
      Mandatory
    )]
    [ValidateSet(
      "blue",
      "green",
      "red"
    )]
    [String]
    $Color
  ) # End block:param

  process {
    $Count = if ( $Game -match $Color ) {
      $Game -replace ".* (\d+) $($Color).*",'$1'
    } else {
      0
    }

    Write-Output ($Count -as [double])

  } # End block:process

} # End function
