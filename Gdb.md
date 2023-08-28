asm("int $3");
gdb -ex run --args ./astroserv

```gdb
info files

layout asm
layout regs
tui disable
```

```gdb
set follow-fork-mode child
info reg
info all-registers

info inferior
info proc mappings

# Go
run

# Launched stopped
starti

x/20xa *((size_t *) ($rdi + 0x10))

x/20xa $rsp
x/20xa *((size_t *) ($rsp))

define p
x/15i $pc
end

# Enter function
define s
stepi
x/15i $pc
end

# Do not enter funtion
define n
nexti
x/15i $pc
end
```

# InMemBin

```gdb
run x86_64 -R bash in_mem_bin.sh
handle SIGSEGV nopass

set $pc = $pc+1
p
set *0x7ffff7d14992 = 0xf0003d48
set *(0x7ffff7d14992+4) = 0x5677ffff
set *(0x7ffff7d14992+8) = 0xc3
x/15i 0x7ffff7d14992
set $pc = 0x7ffff7d14992
```
