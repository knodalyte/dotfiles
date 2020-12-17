#!/bin/sh
conky -c ~/.config/qtile/conky-system-overview-arcolinux-qtile &
blueman-tray &
dunst &

udiskie -a -n -s &
