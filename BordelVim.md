*v-eclim.txt*               Eclim shortcuts, maps, tips (todo merge with scirpt)

	:Java %
	:NewJarEntry in .classpath



                                                                *v-eclim-idid*
if import android cannot be resolved:
add to .classpath (graddle)
    <classpathentry kind="src" path="src"/>
   	<classpathentry exported="true" kind="lib" path="/home2/tourneboeuf/Software/Android/SDK/android-sdk-linux/platforms/android-22/android.jar"/>






*v-appearance.txt*          Statusline (todo merge with script)

===============================================================================
Appearance ~

-------------------------------------------------------------------------------
The *v-statusline* option

This is a line at the bottom to get hud text. The ruler is supperposed to the
statusline. 
If you want to play with it, first run 
>vim
  set noruler
  set laststatus=2 
<vim
Then you can see what you are doing.

For a *default-statusline* you can take this one 
>vim
  :set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P
<vim
You can also change ruler with 
>vim
  :set rulerformat=%-14.(%l,%c%V%)\ %P
<vim
>
 hi User2 ctermbg=red   ctermfg=blue  guibg=red   guifg=blue
 hi User1 ctermbg=green ctermfg=red   guibg=green guifg=red
 hi User3 ctermbg=blue  ctermfg=green guibg=blue  guifg=green

 set statusline=
 set statusline+=%1*  "switch to User1 highlight
 set statusline+=%F   "full filename
 set statusline+=%2*  "switch to User2 highlight
 set statusline+=%y   "filetype
 set statusline+=%3*  "switch to User3 highlight
 set statusline+=%l   "line number
 set statusline+=%*   "switch back to statusline highlight
 set statusline+=%P   "percentage thru file
<



vim: ft=myhelp:set modificable  




*v-help.txt*                How to add custom help, like myself


1. Add              |v-help-add|
2. Syntax           |v-help-syntax|
3. Browse           |v-help-browse|


===============================================================================
                                                                  *v-help-add*
Add Help ~

In my runtime folder (ex ~/.vim/), in a doc folder I have many help files with
documentation. They must be in a runtimepath/doc and not in a nested directory
there.

The Filename must start with the type and the tags are in separated with '#'

The first line of the file can contains a tag and it will then be added to the
local-addtions help file (see :h local-addtions)

Dont forget to run helptags ./ in the current dir (doc) or just :Helptags for
all pathogen stuff for the tags to be generated. Then the command :h will
search them in a runtimepath/doc folder


===============================================================================
                                                                  *v-help-syntax*
Help Syntax ~

You can read /usr/share/vim/vim74/syntax/help.vim to get more info. You can
get the vim path with :scriptnames because some of those stuff will be sourced


===============================================================================
                                                               *v-help-browse*
Browse help ~
:h help

You can see everything I made with :h local-addtions

>vim
command -nargs=* -complete=help Help vertical belowright help <args>
:vert help
:vert bo help
<vim

>vim
:tag v#help
:h v#help
<vim


vim: ft=myhelp



*v-map.txt*                 Maps I don't wanna put in my vimrc


>vim
:nmap               Display normal mode maps
:imap               Display insert mode maps
:vmap               Display visual and select mode maps
:smap               Display select mode maps
:xmap               Display visual mode maps
:cmap               Display command-line mode maps
:omap               Display operator pending mode maps
:nmapclear          Clear all normal mode maps
<vim


"insert the directory name of the current buffer:
:inoremap <F2> <C-R>=expand('%:p:h')<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Window mappings
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <Leader>- <C-W>_<C-W><Bar>
map <Leader>_ <C-W>_<C-W><Bar>
map <Leader>= <C-w>=

 
vim: ft=myhelp



*v-stack.txt*               Drop shit here, git and move it then

===============================================================================
Stack ~





" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction


Ctrl+a 	Increment number under the cursor
Ctrl+x 	Decrement number under cursor
ggVGg? 	Change text to Rot13
g~~ 	Invert case
ggguG 	Set all text to lowercase



===============================================================================
                                                                        *v-os*
Os ~
  
ftype code="C:\gvim.exe" --remote-tab-silent "%1"
assoc .py code 
# if you don't know to what python is asso type "assoc .py"

:oldfiles
:browse oldfiles


		set nrformats=
	:e ++ff=unix
	inoremap <C-X><C-S> <C-O>:set completefunc=syntaxcomplete#Complete<CR><C-X><C-U>
	inoremap <C-x><C-z> <C-o>:set completefunc=SimpleComplete<CR><C-x><C-u>
	imap 
	imap <expr> aa pumvisible() ? "<ESC>:echo 'yes'<CR>" : "<ESC>:echo 'no'<CR>"
	:command -complete=file -nargs=1 OpenFile e <args>
	setlocal omnifunc=syntaxcomplete#Complete

	setlocal omnifunc=syntaxcomplete#Complete
	inoremap <expr><C-X><C-S> neocomplete#start_manual_complete()

	Cv Cj insert \%x00 and can be used as a line separator
	? How to complete keyword





	:set virtualedit=all
	highlight LineNr ctermfg=grey ctermbg=white
	:highlight NonText ctermfg=12  # to display ~ for empay lines
	let &colorcolumn=join(range(81,999),",")


cpp 
	CSearchContext for elcim and <C-X> <C-O>
	youcompleteme, clang_complete or cpp_omnicomplete with ctags, or eclim (currently what I use
	You can use gn in version 7.4 onwards (and gN to go backwards). It replaces the v//e trick.

		Search forward for the last used search pattern, like with `n`, and start Visual mode to select the match










	Jav afunction names 
	\v(public|protected|private|static|\s) +(\w|\<|\>|\[|\])+ *\s+\zs\w+\ze *\([^()]*\)


		:set fileformat  # UNIX window
		map ,a :let mycurf=expand("<cfile>")<cr><c-w>w:execute("e ".mycurf)<cr><c-w>p

		"background color 
		:highlight Normal ctermfg=grey ctermbg=darkblue
		make good fold 

au FileType python setlocal formatprg=autopep8\ -


vim: ft=myhelp:set modificable  




*v-todo.txt*                TODO list for vimrc, doc, pluggins, software, ideas



https://noahfrederick.com/log/a-list-of-vims-lists.html

-	iz for in fold stuff z[ z]
-	ii for in indent 




todoc ~

Make a sign for what is very nice and not very known 
ex tips  in tips and with a link in ex (or the opposite)


                                                                        *idid* 

	This show what I found out. 

LATEX ~

Fix fucking font generation map issue
rm ~/.texmf-var/fonts/map/pdftex/updmap/pdftex.map


================================================================================
                                                  *idid-gvim*
idid-gvim ~
	Select with mouse as wisual selection and no auto-insert 
		-> behave xterm 
		-> remove mswim.vim in vim74 




vim: ft=myhelp
