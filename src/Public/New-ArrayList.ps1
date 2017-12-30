function New-ArrayList {
    <#
    .SYNOPSIS
    Create a new array to append objects into.

    .DESCRIPTION
    By default, constructs an empty [System.Collections.ArrayList] collection.

    When specifying -Type, constructs an empty [System.Collections.Generic.List<T>] collection.

    Capture New-ArrayList in a variable to reuse it with Add-ArrayObject.

    .EXAMPLE
    $a = New-ArrayList
    Create $a as an empty ArrayList, to use later with Add-ArrayObject.

    .EXAMPLE
    $a = New-ArrayList -Type PSCustomObject
    Create $a as an empty Generic.List collection. This list is "type-safe,"
    meaning it will append only objects of type PSCustomObject, rejecting others.

    .OUTPUTS
    [System.Collections.ArrayList]
    [System.Collections.Generic.List<T>]

    .NOTES
    https://stackoverflow.com/questions/2309694/arraylist-vs-list-in-c-sharp
    https://serverfault.com/questions/708832/how-to-cast-as-arraylist-preset-data-in-param-block-and-return-as-arraylist
    https://connect.microsoft.com/PowerShell/feedback/details/1622532

    .LINK
    https://github.com/brianbunke/ArrayList
    #>

    [CmdletBinding()]
    param (
        # Optionally specify the only object type that the new list will accept.
        # This will construct a Generic.List collection, instead of the default ArrayList.
        # -Type expects a string ("int") instead of a type notation ([int]).
        [string]$Type
    )

    If ($Type) {
        New-Object System.Collections.Generic.List[$Type]
    } Else {
        New-Object System.Collections.ArrayList
    }
}
