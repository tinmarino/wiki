# Shortcut

* `Ctrl M - Ctrl A`		Collapse
* `Ctrl M - Ctrl X`		Expand
* `Ctrl shift space`	See protoype

# Compiler flags

| Flag      | Description                                                                               |
| ---       | ------------------------------------------------------------------                        |
| RTC1      | Enable the run-time error checks feature                                                  |
| Zc        | Get header files types as native type                                                     |
| EHsc      | Exception handling model : {s or a}[c][r][-]                                              |
| Gs1000000 | Control stack checking call: The number of bytes variable can occupy before a stack check |
| Gs-       | Disable security checks (stack cookies)                                                   |
| W4        | Highest Warning Level                                                                     |
| nologo    |                                                                                           |
| Od        | Disable optimizations                                                                     |
| Ob2       | Inline function as much as you can Need optimization (O1, O2, Ox or Og)                   |
| Oi        | Enable intrinsic functions                                                                |
| Gd        | Cdeclaration calling convention                                                           |
| Zi        | Debugger needs its Produces a program database (PDB) that contains                        |
|           | type information and symbolic debugging information for use with the debugger.            |
              


# Linker flags


| Flag              | Description                                                                                                |
| ---               | --------------------------------------------------------------------                                       |
| NOLOGO            |                                                                                                            |
| MACHINE:X64       | Architecture (depends on the target)                                                                       |
| INCREMENTAL:NO    | Disable incremental linking: NO JUMPERS No static pointers in the data section to jump to functions        |
| ALIGN:4096        | Align sections in the RAM                                                                                  |
| FILEALIGN:4096    | Align sections in the HD Both the above was made to extract the shellcode with a remote tool               |
| IGNORE:4108       | Ignore the /ALIGN with /DRIVER warning. This warning aims to prevent unloadable dll but I am my own loader |
| SUBSYSTEM:CONSOLE | To be able to test with the cmdline                                                                        |
| DEBUG             | Generate Debug information. Easyer to read IDA files (see if linking works)                                |
