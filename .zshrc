# vim: ft=zsh
#
# ~/.zshrc
#  Author: proxa
#

#-------------------
# Interactive Check
#-------------------
[[ $- == *i* ]] || return

#-----------------
# General Options
#-----------------
#zstyle ':completion:*' completer _complete _ignored
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
#zstyle :compinstall filename '/home/proxa/.zshrc'
### If you want zsh's completion to pick up new commands in $path automatically
### comment out the next line and un-comment the following 5 lines
zstyle ':completion:::::' completer _complete _approximate
#_force_rehash() {
#  (( CURRENT == 1 )) && rehash
#  return 1 # Because we didn't really complete anything
#}
#zstyle ':completion:::::' completer _force_rehash _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes 

#------------------------------
# Personal Configuration Files
#------------------------------
local files
local file

files=( .aliases .zprompt )

for file in $files
  do
    [[ -r $file ]] && source ~/$file
  done

#------
# Less
#------
export LESS="-R -b-1 -J -i -M -W -#.01"
export LESSHISTFILE="$HOME/.hist/less_history"
export LESSHISTSIZE=100
export LESS_TERMCAP_mb=$'\e[0;31m'    # blink
export LESS_TERMCAP_md=$'\e[0;35m'    # bold
export LESS_TERMCAP_us=$'\e[0;94m'    # underline
export LESS_TERMCAP_so=$'\e[0;44;37m' # info box
export LESS_TERMCAP_me=$'\e[0m'       # end mode
export LESS_TERMCAP_se=$'\e[0m'       # end info box
export LESS_TERMCAP_ue=$'\e[0m'       # end underline

#-------------
# Zsh Modules
#-------------
autoload -Uz compinit promptinit colors
compinit
promptinit
colors

#-------------
# Zsh History
#-------------
HISTFILE=~/.hist/zsh_history
HISTSIZE=20
SAVEHIST=1000
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS BANG_HIST

#---------------
# Zsh Options
#---------------
unsetopt GLOBAL_RCS BEEP
setopt DVORAK PRINT_EXIT_VALUE BG_NICE NOTIFY APPEND_HISTORY EXTENDED_GLOB \
         LIST_TYPES IGNORE_EOF

#--------------
# Vim Bindings
#--------------
bindkey -v
