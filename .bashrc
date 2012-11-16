#
# .bashrc - interactive shell configuration
#

# check for interactive
[[ $- = *i* ]] || return

export TTY=$(tty)
export GPG_TTY=$TTY

# shell opts
shopt -s cdspell dirspell extglob histverify no_empty_cmd_completion checkwinsize autocd

set -o notify           # notify of completed background jobs immediately
ulimit -S -c 0 -n 4096  # disable core dumps
stty -ctlecho           # turn off control character echoing

if [[ $TERM = linux ]]; then
      setterm -regtabs 4    # set tab width of 4 (only works on TTY)
fi
      
# more for less
export LESS=-R # use -X to avoid sending terminal initialization
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'
      
# history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd *"
export HISTCONTROL="ignoreboth:erasedups"
export HISTSIZE=1000
export HISTFILESIZE=2000
      
# git prompt
[[ -f /usr/share/git/git-prompt.sh ]] && . /usr/share/git/git-prompt.sh


# parse configuration files
for config in .aliases .functions .prompt .bashrc."$HOSTNAME"; do
    [[ -r ~/$config ]] && . ~/"$config"
done
unset config 

PS1="\[\033[0;33m\]\`
if [[ \$? = "0" ]]; 
    then echo "\\[\\033[32m\\]"; 
    else echo "\\[\\033[31m\\]"; 
fi

\`[\u.\h: \`

if [[ `pwd|wc -c|tr -d " "` > 18 ]]; 
    then echo "\\W"; 
    else echo "\\w"; 
fi
\`]\$\[\033[0m\] ";
PS1='\[\033[0;33m\][\u.\h \W$(__git_ps1 " (%s)")]\$ '

if [[ $EUID -eq 0 ]]; then
    echo "\\[\\033[32m\\]"
else
    echo "\\[\\033[31m\\]"
fi



export EDITOR="vim"
