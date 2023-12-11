#!/bin/sh
# automatic monitor config: see https://github.com/Ventto/mons
#nohup mons -a > /dev/null 2>&1 & */
amixer sset Master 100% &
xinput set-prop "M585/M590 Mouse" "libinput Natural Scrolling Enabled" 1 &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Disable While Typing Enabled" 1 &
xinput set-prop "ELAN2203:00 04F3:309A Mouse" "libinput Natural Scrolling Enabled" 1 &
xinput set-prop "ELAN2203:00 04F3:309A Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput set-prop "ELAN2203:00 04F3:309A Touchpad" "libinput Disable While Typing Enabled" 1 &
xinput set-prop "MOSART Semi. 2.4G Wireless Mouse" "libinput Natural Scrolling Enabled" 1 &
xinput set-prop "Wacom HID 48CF Finger touch" 284 1 &
#unclutter &
sparky-polkit &
xset +dpms
clipmenud &
echo "done"
