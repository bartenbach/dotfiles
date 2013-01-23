" Name:        proxa256.vim (xoria 256 fork)
" Version:     0.0.2
" Author:      proxa
" Description: Vim color file
" Supports:    256-color Terminal only!
" Colors:      http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

if &t_Co != 256 && ! has("gui_running")
  colo default
  finish
endif

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "proxa256"

"" General colors
hi Normal         ctermfg=252  ctermbg=233  cterm=none 
hi CursorColumn                ctermbg=235
hi Cursor         ctermfg=11   ctermbg=11   cterm=reverse
hi CursorLine                  ctermbg=234
hi CursorLineNr   ctermfg=246
hi ColorColumn                 ctermbg=234
hi FoldColumn     ctermfg=248  ctermbg=bg 
hi Folded         ctermfg=255  ctermbg=60 
hi IncSearch      ctermfg=0    ctermbg=223
hi MoreMsg        ctermfg=246  ctermbg=18
hi NonText        ctermfg=248              
hi Pmenu          ctermfg=0    ctermbg=246
hi PmenuSbar                   ctermbg=243
hi PmenuSel       ctermfg=0    ctermbg=243
hi PmenuThumb                  ctermbg=252
hi Search         ctermfg=0    ctermbg=149
hi SignColumn     ctermfg=248
hi SpecialKey     ctermfg=77 
hi StatusLine                  ctermbg=239 
hi StatusLineNC                ctermbg=237  cterm=none
hi TabLine        ctermfg=fg   ctermbg=242  cterm=underline
hi TabLineFill    ctermfg=fg   ctermbg=242  cterm=underline
hi VertSplit      ctermfg=237  ctermbg=12   cterm=none
hi Visual         ctermfg=24   ctermbg=153
hi VIsualNOS      ctermfg=24   ctermbg=153  cterm=none
hi WildMenu       ctermfg=0    ctermbg=184  

"" Syntax highlighting
hi Comment        ctermfg=240
hi Constant       ctermfg=228
hi Error          ctermfg=1    ctermbg=bg   cterm=none
hi ErrorMsg       ctermfg=1    ctermbg=bg   cterm=none
hi Identifier     ctermfg=141               cterm=none
hi Ignore         ctermfg=238
hi LineNr         ctermfg=237
hi MatchParen     ctermfg=255  ctermbg=68
hi Number         ctermfg=180 
hi PreProc        ctermfg=150 
hi Special        ctermfg=174
hi Statement      ctermfg=74                cterm=none
hi Todo           ctermfg=0    ctermbg=184
hi Type           ctermfg=146               cterm=none
hi Underlined     ctermfg=39                cterm=underline

" TODO test for todo color
"" Special
hi Todo           ctermfg=15   ctermbg=93
hi diffAdded      ctermfg=150
hi diffRemoved    ctermfg=174
hi diffAdd        ctermfg=bg   ctermbg=151
hi diffDelete     ctermfg=bg   ctermbg=186  cterm=none
hi diffDelete     ctermfg=bg   ctermbg=246  cterm=none
hi diffChange     ctermfg=bg   ctermbg=181
hi diffText       ctermfg=bg   ctermbg=174  cterm=none

" vim: set expandtab tabstop=2 shiftwidth=2 smarttab softtabstop=2:
