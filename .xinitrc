#!/bin/sh -
#
#  ~/.xinitrc
#

# append artwiz and dina to font path and set dpms
xset +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts &

# set keymap
setxkbmap dvorak &

# shift of red
#redshifter &

# .Xresources
xrdb -nocpp ~/.Xresources

# urxvt 'server'
urxvtd -q -o -f &

# twmn notification daemon
#twmnd &

# try ze xmobar
#xmobar &

# start window manager
exec /usr/bin/xmonad

# vim: set ft=sh :
