#!/bin/sh -

_='
# Something cool should go here like some ASCII art!

# Hey, I am an xinitrc file! 
'

#============
# Variables!
#============
WINDOW_MANAGER='i3'
WALLPAPER='arielorange.jpg'

#=============
# Launch dbus
#=============
source /etc/X11/xinit/xinitrc.d/30-dbus

#=======================
# Set desktop wallpaper
#=======================
hsetroot -full /home/seed419/img/wallpapers/$WALLPAPER

#=====================
# Merge ~/.Xresources
#=====================
xrdb -merge ~/.Xresources

#====================
# Start URxvt server
#====================
urxvtd -q -o -f  

#==============================
# Start my 'Chromium daemon'..
#==============================
chromium --allow-oudated-plugins &


#===========================
# Launch a couple terminals
#===========================
urxvtc -e weechat-curses &
urxvtc &

#==========================
# Start the window manager
#==========================
exec /usr/bin/$WINDOW_MANAGER
