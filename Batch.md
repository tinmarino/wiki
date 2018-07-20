
*   Get pid
    title=mycmd
    tasklist /v /fo csv | findstr /i "mycmd"
    

*   `start`
    *   `/B`    In background -> Like echo "aezaz" &


*   `type c.txt`            # Same as cat (unix)


*   `set /a result=(100*x)/y`
    *   `/a` for automatic substitution so you can use x instead of %x%
    *   `set yy=%date:~-2%`
    *   `set yy=%date:~0,2%`
    * 



*   windbg -k com:pipe,port=\\.\pipe\windbg4,resets=0,baud=115200 -y Z:\Symbols





:: calculate x^n
SET x=3 
SET n=5 
SET result=1 
FOR /L %%i IN (1,1,%n%) DO SET /A result*=x 
ECHO %result% 


fc /l file1 file2           # File compare : like diff in linux
tracert                     # Trace route
&&                          # Command chaining
at                          # Schedula task at a specific time
cls                         # Clean command lines
runas                       # Run process as a specific user
whoami /all                 # display current User/Group/Priviledge information
services.msc                # Open services
assoc                       # Create filetypê asscoaitaion 
                            # assoc .txt=txtfile
ftype                       # Choose program to open files of certain type
                            # ftype txtfile=c:\Program Files\Vim\gvim.exe
type                        # = cat


`tlist /t`          # In the debugging tools for windows
`kd> !idt`          # Display the Interuption Descriptor Table
`WinObj.exe`        # (SysInternals) display all objects



## Copied from an apk cheat
`cd` change directoryundelete Undelete a file that has been deleted.  
`ver` Display the version information.  
`arp` Displays, adds and removes arp information from network devices.  
`xcopy` Copy multiple files, directories,unlock Unlock a disk drivetree View a visual tree of the hard drive.  
`vol` Displays the volume information about the designated driveverify Enables or disables the feature to determine if files have been written properlyunformat Unformat a hard driveType Display the contents of a filetracert Visually view a network packets route across a network.  
`title` Change the title of their MS-DOS window.  
`time` View or modify the system 12:26telnet Telnet to another computer or device from the prompt.  
`sys` Transfer system files to disk drive.  
`switches` Remove add functions from MS-DOS.  
`subst` Substitute a folder on your computer for another drive letter.  
`start` Start a separate window in Windows from the MS-DOS prompt.  
`sort` Sorts the input and displays the output to the screen.  
`shutdown` Shutdown the computer from the MS-DOS prompt.  
`shift` Changes the position of replaceable parameters in a batch program.  
`share` Installs support for file sharing and locking capabilities.  
`setver` Change MS-DOS version to trick older MS-DOS programs.  
`setlocal` Enables local environments to be changed without affecting anything else.  
`set` Change one variable or string to anotherscanreg Scan Registry and recover Registry from errorsat Schedule a time to execute commands or programs.  
`break` Enable and disable Ctrl+C feature.  
`cacls` View and modify filecall Calls a batch file from another batch filechdir Changes directorieschcp Supplement the International keyboard and character set informationchkdsk Check the hard drive runningFAT for errors.  
`chkntfs` Check the hard drive runningNTFS for errors.  
`clip` Redirect command line output to the Windowsclipboardcls Clears the screen.  
`cmd` Opens the command interpreter.  
`color` Change the foreground and background color of the MS-DOS window.  
`command` Opens the command interpreter.  
`comp` Compares files.  
`compact` Compresses and uncompress files.  
`route` View and configure Windows network route tables.  
`robocopy` A robust file copy command for the Windows command line.  
`rmdir` Removes an empty directory.  
`rename` Renames a file or directoryren Renames a file or directoryrd Removes an empty directoryqbasic Open the QBasic.  
`pushd` Stores a directory or network path in memory so it can be returned to at any time.  
`prompt` View and change the MS-DOSpromptprint Prints data to a printer port.  
`power` Conserve power with computer portables.  
`popd` Changes to the directory or network path stored by thepushd command.  
`ping` Test and send information to another network computer or network device.  
`pause` Command used in batch files to stop the processing of a commandpathping View and locate locations of network latencymap Displays the device name of a drivelogon Recovery console command to list installations and enable administrator loginlogoff Logoff the currently profile using the computerlock Lock the hard drive.  
`loadhigh` Load a device driver in to high memory.  
`loadfix` Load a program above the first 64 k.  
`listsvc` Recovery console command that displays the services and drivers.  
`lh` Load a device driver in to high memory.  
`keyb` Change layout of keyboardlabel Change the label of a disk drive.  
`ipconfig` Network command to view network adapter settings and assigned values.  
`ifshlp`.  
`sys` 32-bit file manager.  
`if` Allows for batch files to perform conditional processing.  
`control` Open Control Panel icons from the MS-DOS prompt.  
`convert` Convert FAT to NTFS.  
`copy` Copy one or more files to an alternate locationctty Change the computers input/output devices.  
`date` View or change the systems 2018-07-20debug Debug utility to create assembly programs to modify hardware settings.  
`defrag` Re-arrange the hard drive to help with loading programs.  
`del` Deletes one or more filesdelete Recovery console command that deletes a file.  
`deltree` Deletes one or more files or directories.  
`dir` List the contents of one or more directory.  
`scandisk` k Run the scandisk utility.  
`sc` Communicate with the Service Control Manager and services.  
`runas` Enables a user to run a program as a different user.  
`help` Display a listing of commands and brief explanationftp Command to connect and operate on an FTP server.  
`fType` Displays or modifies file types used in file extension associations.  
`goto` Moves a batch file to a specific label or location.  
`graftabl` Show extended characters in graphics mode.  
`path` View and modify the computers path locationnslookup Look up an IP address of a domain or host on a network.  
`nlsfunc` Load country specific information.  
`netstat` Display the TCP/IP network protocol statistics and information.  
`netsh` Configure dynamic and static network information from MS-DOS.  
`net` Update, fix, or view the network or network settings.  
`nbtstat` Displays protocol statistics and current TCP/IP connections usingNBTmscdex Utility used to load and provide access to the CD-ROM.  
`msd` Diagnostics utility.  
`disable` Recovery console command that disables Windows system services or driversdiskcomp Compare a disk with another diskdoskey Command to view and execute commands that have been run in the past.  
`dosshell` A GUI to help with early MS-DOS usersecho Displays messages and enables and disables echo.  
`edit` View and edit filesedlin View and edit filesenable Recovery console command to enable a disable service or driver.  
`erase` Erase files from computer.  
`exit` Exit from the command interpreter.  
`mkdir` Command to create a new directory.  
`expand` Expand a Microsoft Windows file back to it's original format.  
`extract` Extract files from the Microsoft Windows cabinetsfc Compare filesfdisk Utility used to create partitions on the hard drivefind Search for text within a file.  
`findstr` Searches for a string of text within a file.  
`fixboot` Writes a new boot sector.  
`fixmbr` Writes a new boot record to a disk drive.  
`for` Boolean used in batch files.  
`format` Command to erase and prepare a disk drivemsav Early Microsoft Virus scanner.  
`move` Move one or more files from one directory to another directory.  
`more` Display one page at a time.  
`mode` Modify the port or display settings.  
`mklink` Creates a symbolic link.  
`mem` Display memory on system.  
`md` Command to create a new directory.  
