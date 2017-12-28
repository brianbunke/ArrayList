function Remove-ArrayObject {
    <#
    .SYNOPSIS
    

    .DESCRIPTION
    

    .EXAMPLE
    

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
        $Array,

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
            If ($PSCmdlet.ShouldProcess(
                "$r",
                'Remove all matching objects from array'
            )) {
                # Needed for example: 3 | Remove-ArrayObject
                While ($r -in $Array) {
                    $Array.Remove($r)
                } #While
            } #WhatIf
        } #ForEach $r
    } #END
}
