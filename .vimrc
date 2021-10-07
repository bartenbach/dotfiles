" basic configuration settings
set encoding=utf-8
set number
set cursorcolumn
set expandtab
set cursorline
if has('unnamedplus')
  set clipboard=unnamedplus
endif
set relativenumber

:let mapleader = ";"

" stupid netrw banner
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" vim-plug
call plug#begin()
  Plug 'tpope/vim-fugitive'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/syntastic'
  Plug 'vim-airline/vim-airline'
call plug#end()

" nerdtree bindings
nnoremap <leader><TAB> :NERDTreeFocus<CR>

" airline
let g:airline_powerline_fonts = 1

" autocommands
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
autocmd BufWritePost,FileWritePost *.hs !~/.xmonad/xmonad-x86_64-linux --recompile; ~/.xmonad/xmonad-x86_64-linux --restart
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" colorscheme stuff
set bg=dark
set termguicolors
colorscheme PaperColor
