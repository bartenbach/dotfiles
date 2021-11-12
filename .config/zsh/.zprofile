export PAGER=less
export EDITOR=vim
export VISUAL=vim
export BROWSER=w3m
export ELINKS_CONFDIR="${XDG_CONFIG_HOME}/elinks"
export WWW_HOME="https://lite.duckduckgo.com"
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME}/pass"

if [[ $(uname) == "Darwin" ]]; then
  export TERM=xterm-256color
  export PATH=${PATH}:/usr/local/bin # just why...
  export DASHT_DOCSETS_DIR='/Users/alureon/Library/Application Support/Dash/DocSets'
else
  export TERM=rxvt-unicode-256color
fi

# XDG paths
export XDG_CONFIG_HOME=~/.config
export cfg="${XDG_CONFIG_HOME}" # laziness
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

# Rust things
export PATH=${PATH}:~/.cargo/bin
export RUST_BACKTRACE=1
