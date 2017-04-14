"
" ~/.vimrc - Vim Configuration File
"  Name: ~/.vimrc 
"  Author: Blake Bartenbach
"
"
set noloadplugins " i'm not using any vim plugins
set tabstop=2 " number of spaces that pressing the tab key inserts
set showmatch " show matching brackets
set nocompatible " turn off vi compatibility for vim features
set wrapscan " when searching for text, search entire file
set mousehide " hide mouse cursor when typing
"set ignorecase  " can be set to ignore case when doing searches
set number " show line numbers
"set hlsearch " highlight the previous search pattern
set cursorcolumn " highlight the screen column of the cursor - easier to spot
set cursorline " highlight the screen line of the cursor - easier to spot
set colorcolumn=80 " highlight column 80 as a column limit for us
set scrolloff=0 " 999 will make cursor always be in center of window! :) emacs?
set nospell " don't want spell checking on by default...only on demand
set helplang=en " language of help documentation
set spelllang=en  " spelling language english
set spellsuggest=best " suggestion quality...can also be fast
set winheight=50 " minimum number of lines for the current window for vim
set helpheight=50 " minimum number of lines for help to use
set title " set windows title to filename, path, and - VIM
set showmode " show at bottom INSERT/VISUAL/REPLACE
set ruler " show line and column number of the cursor
set noerrorbells " do not ring an error bell on errors
set visualbell " disable the beep when switching modes
set t_vb=
set undolevels=100 "steps to remember when using undo / this is default
set shiftwidth=2 " spaces to use per tab
set smarttab
set softtabstop=2
set expandtab " replace tabs with spaces
set smartindent
set cindent " enables automatic C program indenting
set modeline " parse modelines in files.  syntax, spacing, etc
set fileformat=unix " well, this aint windows
set write " allows the writing of files
set backup " make a backup before overwriting any file
set backupdir=$HOME/.vim/bak " where to store our backups
set backupext=.bak " extension to give backups
set noautowrite " do not autowrite files after vim commands
set noautoread " do not automatically read files if they have changed
set fsync " forces hard drives to spin up and write files after being written
set swapfile " turn on a swap file for recovery reasons
set dir=$HOME/.vim/swp " where to save swap files
set updatecount=200 " after 200 characters, update the swap file on disk
set updatetime=300000 " update swap file after 5 minutes of inactivity
set history=20 " default number of previous commands to remember
set shell=/bin/zsh " what shell are we using
set errorfile=$HOME/.vim/error.log " where to write encountered errors to
set encoding=utf-8 "set the file encoding
syntax on " turn on syntax highlighting
colo solarized " use my custom color file :)

" fix 256-color scheme problems in tmux
if &term =~ '256color'
  set t_ut=
endif

" solarized
let g:solarized_termcolors=256
set background=dark
