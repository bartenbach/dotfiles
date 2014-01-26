#!/bin/sh -
#
# ~/.xinitrc
#

WINDOW_MANAGER='xmonad'

# append artwiz and dina to font path and set dpms
#xset +dpms +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts

# shift of red
#redshift &

# merge .Xresources
xrdb -merge ~/.Xresources

# urxvt 'server'
urxvtd -q -o -f  

# twmn notification daemon
#twmnd &

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
