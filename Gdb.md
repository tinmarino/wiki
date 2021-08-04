asm("int $3");
gdb -ex run --args ./astroserv

```gdb
info reg
info all-registers

x/20xa *((size_t *) ($rdi + 0x10))

x/20xa $rsp
x/20xa *((size_t *) ($rsp))

define s
stepi
x/15i $pc
end

define n
nexti
x/15i $pc
end

layout asm
layout regs
tui disable
```
