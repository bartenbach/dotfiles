#!/bin/sh -
#
# ~/.xinitrc
#
WINDOW_MANAGER='xmonad'

# set dpms and add local to font path 
xset +dpms +fp /usr/share/fonts/local
xset fp rehash

# background
xsetroot -bg darkred -mod 15 15

# merge .Xresources
xrdb -merge ~/.Xresources

# urxvt 'server'
urxvtd -q -o -f  

# sync copy/paste buffers
#autocutsel -fork &
#autocutsel -selection PRIMARY -fork &
/usr/local/bin/monitors.sh

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :

