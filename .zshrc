# vim: ft=zsh
#
# ~/.zshrc
#  Author: Blake Bartenbach
#

#-------------------
# Interactive Check
#-------------------
[[ $- == *i* ]] || return

#------------------
# Load Zsh Modules
#------------------
fpath=(~/.config/functions $fpath);
autoload -Uz compinit colors ~/.config/functions/proxy ; compinit ; colors

#-----------------
# General Options
#-----------------
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:::::' completer _complete _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes 
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^M' .accept-line

#---------------
# More For Less
#---------------
# less arguments moved to .aliases
export LESS='-#0.1 -R'
export LESSHISTFILE=~/.config/less_history
export LESSHISTSIZE=100
export LESS_TERMCAP_mb=$(printf '\e[0;31m')    # blink
export LESS_TERMCAP_md=$(printf '\e[0;35m')    # bold
export LESS_TERMCAP_us=$(printf '\e[0;94m')    # underline
export LESS_TERMCAP_so=$(printf '\e[0;44;37m') # info box
export LESS_TERMCAP_me=$(printf '\e[0m')       # end mode
export LESS_TERMCAP_se=$(printf '\e[0m')       # end info box
export LESS_TERMCAP_ue=$(printf '\e[0m')       # end underline

#------------------------------
# Personal Configuration Files
#------------------------------
local files
local file
files=(.aliases .zprompt .zprofile)
foreach file ($files) { 
  if [[ -r ~/${XDG_CONFIG_HOME}/$file ]] {
    source ~/${XDG_CONFIG_HOME}/$file
  }
}

#-----------
# Dircolors
#-----------
if [[ -r ~/.config/.dircolors ]] && type -p dircolors >/dev/null;then
  eval $(dircolors -b ~/.config/.dircolors)
fi

#-------------
# Zsh History
#-------------
HISTFILE=~/.config/zsh_history
HISTSIZE=1000
SAVEHIST=10000
setopt SHARE_HISTORY # otherwise you get only the terminal you're on
setopt HIST_FCNTL_LOCK 
setopt HIST_IGNORE_DUPS 
setopt BANG_HIST 
setopt HIST_FIND_NO_DUPS
setopt HIST_VERIFY
setopt HIST_LEX_WORDS # better whitespace handling / maybe slower
setopt HIST_REDUCE_BLANKS # remove extra whitespace from commands in history
setopt COMPLETE_ALIASES 

#----------------
# Zsh Completion
#----------------
setopt AUTO_PARAM_SLASH # add trailing slashes to directories
setopt MARK_DIRS # append slash to dirs
setopt NOMATCH

#-------------
# Zsh Options
#-------------
unsetopt GLOBAL_RCS BEEP
setopt PRINT_EXIT_VALUE BG_NICE NOTIFY APPEND_HISTORY EXTENDED_GLOB \
         LIST_TYPES IGNORE_EOF AUTO_CD

#--------------------- 
# Vim Shell Emulation
#---------------------
bindkey -v

#--------------------------
# Go environment variables
#--------------------------
export GOPATH=~/code/go
export GOBIN=~/code/go/bin
export PATH="$HOME/code/go/bin":$PATH

#------------------------
# Path Modifications
#------------------------
export PATH=${PATH}:~/.xmonad
export PATH=${PATH}:~/.local/bin
export PATH=${PATH}:~/.cabal/bin

#---------------------
# Custom proxy config
#---------------------
export CURRENT_PROXY=none

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
