function Measure-Answer04 {
  param (
    [Part]
    $Part = "B",

    [Parameter(
      ValueFromPipeline,
      ValueFromPipelineByPropertyName
    )]
    [ValidateScript(
      { Test-Path $_ }
    )]
    $Path = (Resolve-Path $PSScriptRoot/Input*)
  ) # End block:param

  process {
    if ( $Part -eq "A" ) {
      $Total = 0
      
      foreach ( $ThisCard in (Get-Content $Path) ) {
        $Total += Get-PointValue $ThisCard
      }
      
      Write-Output $Total

    } # End block:if A

    if ( $Part -eq "B" ) {
      $CardArray = Get-Content $Path

      $Hash_PlayTracker = @{}
      for ( $CardNum = 1; $CardNum -le $CardArray.Count; $CardNum++ ) {
        $Hash_PlayTracker[$CardNum] = @{
          Chances    = 1
          MatchCount = Get-MatchCount $CardArray[$CardNum - 1]
        }
      }

      for ( $CardNum = 1; $CardNum -le $CardArray.Count; $CardNum++ ) {
        $MatchCount = $Hash_PlayTracker[$CardNum].MatchCount
        
        if ( $MatchCount -gt 0 ) {
          $Chances = $Hash_PlayTracker[$CardNum].Chances

          for ( $n = 1; $n -le $MatchCount; $n++ ) {
            $Hash_PlayTracker[$CardNum + $n].Chances += $Chances
          }
        }

      }

      $Total = 0

      foreach ( $ThisCard in $Hash_PlayTracker.Keys ) {
        $Total += $Hash_PlayTracker[$ThisCard].Chances
      }

      Write-Output $Total

    } # End block:if B

  } # End block:process

} # End function
