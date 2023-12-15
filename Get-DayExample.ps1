function Get-DayExample {
  param (
    [Parameter(
      Mandatory
    )]
    [int]
    $Day
  ) # End block:param

  process {
    $ExampleFilePath = Resolve-AocPath -Day $Day -Example

    $DayInput = Get-Content $ExampleFilePath

    Write-Output $DayInput

  } # End block:process

} # End function
