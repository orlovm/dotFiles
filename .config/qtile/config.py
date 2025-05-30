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

import subprocess

from libqtile import bar, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.dgroups import simple_key_binder
from libqtile.dgroups import simple_key_binder
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.lazy import lazy
from libqtile.widget import base, battery
from libqtile import hook
# from libqtile.widget import Bluetooth

@hook.subscribe.startup_once
def autostart_once():
    subprocess.run('exec /usr/bin/solaar -w hide')

alt = "mod1"
mod = "mod4"
terminal = "alacritty"

dgroups_key_binder = simple_key_binder(mod)
groups = [
         ScratchPad("scratchpad", [
              DropDown("term", "alacritty --config-file /home/mikhail/.config/alacritty/.alacritty_quake.toml",
                       opacity=1,),
              DropDown("htop", "alacritty --config-file /home/mikhail/.config/alacritty/.alacritty_quake.toml -e htop",
                       opacity=1,
                       height = 0.6),
              ]),
            Group("1", layout='columns', spawn=terminal),
            Group("2", layout='columns'),
            Group("3", layout='columns', matches=[Match(wm_class=["discord"])]),
            Group("4", layout='columns'),
            Group("5", layout='columns', matches=[Match(wm_class=["TelegramDesktop"])]),
            Group("6", layout='columns', matches=[Match(wm_class=["Slack"])]),
            Group("7", layout='columns'),
            Group("8", layout='columns'),
            Group("9", layout='columns'),
            ]
            
# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
# dgroups_key_binder = simple_key_binder("mod1")

orange = "#E95420"
gray = "#181818"
light_gray = "#282828"

def VPNActive(name):
    try:
         a = subprocess.check_output(['nmcli', "-f", "connection.id", "connection", "show", "--active", "id", name])
         if a:
            return True
    except:
        return False

def toggle(qtile):
    if VPNActive("ll"):
        subprocess.call(['nmcli', 'con', 'down', 'id', 'll'])
    else:
        subprocess.call(['nmcli', 'con', 'up', 'id', 'll'])

class Test(base.InLoopPollText):

    def __init__(self, **config):
        base.InLoopPollText.__init__(self, **config)
        self.update_interval = 1

    def poll(self):
        if VPNActive("vpn"):
            return "VPN " 
        if VPNActive("ll"):
            return "ll-vpn"
        return ""

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "F10", lazy.window.toggle_floating(), desc="Grow window up"),
    Key([mod], "F11", lazy.window.toggle_fullscreen(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "space", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "t", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key([mod], "i", lazy.group['scratchpad'].dropdown_toggle('htop')),
    # Volume control
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("pulsemixer --change-volume +2")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("pulsemixer --change-volume -2")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("pulsemixer --toggle-mute")
    ),
    Key([mod], "r",
        lazy.spawn("dmenu_run -fn 'Monospace-10' -p 'Run: '"),
        desc='Run Launcher'
        ),
    Key([mod], "b",
        lazy.spawn('env GTK_THEME=Adwaita google-chrome-stable --profile-directory="Profile 1" --class=chrome_profile_1 --new-window'),
        desc='Run browser'
        ),
    Key([mod], "w",
        lazy.spawn('env GTK_THEME=Adwaita google-chrome-stable --profile-directory="Profile 5" --class=chrome_profile_5 --new-window'),
        desc='Run browser'
        ),
    Key([mod], "d",
        lazy.spawn('Discord'),
        desc='Discord'
        ),
    Key([mod], "c",
        lazy.spawn("telegram-desktop"),
        desc='Run chat'
        ),
    Key([mod], "f",
        lazy.spawn("pcmanfm"),
        desc='Run fm'
        ),
    # Key([mod], "space",
    #     lazy.next_screen(),
    #     desc='Move focus to next monitor'
    #     ),
    # Dmenu scripts 
    Key([mod, "control"], "k",
        lazy.spawn("dm-kill -fn 'Monospace-10'"),
        desc='Kill processes via dmenu'
        ),
    Key([mod, "control"], "q",
        lazy.spawn("dm-logout -fn 'Monospace-10'"),
        desc='A logout menu'
        ),
    Key([mod], "e",
        lazy.spawn("dm-confedit -fn 'Monospace-10'"), 
        desc='Choose a config file to edit'
        ),
    Key(
        [mod, "control"], "p",
        lazy.spawn("sh -c 'maim | xclip -selection clipboard -t image/png'")
    ),
    Key(
        [mod], "p",
        lazy.spawn("sh -c 'maim -s | xclip -selection clipboard -t image/png'")
    ),
    Key([mod], "v",
        lazy.function(toggle),
        desc='Toggle open vpn'
        ),
    Key([alt], "Shift_L",  lazy.widget["keyboardlayout"].next_keyboard()),
    # Noop caps lock
]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group

# dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {"border_width": 2,
                "border_focus": orange,
                "border_normal": "#151515",
                }

# border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4
layouts = [
    Columns(**layout_theme),
    # Max(**layout_theme),
    # Floating(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=24,
    padding=3,
)
extension_defaults = widget_defaults.copy()

def initGroupBox():
    return widget.GroupBox(
                  borderwidth = 2,
                  highlight_method = "block",
                  urgent_alert_method = "text",
                  urgent_text = orange,
                  urgent_border = "#316588",
                  this_current_screen_border = orange,
                  this_screen_border = orange,
                  disable_drag=True,
                  use_mouse_wheel=False,
                  # fontsize=18,
                  fontsize=24,
                  margin_y=3,
                  padding_y=1,
               )
def charge_controller():
    return (40, 45)

screens = [
    Screen(
        bottom=bar.Bar(
            [
                # widget.CurrentLayout(),
                initGroupBox(),
                widget.WindowName(
                    ),
                # Bluetooth(
                # ),
                widget.Wlan(
                    interface='wlp0s20f3',
                    format='  {essid}-{percent:2.0%} ',
                    ),
                widget.Memory(
                    measure_mem='G',
                    format='󰍛{MemUsed: .00f}{mm} ',
                    ),
                Test(foreground=orange),
                widget.Volume(
                    fmt='  {} ',
                    ),
                widget.Battery(
                    format=' {char}{percent:2.0%} {hour:d}:{min:02d} {watt:.2f}W ',
                    notify_below=16,
                    charge_char = u'↑',
                    discharge_char = u'↓',
                    charge_controller=charge_controller
                    ),
                widget.Systray(icon_size = 28),
                widget.Clock(format=" %Y-%m-%d %a %H:%M", 
                    mouse_callbacks={
                        'Button1': lazy.spawn('gsimplecal next_month'), 
                        'Button3': lazy.spawn('gsimplecal prev_month'), 
                        'Button2': lazy.spawn('pkill gsimplecal') 
                    }),
                widget.KeyboardLayout(configured_keyboards=['us', 'ru']),
            ],
            42,
            background=gray,
        ),
    wallpaper='~/wp.jpg',
        wallpaper_mode='stretch',
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = Floating(border_width=0, 
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
