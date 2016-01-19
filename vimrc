call plug#begin('~/.vim/plugged')
Plug 'fatih/molokai'
Plug 'tpope/vim-sensible'
Plug 'csexton/trailertrash.vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'for': 'go' }

if has('python')
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
endif

call plug#end()

set nocompatible

set ruler
set laststatus=2
set statusline=%<%f%h%m%r%=%l,%c\ %P

" disable mouse (enabled by default with neovim)
set mouse=

filetype plugin indent on
syntax on
colorscheme molokai

set laststatus=2

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Indentation
set expandtab       "Tabs to spaces
set smarttab
set shiftwidth=4
set softtabstop=4
set linebreak
set autoindent

" If we are in a tmux session, rename current window
if $TMUX != ''
    autocmd VimEnter * silent !tmux rename-window `basename %`
    autocmd VimLeave * silent !tmux rename-window `basename $SHELL`
endif

" Better indent
vmap > >gv
vmap < <gv

" Search
set ignorecase      " Ignore case of searches
set smartcase       " Search with case only if needed
set hlsearch        " Highlight search while typing

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Press enter after search to clean highlighting
nnoremap <cr> :noh<CR><CR>:<backspace>

" Start interactive in visual mode
if exists(":Tabularize")
	vmap <Enter> :Tabularize /
endif

" Go vim - :help go-settings
let g:go_fmt_command = "goimports"
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_doc_command = "godoc"
let g:go_doc_keywordprg_enabled = 0 " handled by .vim/ftplugin/go.vim

let mapleader=","
set listchars=tab:▸\ ,eol:¬,trail:·

",l
nmap <leader>l :set list!<CR>

" paste toggle
nnoremap <F12> :set invpaste paste?<CR>
set pastetoggle=<F12>
set showmode

" autocmd paste mode
augroup paste_helper
    " Clear the autocmd
    autocmd!
    " set not paste in normal mode
    autocmd InsertLeave * set nopaste
augroup END

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ],
      \              ['percent'],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

" Reload conf
if !exists("*Vimrc_update()")
    function! Vimrc_update()
        source $MYVIMRC
        echom 'vimrc reloaded'
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endfunction
endif
