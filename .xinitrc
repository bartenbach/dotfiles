#!/bin/sh -
#
# ~/.xinitrc
#
WINDOW_MANAGER='xmonad'

# set dpms and add local to font path 
xset +dpms +fp /usr/share/fonts/local
xset fp rehash

# shift of red
#redshift -l 41.2636:-95.9353 &

# background
xsetroot -bg darkred -mod 15 15

# merge .Xresources
xrdb -merge ~/.Xresources

# urxvt 'server'
urxvtd -q -o -f  

# fix corsair keyboard LEDs (required sudoer file hack)
#sudo kbd_mode -u

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
