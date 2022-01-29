#!/bin/sh

# hide cursor when inactive
unclutter --timeout 2 --start-hidden &

# faster key repeating
xset r rate 220 40

# XF86 keys (volume up/down/mute)
xbindkeys &

# someone called me a boomer for using this
# i mean i *am* a boomer, but damn.
xscreensaver --no-splash &

# make caps lock be control
xmodmap ~/.Xmodmap

# set bg wallpaper
~/.fehbg &

# start a sick X11 compositor for muh GUIz
picom &

# save my eyeballs
redshift &

# japanese input
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drxR

exec /usr/bin/xmonad
