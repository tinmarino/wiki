```bash
# Print include path
g++ -E -x c++ - -v < /dev/null 
g++ -E -x c - -v < /dev/null 
* -E: stop after preprocessing
* -x language
* -v verbose
```

* Assemble
	* gcc file.c -masm=intel -S -o file.d # assemble
	* gcc -c file.s -i file.o # compile
	* gcc file.o -o file # link
	* gcc file.S -o  file
	* .s means pure asm .S means macro too
	* man as
	* see inline asm
	* man objdump
	* -m32  # compile 32 must instal libc en 32 bits



* Echo include dirs
	* g++ -E -x c++ - -v < /dev/null 
	* clang++ -E -x c++ - -v < /dev/null

* Use of Make
  * `export CFLAGS="-g"`

* Compile 32 bit
  * `apt install gcc-multilib`
  * `gcc -m32`
  * `export CFLAGS="-g -m32 -static"`
  * `export LDFLAGS='-m32 -L/usr/lib32'`
