* [Vim Menu](Vim-Menu)


### Location list

call setqflist([])


### Compile

./configure \
            --with-features=huge \
            --prefix=/usr/local \
            --disable-netbeans \
            --enable-gui=auto \
            \
            --enable-cscope \
            --enable-fail-if-missing \
            --enable-largefile \
            --enable-luainterp \
            --enable-multibyte \
            \
            --enable-perlinterp=dynamic \
            --enable-python3interp=dynamic \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-rubyinterp=dynamic \
            --with-ruby-command=$(which ruby) \
            --with-luajit \
            \
            \
            --with-compiledby="Tinmarino" \

__Notes__:
* Cannot make py2 and py3 in debian (choose only one)
* Dynamic loading impossible in debian

### Match non ascii
* `/[^\x00-\x7F]`
* `[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F]`
## Prompt press enter

* For a confirmation, I would use `:call confirm('My warning here')`; this uses a popup window in GVIM.
* To wait for _any_ character, you can use `:call getchar()`.
* For a confirmation with <kbd>Enter</kbd>, the already mentioned `:call input('Press enter to continue')`

# Debug timing function
```vim
function! Foo()
    " do your thing
    for i in range(1,8)
        let @a = i
    endfor
endfunction

" save current time
let start_time = reltime()

" call your function
call Foo()

" echo elapsed time expressed in seconds
echo "elapsed time:" reltimestr(reltime(start_time))
```



### Vim as hex interpreter
vim -s -e '<cmd>'
* s for silent
* e for ex mode
* -V1 for verbose (to see errors)
* -N non-compatible
* -S <file> : source the script <file

example: `vim -i NONE -u NORC -U NONE -V1 -nNesS script-cmd -c'echo""|qall!' -- args...`

### YouCompleteMe Stop
```vim
call youcompleteme#DisableCursorMovedAutocommands()
" do your stuff
call youcompleteme#EnableCursorMovedAutocommands()
```

### Exit 
ZZ

### Jump matching endif

runtime macros/matchit.vim

### Not clearing screen after leaving (for git diff)

`set t_te=`
By default VIM, when terminating, sends the string configured with the option t_te to the hosting terminal to tell it to clear the screen. To avoid it just :set t_te= to send nothing to the terminal and avoid screen clearing. See :help term form more information about terminal capabilities.

### Copy all match

```vim
qaq
:%s//\=setreg('A', submatch(0), 'V')/gn
```

### Version and patch

if v:version == 704 && has('patch399')
