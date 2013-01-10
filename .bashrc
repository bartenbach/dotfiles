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

#----------------
# Shell settings
#----------------
shopt -s autocd cdspell cmdhist dirspell extglob histverify \
no_empty_cmd_completion checkwinsize expand_aliases
unset direxpand
set -o notify 
stty -ctlecho -icanon

#---------------
# Less settings
#---------------
_r=$'\e[0m'
export LESS="-R -b-1 -J -i -M -W -#.01"
export LESSHISTFILE=~"/.hist/less_history"
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
export HISTFILE=~/".hist/bash_history"
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd *"
export HISTCONTROL="ignoreboth:erasedups"
export HISTSIZE=50
export HISTFILESIZE=250

#----------------
# Bash variables
#----------------
FIGNORE=""
unset MAILCHECK # I don't have a maildir
PS3="+"
PS4="  "

#----------------------
# Add custom dircolors
#----------------------
if [[ -r ~/.dircolors ]] && type -p dircolors >/dev/null; then
    eval $(dircolors -b "$HOME/.dircolors")
fi

#--------------------------
# Source relevant dotfiles
#--------------------------
for file in $sourced
  do
    [[ -r ~/$file ]] && . ~/"$file"
  done
unset file
unset sourced

#-----------------
# Bash completion
#-----------------
bash_completion='/usr/share/bash-completion/bash_completion'
[ -r $bash_completion ] && . $bash_completion

#---------------------------
# Yep, I really went there.
#---------------------------
ponysay --colour-msg '1;35' --colour-bubble '0;35' --colour-link '0;35' --q
