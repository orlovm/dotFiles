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

import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401from typing import List  # noqa: F401
from libqtile.dgroups import simple_key_binder

mod = "mod4"
terminal = guess_terminal()

groups = [
         ScratchPad("scratchpad", [
              # define a drop down terminal.
              # it is placed in the upper third of screen by default.
              DropDown("term", "alacritty --config-file /home/mikhail/.alacritty_quake.yml",
                       opacity=1,),
              ]),
          Group("DEV", layout='columns'),
          Group("WWW", layout='monadtall'),
          Group("SYS", layout='monadtall'),
          Group("OTH", layout='monadtall'),
          Group("CHAT", layout='monadtall'),
          Group("DOC", layout='monadtall'),
          Group("MUS", layout='monadtall'),
          Group("VID", layout='monadtall'),
          Group("GFX", layout='floating')]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
dgroups_key_binder = simple_key_binder("mod4")

orange = "#E95420"
gray = "#181818"

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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "t", lazy.group['scratchpad'].dropdown_toggle('term')),
    # Volume control
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -c 0 -q set Master toggle")
    ),
    Key([mod], "r",
        lazy.spawn("dmenu_run -p 'Run: '"),
        desc='Run Launcher'
        ),
    Key([mod], "b",
        lazy.spawn("google-chrome"),
        desc='Run browser'
        ),
    Key([mod], "c",
        lazy.spawn("telegram-desktop"),
        desc='Run chat'
        ),
    Key([mod], "f",
        lazy.spawn("pcmanfm"),
        desc='Run fm'
        ),
    Key([mod], "space",
        lazy.next_screen(),
        desc='Move focus to next monitor'
        ),
    # Dmenu scripts 
    Key([mod, "control"], "k",
        lazy.spawn("dm-kill"),
        desc='Kill processes via dmenu'
        ),
    Key([mod, "control"], "q",
        lazy.spawn("dm-logout"),
        desc='A logout menu'
        ),
    Key([mod], "e",
        lazy.spawn("dm-confedit"), 
        desc='Choose a config file to edit'
        ),
    Key([mod], "i",
        lazy.spawn("dm-maim"),
        desc='Take screenshots via dmenu'
        ),
]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {"border_width": 2,
                "border_focus": orange,
                "border_normal": "#151515",
                }

# border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4
layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
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
    fontsize=12,
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
                  fontsize=11,
                  margin_y=3,
                  padding_y=1,
               )

def initCurScreen():
     return   widget.CurrentScreen(
               active_color=orange,
               inactive_text="",
               active_text="",
               inactive_color=gray,
               fontsize=25,
            )

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                initGroupBox(),
                initCurScreen(),
                widget.WindowName(
                    ),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ff00ff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Memory(
                    measure_mem='G',
                    format='{MemUsed: .0f}{mm}',
                    ),
                widget.Systray(
                    icon_size = 15,
                    ),
                widget.KeyboardLayout(
                    fmt = '{}',
                    padding = 5
                    ),
                widget.Clock(format="%Y-%m-%d %a %H:%M"),
            ],
            18,
            background=gray,
        ),
        wallpaper='~/wp.jpg',
        wallpaper_mode='stretch',
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                initGroupBox(),
                initCurScreen(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
            ],
            18,
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

floating_layout = layout.Floating(**layout_theme, 
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
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
