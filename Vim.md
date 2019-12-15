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
