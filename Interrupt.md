
When generating a software interupt, the processor calls one of the 256
functions pointed to by the interrupt descriptor table (IDT) which is located
in the first 1024 bytes of memory while in real mode.
It is therefore possible to call these withg a far call.

The first 0x20 (from 0 to 0x1F=31) are reserved for the CPU generated.
Then there are 0x10 material interrupts

* __Interrupt Vector Table__ : used in real mode
* __Interrupt Descriptor Table__ : used in protected mode and is more complicated
* __Interrupt Service Routine__ : the routine that is called just after the int
* __Interrupt Request__ : hardware signal sent to the processor calling an interrupt handler





|      |                                                                    |
| ---  | ---                                                                |
| 0X0  | Division by zero                                                   |
| 0X1  | Single-step interrupt                                              |
| 0X2  | NMI                                                                |
| 0X3  |                                                                    |
| 0X4  | Overflow                                                           |
| 0X5  | Bounds                                                             |
| 0X6  | Invalid Opcode                                                     |
| 0X7  | Coprocessor not available                                          |
| 0X8  | Double fault                                                       |
| 0X9  | Coprocessor segment overrun                                        |
| 0XA  | Invalid Task State Segment                                         |
| 0XB  | Segment not present                                                |
| 0XC  | Stack Fault                                                        |
| 0XD  | General Protection Fault                                           |
| 0XE  | Page fault                                                         |
| 0XF  | reserved                                                           |
| 0X10 | Math fault                                                         |
| 0X11 | Alignement check                                                   |
| 0X12 | Machine check                                                      |
| 0X13 | SIMD floating point Exception                                      |
| 0X14 | Virtualization Exception                                           |
| 0X15 | Control Protection Exception                                       |
| 0X16 |                                                                    |
| 0X17 |                                                                    |
| 0X18 |                                                                    |
| 0X19 |                                                                    |
| 0X1A |                                                                    |
| 0X1B |                                                                    |
| 0X1C |                                                                    |
| 0X1D |                                                                    |
| 0X1E |                                                                    |
| 0X1F |                                                                    |
| 0X20 |                                                                    |
| 0X21 |                                                                    |
| 0X22 |                                                                    |
| 0X23 |                                                                    |
| 0X24 |                                                                    |
| 0X25 |                                                                    |
| 0X26 |                                                                    |
| 0X27 |                                                                    |
| 0X28 |                                                                    |
| 0X29 | RtlFailFast(ecx) with ecx = 5 <- STATUS_INVALID_CRUNTIME_PARAMETER |
| 0X2A |                                                                    |
| 0X2B |                                                                    |
| 0X2C |                                                                    |
| 0X2D |                                                                    |
| 0X2E |                                                                    |
| 0X2F |                                                                    |
| 0X30 |                                                                    |
| 0X31 |                                                                    |
| 0X32 |                                                                    |
| 0X33 |                                                                    |
| 0X34 |                                                                    |



## Sources

Wikipedia : interrupt descriptor table
