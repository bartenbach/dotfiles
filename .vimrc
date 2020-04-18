"
" ~/.vimrc - Vim Configuration File
"  Name: ~/.vimrc 
"  Author: Blake Bartenbach
"
"set tabstop=2 " number of spaces that pressing the tab key inserts
set showmatch " show matching brackets
set wrapscan " when searching for text, search entire file
set mousehide " hide mouse cursor when typing
set number " show line numbers
set cursorcolumn " highlight the screen column of the cursor - easier to spot
set cursorline " highlight the screen line of the cursor - easier to spot
set colorcolumn=120 " highlight column 80 as a column limit for us
set scrolloff=0 " 999 will make cursor always be in center of window! :) emacs?
set spell " spell checking
set helplang=en " language of help documentation
set spelllang=en  " spelling language english
set spellsuggest=best " suggestion quality...can also be fast
set title " set windows title to filename, path, and - VIM
set showmode " show at bottom INSERT/VISUAL/REPLACE
set ruler " show line and column number of the cursor
set vb  " set the god forsaken visual bell to stop the beeping
set noerrorbells " do not ring an error bell on errors
set undolevels=100 "steps to remember when using undo / this is default
"set shiftwidth=2 " spaces to use per tab
"set softtabstop=2
set expandtab " replace tabs with spaces
set smartindent
set modeline " parse modelines in files.  syntax, spacing, etc
set write " allows the writing of files
set backup " make a backup before overwriting any file
set backupdir=$HOME/.vim/bak " where to store our backups
set backupext=.bak " extension to give backups
set swapfile " turn on a swap file for recovery reasons
set dir=$HOME/.vim/swp " where to save swap files
set history=20 " default number of previous commands to remember
"set shell=/bin/zsh " what shell are we using
set errorfile=$HOME/.vim/error.log " where to write encountered errors to
set encoding=utf-8 "set the file encoding
set background=light
set backspace=indent,eol,start
set t_Co=256 " 256 color terminal
set laststatus=2
syntax on " turn on syntax highlighting
colo papercolor "colorscheme

" vim-plug
call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#sources#go#gocode_binary = '/Users/alureon/code/go/bin/gocode'
let g:python3_host_prog = '/usr/local/bin/python3'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
call plug#end()

" Go plugin shortcuts
map <F2> :GoBuild <CR>
map <F9> :GoLint <CR>
map <F12> :GoRun <CR>
