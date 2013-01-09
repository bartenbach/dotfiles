#
# .bashrc
#

# return if not interactive
[[ $- == *i* ]] || return

config_files=( '.aliases .prompt .profile .colors .git-prompt' )

# shell opts
shopt -s cdspell dirspell extglob histverify no_empty_cmd_completion checkwinsize autocd

set -o notify           # notify of completed background jobs immediately
ulimit -S -c 0 -n 4096  # disable core dumps
stty -ctlecho           # turn off control character echoing

# better less
export LESS=-R # use -X to avoid sending terminal initialization
export LESS_TERMCAP_mb=$'\e[00;31m' # red somewhere?
export LESS_TERMCAP_md=$'\e[1;35m'
#export LESS_TERMCAP_me=$'\e[0m' # horrible
export LESS_TERMCAP_se=$'\e[0m' #Page up/down place reminder
#export LESS_TERMCAP_ue=$'\e[0m' # horrible
export LESS_TERMCAP_so=$'\e[10;95m' # bottom left man page indicator
export LESS_TERMCAP_so=$'\e[00;44;37m' # what is this?
export LESS_TERMCAP_us=$'\e[00;96m'
      
# history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd *"
export HISTCONTROL="ignoreboth:erasedups"
export HISTSIZE=100
export HISTFILESIZE=500

# dircolors
if [[ -r ~/.dircolors ]] && type -p dircolors >/dev/null; then
    eval $(dircolors -b "$HOME/.dircolors")
fi

# TODO setup sendmail...
unset MAILCHECK

# parse configuration files
for config in $config_files
  do
    [[ -r ~/$config ]] && . ~/"$config"
  done

# bash completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

unset config
unset config_files

ponysay --colour-msg '1;35' --colour-bubble '0;35' --colour-link '0;35' --q
