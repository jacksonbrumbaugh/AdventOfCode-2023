function Get-DayInput {
  param (
    [Parameter(
      Mandatory
    )]
    [int]
    $Day
  ) # End block:param

  process {
    $PaddedDay = "{0:D2}" -f $Day

    $DayInput = Get-Content $ModuleRootDir/*/Input*$PaddedDay*

    Write-Output $DayInput

  } # End block:process

} # End function
