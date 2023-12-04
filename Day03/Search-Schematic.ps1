function Search-Schematic {
  param (
    [string]
    $Above,

    [string]
    $Focus,

    [string]
    $Below
  ) # End block:param

  process {
    if ( $Focus -notmatch "\d" ) {
      return
    }

    if ( [string]::IsNullOrEmpty($Above) ) {
      $Above = "." * $Focus.Length
    }

    if ( [string]::IsNullOrEmpty($Below) ) {
      $Below = "." * $Focus.Length
    }

    if ( $Focus[0] -ne "." ) {
      $Above = "." + $Above
      $Focus = "." + $Focus
      $Below = "." + $Below
    }

    if ( $Focus[-1] -ne "." ) {
      $Above += "."
      $Focus += "."
      $Below += "."
    }

    $PartNumber = @{
      Value = ""
      Index = $null
    }
    for ( $L = 0; $L -lt $Focus.Length; $L++ ) {
      $Char = $Focus[$L]
      if ( $Char -match "\d" ) {
        $PartNumber.Value += "$Char"

        if ( [string]::IsNullOrEmpty($PartNumber.Index) ) {
          $PartNumber.Index = $L
        }
      } else {
        if ( -not [string]::IsNullOrEmpty($PartNumber.Index) ) {
          $RingLen = 2 + $PartNumber.Value.Length

          $PreIndex = $PartNumber.Index - 1

          $Ring = ""
          $Ring += $Above.SubString($PreIndex, $RingLen)
          $Ring += $Below.SubString($PreIndex, $RingLen)
          $Ring += $Focus[$PreIndex]
          $Ring += $Char

          $TestRing = $Ring -replace "\.","" -replace "\d",""

          if ( $TestRing.Length -ne 0 ) {
            Write-Output $PartNumber.Value
          }

        } # End block:if Have Index

        $PartNumber.Value = ""
        $PartNumber.Index = $null

      } # End block:if-else Char is a number

    } # End block:for each Char in Focus

  } # End block:process

} # End function
