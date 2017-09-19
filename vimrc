"basic settings {{{
set nocompatible

source $HOME/.vim/plug.vim

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax on
endif
set number
set history=1000
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
"}}}

"colorscheme {{{
set t_Co=256
colorscheme made_of_code
highlight WarningMsg ctermbg=red guibg=red
highlight User1 ctermbg=blue ctermfg=black guibg=blue guifg=white
highlight User2 ctermfg=green ctermbg=darkgray guifg=green guibg=NONE
"}}}

"for running gVim {{{
if has("gui_running")
  highlight Comment gui=NONE
  set guioptions-=T
  set guioptions-=m

  "OS specific {{{
  if has("win32") || has("win64")
    set encoding=utf8
    cd ~
    autocmd GUIEnter * simalt ~x
    set directory+=$HOME
    set guifont=Lucida\ Console:h12
  elseif has("unix")
    let os = substitute(system("uname"), "\n", "", "g")
    if os ==# "Linux"
      silent! set guifont=Ubuntu\ Mono\ 14
    elseif os == "Darwin"
      silent! set guifont=Monaco:h16
    endif
  endif
  "}}}
endif
"}}}

"indentation and tabs {{{
set autoindent
set backspace=eol,indent,start
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround
set linebreak
"}}}

"statusline {{{
set laststatus=2
set statusline=%1*%{fugitive#statusline()}%*
set statusline+=%2*\ %f\ %* "filename
set statusline+=%y          "filetype
set statusline+=%m          "modified flag
set statusline+=%r          "read-only flag
set statusline+=\ %#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=%=          "move to right
set statusline+=%c:         "current column
set statusline+=%l/         "current line
set statusline+=%-10L       "total line
"}}}

"command entry {{{
set showcmd
set cmdheight=2
set wildmenu
"}}}

"searching {{{
set ignorecase
set smartcase
set incsearch
"set highlighting search terms...
set hlsearch
"...but don't do it every time we source the vimrc
nohlsearch
nnoremap <silent> <leader>- :nohlsearch<CR><C-l>
"}}}

"bracket matching {{{
set showmatch
"}}}

"automatically update files on change {{{
set autoread
"}}}

"allow hidden buffers {{{
set hidden
"}}}

"autocmd {{{
if has('autocmd')
  augroup sign_column "{{{
    autocmd!
    "set default sign column for use with git gutter
    autocmd BufEnter * sign define dummy
    autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
    highlight SignColumn ctermbg=NONE guibg=NONE
  augroup END
  "}}}

  augroup white_space "{{{
    autocmd!
    "remove extra whitespace on save
    autocmd BufWritePre * call StripTrailingWhitespace()
  augroup END
  "}}}

  augroup filetype_gitcommit "{{{
    autocmd!
    "special settings for git commits
    autocmd FileType gitcommit set spell
  augroup END
  "}}}

  augroup filetype_vim "{{{
    autocmd!
    "set the folding method
    autocmd FileType vim setlocal foldmethod=marker nofoldenable
  augroup END
  "}}}

  augroup filetype_wlpp "{{{
    autocmd!
    "wlpp is cpp subset
    autocmd BufEnter *.wlpp set filetype=cpp
  augroup END
  "}}}

  augroup filetype_md "{{{
    autocmd!
    "don't strip whitespace in markdown files
    autocmd FileType markdown let b:no_strip_whitespace=1
    "TODO: find out how to make this an iabbrev instead
    "(seems like auto-pairs breaks abbrevs)
    autocmd FileType markdown :inoremap <buffer> --- &mdash;
  augroup END
  "}}}
endif
"}}}

"white space characters {{{
if &listchars ==# 'eol:$'
  set listchars=tab:▸\ ,eol:¬
endif
"}}}

"extra space while scrolling {{{
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
"}}}

"change git gutter defaults {{{
let g:gitgutter_sign_modified = '+'
let g:gitgutter_sign_modified_removed = '+_'
highlight GitGutterChange ctermfg=green guifg=green
"}}}

"CtrlP custom ignore {{{
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](node_modules|coverage)',
  \ 'file': '',
  \ 'link': '',
  \ }
"}}}

"Syntastic C++11 {{{
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
"}}}

"JSX {{{
let g:jsx_ext_required = 0
"}}}

"Disable default folding in markdown {{{
let g:vim_markdown_folding_disabled = 1
"}}}

"Enable flow syntax highlighting {{{
let g:javascript_plugin_flow = 1
"}}}

"Enable JSDoc syntax highlighting {{{
let g:javascript_plugin_jsdoc = 1
"}}}

"Syntastic eslint checking {{{
let g:syntastic_javascript_checkers = ['eslint', 'flow']
"}}}

"Use local eslint, if you can {{{
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
    let g:syntastic_javascript_eslint_exec = local_eslint
endif
"}}}

"Use local flow, if you can {{{
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow = getcwd() . "/" . local_flow
endif
if executable(local_flow)
    let g:syntastic_javascript_flow_exec = local_flow
endif
"}}}

"plugin mappings {{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>t\| :Tab/\|<CR>
nnoremap <silent> <space> :ToggleBufExplorer<CR>
"}}}

"custom mappings {{{
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
inoremap jj <Esc>
nnoremap j gj
nnoremap k gk
nnoremap K i<CR><Esc>k$
nnoremap Y y$
nnoremap <silent> <leader>l :set list!<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <silent> <leader>ep :tabnew $HOME/.vim/plug.vim<CR>
nnoremap <silent> <leader>d :redraw!<CR>
nnoremap <silent> <leader>r :set relativenumber!<CR>
nnoremap <leader>sp :set spell!<CR>\|:echo "Spell: " . &spell<CR>
nnoremap <leader>sy :SyntasticToggleMode<CR>
nnoremap <leader>w :set wrap!<CR>\|:echo "Wrap: " . &wrap<CR>
nnoremap <leader>* :execute "%s/" . expand("<cword>") . "//gn"<CR><C-o>
set pastetoggle=<F5>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap [a :previous<CR>
nnoremap ]a :next<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
"}}}

"custom functions {{{
function! StripTrailingWhitespace()
  if exists('b:no_strip_whitespace')
    return
  endif
  %s/\s\+$//e
endfunction
"}}}

"avoid webpack livereload issues {{{
set backupcopy=yes
"}}}

"persistent undo {{{
if exists('+undodir')
    set undodir=$HOME/.vim/undodir
    set undofile
endif
"}}}

"put swap files in central location {{{
set directory=$HOME/.vim/swapdir
"}}}
