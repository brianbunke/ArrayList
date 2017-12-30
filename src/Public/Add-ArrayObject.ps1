function Add-ArrayObject {
    <#
    .SYNOPSIS
    Append objects into an existing array.

    .DESCRIPTION
    Adds input objects into a specified ArrayList.
    Based on object count, uses the .Add() or .AddRange() method to append.

    .EXAMPLE
    $a = New-ArrayList
    PS C:\> Add-ArrayObject -Array $a -InputObject 1..10
    
    Adds the numbers 1-10 into the array in variable $a.

    .EXAMPLE
    1, 'test' | Add-ArrayObject -Array $a
    Pipe objects of different types into the $a array.
    This example works only with an ArrayList (default New-ArrayList behavior).

    .EXAMPLE
    Get-Service | Select-Object -First 5 | Add-ArrayObject $a
    Pipe the first five services on your local computer into $a.

    .EXAMPLE
    $a = New-ArrayList
    PS C:\> ForEach ($Folder in ($env:PSModulePath -split ';')) {
        ForEach ($Module in (Get-Module -ListAvailable | Where-Object {$_.Path -like *$Folder*})) {
            [PSCustomObject]@{
                Ver  = $Module.Version
                Name = $Module.Name
                Path = $Folder
            } | Add-ArrayObject $a
        }
    }

    PS C:\> $a | Where-Object {$_.Ver -gt [version]'1.0'}

    A common use case for appending into arrays is from within ForEach loops.
    Here, inside each PSModulePath, get the version/name of each module,
    then store them in the $a array using the PSCustomObject type.

    Finally, you can report on $a, like returning only modules above version 1.0.

    .LINK
    https://github.com/brianbunke/ArrayList
    #>
    [CmdletBinding()]
    param (
        # A list, typically captured in a variable from New-ArrayList.
        # No validation is performed, but -Array assumes a collection of type
        # [System.Collections.ArrayList] or [System.Collections.Generic.List<T>].
        [Parameter(Mandatory = $true)]
        $Array,

        # One or more objects to append into the provided array.
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        $InputObject
    )

    PROCESS {
        Try {
            If ($InputObject.Count -gt 1) {
                [void]$Array.AddRange($InputObject)
            } Else {
                [void]$Array.Add($InputObject)
            }
        } Catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    } #PROCESS
}
