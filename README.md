# ArrayList

Fast, scalable arrays in PowerShell by wrapping .NET's [`System.Collections.Generic.List<T>`].
(And [`System.Collections.ArrayList`], if you really insist.)

"But aren't those .NET methods already pretty easy to use?" Yes.

Is the point of PowerShell to abstract everything into its most awesome form? ALSO YES, MY FRIEND.

<!--more-->

---

## Why?

Please refer to the introductory [blog post] for details.

## Instructions

### Installation

ArrayList is available on the [PowerShell Gallery]! `Install-Module` requires PowerShellGet (included in PS v5, or download for v3/v4 via the gallery link)

```powershell
# One time only install: (requires an admin PowerShell window)
Install-Module ArrayList
```

### Usage
Easy mode:

```powershell
# Capture an empty Generic.List<System.Object> collection
$10 = New-ArrayList
# Append one/many objects via the pipeline
1..10 | Add-ArrayObject -Array $10
# And review
$10
```

Advanced features:

```powershell
# Create a type-safe List<T> collection
$DirList = New-ArrayList -Type PSCustomObject

$UserGCI = (Get-ChildItem $env:USERPROFILE -Directory).FullName
# Appending into arrays is common within a For/ForEach loop:
ForEach ($folder in $UserGCI) {
    Get-ChildItem $folder -Directory | ForEach-Object {
        [PSCustomObject]@{
            Parent    = $folder
            Directory = $_.Name
        } | Add-ArrayObject $DirList
    }
}
# View the results
$DirList

# Remove all entries of Desktop subfolders
$DirList |
    Where-Object {$_.Parent -like '*desktop'} |
    Remove-ArrayObject $DirList
# And view again
$DirList
```

Review the help at any time!

```powershell
Get-Command -Module ArrayList
Get-Help Add-ArrayObject -Full
Get-Help about_ArrayList
```

## Contribute

Bugs? Requests? Have something awesome in mind to help with? I'd love to hear from you! Head over to the Issues tab and let me know.

Or reach out on Twitter: [@brianbunke]



[`System.Collections.Generic.List<T>`]: https://docs.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1
[`System.Collections.ArrayList`]: https://docs.microsoft.com/en-us/dotnet/api/system.collections.arraylist

[blog post]: http://www.brianbunke.com/blog/2018/01/04/powershell-arraylist/

[PowerShell Gallery]: https://www.powershellgallery.com

[@brianbunke]: https://twitter.com/brianbunke
