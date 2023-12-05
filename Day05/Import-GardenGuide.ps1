function Import-GardenGuide {
  [CmdletBinding( DefaultParameterSetName = "OnlyGuide")]
  param (
    [Parameter(
      ParameterSetName = "OnlyGuide",
      Mandatory
    )]
    [Parameter(
      ParameterSetName = "Both",
      Mandatory
    )]
    [PSCustomObject]
    $Guide,

    [Parameter(
      ParameterSetName = "OnlyPath",
      Mandatory
    )]
    [Parameter(
      ParameterSetName = "Both",
      Mandatory
    )]
    [ValidatePattern("csv$")]
    [ValidateScript(
      { Test-Path $_ }
    )]
    [string]
    $GuidePath
  ) # End block:param

  process {
    $OutputGuide = switch -Wildcard ( $PSCmdlet.ParameterSetName ) {
      "*Path" {
        Write-Verbose "Loading guide from $($GuidePath)"
        Import-CSV $GuidePath
      } # End case:*Path

      { "Both" } {
        Write-Verbose "Both a GuidePath & Guide were given as inputs"

        if ( $Guide.Count -eq 0 ) {
          Write-Verbose "Loading guide from $($GuidePath)"
          Import-CSV $GuidePath
        } else {
          Write-Verbose "Using the given Guide"
          $Guide
        }

      } # End case:Both

      "*Guide" {
        if ( $Guide.Count -eq 0 ) {
          $ErrorDetails = @{
            Message     = "The given guide does not have any rows. "
            ErrorAction = "Stop"
          }

          Write-Error @ErrorDetails

        } # End block:if Guide is empty

        $Guide

      } # End case:*Guide

    } # End block:switch on Parameter Set Name

    Write-Verbose "The guide has $($Guide.Count) rows"

    Write-Output $OutputGuide

  } # End block:process

} # End function
