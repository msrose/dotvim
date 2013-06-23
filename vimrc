set nocompatible
if !exists('g:loaded_pathogen')
  execute pathogen#infect()
endif
filetype plugin indent on
syntax enable
set number
set history=1000
set t_Co=256
colorscheme made_of_code

set autoindent
set backspace=eol,indent,start
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set linebreak

"statusline
set laststatus=2
set statusline=%{fugitive#statusline()}
set statusline+=\ %F      "filename
set statusline+=\ -\ %y   "filetype
set statusline+=%=        "move to right
set statusline+=%l/       "current line
set statusline+=%-10L     "total line

"commands
set showcmd
set cmdheight=2
set wildmenu

"searching
set ignorecase
set smartcase
set hlsearch
set incsearch
"Use <C-L> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

"bracket matching
set showmatch

"autocmd
if has('autocmd')
  "set default sign column for use with git gutter
  autocmd BufEnter * sign define dummy
  autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
  highlight SignColumn ctermbg=none

  "remove extra whitespace on save
  autocmd BufWritePre * :%s/\s\+$//e

  "special settings for git commits
  autocmd FileType gitcommit set spell formatoptions+=a

  "resource this file upon any changes
  autocmd! BufWritePost .vimrc source $MYVIMRC
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
highlight GitGutterChange ctermfg=green

"leader mappings
nnoremap <silent> <leader>f :CommandTFlush<CR>\|:CommandT<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>t :TlistToggle<CR>
nnoremap <silent> <leader>l :set list!<CR>

"custom mappings
inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap : ;
nnoremap K i<CR><Esc>k$
nnoremap Y y$
