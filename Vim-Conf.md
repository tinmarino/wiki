```vim

" Fzf {{{1
" https://github.com/samoshkin/dotvim/blob/master/vimrc {{{2
" Ctrl-q allows to select multiple elements an open them in quick list
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Do not let UltiSnips set <Tab> mapping, as we're using own smart <Tab> implementation
" Also we don't need snippet listing, as we're using fzf for this purpose
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsListSnippets="<NUL>"
let g:UltiSnipsEditSplit = 'context'

" Find available snippets from Insert mode using fzf
" Use :UltiSnipsEdit(!) command to edit private(all) snippet definition file
inoremap <silent> <F9> <ESC>:FzfSnippets<CR>
nnoremap <silent> <F9> :UltiSnipsEdit!<CR>
```
