# Links

- [Jupyter TroubleShooting Windows](Jupyter-TroubleShooting-Windows)

# Contents

- [Supported kernel languages](#Supported kernel languages)
- [Jupyter generic](#Jupyter generic)
    - [Jupyter Connection](#Jupyter generic#Jupyter Connection)
    - [References](#Jupyter generic#References)
- [Language specific](#Language specific)
    - [C++](#Language specific#C++)
    - [Java](#Language specific#Java)
    - [Javascript](#Language specific#Javascript)
    - [Perl (shitty/buggy)](#Language specific#Perl (shitty/buggy))
    - [Perl6 (TODO)](#Language specific#Perl6 (TODO))
    - [Ruby](#Language specific#Ruby)
    - [Rust (TODO)](#Language specific#Rust (TODO))
- [Kernel Not to implement](#Kernel Not to implement)
    - [Asm (No syscall, to be used in notebook)](#Kernel Not to implement#Asm (No syscall, to be used in notebook))
    - [C (shitty)](#Kernel Not to implement#C (shitty))



## Supported kernel languages
# Jupyter generic

### Jupyter Connection

* console get `kernel-<PID>.json`
* notebook `kernel-<GUI>.json`

* Never starting by `nbserver` : this is the server that open kernels (from firefox)

### References

[kernel list](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)


# Language specific

### C++

* [C++ at Gihub (1.2k stars)](https://github.com/QuantStack/xeus-cling)

```cpp
// Redefinition
#include <iostream>
void (*myFunc)() = nullptr;
// Cell 2
myFunc = []()->void {
    std::cout << "You";           
};
myFunc();
```

### Java

* Works super well (even too fast)

* [Java at Github (300)](https://github.com/SpencerPark/IJava)


### Javascript

* [Javascript at Github (1200)](https://github.com/n-riesco/ijavascript)

```sh
sudo apt-get install nodejs npm jupyter-notebook
npm config set prefix $HOME
npm install -g ijavascript
ijsinstall
```

### Perl (shitty/buggy)


### Perl6 (TODO)

* [Perl6 at Github](https://github.com/bduggan/p6-jupyter-kernel)


### Ruby

### Rust (TODO)

* [Rust at Github](https://github.com/google/evcxr/tree/master/evcxr_jupyter)



# Kernel Not to implement

### Asm (No syscall, to be used in notebook)

* [Asm at Github](https://github.com/gcallah/Emu86)
* No system call
* No data section
* pretty web site: https://gcallah.github.io/Emu86/index.html


### C (shitty)

* Note: None sens to get vim wrapper : is must compiel all cell as one file

* [C at Github (400 stars)](https://github.com/brendan-rius/jupyter-c-kernel)

```sh
sudo pip3 install jupyter-c-kernel
sudo sudo install_c_kernel --sys-prefix
```

