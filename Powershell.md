* Remote Powershell
	1. Guest : 
		* `Get-NetConectionProfile` : Get interface
		* `Set-NetConectionProfil -IntercaceIndex 9 -NetworkCategory Private` : Enable PS Remote
	2. Both : `Set-Item wsmon:\localhost\client\trustedhosts\ *` : Enable trust
	3. Both : `Restart-Service WimRM`
	4. Host : `Test-WsMan COMPUTER`
	5. Host : `Enter-PSSession -ComputerName COMPUTER -Credential USER`

* Variable Afectation
	* `$a = ls 'HKLM:/Software/'`
	* `$a[0].Property`

* About
	* `[environment]::OSVersion.Version` : get os version (aparently :) 

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
