function Resolve-AocPath {
  param (
    [Parameter(
      Mandatory
    )]
    [int]
    $Day,

    [Parameter(
      ParameterSetName = "FindInput",
      Mandatory
    )]
    [switch]
    $DayInput,

    [Parameter(
      ParameterSetName = "FindExample",
      Mandatory
    )]
    [switch]
    $Example
  ) # End block:param

  process {
    $PathKeyword = if ( $DayInput ) {
      "Input"
    } else {
      "Example"
    }

    $AocFilePath = Join-Path $ModuleRootDir "*/$($PathKeyword)*$($Day)*"

    if ( -not (Test-Path $AocFilePath) ) {
      $PaddedDay = "{0:D2}" -f $Day
      $PaddedDay_AocFilePath = Join-Path $ModuleRootDir "*/$($PathKeyword)*$($PaddedDay)*"

      if ( Test-Path $PaddedDay_AocFilePath ) {
        $AocFilePath = $PaddedDay_AocFilePath
      } else {
        Write-Error "Failed to find the $($PathKeyword) file for Day $($Day). " -ErrorAction "Stop"
      }

    } # End block: finding Advent of Code File Path

    Write-Output (Resolve-Path $AocFilePath).Path

  } # End block:process

} # End block:function
