# Get public and private function definition files
$Public  = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1  -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)

# Dot source the files
ForEach ($Import in @($Public + $Private)) {
    Try {
        Write-Verbose "Importing $($Import.FullName)"
        . $Import.FullName
    } Catch {
        Write-Error "Failed to import function $($Import.FullName): $_"
    }
}

# Export only the public functions for user consumption
Export-ModuleMember -Function $Public.Basename
