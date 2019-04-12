* Help
    * Get-Help Get-Item
    * Get-Command | ?{ $_.Name -like "temp"} | select Name

* Comment
    *  `# mycomment` Single line
    * `<# mycomment #>`multiline

* Enable scripts
    * set-executionpolicy remotesigned

* Script location
    * $PSScriptRoot
    * split-path -parent $MyInvocation.MyCommand.Definition

* Load script
    * Import module myscript.pm1
    * & "C:\My Script with space.ps1"
    * C:\script_without_spaces.ps1

* Last Error
    * `$?` # True if last operation succeed
    * `$LastExitCode` # Exit code of last windows-based program that was run

* Environment
    * Get-ChildItem env:windir

* Random
    * Get-Random

* Find
    * `ls -Recurse -Fiel | select *`
