#!/bin/sh -
#
# ~/.xinitrc
#
WINDOW_MANAGER='xmonad'

# background
xsetroot -bg darkblue -mod 15 15

# merge .Xresources
xrdb -merge ~/.Xresources

# urxvt server
urxvtd -q -o -f  

# locking screensaver for security
xscreensaver -no-splash &

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
