" basic configuration settings
set syntax=on
set number
set cursorcolumn
set cursorline
set clipboard=unnamedplus
set relativenumber

" stupid netrw banner
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" vim-plug
call plug#begin()

call plug#end()

" airline
let g:airline_powerline_fonts = 1


" autocommands
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
autocmd BufWritePost,FileWritePost *.hs !~/.xmonad/xmonad-x86_64-linux --recompile; ~/.xmonad/xmonad-x86_64-linux --restart
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" colorscheme stuff
set bg=dark
set termguicolors
colorscheme PaperColor
