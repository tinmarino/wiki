


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
