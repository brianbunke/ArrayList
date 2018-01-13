Remove-Module ArrayList -ErrorAction SilentlyContinue -Force
Import-Module $PSScriptRoot\..\src\ArrayList.psd1

Describe 'New-ArrayList unit tests' -Tags 'unit' {
    ## List<object>
    
    $GenericList = New-ArrayList
    $ListType = [string]$GenericList.GetType().UnderlyingSystemType
    
    It 'Outputs a Generic.List' {
        $GenericList | Should -BeNullOrEmpty

        $ListType | Should -Be 'System.Collections.Generic.List[System.Object]'
    }

    ## List<T>

    # Test int, string, and PSCustomObject types
    $Types = 'int', 'string', 'PSCustomObject'

    $Types | ForEach-Object {
        It "Outputs a type-safe Generic.List of type [$_]" {
            $List = New-ArrayList -Type $_
            $ListType = [string]$List.GetType().UnderlyingSystemType

            $List | Should -BeNullOrEmpty

            If ($_ -eq 'PSCustomObject') {
                $ListType | Should -Be "System.Collections.Generic.List[psobject]"
            } Else {
                $ListType | Should -Be "System.Collections.Generic.List[$_]"
            }
        }
    } #ForEach

    ## ArrayList

    $ArrayList = New-ArrayList -Legacy

    It 'Outputs a generic ArrayList' {
        $ArrayList | Should -BeNullOrEmpty

        $ArrayList.GetType().FullName | Should -Be 'System.Collections.ArrayList'
    }
}
