function Get-DayInput {
  param (
    [Parameter(
      Mandatory
    )]
    [int]
    $Day
  ) # End block:param

  process {
    $InputFilePath = Resolve-AocPath -Day $Day -DayInput

    $DayInput = Get-Content $InputFilePath

    Write-Output $DayInput

  } # End block:process

} # End function
