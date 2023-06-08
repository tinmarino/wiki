
" From autoload#ctrlz 2022 {{{1

" Add that to my bashrc
" PROMPT_COMMAND='read -r line 2>/dev/null </tmp/vim_cd'\
" '&& > /tmp/vim_cd && cd ${line##\r};'$PROMPT_COMMAND
" And that to vimrc
" nnoremap <expr> <c-z> ctrlz#ctrlz()
" nnoremap <silent> <expr> <leader>cd ctrlz#dadcd()

let s:temp_path = '/tmp'
if "termux" == $os
  let s:temp_path = expand('~/../usr/tmp')
endif

" Main: mapped to <c-z> in vimrc
function! ctrlz#ctrlz()
  call writefile([getcwd(),''], s:temp_path . '/vim_cd', 'b')
  return "\<C-z>"
endfunction


function! ctrlz#shell(cmd)
  " Get shell command output
  execute '!' . a:cmd . ' > ' . s:temp_path . '/vim_cmd'
  let l:res = readfile(s:temp_path . '/vim_cmd')
  if len(l:res) == 0 | let l:res = "" | endif
  return l:res[0]
endfunction


function! ctrlz#dadpid()
  " Get the pid of my highest shell ancestor
  let l:pts = ctrlz#shell('tty')
  let l:pts = substitute(l:pts, '/dev/', '', '')
  let l:cmd = 'ps -f ax ' 
  let l:cmd .= '| grep ''' . pts . '\s*Ss'' '
  let l:cmd .= '| awk ''{print $2}'''
  let l:pid = ctrlz#shell(l:cmd)
  return l:pid
endfunction


function! ctrlz#dadpwd()
  " Get the pwd of the dad process
  let l:pid = ctrlz#dadpid()
  return ctrlz#shell('readlink /proc/' . l:pid . '/cwd')
endfunction 


function! ctrlz#dadcd()
  " Cd to my dad's cd
  " Mapped with ,d
  silent execute 'cd ' . ctrlz#dadpwd()
  redraw!
endfunction

