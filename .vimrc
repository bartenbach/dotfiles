" basic configuration settings
set encoding=utf-8
set backspace=indent,eol,start
set number
set cursorcolumn
set expandtab
set cursorline
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set relativenumber

let mapleader = ";"
let g:netrw_banner = 0

" vim-plug
call plug#begin()
  Plug 'tpope/vim-fugitive'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/syntastic'
  Plug 'vim-airline/vim-airline'
  Plug 'itspriddle/vim-shellcheck'
  Plug 'junegunn/goyo.vim'
call plug#end()

" nerdtree bindings
nnoremap <leader><TAB> :NERDTreeFocus<CR>
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1

" airline
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" autocommands
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
autocmd BufWritePost,FileWritePost *.hs !~/.xmonad/xmonad-x86_64-linux --recompile; ~/.xmonad/xmonad-x86_64-linux --restart
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd FileType latex,markdown setlocal spell


" commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" colorscheme stuff
set bg=dark
set termguicolors
colorscheme PaperColor
hi Normal guibg=NONE ctermbg=NONE
