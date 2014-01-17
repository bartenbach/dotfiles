# vim: ft=zsh
#
# ~/.zshrc
#  Author: proxa
#

#-------------------
# Interactive Check
#-------------------
[[ $- == *i* ]] || return

#------
# Main
#------
function main {
  load_modules
  setup_less
  load_personal_configs
  setup_dircolors
  setup_history
  set_zsh_options
  set_zstyle
}

#------------------
# Load Zsh Modules
#------------------
function load_modules {
  autoload -Uz compinit colors ; compinit ; colors
}

#---------------
# More For Less
#---------------
function setup_less {
  export LESS="-R -b-1 -J -i -M -W -#.01"
  export LESSHISTFILE=~/.hist/less_history
  export LESSHISTSIZE=100
  export LESS_TERMCAP_mb=$'\e[0;31m'    # blink
  export LESS_TERMCAP_md=$'\e[0;35m'    # bold
  export LESS_TERMCAP_us=$'\e[0;94m'    # underline
  export LESS_TERMCAP_so=$'\e[0;44;37m' # info box
  export LESS_TERMCAP_me=$'\e[0m'       # end mode
  export LESS_TERMCAP_se=$'\e[0m'       # end info box
  export LESS_TERMCAP_ue=$'\e[0m'       # end underline
}

#------------------------------
# Personal Configuration Files
#------------------------------
function load_personal_configs {
  local files
  local file
  files=( .aliases .zprompt )

  foreach file ($files) { 
    if [[ -r $file ]] {
      source ~/"$file"
    }
  }
}

#-----------
# Dircolors
#-----------
function setup_dircolors {
  if [[ "$TERM" != "linux" ]]; then
    dircolor_file=~/.dircolors
  else
    dircolor_file=~/dircolors-tty
  fi

  if [[ -r $dircolor_file ]] && type -p dircolors >/dev/null;then
    eval $(dircolors -b $dircolor_file)
  fi
}

#-------------
# Zsh History
#-------------
function setup_history {
  HISTFILE=~/.hist/zsh_history
  HISTSIZE=20
  SAVEHIST=500
  setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_SAVE_NO_DUPS BANG_HIST
}

#-------------
# Zsh Options
#-------------
function set_zsh_options {
  unsetopt GLOBAL_RCS BEEP
  setopt PRINT_EXIT_VALUE BG_NICE NOTIFY APPEND_HISTORY EXTENDED_GLOB \
         LIST_TYPES IGNORE_EOF
  bindkey -v
}

#-----------------
# General Options
#-----------------
function set_zstyle {
  zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
  zstyle ':completion:::::' completer _complete _approximate
  zstyle ':completion:*:descriptions' format "- %d -"
  zstyle ':completion:*:corrections' format "- %d - (errors %e})"
  zstyle ':completion:*:default' list-prompt '%S%M matches%s'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*:manuals' separate-sections true
  zstyle ':completion:*:manuals.(^1*)' insert-sections true
  zstyle ':completion:*' menu select
  zstyle ':completion:*' verbose yes
}

#------
# Main
#------
main
