# C

* [Keywords](C-Keywords) 
* [Operators](C-Operators)


# Macro

* `__declspec(dllexport)` 		# windows : export function in dll 
* `__debugbreak()`				# Set breakpoint
* `offsetof(struct_t, elt_t)` 	# Get elemenet offset
* `extern int const iPi = 3.1415926535`
	* extern so importing this.h get iPi defined
	* const for the precompiler (to avoid errors)
* `#pragma pack(1)` 	# to let the structure without aligning each field


* Jump to arbitrary addr
	void (*foo)(void) = 0xcacacaca;
	foo();

# Notes

* Le tableau aloue de la mémoire et le pointeur non => préféré le tableau


### Random

	```c
	#include <time.h>
	srand(time(NULL)); 	# Set seed
	rand();				# Get Random

	```

## Calling conventions, function prototype

* `typedef int(__cdecl callback_t)(HANDLE h_process);`

### Usercall
	int __usercall fct1@<eax>(int p1@<ecx>, int p2@<edx>, int p3) {return p1 + p2 + p3;}
	
#### Stdcall
The called function is cleaning the stack

#### Cdecl
The __caller__ is correcting the stack (because __HE__ knows : `printf`)

#### Fastcall (x64)
Rcx contains first var. The __callee__ is cleaning the pile
