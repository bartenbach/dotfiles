" basic configuration settings
set encoding=utf-8
set backspace=indent,eol,start
set number
set cursorcolumn
set expandtab
set visualbell
set t_vb=
set cursorline
set tabstop=2 " please, for the love of GOD
set shiftwidth=2
set softtabstop=2
set noautoindent
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set relativenumber

let mapleader = ";"
let g:netrw_banner = 0

" vim-plug
call plug#begin()
  Plug 'rust-lang/rust.vim'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/syntastic'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'vim-airline/vim-airline'
  Plug 'cespare/vim-toml', { 'branch': 'main' }
  Plug 'itspriddle/vim-shellcheck'
  Plug 'junegunn/goyo.vim'
  Plug 'wakatime/vim-wakatime'
call plug#end()

" trailing whitespace detection
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 10
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\u26A0"
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" nerdtree
nnoremap <leader>n     :NERDTreeToggle<CR>
nnoremap <leader>v     :NERDTreeVCS<CR>
nnoremap <leader>g     :Goyo<CR>
nnoremap <leader><tab> <C-w>w
nnoremap <leader><esc> :NERDTreeToggle<CR>
"nnoremap <leader>r compile latex
let g:NERDTreeMinimalUI = 1
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" rust
let g:rustfmt_autosave = 1
let g:rust_recommended_style = 1
nnoremap <leader>r :RustRun<CR>
autocmd FileType rust setlocal makeprg=rustc\ %\ &&\ ./%:r

" autocommands
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
autocmd BufWritePost,FileWritePost *.hs !~/.xmonad/xmonad-x86_64-linux --recompile; ~/.xmonad/xmonad-x86_64-linux --restart
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType *.toml setlocal syntax=ini
autocmd FileType latex,markdown,tex setlocal spell spelllang=en

" commands
" for the times we forget sudo
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :edit! && ':q'
" boomer friendly help
command -nargs=0 HELP h | only
" fullscreen help browsing for topic <args>
command -nargs=1 -complete=help H h <args> | only

" colorscheme stuff
set bg=dark
set termguicolors
colorscheme PaperColor
hi Normal guibg=NONE ctermbg=NONE
