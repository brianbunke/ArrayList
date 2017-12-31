Remove-Module ArrayList -ErrorAction SilentlyContinue -Force
Import-Module $PSScriptRoot\..\src\ArrayList.psd1

Describe 'Remove-ArrayObject unit tests' -Tags 'unit' {
    ## Arrange ArrayList
    $ArrayList = New-ArrayList

    0..8 | Add-ArrayObject $ArrayList
    'remove', 'keep' | Add-ArrayObject $ArrayList
    
    $a1 = [PSCustomObject]@{letter = 'a'; int = 1}
    $a1 | Add-ArrayObject $ArrayList

    $b2 = [PSCustomObject]@{letter = 'b'; int = 2}
    $c3 = [PSCustomObject]@{letter = 'c'; int = 3}
    $d4 = [PSCustomObject]@{letter = 'd'; int = 4}

    1..2 | ForEach-Object {
        # Add all of these twice
        Add-ArrayObject $ArrayList 9
        Add-ArrayObject $ArrayList 'double'
        Add-ArrayObject $ArrayList $b2
        Add-ArrayObject $ArrayList $c3
        Add-ArrayObject $ArrayList $d4
    }

    ## Arrange List<T>
    $intList = New-ArrayList -Type int

    0..11  | Add-ArrayObject $intList
    # Add 8-10 again to test duplicates
    8..10 | Add-ArrayObject $intList

    It 'Removes a single item' {
        Remove-ArrayObject -Array $ArrayList -InputObject 0
        $ArrayList | Should -Not -Contain 0
        Remove-ArrayObject -Array $ArrayList -InputObject 'remove'
        $ArrayList | Should -Not -Contain 'remove'
        Remove-ArrayObject -Array $ArrayList -InputObject $a1
        # TODO: How to test this?

        Remove-ArrayObject -Array $intList -InputObject 0
        $intList | Should -Not -Contain 0
    }

    It 'Removes a single item via the pipeline' {
        1 | Remove-ArrayObject -Array $ArrayList
        $ArrayList | Should -Not -Contain 1

        1 | Remove-ArrayObject -Array $intList
        $intList | Should -Not -Contain 1
    }

    It 'Removes multiple items at once' {
        Remove-ArrayObject -Array $ArrayList -InputObject 2,3
        $ArrayList | Should -Not -Contain 2
        $ArrayList | Should -Not -Contain 3

        Remove-ArrayObject -Array $intList -InputObject 2,3
        $intList | Should -Not -Contain 2
        $intList | Should -Not -Contain 3
    }

    It 'Removes multiple items via the pipeline' {
        4,5 | Remove-ArrayObject -Array $ArrayList
        $ArrayList | Should -Not -Contain 4
        $ArrayList | Should -Not -Contain 5

        4,5 | Remove-ArrayObject -Array $intList
        $intList | Should -Not -Contain 4
        $intList | Should -Not -Contain 5
    }

    It 'Supports expected positional parameters' {
        Remove-ArrayObject $ArrayList 6
        $ArrayList | Should -Not -Contain 6
        7 | Remove-ArrayObject $ArrayList
        $ArrayList | Should -Not -Contain 7

        Remove-ArrayObject $intList 6
        $intList | Should -Not -Contain 6
        7 | Remove-ArrayObject $intList
        $intList | Should -Not -Contain 7
    }

    It 'Removes duplicate simple objects' {
        9 | Remove-ArrayObject $ArrayList
        $ArrayList | Should -Not -Contain 9
        Remove-ArrayObject $ArrayList 'double'
        $ArrayList | Should -Not -Contain 'double'

        8 | Remove-ArrayObject $intList
        $intList | Should -Not -Contain 8
        Remove-ArrayObject $intList 9
        $intList | Should -Not -Contain 9
    }

    It 'Removes duplicate nested objects' {
        # Removes both $b2 instances
        Remove-ArrayObject $ArrayList $b2
        # Removes both $c3 instances
        $c3 | Remove-ArrayObject $ArrayList
        # Removes both $d4 instances
        $ArrayList | Where-Object letter -eq 'd' | Remove-ArrayObject $ArrayList
    }

    It 'Retains the expected collection type' {
        $ArrayList.GetType().FullName | Should Be 'System.Collections.ArrayList'

        [string]$intList.GetType().UnderlyingSystemType |
            Should -Be 'System.Collections.Generic.List[int]'
    }

    It 'Retains expected objects' {
        $ArrayList | Should -Contain 8
        $ArrayList | Should -Contain 'keep'
        # Verify that member objects are counted, instead of just one ArrayList
        $ArrayList.Count | Should Be 2

        $intList | Should -Contain 10
        $intList | Should -Contain 11
        # Verify that member objects are counted, instead of just one ArrayList
        $intList.Count | Should Be 3
    }
}
