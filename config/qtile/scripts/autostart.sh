#!/bin/sh
COLUMNS=
LINES=
#exec ranger '$@'
# sleep 5
systemctl --user import-environment DISPLAY
# echo "starting kitty..."
# qtile cmd-obj -o screen -f toggle_group -a '2'
# qtile cmd-obj -o screen -f toggle_group -a '1'
# # kitty &
# sleep 2
#@autorandr -c
#sleep 2

#qtile run-cmd -g 1 kitty clifm &
#qtile run-cmd -g 1 kitty &
TERM=xterm-256-color && kitty clifm &
# TERM=xterm-kitty && kitty clifm &
# alacritty &
kitty &
kitty yazi &
sleep 1
echo "starting ranger..."
qtile cmd-obj -o screen -f toggle_group -a '2'
#qtile run-cmd -g 2 zsh -c
unset COLUMNS # && kitty zsh -c ranger
unset LINES
kitty ranger &
sleep 1
# qtile run-cmd -g 2  COLUMNS= && LINES= && kitty --start-as maximized ranger &
# qtile cmd-obj -o screen -f toggle_group -a '2'  COLUMNS= LINES= kitty --start-as maximized ranger &
#sleep 2
#
# echo "starting obsidian..."
# # echo "starting QOwnNotes..."
# qtile cmd-obj -o screen -f toggle_group -a '4'
# # QOwnNotes &
# # obsidian &
qtile cmd-obj -o screen -f toggle_group -a '4'
qtile run-cmd -g 4 anytype &
# qtile run-cmd -g 4 vnote &
# qtile run-cmd -g 4 QOwnNotes &
sleep 1

echo "starting synaptic..."
qtile cmd-obj -o screen -f toggle_group -a '5'
# qtile cmd-obj -o screen -f toggle_group -a '5' dbus-launch synaptic-pkexec &
qtile run-cmd -g 5 zsh -c "dbus-launch synaptic-pkexec" &
sleep 2

echo "starting nvim"
#echo "$NVIM_LISTEN_ADDRESS = " $NVIM_LISTEN_ADDRESS
qtile cmd-obj -o screen -f toggle_group -a '7'
#glrnvim --listen $NVIM_LISTEN_ADDRESS &

kitty nvrs &
#rm $NVIM_LISTEN_ADDRESS
# glrnvim --listen /tmp/nvimsocket &
#kitty nvim --listen /tmp/nvimsocket
# echo "nvim on " $NVIM_LISTEN_ADDRESS &
# qtile cmd-obj -o screen -f toggle_group -a '7' glrnvim --listen localhost:11111 &
# qtile cmd-obj -o screen -f toggle_group -a '7'
# NVIM_LISTEN_ADDRESS=localhost:12345 $VISUAL &
# qtile cmd-obj -o screen -f toggle_group -a '7'
# NVIM_LISTEN_ADDRESS=localhost:12345 nvr --remote-silent &
sleep 1
#
echo "starting firefox..."
qtile cmd-obj -o screen -f toggle_group -a '3'
qtile run-cmd -g 3 firefox &
# kitty --hold sh -c "firefox &"
# firefox &

autorandr -c

clipmenud

# echo "apps started, now start tray apps"
# sh ~/.config/common/tray_appsq.sh

#@.screenlayout/d.sh &

# cbavd
# sleep 4
# source $HOME/.zshenv
# cbastart

# function run {
#   if ! pgrep $1 ;
#   then
#     $@&
#   fi
# }
#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.config/qtile/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off

#change your keyboard if you need it
#setxkbmap -layout be

#Some ways to set your wallpaper besides variety or nitrogen
# feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
#start the conky to learn the shortcuts
# (conky -c $HOME/.config/qtile/scripts/system-overview) &

#starting utility applications at boot time
#run variety &
#run nm-applet &
#run pamac-tray &
#run xfce4-power-manager &
#numlockx on &
#blueberry-tray &
#picom --config $HOME/.config/qtile/scripts/picom.conf &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &

##starting user applications at boot time
#run volumeicon &
#run discord &
#nitrogen --restore &
#run caffeine -a &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run spotify &
#run atom &
#run telegram-desktop &
