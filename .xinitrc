#!/bin/sh -
#
# ~/.xinitrc
#
WINDOW_MANAGER='xmonad'

# Source global scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# background
xsetroot -bg darkred -mod 15 15

# merge .Xresources
xrdb -merge ~/.Xresources

# urxvt daemon
urxvtd -q -o -f  

# bind special keys
xbindkeys

# start xmobar
xmobar

# window manager
exec /usr/bin/$WINDOW_MANAGER

# vim: set ft=sh :
