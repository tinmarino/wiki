

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

