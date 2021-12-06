#!/bin/bash

unclutter --timeout 2 --start-hidden &

xset r rate 220 40

xbindkeys &

xmodmap ~/.Xmodmap

~/.fehbg &

picom &

exec xmonad
