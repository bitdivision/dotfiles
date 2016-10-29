set nocompatible

set modelines=0

set tabstop=2
set shiftwidth=2
"set softtabstop=4
set smarttab
set expandtab

"Set to on for taglist plugin
filetype indent plugin on

set encoding=utf-8
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set relativenumber
"set undofile

"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

call pathogen#infect()

nnoremap <leader><space> :noh<cr>
nnoremap <leader>t :TaskList<cr>
nnoremap <silent><leader>n :set relativenumber!<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap <F5> :GundoToggle<CR>


set wrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=85

"Color scheme for terminal:
syntax on
set background=dark


function! UpdateVimRC()
 for server in split(serverlist())
     call remote_send(server, '<Esc>:source $HOME/.vim/.vimrc<CR>')
 endfor
endfunction


"removed colorscheme from terminal since colours don't work
colorscheme molokai

"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk


"Taglist Mappings
nnoremap <F8> :TlistToggle<CR>


set cindent 
set cpoptions-=J 

autocmd BufLeave,FocusLost * silent! wall

autocmd FileType autocmd BufWritePre *.js :%s/\s\+$//e


let mapleader = ","

"Source the vimrc if it has changed
augroup myvimrchooks
au!
    autocmd bufwritepost .vimrc call UpdateVimRC()
augroup END

let mapleader = ","

nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>p "+gP

set gfn=Envy\ Code\ R\ 10

set mouse=a

" Settings for VimClojure

let vimclojure#FuzzyIndent=1
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun=1
let vimclojure#NailgunClient = "/usr/local/bin"

"looks for tags directory recursively up the tree so we don't have to be in
"project root directory.
set tags=./tags;/

"F8 will build tags in the current working directory
map <F8> :!/usr/bin/ctags -R .<CR>

"Configure taglist.vim
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
map <F4> :TlistToggle<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim

au focusLost * silent! wa

"Fix the bug where clicks don't register on right side of screen
	set ttymouse=sgr


"Bloody python-mode linter defaults aren't sane
"
let g:pymode_lint = 0
let g:pymode_lint_ignore = "E203,E303,E501,E701"

"Function to allow diffs of file vs. filesystem
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"Remap uppercase W command for typos
:command WQ wq
:command Wq wq
:command W w
:command Q q


"Allow ALT + j,k  move a line up or down
"
nnoremap <C-A-j> :m .+1<CR>==
nnoremap <C-A-k> :m .-2<CR>==
inoremap <C-A-j> <Esc>:m .+1<CR>==gi
inoremap <C-A-k> <Esc>:m .-2<CR>==gi
vnoremap <C-A-j> :m '>+1<CR>gv=gv
vnoremap <C-A-k> :m '<-2<CR>gv=gv
