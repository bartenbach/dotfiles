#!/bin/sh -
#
#  ~/.xinitrc
#
WINDOW_MANAGER='xmonad'
WALLPAPER='haskell.png'

# launch dbus
dbus-launch --sh-syntax

# append artwiz and dina to font path
xset +dpms +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts

# shift of red
redshifter

# wallpaper
hsetroot -center /home/seed419/img/wallpapers/$WALLPAPER

# merge .Xresources
xrdb merge ~/.Xresources

# urxvt 'server'
urxvtd -q -o -f  

# twmn notification daemon
twmnd &

# start window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
