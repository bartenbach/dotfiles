export PAGER=less
export EDITOR=vim
export VISUAL=vim

if [[ $(uname) == "Darwin" ]]; then
  export TERM=xterm-256color
else
  export TERM=rxvt-unicode-256color
fi

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state
