#
# ~/.bashrc
#

#---------------------------
# Return if not interactive
#---------------------------
[[ $- == *i* ]] || return

#-------------------------
# Personal configurations
#-------------------------
sourced=( '.aliases .git-prompt .prompt' )

local file
for file in $sourced
  do
    [[ -r ~/$file ]] && . ~/"$file"
  done
unset file
unset sourced

#----------------
# Shell settings
#----------------
shopt -s autocd cdspell cmdhist dirspell extglob histverify \
no_empty_cmd_completion checkwinsize expand_aliases
set -o notify 
stty -ctlecho

#---------------
# Less settings
#---------------
_r=$'\e[0m'
export LESS="-R -b-1 -J -i -M -W -#.01"
export LESSHISTFILE="$HOME/.hist/less_history"
export LESSHISTSIZE=100
export LESS_TERMCAP_mb=$'\e[0;31m'     # Begin blinking
export LESS_TERMCAP_md=$'\e[0;35m'     # Begin bold
export LESS_TERMCAP_us=$'\e[0;94m'     # Begin underline
export LESS_TERMCAP_me=$_r             # End mode
export LESS_TERMCAP_se=$_r             # End standout-mode
export LESS_TERMCAP_ue=$_r             # End underline
export LESS_TERMCAP_so=$'\e[0;44;37m'  # Begin standout-mode (info box)

#--------------   
# Bash history
#--------------
export IGNOREEOF=2
export HISTFILE="$HOME/.hist/bash_history"
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd *"
export HISTCONTROL="ignoreboth:erasedups"
export HISTSIZE=50
export HISTFILESIZE=250

#----------------
# Bash variables
#----------------
FIGNORE=""
PS3="+"
PS4="  "

#----------------------
# Add custom dircolors
#----------------------
if [[ -r ~/.dircolors ]] && type -p dircolors >/dev/null; then
    eval $(dircolors -b "$HOME/.dircolors")
fi

#-----------------
# Bash completion
#-----------------
bash_completion='/usr/share/bash-completion/bash_completion'
[ -r $bash_completion ] && . $bash_completion
