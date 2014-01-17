#!/bin/sh -
#
# ~/.xinitrc
#

# set bg to midnight blue
hsetroot -solid '#171790' &

# urxvt 'server'
urxvtd -q -o -f  

#append artwiz and dina to font path and set dpms
xset +dpms +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts

# merge .Xresources
xrdb merge ~/.Xresources

# pulseaudio sound server
start-pulseaudio-x11

# window manager
exec /usr/bin/xmonad

# vim: set ft=sh :
