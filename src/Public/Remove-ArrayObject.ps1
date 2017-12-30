function Remove-ArrayObject {
    <#
    .SYNOPSIS
    Remove the specified object(s) from within your existing array.

    .DESCRIPTION
    Removes all instances of the specified object in the specified array.
    This is accomplished by using the .Remove() method in a While loop. (see NOTES)

    By default, .Remove() only removes the first instance of a specified object.
    If you want that behavior, call the method instead of using this function :)

    .EXAMPLE
    Remove-ArrayObject -Array $a -InputObject 13
    Remove all instances of the number 13 from the collection in variable $a.

    .EXAMPLE
    'localhost' | Remove-ArrayObject $HostnameList
    Remove all instances of the string 'localhost' from your $HostnameList array.
    Pipeline input is supported, but optional.

    .EXAMPLE
    $srv = New-ArrayList
    PS C:\>Get-Service | Add-ArrayObject $srv

    PS C:\>$srv | Where-Object {$_.Name -like 'w*'} | Remove-ArrayObject $srv

    Remove-ArrayObject will also remove complex matching objects.
    Here, all services starting with "w" will be removed from the $srv array.

    .NOTES
    https://www.sapien.com/blog/2014/11/18/removing-objects-from-arrays-in-powershell/
    https://p0w3rsh3ll.wordpress.com/2012/11/24/delete-elements-from-an-array/

    .LINK
    https://github.com/brianbunke/ArrayList
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'Medium'
    )]
    param (
        # A list, typically captured in a variable from New-ArrayList.
        # No validation is performed, but -Array assumes a collection of type
        # [System.Collections.ArrayList] or [System.Collections.Generic.List<T>].
        [Parameter(Mandatory = $true)]
        $Array,

        # One or more objects to remove from the provided array.
        # All matching objects will be removed.
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        $InputObject
    )

    BEGIN {
        $Remove = New-Object System.Collections.ArrayList
    }

    PROCESS {
        # Adding to a new array to remove in END block avoids the error:
        # "Collection was modified; enumeration operation may not execute"

        ForEach ($Object in $InputObject) {
            [void]$Remove.Add($Object)
        }
    } #PROCESS

    END {
        ForEach ($r in $Remove) {
            Try {
                If ($PSCmdlet.ShouldProcess(
                    "$r",
                    'Remove all matching objects from array'
                )) {
                    # Needed for example: 3 | Remove-ArrayObject
                    While ($r -in $Array) {
                        [void]$Array.Remove($r)
                    } #While
                } #WhatIf
            } Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        } #ForEach $r
    } #END
}
