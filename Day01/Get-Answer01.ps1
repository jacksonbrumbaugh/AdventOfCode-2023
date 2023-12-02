function Get-Answer01 {
  param (
    [Parameter(
      Mandatory,
      Position = 0,
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    [ValidateScript(
      { Test-Path $_ }
    )]
    [SupportsWildcards()]
    [string]
    $Path,

    [ValidateSet(
      "A",
      "B"
    )]
    $Puzzle = "B"
  ) # End block:param

  process {
    $Total = 0

    foreach ( $ThisLine in (Get-Content $Path) ) {
      $PuzzleCheckedLine = switch ( $Puzzle ) {
        "A" { $ThisLine }

        "B" { Convert-Line $ThisLine }

      } # End block:switch on Puzzle

      $Total += Get-LineValue $PuzzleCheckedLine

    } # End block:foreach Line

    Write-Output $Total

  } # End block:process

} # End function
