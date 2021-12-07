export PAGER=less
export EDITOR=nvim
export VISUAL=nvim

# web
export BROWSER=qutebrowser
export WWW_HOME="https://lite.duckduckgo.com"

# pass
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME}/pass"

# video
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia

# XDG paths
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

# dev
export PATH=${PATH}:~/.cargo/bin
export RUST_BACKTRACE=1
