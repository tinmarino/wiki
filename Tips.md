% Vim Tips


* Random, Sort, Shuffle
  	* Random shuffle
		:10,20!shuf<CR>
		func Random()
			return reltimestr(reltime())[-2:]
		endfunc
		%s/^/\=Random() . ""/|sort n|%s/^\S*//

* Remote 
	vim --servername DEMO
	vim --servername DEMO --remote file.txt
	vim --servername DEMO  --remote-send ":3d<CR>"
	:!vim --servername DEMO --remote-tab "%"   " Send current buffer to remote vim
	
* File format
	* `:e ++ff=unix`
	* `:w ++ff=dos`
	* `%s/\r\n/`

* Buffer
	* `:b *.java<c-d>` : list buffer names matching regex

* Pipeline
	* `echo toto | vim -` : take arguments from stdin
	* `echo foo | vim -e '+%print' '+q!' /dev/stdin` : exmode to not consume stdin and not clear output on quit
	* `vim <(echo toto)` : process substitution command (BaSh)
	* `:w !tee` : write to stdout

* Script : Get filetype of a buffer
	* `:let bufFiletype = getbufvar(bufNr, '&filetype')`

* Substitute without escaping the replcement
  * `:%sno/search_string/replace_string/g`
  * `:s/</\='&lt;'/g`

* Delete everything except text
  * `:%s/\(^\|\(text\)\@<=\).\{-}\($\|text\)\@=//g`
  *
    ```
    \(^\|\(text\)\@<=\)     # means start of line, or some point preceded by “text”
    .\{-}                   # as few characters as possible
    \($\|text\)\@=          # without globbing characters, checking that we reached either end of line or occurrence of “text”.
    ```
  * Another way to do it:

  * Create a function that count matches of a pattern in a string (see :help match() to help you design that)
  * Use: :%s/.*/\=repeat('text', matchcount('text', submatch(0)))

* Find where root runtime is 
	* `:echo $VIMRUNTIME` -> `/usr/share/vim/vim74`
	
* Source autoload file
	* `:call example#BadFunction()`

* Find where a map has been defined (in which script)
	* `:verbose map <c-z>` 

*   Use `s/\%V` to substitude within selection and not full lines

* Remember manual folds
	* `au BufWinLeave ?*mkview`
	* `au BufWinEnter ?* silent loadview`


Vim can browse tar and zip archives
uppercase maps to jump between files
Read vimcast of drew neil and tim pope


# Advanced commands

```

# Moving
( | ) 					# Jump backward | forward one sentence
{ | } 					# Jump backward | forward one paragraph
_ | ^					# Move to the first non-blank
'. 						# Jump to last modificated line

# Edit
T,c,                    # Delete between coma

# Display
ga 						# Show as Ascii
g8 						# Show as Unicode (:h character-class)
8g8						# Detect invalid utf8 characters
zl, zh, zL, zH			# Scrool horizontally

# Folding
zc, zC | zo, zO 		# Close | Open [nested] folds
zr | zm					# Reduce | increase foldlevel (think restore, mask)
zg | zk
zx | zv
zf'a | zf 				# Fold from here 
zj | zk 				# Move between folds
[z | ]z 				# Goto begining | end of fold

# Commands
:@"						# Execute what is yanked
/\%xYY					# YY hex ord(ascii)
/\%uYYYY				# YYYYY hex ord(unicode)
:args * .* **/{*, .*}   # Add all file to buffers
:b#|bd#

											
```										


# Easy commands

```
ma 						Mark a
'a 						Goto mark a
```

	:wall # save all 
	cd %:p:h

	K   # get the doc 
	mapclear

	:nnoremap ,s :exe 'grep ' . expand('<cword>') . ' *'<CR>
	:nnoremap ,s :grep <C-R><C-W> *<CR>
	:inoremap <F5> <C-O>:call MyVimFunc()<CR>
	CTRL-\ CTRL-N command to go to normal mode. I




	:!mv {file location} {new file location}
	:e {new file location}
		Write the file while editing - :w newname - to create a copy.
		Start editing the new copy - :e#.
		(Optionally) remove the old copy - :!rm oldname.


		<c-w>f 	open in a new window (Ctrl-w f)
		<c-w>gf 	open in a new tab (Ctrl-w gf) 
		:find 
		:e **/test/Suite.java
		:r! find . -type f



q:
q/
:<c-f>
:%normal @a			" Execute a on all lines
:%s//@=0			" REplace last search by last yanked
&					" Repeat last s on this line
g& 					" repeat last s on all lines
:g/*{/ .+1,/-1 sort " Sort lines between { and }
:saveas
:=					" print last line number
:echo expand('<sfile>') 			" print file of script
:syntax sync fromstart 				" REdraw syntax
:b#|bd#				" Delete buffer, not window



g,g; gi



gJ join lone without space
g-  g+   for older newer changes
ga 				Show char hex
g*, g#			Smae as *, # but without delimiters
gq				Filter via formatprg
X				Delete char before

<c-g> 			Print filename
K				See documentation


<c-q> or <c-v> 	Visual block
gv				Reselect last selection
gu, gU, ~		Lower, Uppder case operator


EDIT 

Auto-completion
Ctrl+n Ctrl+p (in insert mode) 	Complete word
Ctrl+x Ctrl+l 	Complete line
:set dictionary=dict 	Define dict as a dictionnary
Ctrl+x Ctrl+k 	Complete with dictionnary

<c-x> <c-f> 			# for filname completion 

gUgU or gUU # duplicate operator on whole line

>G   # increase indentation until the end of file
f+s + <Esc>;.;.;.  # remplace "+" par " + "
180<C-a>k.k.k.  # add 180 to all 

INsret 
R # get in pelace made and stay in replace mode 
80a-<esc>
IN VISUAL 
o - move to other end of marked area
O - move to other corner of block



ga # show the hewa code for char 


:12,20>>> indents lines 12 to 20 inclusive three times 


80a=<Esc>		" Create tje line
:Sex 	            | Split window and open integrated file explorer
:e . 			    | Open integrated file explorer


=				    Indent operator

:.,$normal @q       To make macro on all lines

	:py print 2
	:version
	:h +feature-list
	:h ex-cmd-index

vim: ft=myhelp
