function Search-GearRatio {
  param (
    [string]
    $Above,

    [string]
    $Focus,

    [string]
    $Below
  ) # End block:param

  begin {
    function Find-Gear ( [string]$Line, [int]$Position ) {
      switch -Regex ( $Line.Substring($Position - 1, 3) ) {
        "\D\d\D" {
          $Line[$Position]
        }

        "\d\D\d" {
          ($Line.Substring(0, $L) -split "\D")[-1]
          ($Line.Substring($L + 1, $Line.Length - $L - 1) -split "\D")[0]
        }

        "\d\d\D" {
          ($Line.Substring(0, $L + 1) -split "\D")[-1]
        }

        "\d\D\D" {
          ($Line.Substring(0, $L) -split "\D")[-1]
        }

        "\D\D\d" {
          ($Line.Substring($L + 1, $Line.Length - $L - 1) -split "\D")[0]
        }

        "\D\d\d" {
          ($Line.Substring($L, $Line.Length - $L) -split "\D")[0]
        }

        "\d\d\d" {
          $FirstPart = ($Line.Substring(0, $L) -split "\D")[-1]
          $LastPart = ($Line.Substring($L, $Line.Length - $L) -split "\D")[0]

          "{0}{1}" -f $FirstPart, $LastPart
        }

      } # End block:switch on Test Code

    } # End function:Find-Gear

  } # End block:begin

  process {
    if ( $Focus -notmatch "\*" ) {
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

    for ( $L = 0; $L -lt $Focus.Length; $L++ ) {
      if ( $Focus[$L] -ne "*" ) { continue }

      $FactorArray = @()

      if ( $Focus[$L - 1] -match "\d" ) {
        $FactorArray += ($Focus.Substring(0, $L) -split "\D")[-1]
      }

      if ( $Focus[$L + 1] -match "\d" ) {
        $FactorArray += ($Focus.SubString($L + 1, $Focus.Length - $L -1) -split "\D")[0]
      }

      if ( $Above.Substring($L - 1, 3) -match "\d" ) {
        $FactorArray += Find-Gear -Line $Above -Position $L
      }

      if ( $Below.Substring($L - 1, 3) -match "\d" ) {
        $FactorArray += Find-Gear -Line $Below -Position $L
      }

      if ( $FactorArray.Count -eq 2 ) {
        ("$($FactorArray[0])" -as [int]) * ("$($FactorArray[1])" -as [int])
      }

    } # End block:for each Char in Focus

  } # End block:process

} # End function
