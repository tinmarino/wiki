% Empire

This is to test, play withg empire, a framework to send comand to a remote session (from Linux to Windows)
Usually, it take 3 sec for empire to connect
Before, you should check the ip

# Quick start
* `>help`
* Listener | agent | module
* `>listeners`
  * `>uselisteners <Tab>`
  * `>info`
  * `>sert|unset`
  * `>execute`
* `>usestager <Tab> `
* `>agents`
  * `>list`


# Execute (Windows commands)

### Analyse
*   whoami 
*   query user          # Get connected users
*   tasklist
*   wmic process list   # Windows Management Instrumentation Command-line tool

### Message
*   msg user Hi you have been infected

### Sound
*   pressing <c-g> in the shel lmake a bad cmd and trigger the beep

### Lateral movements
To make a sound, yo umust run as the user that is logged (the frist arg of msg)

*   start
*   runas /user:user cmd
*   runas /user:user "notepad c:\boot.ini"
*   tskill notepad   or pskill notepad


# Empire commands (latteral movements ...)

*   `download` stores -> files in ./downloads/AGENT_NAME
                    -> log in .agent.log
*   `kill` all                     

*   `ps`                          # List processes
*   `ps` powershell               # With filter

*   `spawn` <listener>            # Like a span http1
                                # SPawn a new powershell listener process

*   `psinject` http1 explorer.exe # The format is psinject <listener> <procname/pid> 
                                # Warning do not inject in LSASS
                                # Please choose a process in the same section
                    
# Prepare (Linux)

*   espeak Hi from the deep --stdout > hi.wav

