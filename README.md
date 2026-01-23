# dotfiles

Style: _Catppuccin Mocha_

## Needed software
- `swayfx`            (only used for `corner_radius` in sway config)
- `waybar` 
- `brightnessctl`     (scripts in sway config folder)
- `wireplumber`       (binds in sway config)
- `mako`              (need for brightness and volume changing)
- `rofi`              (bind Meta+D in sway config)
- `nautilus`          (bind Meta+Ctrl+F in sway config)
- `flameshot`         (bind Print in sway config)
- `alacritty`         (bind Meta+Enter in sway config)
- `nvim`              (pure optional)
- `zsh` 
- `wooz`              (bind Insert in sway config)
- `wshowkeys-mao-git` (bind Alt+F4 in sway config)
- `playerctl`         (check binds in sway config)
- `ydotool`           (only used in sway for daemon start)

_Note_: I am sure that I am missing some software.


## Bindings
Bindings similar to the default in Sway. (`$mod = Meta`)
Except for moving and split:
- `h` -- left
- `j` -- down
- `k` -- up
- `l` -- right
- `$mod+g` -- splith
- `$mod+v` -- splith

Additional bind for focusing child window:
`$mod+Shift+a`

Audio control bindings (via `wpctl`):
| Combination            | Result              |
| :---------             | :----               |
| `XF86AudioMute`        | Mute/unmute sink    |
| `XF86AudioLowerVolume` | Lower sink volume   |
| `XF86AudioRaiseVolume` | Raise sink volume   |
| `$mod+F2`              | Lower source volume |
| `$mod+F3`              | Raise source volume |
| `XF86AudioMicMute`     | Mute/Unmute source  |

Brightness control (via `brightnessctl`):
| Combination             | Result                             |
| :---------              | :----                              |
| `XF86MonBrightnessDown` | Lower brightness level             |
| `XF86MonBrightnessUp`   | Raise brightness level             |
| `$mod+F5`               | Minimize/Maximize brightness level |

Mediaplayer control (via `playerctl`):
| Combination   | Result              |
| :---------    | :----               |
| `$mod+o`      | Stop playing        |
| `$mod+p`      | Play/pause playing  |
| `$mod+[`      | Play previous media |
| `$mod+]`      | Play next media     |
| `$mod+Alt+[`  | Lower player volume |
| `$mod+Alt+]`  | Raise player volume |


_Note:_ Audio, brightness and mediaplayer control provide notifications,
so `mako` is required.

Screenshot tool (`flameshot`):
| Combination | Result           |
| :---------  | :----            |
| `Print`     | Invoke Flameshot |

Magnifier tool (`wooz`):
| Combination | Result                            |
| :---------  | :----                             |
| `Insert`    | Take screenshot and use magnifier | 

Keyboard typing display tool (`wshowkeys`):
| Combination | Result                                          |
| :---------  | :----                                           |
| `$mod+F11`  | Enable/Disable displaying keyboard interactions |


## Pictures
![Blank Screen](./assets/blank_screen.jpg)
![Rofi Screen](./assets/nvim_fetch_rofi_screen.jpg)
![GTK Apps](./assets/some_apps.jpg)

