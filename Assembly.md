# Assembly and retro engineering


* fs:30 -> PEB
* fs:00 -> TIB

* Addressing modes TODO add examples
    * Immediate
    * Register
    * Direct
    * Register indirect
    * Indexed

# Optimisation (gcc)

* -O0 "no optimization"
* -O1 Somewhere between -O0 and -O2.
* -O2 Moderate level of optimization which enables most optimizations.
* -O3 Faster / Larger code (may be longer to compile)
* -Ofast The fastest
* -Os Size small
* -Oz Size super small
* -finline-functions


# Memory

* Les pages sont marquées "kernel" ou "user" au niveau des PTE
* `SMEP` != `NX` : SMEP is for userland (ring 0 execution prevention) and NX is to prevent kernel from executing data
  

# Calling conventions (x64)

* Application Binary Interface : Calling convention, Name mangling and type representation

| Convention | Arguments                  | Cleaner | Memo             |
| ---        | ---                        | ---     | ---              |
| cdecl      | stack                      | caller  | printf           |
| syscall    | al <- nb of dw in arg_list | caller  |                  |
| stdcall    | stack                      | callee  | do(&accelerate)  |
| fastcall   | rcx, rdx r8, r9, stack     | callee  | rotate(30, true) |
| thiscall   | rcx, stack                 | callee  | x.sum(y)         |


# Famous instructions (x86)

* Lea relative ro rip are only valids in 64 bits

| Mnemonic     | Opcodes (hex)     |
| ---          | ---               |
| NOP          | 90                |
| JMP esp      | FF E4             |
| CALL esp     | FF DC             |
| DEBUGBREAK   | CC                |
| INT 03       | CC                |
| RETN         | C3                |
| RETN 14      | C2 14 00          |
| ADD ESP, 4   | 83 C4 04          |
| ASS ESP, 104 | 81 C4 01 01 00 00 |
| PUSH 101     | 68 01 01 00 00    |

| JG | JL | Signed   |
| JA | JB | Unsigned |


* `IMUL RCX`    #  RDX:RAX <= RCX x RAX

* `REP MOSD`    # ESI -> EDI with size = (4 x ECX) 
* `PAUSE`       # SpinLock : the only lock you can use at dispatch lvl 2.  Because the onther locks are dispatcher themselves
* `PUSHAD`      # pushes eax, ecx, edx, ebx, esp, ebp, esi, edi
* `FLD`         # pushed on float stack
* `LEAVE`       # mov esp, ebp ; pop ebp
* `CLI`         # Clear Interrupt flag : to mask interrupts
* `STI`         # Restore Interrupt flag
* `LIDT`        # Load IDT
* `SIDT`        # Store IDT
* `INVLPG`      # Invalidate TLB Entry
* `LAHF`        # Load Status Flag -> AH
* `SAHF`        # Store ... <- AH
* `OUT`         # Output to port
* `Enter`       # Create, Allocates new local stack frame
* `Leave`       # Last inst of a function : Destroy the stack frame
* `LIDT`
* `IRET`        # Interrupt Return (POP EFLAG ; POP RIP)
* `RDMSR`       # Read the 64 bit MSR register specified by ECX to EDX:EAX
* `WDMSR`       # Write ...
