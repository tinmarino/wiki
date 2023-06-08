* [Vim Menu](Vim-Menu)

# Fast

```vim
" indent
:%s/^\s*/&&


function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)


g/^\w/s/^\([a-zA-z0-9-/]\+\)\s\+\t\(.*\)\s*\t.*/| \1 | \2|/
g/^\w/s/^\([a-zA-z0-9-/]\+\)\s*\t\(.*\)\t.*/| \1 | \2|/

" Tip from Brennen in https://github.com/vimwiki/vimwiki/issues/1291
" hit ,S to debug current syntax highlighting groups
" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
"
map <Leader>S :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap <silent> <leader><space> :execute 'silent! update'<Bar>Files<CR>
tmux unbind -T copy-mode-vi MouseDragEnd1Pane
vim pre.md  +'redir! > cmds | sil com Vimwiki' +q && cut -b5- cmds | cut -d ' ' -f 3
$ vim --clean DbBuilder.pm -c 'setfiletype perl6' \
   -c 'syntime on' \
   -c redraw -c redraw -c redraw \
   -c 'syntime report'
   # See there: https://github.com/vim/vim/issues/4339
   
:cq commit quit -> Quit with error -> amend commit
1<C-g> show full file path, 2<C-g> 
'<,'>s#\-\?\d\+\(\.\d\+\)\?#\=str2float(submatch(0))*0.05#g
```

* `:window diffthis`
* `:diffoff!  " <-:window diffoff`

## Ctags

```bash
ctags -R --language=C++ --c++-kinds=+p --fields=+iaS --extra=+q .
ctags -R --language=C++ --c++-kinds=+p --fields=+iaS --extra=+q .
ctags -R -a --language=C++ --c++-kinds=+p --fields=+iaS --extra=+q /usr/lib/gcc/x86_64-linux-gnu/9/include /usr/local/include /usr/include/x86_64-linux-gnu /usr/include /usr/include/c++/9/ /usr/include/c++/9 /usr/include/x86_64-linux-gnu/c++/9 /usr/include/c++/9/backward /usr/lib/gcc/x86_64-linux-gnu/9/include

readarray -t a_system_include < <(echo | gcc -E -Wp,-v - |& sed -ne '/^#include </,/^End of search/{//!p}' | tr '\n' ' ')
ctags -R -a . "${a_system_include[@]}"
```

## Python

```text
]] Jump forward to begin of next toplevel
[[ Jump backwards to begin of current toplevel (if already there, previous toplevel)
]m Jump forward to begin of next method/scope
[m Jump backwords to begin of previous method/scope

][ Jump forward to end of current toplevel
[] Jump backward to end of previous of toplevel
]M Jump forward to end of current method/scope
[M Jump backward to end of previous method/scope

PYMODE
==========  ============================
Key         Command (modes)
==========  ============================
[[          Jump to previous class or function (normal, visual, operator)
]]          Jump to next class or function  (normal, visual, operator)
[M          Jump to previous class or method (normal, visual, operator)
]M          Jump to next class or method (normal, visual, operator)
aC          Select a class. Ex: vaC, daC, yaC, caC (normal, operator)
iC          Select inner class. Ex: viC, diC, yiC, ciC (normal, operator)
aM          Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator)
iM          Select inner func. or method. Ex: viM, diM, yiM, ciM (normal, operator)
==========  ============================
```

## Sudo

* `sudo -E vim README.txt`
* `sudoedit`


## Snippet

```vim
" Make it AutoScroll
augroup JupyterTerm
    autocmd!
    autocmd TextChanged __jupyter_term__ call cursor('$', 0)
augroup END
echo getregtype('a') " To see if in Visual or v
```

### Run lines

```vim
:vnoremap <f2> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>
:execute getline(".")
```

### Location list

call setqflist([])


### Compile

See: https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source

##### Local
```sh
# Add first line for debug
export CFLAGS='-g -gdwarf4 -DDEBUG -O0 -fno-omit-frame-pointer'
export MAKE_PARS='-j 28 '; export LC_CTYPE=en_US.UTF-8; export MAKE_NOSTATIC=yes; export MAKE_NOIFR_CHECK=on;
export CFLAGS='-O2'
#export LDFLAGS='-static -lxcb -lX11'

./configure \
            --with-features=huge \
            --with-x=yes \
            \
            --enable-cscope \
            --enable-fail-if-missing \
            --enable-largefile \
            --enable-multibyte \
            --enable-autoservername \
            \
            --enable-python3interp=dynamic \
            --with-python3-config-dir=$(python3-config --configdir) \
            \
            --with-compiledby="Tinmarino"

./configure \
            --with-features=huge \
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
            --enable-gui=gtk3 \
            \
            --with-compiledby="Tinmarino" \
```


##### On remote (Alma)
```sh
# export LDFLAGS=-static
# Do not see local --prefix=/usr/local \
./configure \
            --with-features=huge \
            --prefix=$HOME/.local \
            --disable-netbeans \
            --enable-gui=auto \
            \
            --enable-cscope \
            --enable-fail-if-missing \
            --enable-largefile \
            --enable-multibyte \
            \
            --enable-python3interp=dynamic \
            --with-python3-config-dir=$(python3-config --configdir) \
            \
            \
            --with-compiledby="Tinmarino" \
make && make install 
make install DESTDIR=~/.local
```

__Notes:__
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
ZQ

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
