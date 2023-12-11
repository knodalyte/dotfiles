#!/bin/sh
# lxqt-panel &
lxqt-powermanagement &
dunst                  &
kdeconnect-indicator &
blueman-tray &
udiskie --automount --notify --smart-tray &
syncthing-gtk &
copyq &
pasystray &
# QOwnNotes &
# redshift-gtk &
# suspect variety may have caused screen freeze
# variety &
nm-applet &
caffeine-indicator &
# using tdrop rather than guake # guake &
guake &
sudo matebook-applet &
# /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
alttab -d 1  &
menutray -i -gtk3 &
sleep 2
tint2 &

