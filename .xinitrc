#!/bin/sh -
#
# ~/.xinitrc
#
WINDOW_MANAGER='xmonad'

# background
xsetroot -bg darkred -mod 15 15

# merge .Xresources
xrdb -merge ~/.Xresources

# urxvt daemon
urxvtd -q -o -f  

# bind special keys
xbindkeys

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
