Remove-Module ArrayList -ErrorAction SilentlyContinue -Force
Import-Module $PSScriptRoot\..\src\ArrayList.psd1

# TODO: How to best assert actions on PSCustomObjects?

Describe 'Add-ArrayObject unit tests' -Tags 'unit' {
    $ArrayList = New-ArrayList
    $intList   = New-ArrayList -Type int
    $objList   = New-ArrayList -Type PSCustomObject

    # Make $0-$4 objects to populate $objList
    for ($i = 0; $i -lt 5; $i++) {
        [PSCustomObject]@{ID = $i} | New-Variable $i
    }

    It 'Adds a single item' {
        Add-ArrayObject -Array $ArrayList -InputObject 0
        $ArrayList | Should -Contain 0

        Add-ArrayObject -Array $intList -InputObject 0
        $intList | Should -Contain 0

        Add-ArrayObject -Array $objList -InputObject $0
    }

    It 'Pipes a single item into an array' {
        1 | Add-ArrayObject -Array $ArrayList
        $ArrayList | Should -Contain 1

        1 | Add-ArrayObject -Array $intList
        $intList | Should -Contain 1

        $1 | Add-ArrayObject -Array $objList
    }

    It 'Adds multiple items at once' {
        2,3 | Add-ArrayObject -Array $ArrayList
        $ArrayList | Should -Contain 2
        $ArrayList | Should -Contain 3

        2,3 | Add-ArrayObject -Array $intList
        $intList | Should -Contain 2
        $intList | Should -Contain 3

        $2,$3 | Add-ArrayObject -Array $objList
    }

    It 'Accepts positional parameter input' {
        Add-ArrayObject $ArrayList 4
        $ArrayList | Should -Contain 4

        Add-ArrayObject $intList 4
        $intList | Should -Contain 4

        Add-ArrayObject $objList $4
    }

    It 'Adds duplicate objects' {
        Add-ArrayObject $ArrayList 4
        $ArrayList | Should -Contain 4

        Add-ArrayObject $intList 4
        $intList | Should -Contain 4

        Add-ArrayObject $objList $4
    }

    It 'Adds a second object type to the array' {
        'test' | Add-ArrayObject -Array $ArrayList
        $ArrayList | Should -Contain 'test'
    }

    It 'Retains all added values' {
        $ArrayList | Should -Be @(0, 1, 2, 3, 4, 4, 'test')

        $intList | Should -Be @(0, 1, 2, 3, 4, 4)

        $objList | Should -Be @($0, $1, $2, $3, $4, $4)
    }

    It 'Adds nested objects to the array' {
        [PSCustomObject]@{letter = 'a'; number = 1} | Add-ArrayObject $ArrayList
    }

    It 'Fails to add objects that do not match the list type' {
        {$intList | Add-ArrayObject $1} | Should -Throw

        {$objList | Add-ArrayObject 1}  | Should -Throw
    }

    It 'Retains the expected collection type' {
        $ArrayList.GetType().FullName | Should -Be 'System.Collections.ArrayList'

        [string]$intList.GetType().UnderlyingSystemType |
            Should -Be 'System.Collections.Generic.List[int]'

        [string]$objList.GetType().UnderlyingSystemType |
            Should -Be 'System.Collections.Generic.List[psobject]'
    }

    It 'Displays the correct object count' {
        # Verify that member objects are counted, instead of just one ArrayList
        $ArrayList.Count | Should -Be 8

        $intList.Count | Should -Be 6

        $objList.Count | Should -Be 6
    }
}
