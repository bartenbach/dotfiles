#!/bin/sh -
#
# ~/.xinitrc
#

WINDOW_MANAGER='xmonad'
WALLPAPER='3840s/3840test2.jpg'

# append artwiz and dina to font path
xset +dpms +fp /usr/share/fonts/local,/usr/share/fonts/artwiz-fonts

# shift of red
redshift &

# wallpaper
hsetroot -center /home/seed419/img/wallpapers/$WALLPAPER

# merge .Xresources
xrdb merge ~/.Xresources

# urxvt 'server'
urxvtd -q -o -f  

# twmn notification daemon
twmnd &

# systemd-logind session
systemd --user &

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
