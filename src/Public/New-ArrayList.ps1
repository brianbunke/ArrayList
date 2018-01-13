function New-ArrayList {
    <#
    .SYNOPSIS
    Create a new array to append objects into.

    .DESCRIPTION
    By default, constructs an empty [System.Collections.Generic.List<System.Object>] collection.

    When specifying -Type, constructs an empty [System.Collections.Generic.List<T>] collection.

    -Legacy parameter will override -Type, providing a [System.Collections.ArrayList] instead.

    Capture New-ArrayList in a variable to reuse it with Add-ArrayObject.

    .EXAMPLE
    $a = New-ArrayList
    Create $a as an empty Generic.List, to use later with Add-ArrayObject.

    .EXAMPLE
    $a = New-ArrayList -Type string
    Create $a as an empty Generic.List collection. This list is "type-safe,"
    meaning it will append only objects of type [string], rejecting others.

    .EXAMPLE
    $a = New-ArrayList -Legacy
    Create $a as an empty ArrayList. Generic.List is recommended, but ArrayList
    remains for anyone insistent...especially because of the module name. ;)

    .OUTPUTS
    [System.Collections.Generic.List<System.Object>]
    [System.Collections.Generic.List<T>]
    [System.Collections.ArrayList]

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
        # This will construct a "type-safe" Generic.List collection.
        # -Type expects a string ("int") instead of a type notation ([int]).
        [string]$Type,

        # Outputs a [System.Collections.ArrayList] collection, ignoring the -Type parameter.
        [switch]$Legacy
    )

    If ($Legacy) {
        New-Object System.Collections.ArrayList
    } ElseIf ($Type) {
        New-Object System.Collections.Generic.List[$Type]
    } Else {
        New-Object System.Collections.Generic.List[Object]
    }
}
