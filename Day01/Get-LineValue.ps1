function Get-LineValue {
  param (
    [Parameter(
      Mandatory
    )]
    [string]
    $Line
  ) # End block:param

  process {
    $OnlyNumber = $Line -replace "\D",""
    
    if ( $OnlyNumber.Length -eq 0 ) {
      $ErrorDetails = @{
        Message     = "Failed to find any digits inside the line $($Line)"
        ErrorAction = "Stop"
      }
      Write-Error @ErrorDetails
    }
    
    $FirstDigit = $OnlyNumber[0]
    $LastDigit = $OnlyNumber[-1]
    
    $Value = "{0}{1}" -f $FirstDigit, $LastDigit
    
    Write-Output $Value

  } # End block:process

} # End function
