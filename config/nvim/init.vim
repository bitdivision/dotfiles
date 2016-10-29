call plug#begin()

Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'git@github.com:sickill/vim-monokai.git'
Plug 'https://github.com/smancill/conky-syntax.vim'
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/ElmCast/elm-vim.git'
Plug 'https://github.com/Valloric/YouCompleteMe'
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

call plug#end()

syntax enable
colorscheme monokai

" Enable powerline fonts for airline. Must install powerline fonts first
" Doesn't seem to work well. Fix might be to change fontsize to odd number in
" Xdefaults?
" https://github.com/vim-airline/vim-airline/wiki/FAQ
"let g:airline_powerline_fonts = 1

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

set smarttab
set expandtab

set shiftwidth=2
set tabstop=2
set softtabstop=4

hi Normal ctermbg=none
hi NonText ctermbg=none


" NeoMake config for building rust on the fly.
let g:neomake_echo_current_error=1
let g:neomake_verbose=0
autocmd! BufWritePost *.rs Neomake
autocmd FileType c,cpp,rust,js autocmd BufWritePre <buffer> :%s/\s\+$//e

" Elm Stuff
let g:elm_format_autosave = 1

let g:ycm_rust_src_path="/home/bitdivision/rust/rust-master/src/"
