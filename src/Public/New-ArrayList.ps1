function New-ArrayList {
    <#
    .SYNOPSIS
    Create a new array to append objects into.

    .DESCRIPTION
    Constructs a new [System.Collections.ArrayList] object.

    Capture New-ArrayList in a variable to reuse it with Add-ArrayObject.

    .EXAMPLE
    $a = New-ArrayList
    Create $a as an empty ArrayList, to use later with Add-ArrayObject.

    .OUTPUTS
    [System.Collections.ArrayList]

    .NOTES


    .LINK
    https://github.com/brianbunke/ArrayList
    #>

    [CmdletBinding()]
    param (
        [string]$Type
    )

    If ($Type) {
        New-Object System.Collections.Generic.List[$Type]
    } Else {
        New-Object System.Collections.ArrayList
    }
}
