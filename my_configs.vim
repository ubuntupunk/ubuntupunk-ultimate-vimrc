
" off99555's '.vimrc' configurations
" Extended to the Ultimate .vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" file settings
set number
" Maximize the Vim window under Windows OS
if has('gui_running') && (has("win16") || has("win32"))
    au GUIEnter * simalt ~x 
endif

" Stay in visual mode after indentation
vnoremap < <gv
vnoremap > >gv

" Make big Y behaves like other command
map Y y$

" Improve up/down movement on wrapped lines
"nnoremap j gj
"nnoremap k gk

" Force saving files that require root permission
"cmap w!! %!sudo tee > /dev/null %

" The smash escape
inoremap jk <Esc>
"inoremap kj <Esc>

" Open new split windows to the right/bottom instead of left/top
set splitright splitbelow

" Allow working with Unicode characters
scriptencoding utf-8
"set listchars=trail:·,precedes:«,extends:»,eol:¬,tab:▸\ 
set listchars=trail:·,precedes:«,extends:»,tab:→\ 
set list

" Inserting blank lines without going into insert mode
nnoremap <S-CR> O<Esc>S<Esc>j
nnoremap <C-CR> o<Esc>S<Esc>k

" Python PEP8 style guide
au BufNewFile,BufRead *.py
  \ setlocal tabstop=4 |
  \ setlocal softtabstop=4 |
  \ setlocal shiftwidth=4 |
  \ setlocal textwidth=79 |
  \ setlocal expandtab |
  \ setlocal autoindent |
  \ setlocal fileformat=unix

" Web dev style
" au BufNewFile,BufRead *.js, *.html, *.css
"   \ set tabstop=2 |
"   \ set softtabstop=2 |
"   \ set shiftwidth=2

" Enable folding
set foldmethod=indent
set foldlevel=99 "start by not closing any folds

" This rewires n and N to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.05)<cr>
"nnoremap <silent> N   N:call HLNext(0.05)<cr>

" just highlight the match in red...
function! HLNext (blinktime)
  highlight WhiteOnRed ctermfg=white ctermbg=red guifg=white guibg=red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#\%('.@/.'\)'
  let ring = matchadd('WhiteOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

if has('gui_running')
  set cursorline
endif
nnoremap Q <esc>:echo "'Q' is for useless Ex mode.
      \ < < ===== CHECK CAPS LOCK ===== > > "<cr>

" g GG <c-d> <c-u> will stay in the same column
" nice for doing visual block motions
set nostartofline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""" Thoughtbot .vimrc """""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd
set nowritebackup
set autowrite

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

set nojoinspaces

set textwidth=80
"highlight ColorColumn ctermbg='magenta' guibg='magenta'
set colorcolumn=+1
"autocmd BufWinEnter * call matchadd('ColorColumn', '\%81v', 100)

set number
set numberwidth=5
" relativenumber confuses other people watching our screen, nice argument!
"set relativenumber
"autocmd InsertEnter * :set number norelativenumber
"autocmd InsertLeave * :set number relativenumber
"autocmd FocusLost * :set norelativenumber
"autocmd FocusGained * :set relativenumber
"nnoremap <c-l> :set relativenumber!<cr><c-l>

" Tab completion
" will insert tab if the preceding character is a space or a tab
" otherwise, do autocomplete <c-n>
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col - 1] =~# '\s'
    return "\<tab>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-p>

"nnoremap <leader><leader> <c-^>

" Get off my lawn
"nnoremap <Left> :echoe "Use h"<CR>
"nnoremap <Right> :echoe "Use l"<CR>
"nnoremap <Up> :echoe "Use k"<CR>
"nnoremap <Down> :echoe "Use j"<CR>
noremap <Left> {
noremap <Right> }
noremap <Up> 5<c-y>
noremap <Down> 5<c-e>

" Run commands on the shell
"nnoremap <Leader>r q:i!

" Always use vertical diffs
set diffopt+=vertical

" change font size quickly
if has("gui_running")
  nnoremap <C-Up> :silent! let &guifont = substitute(
  \ &guifont,
  \ ':h\zs\d\+',
  \ '\=eval(submatch(0)+1)',
  \ 'g')<CR>
  nnoremap <C-Down> :silent! let &guifont = substitute(
  \ &guifont,
  \ ':h\zs\d\+',
  \ '\=eval(submatch(0)-1)',
  \ 'g')<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change/rename current word and is repeatable using dot (.)
nmap <leader>r *``cgn

" vim-indent-lines
nnoremap <leader>ilt :IndentLinesToggle<cr>

" allow copying via ctrl-c and do motion like default vim behavior
vnoremap <c-c> "*ygv<c-c>
" allow pasting via ctrl-v
inoremap <c-v> <esc>"*p
cnoremap <c-v> <c-r>*

" copy this buffer into a new temporary tab
nnoremap <leader>co gg""yG``zz:tabnew<cr>:set syntax=qf<cr>""P
vnoremap <leader>co ""y:tabnew<cr>:set syntax=qf<cr>""P

" CtrlP
nnoremap z/ :CtrlPLine %<cr>

" vim-surround with 3 backticks for code (only works for whole line)
" TODO: Make this works on part of a line too
vnoremap Sc <esc>`<O<esc>S```<esc>`>o<esc>S```<esc>k$
