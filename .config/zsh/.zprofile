export PAGER=less
export EDITOR=nvim
export VISUAL=nvim
export ELEVATOR=sudo

# web
export BROWSER=qutebrowser
export WWW_HOME="https://lite.duckduckgo.com"

# pass
export PASSWORD_STORE_DIR="${XDG_CONFIG_HOME}/pass"

# video
export LIBVA_DRIVER_NAME=vdpau
export VDPAU_DRIVER=nvidia
export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=DP-4
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DP-4
export WINIT_X11_SCALE_FACTOR=1.66

# gentoo bullshit - this is fuckin dumb
export JAVA_HOME=/usr/lib64/openjdk-17
export EQUERY=$(which equery)

# XDG paths
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

# dev
export PATH=${PATH}:~/.cargo/bin
export RUST_BACKTRACE=1

# pumpkin's pool public key
export PPI=4cheZ7QmWigAXpbZog7SMeXBXLHgKG2U8aGGJ8ba772y
export PPV=DsiG71AvUHUEo9rMMHqM9NAWQ6ptguRAHyot6wGzLJjx

export PATH="/home/blake/.local/share/solana/install/active_release/bin:$PATH"
