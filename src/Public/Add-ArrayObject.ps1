function Add-ArrayObject {
    [CmdletBinding()]
    param (
        [System.Collections.ArrayList]$Array,

        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        $InputObject
    )

    BEGIN {
    }

    PROCESS {
        If ($InputObject.Count -gt 1) {
            [void]$Array.AddRange($InputObject)
        } Else {
            [void]$Array.Add($InputObject)
        }
    }

    END {
    }
}
