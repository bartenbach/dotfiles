" basic configuration settings
set encoding=utf-8
set backspace=indent,eol,start
set number
set cursorcolumn
set cc=80
set expandtab
set visualbell
set t_vb=
set cursorline
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noautoindent
set relativenumber
filetype plugin indent on " required by rust.vim
if has('unnamedplus')
  set clipboard=unnamedplus
endif

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
"  Plug 'vimwiki/vimwiki' " good idea in theory but not using
call plug#end()

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" plugin options
let g:NERDTreeMinimalUI = 1
let g:rustfmt_autosave = 1
let g:rust_recommended_style = 1
let g:rust_cargo_check_all_features = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 10
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\u26A0"
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" nerdtree
autocmd BufEnter * if tabpagenr('$') == 1
      \ && winnr('$') == 1
      \ && exists('b:NERDTree')
      \ && b:NERDTree.isTabTree() | quit | endif

" functions
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" custom mappings
inoremap <F5>          <C-x><C-f>
nnoremap <leader>g     :Goyo<CR>
nnoremap <leader>h     :nohls<CR>
nnoremap <leader>l     :execute ':!pdflatex % > /dev/null'<CR>
nnoremap <leader>n     :NERDTreeVCS<CR>
nnoremap <leader>r     :RustRun<CR>
nnoremap <leader>w     :call TrimWhiteSpace()<CR>
nnoremap <leader><esc> :NERDTreeToggle<CR>
nnoremap <leader><tab> <C-w>w

" airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" vimwiki
let g:vimwiki_list = [{'path:': '~/doc/journal/entries/',
      \ 'path_html': '~/doc/journal/html/',
      \ 'syntax': 'markdown',
      \ 'ext': '.md'}]

" rust

" trailing whitespace detection
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" filetype autocommands
autocmd FileType rust setlocal makeprg=rustc\ %\ &&\ ./%:r
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType latex,markdown,tex,text
      \ setlocal spell spelllang=en wrap linebreak

" rust formatter
autocmd BufWritePost,FileWritePost *.rs :RustFmt

" xmonad auto recompiler
autocmd BufWritePost,FileWritePost xmonad.hs !~/.xmonad/xmonad-x86_64-linux
      \ --recompile; ~/.xmonad/xmonad-x86_64-linux --restart
" xrdb auto merger
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults

" :commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command -nargs=0 HELP h | only # boomer friendly help
command -nargs=1 -complete=help H h <args> | only

" colorscheme
set bg=dark
set termguicolors
colorscheme PaperColor
hi Normal guibg=NONE ctermbg=NONE
