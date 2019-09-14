call plug#begin()

"Vim QoL Plugins
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'vim-airline/vim-airline'
Plug 'sickill/vim-monokai'
"Plug 'benekastah/neomake'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'vimwiki/vimwiki'

Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'smancill/conky-syntax.vim'

" Host specific Plugins
if hostname() == "ArchBox"
  " YouCompleteMe for rust. Need to run setup.py with rust enabled to work
  Plug 'https://github.com/Valloric/YouCompleteMe'
endif

call plug#end()

syntax enable

" Tab stuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

let mapleader = ","

" Installed by vim plug
colorscheme monokai

" Enable powerline fonts for airline. Must install powerline fonts first
" Doesn't seem to work well. Fix might be to change fontsize to odd number in
" Xdefaults?
" https://github.com/vim-airline/vim-airline/wiki/FAQ
"let g:airline_powerline_fonts = 1

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Read js files as jsx for react stuff
autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx

" Think this is for transparent terminal?
hi Normal ctermbg=none
hi NonText ctermbg=none

" Move text and rehighlight -- vim tip_id=224 
vnoremap > ><CR>gv 
vnoremap < <<CR>gv 

" Remove trailing whitespace on save
autocmd BufWritePre *.js,*.h,*.c :%s/\s\+$//e

" Leader Commands

" Fugitive mappings
nmap <Leader>gc :Gcommit
nmap <Leader>gp :Gpush

" VimRC
nnoremap <Leader>v :vsplit $MYVIMRC<CR>

" Show Linenumbers
nnoremap <Leader>l :set invnumber<CR>

" Astyle command to sort out bad C
command CStyle %!astyle --style=java --align-pointer=middle --add-brackets --break-blocks

" Host specific Configs
"if hostname() == "ArchBox"
"  " NeoMake config for building rust on the fly.
"  let g:neomake_echo_current_error=1
"  let g:neomake_verbose=0
"  autocmd! BufWritePost *.rs Neomake
"  autocmd FileType c,cpp,rust,js autocmd BufWritePre <buffer> :%s/\s\+$//e
"  let g:ycm_rust_src_path="/home/bitdivision/rust/rust-master/src/"
"endif

" VimWiki Options
" auto update ToC
let g:vimwiki_list = [{'path': '~/vimwiki/', 'auto_toc': 1}]

" Copy to system clipboard
" On linux, best to install xclip to provide clipboard to vim
"set clipboard=unnamedplus

vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

set mouse=a

set hidden 

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
