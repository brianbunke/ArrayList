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

    .LINK
    https://github.com/brianbunke/ArrayList
    #>

    New-Object System.Collections.ArrayList
}
