#!/bin/sh -

_='
# Something cool should go here like some ASCII art!

# Hey, I am an xinitrc file! 
'

#============
# Variables!
#============
WINDOW_MANAGER='xmonad'
WALLPAPER='arielorange.jpg'

#=============
# Launch dbus
#=============
source /etc/X11/xinit/xinitrc.d/30-dbus

#=================
# Begin redshift!
#=================
redshift -l 41.25590487876669:-95.93065448105335 &

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

#==========================
# Start the window manager
#==========================
exec /usr/bin/$WINDOW_MANAGER
