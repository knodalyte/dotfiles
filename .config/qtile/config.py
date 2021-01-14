# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Screen, KeyChord, Match
from libqtile.lazy import lazy
from libqtile.extension import WindowList, CommandSet
from libqtile.config import ScratchPad, DropDown
from libqtile.utils import guess_terminal
from libqtile.log_utils import logger
# from libqtile.config import EzKey as Key
import os
import subprocess
import psutil

mod = "mod4"
alt = "mod1"
ctrl = "control"

home = os.path.expanduser("~")
local_bin = home + "/.local/bin"
terminal = 'kitty' # guess_terminal()

# Color set for solarized dark colors
base03 = "#002b36"
base02 = "#073642"
base01 = "#586e75"
base00 = "#657b83"
base0 = "#839496"
base1 = "#93a1a1"
base2 = "#eee8d5"
base3 = "#fdf6e3"
yellow = "#b58900"
orange = "#cb4b16"
red = "#dc322f"
magenta = "#d33682"
violet = "#6c71c4"
blue = "#268bd2"
cyan = "#2aa198"
green = "#859900"

# @hook.subscribe.client_new
# def set_floating(window):
#     normal_hints = window.window.get_wm_normal_hints()
#     if normal_hints and normal_hints["max_width"]:
#         window.floating = True
#         return

#     floating_classes = ("nm-connection-editor", "pavucontrol")
#     try:
#         if Match(wm_class()[0] in floating_classes:
#             window.floating = True
#     except IndexError:
#         pass

@hook.subscribe.client_new
def set_parent(window):
    client_by_pid = {}
    for client in qtile.windows_map.values():
        client_pid = client.window.get_net_wm_pid()
        client_by_pid[client_pid] = client

    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    while ppid:
        window.parent = client_by_pid.get(ppid)
        if window.parent:
            return
        ppid = psutil.Process(ppid).ppid()


@hook.subscribe.client_new
def swallow(window):
    if window.parent:
        window.parent.minimized = True


@hook.subscribe.client_killed
def unswallow(window):
    if window.parent:
        window.parent.minimized = False

@hook.subscribe.screen_change
def set_screens(event):
    logger.debug("Handling event: {}".format(event))
    subprocess.run(["autorandr", "--change"])
    qtile.restart()

@hook.subscribe.startup_once
def start_once():
    subprocess.Popen(["autorandr", "--change"])
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])
    subprocess.Popen(["/bin/sh", home + "/.config/common/tray_appsq.sh"])
    subprocess.Popen([home + "/.config/qtile/scripts/autostart.sh"])
    # subprocess.call([home + "/.config/qtile/scripts/autostart.sh"])

@hook.subscribe.startup_complete
def start_apps():
    subprocess.Popen(["autorandr", "--change"])
    # subprocess.call([home + "/.config/common/setting.sh"])
    # subprocess.run(["cbastart"])
    pass

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    # subprocess.run("xsetroot -cursor_name left_ptr")
    # subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])
    subprocess.run([home + "/.config/common/setting.sh"])
    subprocess.Popen(["autorandr", "--change"])
    pass

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

# Key([mod, "shift", "mod1"], "Left", lazy.function(window_to_previous_screen)),
#         Key([mod, "shift", "mod1"], "Right", lazy.function(window_to_next_screen)),

#         Key([mod], "t", lazy.function(switch_screens)),

@lazy.function
def float_to_front(qtile):
    logging.info("bring floating windows to front")
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()

# from https://github.com/qtile/qtile/wiki/workspaces
def cycle_groups(direction, move_window):
    def _inner(qtile):
        current = qtile.groups.index(qtile.current_group)
        destination = (current + direction) % len(groups)
        if move_window:
            qtile.current_window.togroup(qtile.groups[destination].name)
        qtile.groups[destination].cmd_toscreen()
    return _inner

next_group = lazy.function(cycle_groups(direction=1, move_window=False))
previous_group = lazy.function(cycle_groups(direction=-1, move_window=False))
to_next_group = lazy.function(cycle_groups(direction=1, move_window=True))
to_previous_group = lazy.function(cycle_groups(direction=-1, move_window=True))


keys = [
    #overall keyboard shortcut strategy:
    #use mod+char to shift focus to specific group
    #mod+shift+char to move focused window to group and follow
    #    u
    #n   e   i
    #mod+n or i to change focus to previous or next group
    #mod+u or e to change focus to monitor above or below (not used often)
    #mod+arrow to change focus to window to left/right/above/below
    #mod+arrow+shift to shuffle window to left/right/above/below
    #?+n or i to change focus to window above/below

    #keychords:
    #L # OS
    #    sleep
    #V # video or display
    #    (from a)
    #Q #qtile

    #T # tiling

    #M move groups vs move between monitors

    #F focus
    # a screen is a monitor
    # groups have names, screens and layouts have numbers

    #M # monitors

    #KeyChord([mod], "q", [
    #    Key([], "a", lazy.spawn("firefox")),
    #]),
    #Key([mod], 'a', lazy.run_extension(CommandSet(
    #commands={
    #    'hdmi': 'autorandr -l HDMI',
    #    'edp': 'autorandr -l eDP',
    #    'displayport': 'autorandr -l Displayport',
    #    'both': 'autorandr -l Displayport-eDP',
    #    'famm2': 'autorandr -l HDMI-eDP',
    #    },
    ## pre_commands=['[ $(mocp -i | wc -l) -lt 1 ] && mocp -S'],
    ##**Theme.dmenu
    #)))

    # KeyChord([mod], "s", [
    #     Key([], "e", lazy.spawn("/home/cba/.screenlayout/cbave.sh")),
    #     Key([], "h", lazy.spawn("/home/cba/.screenlayout/cbavh.sh")),
    #     Key([], "d", lazy.spawn("/home/cba/.screenlayout/cbavd.sh")),
    # ]),

    ### Switch focus to specific monitor  AKA screen (out of three)
    Key([mod, alt], "1", lazy.to_screen(0), desc="Keyboard focus to monitor 1"),
    Key([mod, alt], "2", lazy.to_screen(1), desc="Keyboard focus to monitor 2"),
    Key([mod, alt], "3", lazy.to_screen(2), desc="Keyboard focus to monitor 3"),
    ### Switch focus of monitors
    Key([mod, alt], "period", lazy.next_screen(),  desc="Move focus to next monitor"),
    Key([mod, alt], "comma",  lazy.prev_screen(),  desc="Move focus to prev monitor" ),
    # workspace is same as tab is same as group
    Key([mod], "period", lazy.screen.next_group()),
    Key([mod], "comma", lazy.screen.prev_group()),
    Key([mod], "b", lazy.screen.toggle_group()),
    Key([ctrl, alt], "Right", next_group),
    Key([ctrl, alt], "Left", previous_group),
    Key([ctrl, alt, "shift"], "Right", to_next_group),
    Key([ctrl, alt, "shift"], "Left", to_previous_group),
# from docs:
    Key([mod], "e", lazy.layout.down()),
    Key([mod], "u", lazy.layout.up()),
    Key([mod], "n", lazy.layout.left()),
    Key([mod], "i", lazy.layout.right()),
    Key([mod, "shift"], "e", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "u", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "n", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "i", lazy.layout.shuffle_right()),
    Key([mod, alt], "e", lazy.layout.flip_down()),
    Key([mod, alt], "u", lazy.layout.flip_up()),
    Key([mod, alt], "n", lazy.layout.flip_left()),
    Key([mod, alt], "i", lazy.layout.flip_right()),
    Key([mod, ctrl], "e", lazy.layout.grow_down()),
    Key([mod, ctrl], "u", lazy.layout.grow_up()),
    Key([mod, ctrl], "n", lazy.layout.grow_left()),
    Key([mod, ctrl], "i", lazy.layout.grow_right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, alt], "Down", lazy.layout.flip_down()),
    Key([mod, alt], "Up", lazy.layout.flip_up()),
    Key([mod, alt], "Left", lazy.layout.flip_left()),
    Key([mod, alt], "Right", lazy.layout.flip_right()),
    Key([mod, ctrl], "Down", lazy.layout.grow_down()),
    Key([mod, ctrl], "Up", lazy.layout.grow_up()),
    Key([mod, ctrl], "Left", lazy.layout.grow_left()),
    Key([mod, ctrl], "Right", lazy.layout.grow_right()),
    # Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod], "minus", lazy.layout.toggle_split()),

    # window layout
    # use F11 for fullscreen
    # Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "m", lazy.window.toggle_maximize()),
    Key([mod], "f", lazy.window.toggle_floating()),
    # Key([mod], "m", lazy.group.setlayout('max'))
    Key([mod], "space", lazy.next_layout(), desc="Toggle through layouts"              ),

    #Key([mod, 'control'], 'x', lazy.run_extension(CommandSet(
    #commands={
    #    'shutdown': 'systemctl poweroff',
    #    'reboot': 'systemctl reboot',
    #    'suspend': 'systemctl suspend',
    #    'hibernate': 'systemctl hibernate',  # NOTE: A few things need to be set up in advance for this to work.
    #    'logout': 'loginctl terminate-session $XDG_SESSION_ID',
    #    'switch user': 'dm-tool switch-to-greeter',  # "dm-tool" is probably part of something other than systemd
    #    'lock': 'loginctl lock-session',
    #},
    #dmenu_prompt='session>',
    ## **dmenu_theme  # you can just leave this out if you don't have your own dmenu-theme
#)), desc='List options to quit the session.'),

    Key([mod], 'a', lazy.run_extension(CommandSet(
        commands={
            'displayport': home + '/.screenlayout/d.sh',
            'hdmi': home + '/.screenlayout/h.sh',
            'edp': home + '/.screenlayout/e.sh',
            '2edp/displayport': home + '/.screenlayout/ed.sh',
            '3displayport/edp': home + '/.screenlayout/de.sh',
            '4hdmi/edp': home + '/.screenlayout/he.sh',
            '5edp/hdmi': home + '/.screenlayout/eh.sh',
            },
        dmenu_prompt='display>',
        # dmenu_command = 'rofi',
        # pre_commands=['AUTORANDR_PROFILE_FOLDER=/home/cba/.config/autorandr'],
    #**Theme.dmenu
    )), desc='List monitors to activate'),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),
    # bring all floating windows to front
    Key([mod, "shift"], "f", float_to_front),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "Return", lazy.spawn("kitty")),
    Key([mod], "KP_Enter", lazy.spawn("kitty")),
    Key([mod], "o", lazy.spawn("kitty ranger")),
    Key([mod], "c", lazy.spawn("kitty clipcat-menu insert")),
    # Key([mod], "c", lazy.spawn("clipmenu")),
    # as set up by arandr:
    # Key([mod], "apostrophe", lazy.spawn("/home/cba/.screenlayout/cbave.sh")),
    # Key([mod], "bracketleft", lazy.spawn('/home/cba/.screenlayout/cbavh.sh')),
    # Key([mod], "bracketright", lazy.spawn('/home/cba/.screenlayout/cbavd.sh')),
    # Key("M-S-a", callback, ...),
    Key([mod], "z", lazy.spawn("rofi -combi-modi window#run#drun -show combi -modi combi")),
    Key([mod], "j", lazy.spawn("jgmenu_run")),
    Key([mod], "semicolon", lazy.spawn("rofi -combi-modi window#run#drun -show combi -modi combi")),
    Key([mod], "d", lazy.spawn("rofi -show drun -run-shell-command")),
    # Key([mod, ctrl], "d", lazy.spawn("rofi -show drun -run-command 'pkexec /usr/sbin/{cmd}'")),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.layout.next()),
    # Key([alt], "Tab", lazy.spawn("alttab")),
    # Key([alt], "Tab", lazy.spawn("rofi -show window")),
    Key([alt], "Tab", lazy.group.next_window(), lazy.window.bring_to_front()),
    Key([alt], "F4", lazy.window.kill()),
    # Key([mod, ctrl, alt], "k", kill_all_windows), # Kill all windows

    Key([mod, "shift"], "l", lazy.spawn("i3lock-fancy")),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([mod, "shift"], "z", lazy.spawn("sudo systemctl suspend")),
    Key([mod], "x", lazy.spawncmd(command="kitty --hold '%s'")),
    Key([mod, "shift"], "x", lazy.spawncmd(command="kitty --hold 'sudo %s'")),
    Key([], "F12", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod], "p", lazy.group["scratchpad"].dropdown_toggle("pkm")),
    Key([], "Print", lazy.spawn("flameshot")),
    # Key([], "Print", lazy.spawn("scrot")),

# MULTIMEDIA KEYS
    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute 1 toggle")),
# INCREASE/DECREASE BRIGHTNESS
    Key([], "XF86MonBrightnessUp", lazy.spawn("light -A 25 -s sysfs/backlight/amdgpu_bl0")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("light -U 25 -s sysfs/backlight/amdgpu_bl0")),
# INCREASE/DECREASE/MUTE VOLUME
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
]

groups = []
group_labels = ["1:terms", "2:files", "3:web", "4:pkm", "5:sys", "6:misc", "7:vim", "8:find", "9:help"] # "6", "7", "8", "9", "0",]
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] #, "0",]
#group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout="max",
            # layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([
#CHANGE groupS
        Key([mod], i.name, lazy.group[i.name].toscreen()),
# MOVE WINDOW TO SELECTED group 1-10 AND STAY ON group
        #Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
# MOVE WINDOW TO SELECTED group 1-10 AND FOLLOW MOVED WINDOW TO group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
    ])

groups.append(ScratchPad("scratchpad", [
        # define a drop down terminal.
        # it is placed in the upper third of screen by default.
        DropDown("term", "kitty", height=.9, x=0, y=0, width=1, on_focus_lost_hide=True),
        DropDown("pkm", "kitty", height=.9, x=0, y=0, width=1),

        # define another terminal exclusively for qshell at different position
        DropDown("qshell", "kitty -hold qshell",
                 x=0.05, y=0.4, width=0.9, height=0.6, opacity=0.9,
                 on_focus_lost_hide=True) ]))


##### DEFAULT THEME SETTINGS FOR LAYOUTS #####
layout_theme = {"border_width": 2,
        "margin": 6,
        "border_focus": green,
        "border_normal": "1D2330"
        }

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

def get_num_monitors():
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors

num_monitors = get_num_monitors()

def open_calendar(qtile):
    qtile.cmd_spawn('gnome-calendar')

# COLORS FOR THE BAR

def init_colors():
    return [["#2F343F", "#2F343F"], # color 0
            ["#2F343F", "#2F343F"], # color 1
            ["#c0c5ce", "#c0c5ce"], # color 2
            ["#fba922", "#fba922"], # color 3
            ["#3384d0", "#3384d0"], # color 4
            ["#f3f4f5", "#f3f4f5"], # color 5
            ["#cd1f3f", "#cd1f3f"], # color 6
            ["#62FF00", "#62FF00"], # color 7
            ["#6790eb", "#6790eb"], # color 8
            ["#a9a9a9", "#a9a9a9"]] # color 9


colors = init_colors()

widget_defaults = dict(
    # font="Monoisome Tight",
    font="Andika Compact",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
            widget.CurrentScreen(),
            widget.GroupBox(
                    fontsize = 16,
                    # margin_y = -1,
                    margin_x = 0,
                    # padding_y = 6,
                    padding_x = 5,
                    borderwidth = 0,
                    disable_drag = True,
                    markup = True,
                    active = "FFFFFF",
                    # active = colors[9],
                    inactive = "909090",
                    # inactive = colors[5],
                    rounded = False,
                    highlight_method = "block",
                    this_current_screen_border = colors[8],
                    foreground = colors[2],
                    background = colors[1],
                    hide_unused = True,
                    ),
            widget.CurrentLayout(),
            # widget.CurrentLayoutIcon(),
            widget.TaskList(mouse_callbacks = {}, margin_y = 0, highlight_method = "border", border = green, unfocused_border = base01, padding_y = 0, icon_size = 20),
            # widget.TaskList(mouse_callbacks = {3: "xkill"}, margin_y = -1, highlight_method = "border", border = green, unfocused_border = base01, padding_y = 4, icon_size = 22),
            widget.Prompt(),
            # widget.Notify(iconsize=24),
            # widget.Net(format = "{down} ↓↑ {up}", foreground = blue),
            # widget.Chord(
                    # chords_colors={
                    #     'launch': ("#ff0000", "#ffffff"),
                    # },
                    # name_transform=lambda name: name.upper(),
                # ),
            widget.NetGraph(type="line", width=50, graph_color=blue, samples=50),
            widget.CPUGraph(type="line", width=50, graph_color=yellow, samples=50),
            # widget.Wlan(),
            # widget.CPU(format = "{freq_current}G {load_percent}%  ", foreground = yellow),
            widget.Systray(padding=1, icon_size=22),
            # widget.Clock(format="  %a %e %b %l:%M:%S", fontsize=16),
            widget.Clock(format="  %a %e %b %l:%M:%S", fontsize=16, mouse_callbacks={'Button1': open_calendar}),
                # widget.CurrentLayout(),
                # widget.GroupBox(),
                # widget.Prompt(),
                # widget.WindowName(),
                # widget.Chord(
                #     chords_colors={
                #         'launch': ("#ff0000", "#ffffff"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # widget.Systray(),
                # widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                # widget.QuickExit(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    Match(wm_type='utility'),
    Match(wm_type='notification'),
    Match(wm_type='toolbar'),
    Match(wm_type='splash'),
    Match(wm_type='dialog'),
    Match(wm_class='file_progress'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='nm-connection-editor'),  #
    Match(wm_class='pavucontrol'),  #
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(title='apt-listchanges'),  # GPG key password entry
])

auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

if __name__ in ["config", "__main__"]:
    local_bin = os.path.expanduser("~") + "/.local/bin"
    if local_bin not in os.environ["PATH"]:
        os.environ["PATH"] = "{}:{}".format(local_bin, os.environ["PATH"])

    # mod = "mod4"
    # browser = "google-chrome"
    # terminal = "roxterm"
    # screenlocker = "i3lock -d"
    # hostname = socket.gethostname()
    # cursor_warp = True
    # focus_on_window_activation = "never"

    # keys = init_keys()
    # mouse = init_mouse()
    # groups = init_groups()
    # floating_layout = init_floating_layout()
    # layouts = init_layouts()
    # widgets = init_widgets()
    # bar = bar.Bar(widgets=widgets, size=22, opacity=1)
    # screens = [Screen(top=bar, wallpaper="~/.background.jpg")]
    # widget_defaults = {"font": "DejaVu", "fontsize": 11, "padding": 2,
    #                    "background": DARK_GREY}

# keys = [
#     # Switch between windows in current stack pane
#     Key([mod], "k", lazy.layout.down(),
#         desc="Move focus down in stack pane"),
#     Key([mod], "j", lazy.layout.up(),
#         desc="Move focus up in stack pane"),

#     # Move windows up or down in current stack
#     Key([mod, "control"], "k", lazy.layout.shuffle_down(),
#         desc="Move window down in current stack "),
#     Key([mod, "control"], "j", lazy.layout.shuffle_up(),
#         desc="Move window up in current stack "),

#     # Switch window focus to other pane(s) of stack
#     Key([mod], "space", lazy.layout.next(),
#         desc="Switch window focus to other pane(s) of stack"),

#     # Swap panes of split stack
#     Key([mod, "shift"], "space", lazy.layout.rotate(),
#         desc="Swap panes of split stack"),

#     # Toggle between split and unsplit sides of stack.
#     # Split = all windows displayed
#     # Unsplit = 1 window displayed, like Max layout, but still with
#     # multiple stack panes
#     Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
#         desc="Toggle between split and unsplit sides of stack"),
#     Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

#     # Toggle between different layouts as defined below
#     Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
#     Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

#     Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
#     Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
#     Key([mod], "r", lazy.spawncmd(),
#         desc="Spawn a command using a prompt widget"),
# ]

# groups = [Group(i) for i in "asdfuiop"]

# for i in groups:
#     keys.extend([
#         # mod1 + letter of group = switch to group
#         Key([mod], i.name, lazy.group[i.name].toscreen(),
#             desc="Switch to group {}".format(i.name)),

#         # mod1 + shift + letter of group = switch to & move focused window to group
#         Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
#             desc="Switch to & move focused window to group {}".format(i.name)),
#         # Or, use below if you prefer not to switch to that group.
#         # # mod1 + shift + letter of group = move focused window to group
#         # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
#         #     desc="move focused window to group {}".format(i.name)),
#     ])

