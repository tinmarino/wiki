% Pluggin list: Community matters

Pluggins are the most important stuff for a true text editor as one person
cannot implement all the languages.
Even thought most of Vim functionality is enought with small coding.
Some big plugins bundle exist but you should known and clone these one by
one. (Otherwise how can you use these all)
Notice that the order in the TOC is not the same as in the file.

# MENU

| Plugin                              | Use                 |
| ---                                 | ---                 |
| Language                            |                     |
| [Fugitive](#fugitive)               | Git                 |
| [Ipython](#ipython)                 | Ipython             |
| [Python-mode](#python-mode)         | Python              |
| [Eclim](#eclim)                     | Java                |
| [Vimtex](#vimtex)                   | Latex               |
| [Conque-GDB](#conque-gdb)           | Gdb                 |
| Commands                            |                     |
| [Surround](#surround)               | Around text-objects |
| [Commentary](#commentary)           | Comment             |
| [Unimpaired](#unimpaired)           | Maps set            |
| [Abolish](#abolish)                 | Sub, ab             |
| [Repeat](#repeat)                   | Repeat maps         |
| [CamelCaseMotion](#camelcasemotion) | Motions             |
| [DelimitMate](#delimitmate)         | Autoclose ()        |
| [MatchIt](#matchit)                 | % better            |
| [Ultisnips](#ultisnips)             | Snippet manager     |
| [Vim-snippets](#vim-snippets)       | Snippet collection  |
| [Commandline](#commandline)         | Maps for cmdline    |
| Display                             |                     |
| [Colorscheme](#colorscheme)         | More Colors         |
| [AnsiEsc](#ansiesc)                 | Color ANSI          |
| [Rainbow_Pare.](#rainbow_pare.)     | Color imbrication   |
| Interface                           |                     |
| [CtrlP](#ctrlp)                     | Fuzzy Browse        |
| [NErdtree](#nerdtree)               | Directory browsing  |
| [Airline](#airline)                 | Status bar (bottom) |
| [Undotree](#undotree)               | See Undo as tree    |
| ### Old                             |                     |
| [Pathogen](#pathogen)               | Pluggin manager     |


### On local machine 
git submodule add https://github.com/tpope/vim-fugitive
/pack/bundle/start/fugitive
:Helptags ALL

### On remote machine 
git submodule init
git submodule update



# BUNDLE

https://github.com/altercation/vim-colors-solarized


# PATHOGEN

Note: Since vim version 8.0, it is useless since pack/bundle will be
automatically added to your runtimepath.

Is a pluggin manager. It basically extends your runtimepath dynamically.
You just have to git clone the  desired pluggin in ~/.vim/bundle/ for it to be
loaded as if it was in the root folder (~/.vim)

# FUGITIVE

Get git functionality in current file folder with the `:Git` command.
Very well coded
:Gdiff      -> Use vimdiff to push in index
:Gstatus    -> Many map to add or remove

https://github.com/tpope/vim-fugitive

# IPYTHON

Replaced by jupyter-vim
The functionality `vim-server` and `python-zmq` (zero-message-query: to
install) plus this small plugin, allow you to execute lines of code from here
to a remote ipython/jupyter kernel

https://github.com/ivanov/vim-ipython

# PYTHON-MODE

```sh
pip3 install --user pylint
```

A HUGE collection of python plugins taht are up to date because they are
written in python. Thanks to the +python feature of vim that is now embeded
with a python interpreter.
    Pylama                  # Wraps others
    Rope                    # Refractoring
    PEP8; Pyflakes, Pylint  # Code checking
    
    And much much more.
NB: Community pluggin as dirty as python

https://github.com/python-mode/python-mode

# ECLIM

Java users: Eclipse (free) is used as a server and vim as a client. So I can
get completion, jump to code and error checking.

http://eclim.org/

# COLORSCHEME SWITCHER

Lot of colorschemes and 2 maps to switch: <F8> and <S-F8>
May be included in the Main vim disti (at least neovim)


# CTRLP

Fuzzy file browsing with some regexp of the path (type scGam for
s.*c.*G.*a.*m).
Can browse in:
1. Files (above the pwd)
2. Most Recently Updated (MRU)
3. Buffers
My settings are: 
```vim
" E like edit and closer to ctrl + <c-p> used to paste
let g:ctrlp_map = '<c-e>'
" Mixed to search in MRU, FIles, Buffers
let g:ctrlp_cmd = 'CtrlPMixed'
```

https://github.com/kien/ctrlp.vim

# SURROUND

https://github.com/tpope/vim-surround

# SOLARIZED

Make a noise nothing: I prefer dante colorscheme!


# VIMTEX

Help Writting compiling Tex, LaTex files.
Huge doc: 2000 lines.
Many commands, options the vim way.
Continous build mode
Works

https://github.com/lervag/vimtex

# NERDTREE

Explore the directories. Move ...
Better than the embeded netrw plugin

https://github.com/scrooloose/nerdtree

# CONQUE-GDB

Gdb integration thank to embede ConqueTerm.
Works fine on Linux at least (on windows idk)

https://github.com/vim-scripts/Conque-GDB

# ULTISNIPS

Snippets manager. Easy to use.
Considered to be the best by web community.

https://github.com/SirVer/ultisnips

# SNIPPETS

Snippets database for 2 plugins including |v-plugin#ultisnips|

https://github.com/honza/vim-snippets

# AIRLINE

Lean & mean status/tabline for vim that's light as air.

https://github.com/vim-airline/vim-airline

# ANSIESC

Colorise text with Ansi Escaped colors

https://github.com/powerman/vim-plugin-AnsiEsc

# RAINBOW PARENTHESES

Colorise parentheses according to imbrication.
Give a quick short view of imbrication and maybe bugs

https://github.com/kien/rainbow_parentheses.vim

# COMMENTARY

Toggle commenting and uncommenting

https://github.com/tpope/vim-commentary

# UNIMPAIRED

A set of man Tpope's maps
I still never used it !

https://github.com/tpope/vim-unimpaired

# ABOLISH

Abbreviation
Substitution
Coercion

https://github.com/tpope/vim-abolish

# REPEAT

Repeat the last used map

https://github.com/tpope/vim-repeat

# CAMELCASE MOTION

Gives you camel case motions
Can be usefull for java

https://github.com/vim-scripts/camelcasemotion

# DELIMITMATE

Autocomplete the ([{}])

https://github.com/Raimondi/delimitMate

# MATCHIT

For the |%| to work with language imbrication

https://github.com/vim-scripts/matchit.zip

# UNDOTREE

Watch you undo as a tree.
Cause it can be complicated to use vim default mapping

https://github.com/mbbill/undotree

# EMACS COMMANDLINE

To get emacs (terminal) shortcuts on vim cmdline
Warning: It overwrites the: <<C-R> -> pretty annoying

https://github.com/houtsnip/vim-emacscommandline

# My gitmodules in 2023

When I started using Vim-Plug

```
https://github.com/junegunn/gv.vim
https://github.com/scop/bash-completion
https://github.com/jpalardy/vim-slime
https://github.com/tinmarino/vim-almasw
https://github.com/neoclide/coc.nvim
https://github.com/ryanoasis/vim-devicons
https://github.com/Xuyuanp/nerdtree-git-plugin
https://github.com/kana/vim-submode
https://github.com/farmergreg/vim-lastplace
https://github.com/christoomey/vim-tmux-navigator
https://github.com/junegunn/fzf
https://github.com/junegunn/fzf.vim
https://github.com/chrisbra/unicode.vim
https://github.com/ycm-core/YouCompleteMe
https://github.com/tinmarino/vim-color
https://github.com/junegunn/vader.vim
https://github.com/Raku/vim-raku
https://github.com/kana/vim-textobj-user
https://github.com/kana/vim-textobj-function
https://github.com/tpope/vim-sleuth
https://github.com/cohama/lexima.vim
https://github.com/dense-analysis/ale
https://github.com/mbbill/undotree
https://github.com/tpope/vim-repeat
https://github.com/chrisbra/Colorizer.git
git://github.com/honza/vim-snippets.git
https://github.com/itchyny/calendar.vim
https://github.com/powerman/vim-plugin-viewdoc
https://github.com/c9s/perlomni.vim
https://github.com/dhruvasagar/vim-table-mode
https://github.com/github/gitignore
https://github.com/mileszs/ack.vim
https://github.com/salsifis/vim-transpose
https://github.com/python-mode/python-mode
https://github.com/vim-vdebug/vdebug
https://github.com/michaeljsmith/vim-indent-object
https://github.com/vim-scripts/Align
https://github.com/vim-scripts/Mines
https://github.com/vim-scripts/DrawIt
https://github.com/suan/vim-instant-markdown
https://github.com/vimwiki/vimwiki
https://github.com/tpope/vim-unimpaired
https://github.com/junegunn/vim-emoji
https://github.com/vim-scripts/argtextobj.vim
https://github.com/michaeljsmith/vim-indent-object
https://github.com/houtsnip/vim-emacscommandline
https://github.com/powerman/vim-plugin-AnsiEsc
https://github.com/SirVer/ultisnips
https://github.com/vim-airline/vim-airline
https://github.com/vim-scripts/Conque-GDB
https://github.com/xolox/vim-misc
https://github.com/scrooloose/nerdtree
https://github.com/ctrlpvim/ctrlp.vim
https://github.com/tpope/vim-surround
https://github.com/xolox/vim-colorscheme-switcher
https://github.com/lervag/vimtex
https://github.com/python-mode/python-mode
https://github.com/tpope/vim-fugitive
```



# My ex vimconf

Just to keep the timer trick

```vim

Plug farmergreg/vim-lastplace  " Open vim at last edition place on file
Plug tpope/fugitive

" TODO
packadd submode  " Map C-W

function! TimerPack(timer) abort
  " Lazy loader
  packadd almasw
  " Map: 10ms for 9pg
  packadd surround  " ySS<div>
  packadd repeat  " for surround
  packadd textobj-user  " for function
  packadd textobj-arg  " data
  packadd textobj-indent  " dai
  packadd textobj-function  " daf
  packadd unimpaired  " 5ms  ]b (:bn) , ]<space> (add empty lines), ]q
  packadd tmux-navigator  " ]q
  packadd emacscommandline  " 3ms
  "packadd tex
  " Misc:
  packadd vader
  packadd ale
  " Youcompleteme: is verbose at init if no python
  try
    python3 '42'
    " Deletes the vim intro screen
    let g:ycm_auto_hover = ''
    " set omnifunc=syntaxcomplete#Complete
    " packadd youcompleteme
  catch | endtry
  "" Ultisnip: is annoying at run time if no python
  try
    python3 '42'
    packadd ultisnips  " 3ms
    packadd snippets " for some ultisnips macro
  catch | endtry
endfunction

" Call it
if has('timers')
  call timer_start(0, 'TimerPack')
else
  call TimerPack(42)
endif
