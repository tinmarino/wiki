* [Vim Menu](Vim-Menu)


### Vim as hex interpreter
vim -s -e '<cmd>'
* s for silent
* e for ex mode
* -V1 for verbose (to see errors)
* -N non-compatible
* -S <file> : source the script <file>

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
