function Convert-Calibration {
  param (
    [Parameter(
      Mandatory
    )]
    [string]
    $Line
  ) # End block:param

  process {
    $Map_Overlap = @{
      oneight   = "oneeight"
      threeight = "threeeight"
      fiveight  = "fiveeight"
      sevenine  = "sevennine"      
      nineight  = "nineeight"
      eighthree = "eightthree"
      eightwo   = "eighttwo"
      twone     = "twoone"
    }

    $ExpandedLine = $Line
    
    foreach ( $ThisOverlap in $Map_Overlap.Keys ) {
      $ExpandedLine = $ExpandedLine -replace $ThisOverlap, $Map_Overlap.$ThisOverlap
    }

    $Map_NumberWord = [ordered]@{
      one       = 1
      two       = 2
      three     = 3
      four      = 4
      five      = 5
      six       = 6
      seven     = 7
      eight     = 8
      nine      = 9
    }

    $ConvertedLine = $ExpandedLine

    foreach ( $ThisNumberWord in $Map_NumberWord.Keys ) {
      $ConvertedLine = $ConvertedLine -replace $ThisNumberWord,$Map_NumberWord.$ThisNumberWord
    }

    Write-Output $ConvertedLine

  } # End block:process

} # End function
