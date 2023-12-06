function Import-GardenGuide {
  param (
    [ValidatePattern("csv$")]
    [ValidateScript(
      { Test-Path $_ }
    )]
    [string]
    $GuidePath,

    [PSCustomObject[]]
    $Guide
  ) # End block:param

  process {
    $isGuideEmpty = $Guide.Count -eq 0
    $isGuidePathBlank = [string]::IsNullOrEmpty($GuidePath)

    if ( $isGuideEmpty -and $isGuidePathBlank ) {
      $ErrorDetails = @{
        Message     = "Failed to give either a Gardening Spec Guide or a path to a guide. "
        ErrorAction = "Stop"
      }

      Write-Error @ErrorDetails

    } # End block:if both useless

    $OutputGuide = if ( -not $isGuidePathBlank ) {
      Import-CSV $GuidePath
    } else {
      $Guide
    }

    Write-Output $OutputGuide

  } # End block:process

} # End function
