# Assembly and retro engineering


* fs:30 -> PEB
* fs:00 -> TIB

* Addressing modes TODO add examples
    * Immediate
    * Register
    * Direct
    * Register indirect
    * Indexed





# Famous instructions (x86)

| Mnemonic   | Opcodes (hex) |
| ---        | ---           |
| NOP        | 90            |
| JMP esp    | FF E4         |
| CALL esp   | FF DC         |
| DEBUGBREAK | CC            |


* `PUSHAD`      # pushes eax, ecx, edx, ebx, esp, ebp, esi, edi
* `FLD`         # pushed on float stack
* `LEAVE`       # mov esp, ebp ; pop ebp
* `CLI`         # Clear Interrupt flag : to mask interrupts
* `STI`         # Restore Interrupt flag
* `LIDT`        # Load IDT
* `SIDT`        # Store IDT
* `INVLPG`      # Invalidate TLB Entry
