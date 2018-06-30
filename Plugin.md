*v-plugin.txt*              Pluggin list: Community matters

Pluggins are the most important stuff for a true text editor as one person
cannot implement all the languages.
Even thought most of Vim functionality is enought with small coding.
Some big plugins bundle exist but you should known and clone these one by
one. (Otherwise how can you use these all)
Notice that the order in the TOC is not the same as in the file.

===============================================================================
MENU                                                           *v-plugin#menu*

Language ~
-------------------------------------------------------------------------------
Fugitive        |v-plugin#fugitive|                 Git              
Ipython         |v-plugin#ipython|                  Ipython
Python-mode     |v-plugin#python-mode|              Python
Eclim           |v-plugin#eclim|                    Java
Vimtex          |v-plugin#vimtex|                   Latex
Conque-GDB      |v-plugin#conque-gdb|               Gdb

Commands ~
-------------------------------------------------------------------------------
Surround        |v-plugin#surround|                 Around text-objects
Commentary      |v-plugin#commentary|               Comment
Unimpaired      |v-plugin#unimpaired|               Maps set
Abolish         |v-plugin#abolish|                  Sub, ab
Repeat          |v-plugin#repeat|                   Repeat maps
CamelCaseMotion |v-plugin#camelcasemotion|          Motions
DelimitMate     |v-plugin#delimitMate|              Autoclose ()
MatchIt         |v-plugin#matchit|                  % better
Ultisnips       |v-plugin#ultisnips|                Snippet manager
Vim-snippets    |v-plugin#snippets|                 Snippet collection 
Commandline     |v-plugin#emacscommandline|         Maps for cmdline

Display ~
-------------------------------------------------------------------------------
Colorscheme     |v-plugin#colorscheme-switcher|     More Colors
AnsiEsc         |v-plugin#ansiesc|                  Color ANSI
Rainbow_Pare.   |v-plugin#rainbow_parentheses|      Color imbrication

Interface ~
-------------------------------------------------------------------------------
CtrlP           |v-plugin#ctlp|                     Fuzzy Browse  
NErdtree        |v-plugin#nerdtree|                 Directory browsing
Airline         |v-plugin#airline|                  Status bar (bottom)
Undotree        |v-plugin#undotree|                 See Undo as tree

Old ~
-------------------------------------------------------------------------------
Pathogen        |v-plugin#pathogen|                 Pluggin manager


On local machine ~
git submodule add https://github.com/tpope/vim-fugitive
/pack/bundle/start/fugitive
:Helptags ALL

On remote machine ~
git submodule init
git submodule update



===============================================================================
BUNDLE                                                               *v-bundle*

https://github.com/altercation/vim-colors-solarized


===============================================================================
PATHOGEN                                                   *v-plugin#pathogen*

Note: Since vim version 8.0, it is useless since pack/bundle will be
automatically added to your runtimepath.

Is a pluggin manager. It basically extends your runtimepath dynamically.
You just have to git clone the  desired pluggin in ~/.vim/bundle/ for it to be
loaded as if it was in the root folder (~/.vim)

===============================================================================
FUGITIVE                                                   *v-plugin#fugitive*

Get git functionality in current file folder with the `:Git` command.
Very well coded
:Gdiff      -> Use vimdiff to push in index
:Gstatus    -> Many map to add or remove

https://github.com/tpope/vim-fugitive

===============================================================================
IPYTHON                                                     *v-plugin#ipython*

The functionality `vim-server` and `python-zmq` (zero-message-query: to
install) plus this small plugin, allow you to execute lines of code from here
to a remote ipython/jupyter kernel

https://github.com/ivanov/vim-ipython

===============================================================================
PYTHON-MODE                                             *v-plugin#python-mode*

A HUGE collection of python plugins taht are up to date because they are
written in python. Thanks to the +python feature of vim that is now embeded
with a python interpreter.
    PEP8
    Pyflakes
    And much much more.
NB: Community pluggin as dirty as python

https://github.com/python-mode/python-mode

===============================================================================
ECLIM                                                          *v-plugin#eclim*

Java users: Eclipse (free) is used as a server and vim as a client. So I can
get completion, jump to code and error checking.

http://eclim.org/

===============================================================================
COLORSCHEME SWITCHER                            *v-plugin#colorscheme-switcher*

Lot of colorschemes and 2 maps to switch: <F8> and <S-F8>
May be included in the Main vim disti (at least neovim)


===============================================================================
CTRLP                                                          *v-plugin#ctrlp*

Fuzzy file browsing with some regexp of the path (type scGam for
s.*c.*G.*a.*m).
Can browse in:
1. Files (above the pwd)
2. Most Recently Updated (MRU)
3. Buffers
My settings are: 
>vim
" E like edit and closer to ctrl + <c-p> used to paste
let g:ctrlp_map = '<c-e>'
" Mixed to search in MRU, FIles, Buffers
let g:ctrlp_cmd = 'CtrlPMixed'
<vim

https://github.com/kien/ctrlp.vim

===============================================================================
SURROUND                                                    *v-plugin#surround*

https://github.com/tpope/vim-surround

===============================================================================
SOLARIZED                                                  *v-plugin#solarized*

Make a noise nothing: I prefer dante colorscheme!


===============================================================================
VIMTEX                                                        *v-plugin#vimtex*

Help Writting compiling Tex, LaTex files.
Huge doc: 2000 lines.
Many commands, options the vim way.
Continous build mode
Works

https://github.com/lervag/vimtex

===============================================================================
NERDTREE                                                   *v-plugin#nerdtree*

Explore the directories. Move ...
Better than the embeded netrw plugin

https://github.com/scrooloose/nerdtree

===============================================================================
CONQUE-GDB                                               *v-plugin#conque-gdb*

Gdb integration thank to embede ConqueTerm.
Works fine on Linux at least (on windows idk)

https://github.com/vim-scripts/Conque-GDB

===============================================================================
ULTISNIPS                                                 *v-plugin#ultisnips*

Snippets manager. Easy to use.
Considered to be the best by web community.

https://github.com/SirVer/ultisnips

===============================================================================
SNIPPETS                                                   *v-plugin#snippets*

Snippets database for 2 plugins including |v-plugin#ultisnips|

https://github.com/honza/vim-snippets

===============================================================================
AIRLINE                                                     *v-plugin#airline*

Lean & mean status/tabline for vim that's light as air.

https://github.com/vim-airline/vim-airline

===============================================================================
ANSIESC                                                     *v-plugin#ansiesc*

Colorise text with Ansi Escaped colors

https://github.com/powerman/vim-plugin-AnsiEsc

===============================================================================
RAINBOW PARENTHESES                             *v-plugin#rainbow_parentheses*

Colorise parentheses according to imbrication.
Give a quick short view of imbrication and maybe bugs

https://github.com/kien/rainbow_parentheses.vim

===============================================================================
COMMENTARY                                               *v-plugin#commentary*

Toggle commenting and uncommenting

https://github.com/tpope/vim-commentary

===============================================================================
UNIMPAIRED                                               *v-plugin#unimpaired*

A set of man Tpope's maps
I still never used it !

https://github.com/tpope/vim-unimpaired

===============================================================================
ABOLISH                                                     *v-plugin#abolish*

Abbreviation
Substitution
Coercion

https://github.com/tpope/vim-abolish

===============================================================================
REPEAT                                                       *v-plugin#repeat*

Repeat the last used map

https://github.com/tpope/vim-repeat

===============================================================================
CAMELCASE MOTION                                    *v-plugin#camelcasemotion*

Gives you camel case motions
Can be usefull for java

https://github.com/vim-scripts/camelcasemotion

===============================================================================
DELIMITMATE                                             *v-plugin#delimitMate*

Autocomplete the ([{}])

https://github.com/Raimondi/delimitMate

===============================================================================
MATCHIT                                                     *v-plugin#matchit*

For the |%| to work with language imbrication

https://github.com/vim-scripts/matchit.zip

===============================================================================
UNDOTREE                                                   *v-plugin#undotree*

Watch you undo as a tree.
Cause it can be complicated to use vim default mapping

https://github.com/mbbill/undotree

===============================================================================
EMACS COMMANDLINE                                  *v-plugin#emacscommandline*

To get emacs (terminal) shortcuts on vim cmdline
Warning: It overwrites the: <<C-R> -> pretty annoying

https://github.com/houtsnip/vim-emacscommandline



===============================================================================
vim: ft=myhelp
