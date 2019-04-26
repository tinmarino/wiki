* [Raccourci](Windows_Raccourci)
* [Cmder](Windows_Cmder)
* [[Windows Services](Windows-Services)]
* [Ms Dos](Ms-Dos)

* Check if admin
	* `regedit /HKLM/SAM` : if you can open AM, you are priviledged

* Power off (shutdown)
	shutdown /h /f  # hibernate force
			 /? 	# help
			 /r 	# reboot
			 /t 10  # in 10 sec
	powercfg /hibernate on
	powercfg /hibernate off  # To be able to resize C (because /hiberfil.sys is an unmovable file)

* Screen off
	scrnsave.scr /s
    
* Open explorer
    * `start .`

* User and groups (local)
    * `lusrmgr`

* Procmon
    * To trace boot process
        * remove the drivers if error
        * Do not capture befor reoobting
        * Open procmon afeter startup, it will ask you if you wanna recover the boot logs
        * Save as a logfile
        * `procmon /BackingFile c:\Users\user\Desktop\proc.pml /AcceptEula /Quiet /noconnect`
        * `procmon /Terminate`

* Driver loading management `fltmc`
    * `fltmc UNLOAD PROCMON23`


## Notes from draft book

* In computing, Read or Write depends on the point of view ...
* In kernel, we use objects and not handles
* Some services cannot be debugged locally because of traps (anti-debug). So one must debug natively (i.e kernel, remote)

# Security
## T

# API

* EnumDevideDrivers 		# Fill array of LPVOID with start address of all drivers
* GetDeviceDriverFileName 	# Returns the name of the driver
* NtQuerySystemInformation

### Control Access to Resources

* GetCurrentProcess
* OpenProcessToken
* GetTokenInformation
* AdjustTokenGroups
* AdjustTokenPrivileges
* SeAccessCheck


# InterProcess Communication

* Clipboard
* Event (most primitive)
* File / FileMapping
* Pipe
* COM (Component Object Model)
* Shared Memory
* Socket
* Mailslot
* Window Message
* RPC (most advanced)

| Server                           | Client                   |
| ---                              | ---                      |
| 1/ Init Winsock                  | 1/ Init WinSock          |
| 2/ Create Socket                 | 2/ Create Socket         |
| 3/ Bind Socket                   | 3/ Connect to server     |
| 4/ Listen on socket for a client | 4/ Send and receive data |
| 5/ Accept connection form lcient | 5/ Disconnect            |
| 6/ Receive and send data         |                          |
| 7/ Disconnect                    |                          |


# Service


# Hooks (userland)

* PsSetLoadImageNotifyRoutine
* PsSetCreateProcessNotifyRoutine
* PsSetCreateThreadNotifyRoutine
* PsRemoveCreateThreadNotifyRoutine
* CmRegisterCallback
* SeRegisterImageVerificationCallback
* 


# Interupt table (TODO my own file)

* `int 31h` : Memory allocation, sector manipulation, table of descriptors
* `int 21h` : 
* `int 13h` : Access to disk
* `int 10h` :
	* `fct 00h` : Change video mode and clear screen
	* `fct 01h` : Set cursor type
	* `fct 13h` : Show string on screen


## Tab manipulation

Ctrl + `	: Global summon from taskbar
Win  + Alt + p 	: Preferences 
Ctrl + t	: New tab 
Ctrl + w 	: Close tab 
Shitft + Alt + 1: New CMD tab 
Shitft + Alt + 2: New Powershell tab 
Alt + Enter 	: Full screen


## Shell

Shift + Up 	: Traverse up in directory structure 
End, Home Ctrl 	: Traverse text as usual in windows 
Ctrl + r	: History search 
Shift + mouse 	: Select and copy from buffer 
Right click 	: Paste text (or ctrl + shift + v)


# MS Office

shift+f5 : Full screen current slide


# Windows shortcut

win r cmd  # as run
