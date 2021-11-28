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
  Plug 'airblade/vim-gitgutter'
  Plug 'cespare/vim-toml', { 'branch': 'main' }
  Plug 'itspriddle/vim-shellcheck'
  Plug 'junegunn/goyo.vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'mattn/calendar-vim'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'junegunn/fzf'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'preservim/nerdtree'
  Plug 'rust-lang/rust.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/syntastic'
  Plug 'vim-airline/vim-airline'
  Plug 'vimwiki/vimwiki'
  Plug 'wakatime/vim-wakatime'
"  Plug '~/code/vim-wakatime' need to fix XDG on this...
call plug#end()

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'] }

nmap <F7> <Plug>(lcn-menu)
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)

" wakatime
let g:wakatime_home="~/.config/wakatime"

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

" disable the useless F1 key that no one would ever use
" and only proves an annoyance
:nmap <F1> :echo<CR>
:imap <F1> <C-o>:echo<CR>

" custom mappings

" this is cryptic and needs explaining - so spelling replacement in vim is
" arguably not great. this binds ctrl+s in both normal and insert mode to
" replace the last (most recent previous) detected spelling mistake with the
" first suggestion from vim's suggestion list. can be undone with 'u' as
" you would expect.
nnoremap <c-s>         <c-g>u<Esc>[s1z=`]a<c-g>u
inoremap <c-s>         <c-g>u<Esc>[s1z=`]a<c-g>u

" this is an easier binding for filename comletion in insert mode
inoremap <F5>          <C-x><C-f>

nnoremap <F12>         :VimwikiMakeDiaryNote<CR>
nnoremap <leader>g     :Goyo<CR>
nnoremap <leader>h     :nohls<CR>
nnoremap <leader>l     :execute ':!pdflatex % > /dev/null'<CR>
" i've never done this on purpose nnoremap <leader>n     :NERDTreeVCS<CR>
" not really needed anymore? nnoremap <leader>r     :RustRun<CR>
nnoremap <leader>w     :call TrimWhiteSpace()<CR>
" nnoremap <leader><esc> :NERDTreeToggle<CR>
nnoremap <leader><tab> <C-w>w

" airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" vimwiki
let g:vimwiki_list = [{'path': '~/doc/wiki', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

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
autocmd FileType latex,markdown,vimwiki,plaintex
      \ setlocal spell spelllang=en wrap linebreak

" rust formatter
autocmd BufWritePost,FileWritePost *.rs :RustFmt

" xmonad auto recompiler
autocmd BufWritePost,FileWritePost xmonad.hs !xmonad --recompile;
          \ xmonad --restart
" xrdb auto merger
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults
autocmd BufWritePost,FileWritePost *.mod !cafeobj -batch %

" :commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command -nargs=0 HELP h | only # boomer friendly help
command -nargs=1 -complete=help H h <args> | only

" colorscheme
set bg=dark
set termguicolors
colorscheme iceberg
hi Normal guibg=NONE ctermbg=NONE
