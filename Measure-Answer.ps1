function Measure-Answer {
  param (
    [Parameter(
      Mandatory
    )]
    [int]
    $Day,

    [Parameter(
      ParameterSetName = "ExampleOnly",
      Mandatory
    )]
    [switch]
    $Example,

    [Parameter(
      ParameterSetName = "MainInput"
    )]
    [switch]
    $DayInput,

    [Part]
    $Part = "A"
  ) # End block:param

  process {
    $PuzzlePath = if ( $Example ) {
      Resolve-AocPath -Day $Day -Example
    } else {
      Resolve-AocPath -Day $Day -DayInput
    }

    $ExpressionToCall = "Measure-Answer{0:D2} -Part {1} -Path {2}" -f $Day, $Part, $PuzzlePath

    Invoke-Expression $ExpressionToCall

  } # End block:process

} # End function
