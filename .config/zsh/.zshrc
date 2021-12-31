# vim: ft=zsh
#
# ~/.zshrc
#  Author: Blake Bartenbach
#

# sourcing the profile here because zsh doesn't appear to?
source "${ZDOTDIR}/.zprofile"

#-------------------
# Interactive Check
#-------------------
[[ $- == *i* ]] || return

# serious brainlet shit
stty -ixon

#--------------------
# Readable TTY font
#--------------------
if [[ -z $DISPLAY ]]; then
  setfont Lat2-Terminus16 -d
fi

#------------------------------------------
# Loading my zsh functions which is absurd
# and way harder than it should be. I'm
# legitimately upset at how awful this is.
#------------------------------------------
ZFUNC_PATH="${ZDOTDIR}/functions"
fpath=(${ZFUNC_PATH} $fpath)
for function in ${ZFUNC_PATH}/*; do
  autoload -Uz $function
done

autoload -Uz compinit colors
compinit
colors

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
#bindkey -M menuselect '^M' .accept-line

#---------------
# More For Less
#---------------
export LESS='-#0.1 -R'
export LESSHISTFILE="-"
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
files=(shell/aliases zsh/zprompt)
foreach file ($files); do
  filepath="${XDG_CONFIG_HOME}/${file}"
  if [[ -r "${filepath}" ]]; then
    source "${filepath}"
  else
    echo "cannot source unreadable file: ${filepath}"
  fi
done

#-----------
# Dircolors
#-----------
dircolor_file="${XDG_CONFIG_HOME}/shell/dircolors"
if [[ -r "${dircolor_file}" && $(command -v dircolors) ]]; then
  eval $(dircolors -b "${dircolor_file}")
fi

#-------------
# Zsh History
#-------------
HISTFILE="${XDG_CACHE_HOME}/zsh/zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt SHARE_HISTORY # otherwise you get only the terminal you're on
setopt EXTENDED_HISTORY # record the time the command occurred
setopt INC_APPEND_HISTORY_TIME # record time in history file immediately
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS # no point recording duplicates
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt BANG_HIST
setopt HIST_VERIFY
setopt HIST_LEX_WORDS # better whitespace handling / maybe slower
setopt HIST_REDUCE_BLANKS # remove extra whitespace from commands in history
setopt COMPLETE_ALIASES # show what actually was executed

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
setopt PRINT_EXIT_VALUE BG_NICE NOTIFY APPEND_HISTORY EXTENDED_GLOB LIST_TYPES IGNORE_EOF

#---------------------
# Vim Shell Emulation
#---------------------
bindkey -v

#--------------------------
# Go environment variables
#--------------------------
export GOPATH=~/code/go
export GOBIN=~/code/go/bin

#------------------------
# Path Modifications
#------------------------
export PATH=${PATH}:${GOBIN}
export PATH=${PATH}:~/.local/bin
export PATH=${PATH}:~/.cabal/bin
export PATH=${PATH}:/usr/local/bin

eval $(thefuck --alias) # please help my git typos
neofetch --ascii_distro $(randlogo.sh) --logo
fortune | lolcat
