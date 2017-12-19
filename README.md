# ArrayList

Fast, scalable arrays in PowerShell by wrapping .NET's `System.Collections.ArrayList`.

<!--more-->

---

## Instructions

### Installation

ArrayList is available on the [PowerShell Gallery]! `Install-Module` requires PowerShellGet (included in PS v5, or download for v3/v4 via the gallery link)

```powershell
# One time only install: (requires an admin PowerShell window)
Install-Module ConfluencePS
```

### Usage

```powershell
# Capture an empty ArrayList
$10 = New-ArrayList
# Append one/many objects via the pipeline
1..10 | Add-ArrayObject -Array $10

# Or, commonly, use it within a For/ForEach loop:
$DirList = New-ArrayList
ForEach ($folder in (Get-ChildItem C:\ -Directory).FullName) {
    Get-ChildItem $folder -Directory | ForEach-Object {
        [PSCustomObject]@{
            Parent    = $folder
            Directory = $_.Name
        } | Add-ArrayObject $DirList
    }
}
$DirList

# Review the help at any time!
Get-Help about_ArrayList
Get-Command -Module ConfluencePS
Get-Help Add-ArrayObject -Full
```

## Contribute

Bugs? Requests? Have something awesome in mind to help with? I'd love to hear from you! Head over to the Issues tab and let me know.

Or let me know on Twitter: [@brianbunke]



  [PowerShell Gallery]: https://www.powershellgallery.com
  [@brianbunke]: https://twitter.com/brianbunke
