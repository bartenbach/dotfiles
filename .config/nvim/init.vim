" basic configuration settings
set encoding=utf-8
set backspace=indent,eol,start
set number
set nocompatible
"set cursorcolumn only useful when aligning things, otherwise distracting
set cursorline
set colorcolumn=80
set expandtab
set visualbell
set t_vb=
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noautoindent
set updatetime=100 " gitgutter speed hack
"set relativenumber this is just not for me...
set conceallevel=2
syntax on
filetype plugin on
filetype plugin indent on " required by rust.vim
" sync clipboard with X11
if has('unnamedplus')
  set clipboard=unnamedplus
endif

" the leader key - this is your personal leader key for miscellaneous commands
let mapleader = ";"

" this will turn off the vim file browser banner if you open a directory with vim
"let g:netrw_banner = 0

call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'cespare/vim-toml', { 'branch': 'main' }
  Plug 'itspriddle/vim-shellcheck'
  Plug 'cocopon/iceberg.vim'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'junegunn/goyo.vim'
  Plug 'ron-rs/ron.vim'
  Plug 'rust-lang/rust.vim'
  Plug 'scrooloose/syntastic'
  Plug 'vim-airline/vim-airline'
  Plug 'vimwiki/vimwiki'
  Plug 'wakatime/vim-wakatime'
call plug#end()

" Required for operations modifying multiple buffers like rename.
set hidden

" rust language server - have not tested this yet!
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

" rust plugin
let g:rustfmt_autosave = 1
"let g:rustfmt_options = "--edition 2018"
let g:rust_recommended_style = 1
let g:rust_cargo_check_all_features = 1

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 10
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\u26A0"
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" gitgutter
let g:gitgutter_highlight_lines = 1

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
nnoremap <c-s>        <c-g>u<Esc>[s1z=`]a<c-g>u
inoremap <c-s>        <c-g>u<Esc>[s1z=`]a<c-g>u

" this is an easier binding for filename comletion in insert mode
inoremap <F2>          <C-x><C-f>
nnoremap <leader>t     :VimwikiTOC<CR>
nnoremap <leader>T     :VimwikiTable<CR>
nnoremap <leader>G     :VimwikiDiaryGenerateLinks<CR>
nnoremap <leader>g     :Goyo<CR>
nnoremap <leader>I     :VimwikiIndex<CR>
nnoremap <leader>N     :VimwikiMakeDiaryNote<CR>
nnoremap <leader>h     :nohls<CR>
nnoremap <leader>H     :VimwikiIndex<CR> " think 'home'
nnoremap <leader>l     :execute ':!pdflatex % > /dev/null'<CR>
nnoremap <leader>w     :call TrimWhiteSpace()<CR>
nnoremap <leader><tab> <C-w>w

" airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" vimwiki
let g:vimwiki_list = [{'path': '~/doc/wiki', 'syntax': 'markdown'
      \, 'ext': '.md', 'auto_toc': 1, 'links_space_char': '_', 'maxhi': 1
      \, 'auto_diary_index': 1 }]
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_auto_header = 1
:hi VimwikiHeader1 guifg=#FF0000
:hi VimwikiHeader2 guifg=#00FF00
:hi VimwikiHeader3 guifg=#0000FF
:hi VimwikiHeader4 guifg=#FF00FF
:hi VimwikiHeader5 guifg=#00FFFF
:hi VimwikiHeader6 guifg=#FFFF00
let g:vimwiki_global_ext = 0
let g:diary_caption_level = 2
let g:list_margin = 0

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
      \ setlocal spell spelllang=en wrap linebreak textwidth=80

autocmd BufWritePost,FileWritePost *.rs :RustFmt
autocmd BufWritePost,FileWritePost xmonad.hs !xmonad --recompile; xmonad --restart
autocmd BufWritePost,FileWritePost xmobarrc !xmonad --recompile; xmonad --restart
autocmd BufWritePost,FileWritePost .Xdefaults !xrdb ~/.Xdefaults
autocmd BufWritePost,FileWritePost *.mod !cafeobj -batch %

" :commands
command SAVE :execute ':silent w !sudo tee % > /dev/null' | :edit!
command -nargs=0 HELP h | only # boomer friendly help
command -nargs=1 -complete=help H h <args> | only

" colorscheme
let g:tokyonight_style = "night"
set bg=dark
set termguicolors
"colorscheme iceberg
colorscheme tokyonight
hi Normal guibg=NONE ctermbg=NONE
