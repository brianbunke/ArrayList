# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/),
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.1.0] - 2018-01-13

Embarrassingly, I didn't know how easy it was to create a Generic.List that accepts many object types.

### Changed
- Default `New-ArrayList` collection type is now `[System.Collections.Generic.List<System.Object>]`

### Added
- If you insist, an ArrayList collection can still be generated with the command `New-ArrayList -Legacy`
- This changelog :)


## [1.0.0] - 2018-01-04
Hello World! http://www.brianbunke.com/blog/2018/01/04/powershell-arraylist/

### Added
- `New-ArrayList`
- `Add-ArrayObject`
- `Remove-ArrayObject`
