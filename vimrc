"basic settings {{{
set nocompatible

source $HOME/.vim/plug.vim "load plugin list
source $HOME/.vim/helpers.vim

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax on
endif
set number
set history=1000
set noerrorbells visualbell t_vb=
"}}}

"colorscheme {{{
set t_Co=256
let s:colors_name = 'made_of_code' "Others: 'tender', '256-grayvim'
execute 'colorscheme ' . s:colors_name
let g:colors_name = s:colors_name

"overrides for colorschemes
if s:colors_name ==# '256-grayvim'
  highlight PreProc term=bold cterm=bold ctermfg=160 guifg=#f8f8f8
endif
if s:colors_name ==# 'made_of_code'
  "Hacks to get typescript to look okay-ish, but has some weird side-effects
  highlight Special ctermfg=203 guifg=#ff3854
  highlight Keyword ctermfg=81 guifg=#6fd3ff
  call MatchHighlight('Label', 'Normal', ['ctermfg', 'guifg'])
endif
highlight WarningMsg ctermbg=red guibg=red
"always have a black background because other colors look bad
highlight Normal ctermbg=black guibg=black
"use LineNr bg default from made_of_code
highlight LineNr ctermbg=17 guibg=#212231
"}}}

"GUI settings {{{
if has('gui_running')
  augroup gui
    autocmd!
    autocmd GUIEnter * set visualbell t_vb=
  augroup END

  "no italic comments
  highlight Comment gui=NONE

  set guioptions-=T "no toolbar
  set guioptions-=m "no menu
  set guioptions-=r "no right scroll
  set guioptions-=L "no left scroll

  "OS specific
  if has('win32') || has('win64')
    set encoding=utf8
    cd ~
    augroup windows
      autocmd!
      autocmd GUIEnter * simalt ~x
    augroup END
    set directory+=$HOME
    set guifont=Lucida\ Console:h12
  elseif has('unix')
    let os = substitute(system('uname'), "\n", '', 'g')
    if os ==# 'Linux'
      silent! set guifont=Ubuntu\ Mono\ 14
    elseif os ==# 'Darwin'
      silent! set guifont=Monaco:h14
    endif
  endif
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
highlight StatusLine ctermfg=white guifg=white
highlight User1 ctermbg=blue ctermfg=black guibg=blue guifg=white
highlight User2 ctermfg=green ctermbg=darkgray guifg=green guibg=NONE
set laststatus=2
set statusline=%1*%{fugitive#statusline()}%*
set statusline+=%2*\ %f\ %* "filename
set statusline+=%y          "filetype
set statusline+=%m          "modified flag
set statusline+=%r          "read-only flag
set statusline+=\ %#warningmsg#%{LinterStatus()}%*
set statusline+=%=          "move to right
set statusline+=%{gutentags#statusline()}
set statusline+=\ %c:       "current column
set statusline+=%l/         "current line
set statusline+=%-10L       "total line
"}}}

"miscellaneous options {{{

"command entry
set showcmd
set cmdheight=2
set wildmenu

"searching
set ignorecase
set smartcase
set incsearch
set hlsearch "set highlighting search terms...
nohlsearch   "but don't do it every time we source the vimrc

"bracket matching
set showmatch

"automatically update files on change
set autoread

"allow hidden buffers
set hidden

"white space characters
if &listchars ==# 'eol:$'
  set listchars=tab:▸\ ,eol:¬
endif

"extra space while scrolling
if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

"avoid webpack livereload issues
set backupcopy=yes

"persistent undo
if has('persistent_undo')
  set undodir=$HOME/.vim/undodir
  set undofile
endif

"put swap files in central location
set directory=$HOME/.vim/swapdir

"highlight at 80 chars
if exists('+colorcolumn')
  set colorcolumn=80
endif

"delete comment character when joining
set formatoptions+=j

"for speed, don't search included files when auto-completing
set complete-=i

"no redraw during macro execution
set lazyredraw

"signcolumn
if has('signs')
  set signcolumn=yes
  "make signcolumn the same background color as line numbers
  call MatchHighlight('SignColumn', 'LineNr', ['ctermbg', 'guibg'])
endif

"}}}

"autocmd {{{
if has('autocmd')
  augroup white_space "{{{
    autocmd!
    "remove extra whitespace on save
    autocmd BufWritePre * call StripTrailingWhitespace()
  augroup END
  "}}}

  augroup filetype_gitcommit "{{{
    autocmd!
    "special settings for git commits
    autocmd FileType gitcommit set spell completefunc=emoji#complete
  augroup END
  "}}}

  augroup filetype_pullrequest "{{{
    autocmd!
    "special settings for pull requests (hub CLI)
    autocmd FileType pullrequest set spell completefunc=emoji#complete
  augroup END
  "}}}

  augroup filetype_vim "{{{
    autocmd!
    "set the folding method
    autocmd FileType vim setlocal foldmethod=marker nofoldenable
  augroup END
  "}}}

  augroup filetype_md "{{{
    autocmd!
    "don't strip whitespace in markdown files
    autocmd FileType markdown let b:no_strip_whitespace=1
    autocmd FileType markdown set completefunc=emoji#complete
  augroup END
  "}}}

  augroup quickfix "{{{
    autocmd!
    "use <C-t> to open quickfix entry in new tab
    autocmd FileType qf nnoremap <buffer> <C-t> <C-W><Enter><C-W>T
    "always show quickfix window at full width
    autocmd FileType qf wincmd J
  augroup END
  "}}}
endif
"}}}

"plugin settings {{{

let NERDTreeShowHidden=1

"configure vim-signify
set updatetime=100
let g:signify_sign_change = '~'
highlight SignifySignAdd cterm=bold ctermfg=119
highlight SignifySignDelete cterm=bold ctermfg=167
highlight SignifySignChange cterm=bold ctermfg=227
"give signify signs the same background as the sign column
for group in ['Add', 'Delete', 'Change']
  call MatchHighlight('SignifySign' . group, 'SignColumn', ['ctermbg', 'guibg'])
endfor

"FZF command prefix
let g:fzf_command_prefix = 'FZF'

"files to generate tags for
let g:gutentags_file_list_command = 'git ls-files'

"directory in which to store tag files
let g:gutentags_cache_dir = $HOME . '/.vim/tagsdir'

"localvimrc settings
let g:localvimrc_persistent = 1

"ale pylint
let g:ale_python_pylint_change_directory = 0

"Make ale use pylint correctly
let g:ale_python_pylint_change_directory = 0

"Make ale show linter name
let g:ale_echo_msg_format = '[%linter%] %code: %%s'

"Use eslint_d if it exists
if executable('eslint_d')
  let g:ale_javascript_eslint_executable = 'eslint_d'
  let g:ale_javascript_eslint_use_global = 1
endif

"Make ale use underlines instead of highlights
highlight ALEError ctermbg=none cterm=underline
"}}}

"custom commands {{{

"git grep with fugitive and open quickfix window
command! -nargs=+ Gg execute 'silent Ggrep!' <q-args> | cwindow | redraw!

"git grep with fzf for fuzzy searching through contents
command! -bang -nargs=* FZFGg
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

"writing mode
command! WriteOn Goyo | Limelight
command! WriteOff Goyo! | Limelight! | source $MYVIMRC

"}}}

"plugin mappings {{{
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader>n :NERDTreeFind<CR>
nnoremap <silent> <C-p> :FZFGFiles<CR>
nnoremap <silent> <C-b> :FZFBuffers<CR>
nnoremap <silent> <leader>f :FZFGg<CR>
nnoremap <silent> <leader>g :FZFGFiles?<CR>
nnoremap <silent> <leader>t :Tagbar<CR>
nnoremap <silent> <leader>be :ToggleBufExplorer<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <leader>p :ALEFix eslint<CR>
nnoremap <C-f> :Gg <cword><CR>
"}}}

"custom mappings {{{
inoremap jj <Esc>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap j gj
nnoremap k gk
nnoremap K i<CR><Esc>k$
nnoremap Y y$
nnoremap <Backspace> <C-^>
nnoremap <silent> <leader>l :set list!<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <silent> <leader>ep :tabnew $HOME/.vim/plug.vim<CR>
nnoremap <silent> <leader>r :set relativenumber!<CR>
nnoremap <silent> <leader>c :call QuickfixToggle()<CR>
nnoremap <silent> <leader>y :call SynGroup()<CR>
nnoremap <leader>sp :set spell!<CR>\|:echo "Spell: " . &spell<CR>
nnoremap <leader>w :set wrap!<CR>\|:echo "Wrap: " . &wrap<CR>
nnoremap <silent> <leader>- :nohlsearch<CR><C-l>
nnoremap <silent> <leader>h :help <C-r><C-w><CR>
set pastetoggle=<F5>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
let s:cycle_shortcut_mapping = { 'a': '', 'b': 'b', 'q': 'c', 't': 't', 'l': 'L' }
for [shortcut, command_prefix] in items(s:cycle_shortcut_mapping)
  execute 'nnoremap [' . toupper(shortcut) . ' :' . command_prefix . 'first<CR>'
  execute 'nnoremap [' . shortcut . ' :' . command_prefix . 'previous<CR>'
  execute 'nnoremap ]' . toupper(shortcut) . ' :' . command_prefix . 'last<CR>'
  execute 'nnoremap ]' . shortcut . ' :' . command_prefix . 'next<CR>'
endfor
"}}}
