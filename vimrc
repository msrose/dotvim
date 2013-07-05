set nocompatible
if !exists('g:loaded_pathogen')
  execute pathogen#infect()
endif
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax on
endif
set number
set history=1000
set t_Co=256
colorscheme made_of_code
highlight WarningMsg ctermbg=red guibg=red
highlight User1 ctermbg=blue ctermfg=black guibg=blue guifg=white
highlight User2 ctermfg=green ctermbg=darkgray guifg=green guibg=NONE

set autoindent
set backspace=eol,indent,start
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround
set linebreak

"statusline
set laststatus=2
set statusline=%1*%{fugitive#statusline()}%*
set statusline+=%2*\ %f\ %* "filename
set statusline+=%y          "filetype
set statusline+=%m          "modified flag
set statusline+=%r          "read-only flag
set statusline+=\ %#warningmsg#%{SyntasticStatuslineFlag()}%*
set statusline+=%=          "move to right
set statusline+=%l/         "current line
set statusline+=%-10L       "total line

"command entry
set showcmd
set cmdheight=2
set wildmenu

"searching
set ignorecase
set smartcase
set hlsearch
set incsearch
nnoremap <silent> <leader>- :nohlsearch<CR><C-l>

"bracket matching
set showmatch

"autmatically update files on change
set autoread

"autocmd
if has('autocmd')
  "set default sign column for use with git gutter
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
  highlight SignColumn ctermbg=NONE guibg=NONE

  "remove extra whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  "special settings for git commits
  autocmd FileType gitcommit set spell formatoptions+=a
endif

"white space characters
if &listchars ==# 'eol:$'
  set listchars=tab:▸\ ,eol:¬
endif

"extra space while scrolling
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

"change git gutter defaults
let g:gitgutter_sign_modified = '+'
let g:gitgutter_sign_modified_removed = '+_'
highlight GitGutterChange ctermfg=green guifg=green

"plugin mappings
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>t :TlistToggle<CR>
nnoremap <silent> <leader>g :GundoToggle<CR>

"custom mappings
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
nnoremap <silent> <leader>v :source $MYVIMRC<CR>
nnoremap <silent> <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <silent> <leader>r :set relativenumber!<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap - ddp
nnoremap _ ddkP
