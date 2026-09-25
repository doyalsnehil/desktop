# Gemini handoff claim verification

Witness reviewed: `docs/investigation/SYSTEM_HANDOFF.md`. The requested path `docs/investigation/GEMINI_SYSTEM_HANDOFF.md` does not exist. Verdicts describe the **current** machine, not whether a historical attempt happened. `CONFIRMED` requires evidence appropriate to the claim; configured actions without a live result are only partial or unverified.

| Handoff claim | Verdict | Current evidence and limit |
|---|---|---|
| CachyOS, Arch based | CONFIRMED | `/etc/os-release` says `ID=cachyos`, `ID_LIKE=arch`; CachyOS packages installed. |
| Migrated away from Omarchy | PARTIALLY_CONFIRMED | Current session uses the personal Hyprland/Quickshell tree; many scripts still contain `omarchy:*` metadata, old command references, `omarchy.wifiqr/speedtest`, and `~/.zshrc` retains an Omarchy prompt comment. No Omarchy process was found. |
| SDDM replaced greetd and is enabled | CONFIRMED | `sddm.service` enabled and active, display-manager alias points to it; `greetd.service` disabled/inactive. |
| SDDM Astronaut theme works | UNVERIFIED | Theme package and files exist; `/etc/sddm.conf.d/theme.conf` selects it. Autologin prevented observing an interactive theme; boot journal says `Loaded empty theme configuration`. User recalls theme attempt did not reach desired result. |
| SDDM autologin is used | CONFIRMED | `loginctl` service `sddm-autologin`, live helper command has `--autologin`, and current-boot SDDM journal records its PAM session. This confirms this boot, not reliability on future boots. |
| Hyprland Lua wrapper is active | CONFIRMED | No `hyprland.conf`; `hyprland.lua` requires `config/*.lua`; live `hyprctl -j binds` entries dispatch through `__lua`. Exact implicit entry-point resolution was not traced with file-open monitoring. |
| `autostart.lua` launches core daemons | CONFIRMED | Declared `hl.on("hyprland.start")` commands and matching children of live Hyprland PID 1068 (`awww-daemon`, SwayOSD, Waybar, `qs`, keyboard daemon). |
| `awww-daemon` is active | CONFIRMED | PID 1126, mapped layer, `awww query` returned the live image. |
| SwayOSD is active | CONFIRMED | `swayosd-server` PID 1129, child of Hyprland. Individual OSD presentation not exercised. |
| Dell keyboard backlight daemon runs | CONFIRMED | Python PID 1128 runs `personal-kbd-osd-daemon`; script watches `/sys/class/leds/dell::kbd_backlight/brightness`. Its event display was not exercised. |
| Waybar top bar runs | CONFIRMED | PID 1131, mapped `waybar` layer and loaded-looking default config at `~/.config/waybar/config.jsonc`. |
| Quickshell overlays run | CONFIRMED | PID 1132 command `qs -p /home/snehil/.config/quickshell/personal`, mapped `quickshell` layer; `shell.qml` instantiates panels. Individual popups untested. |
| Quickshell replaced Waybar workspace rendering | CONTRADICTED | Active Waybar config still includes `hyprland/workspaces`. Quickshell `WorkspaceIndicator.qml` exists but `shell.qml` does not instantiate it. |
| Quickshell has Audio, Battery, Bluetooth, Calendar, Network, Polkit, Speedtest, WifiQR | PARTIALLY_CONFIRMED | All are instantiated in the active `shell.qml`; actions and prompts were not exercised. Polkit references absent `personal-hw-laptop-closed`; Battery hardcodes `BAT0`. |
| Matugen drives wallpaper and outputs | PARTIALLY_CONFIRMED | `personal-wallpaper` invokes Matugen; generated palette, Waybar CSS and Ghostty theme have startup timestamps; Matugen config sets awww wallpaper hook. Current awww image differs from saved state, and runtime Hyprland border differs from the palette hook's desired setting. |
| `personal-wallpaper` directly sets image via awww | CONTRADICTED | Its `awww img "$image"` line is commented. Matugen config is the configured setter. Current image and saved state both point to `/home/snehil/Downloads/onePiece.png`; `~/Pictures/wallpapers/test.jpg` is only a fallback. |
| `personal-power-menu` is Fuzzel based and uses loginctl logout | PARTIALLY_CONFIRMED | Script uses Fuzzel and `loginctl terminate-session $XDG_SESSION_ID`; Hyprland and Waybar call it. Logout path not executed. |
| `personal-screenshot` uses Slurp/Grim/wl-copy | PARTIALLY_CONFIRMED | Script and bind show this chain; capture not triggered. |
| `personal-theme-apply` updates Hyprland borders | CONTRADICTED | Script issues keywords and is called by Matugen; live `hyprctl` reports static CachyOS gradient and border size 2, whereas script sets palette values and size 1. The exact failure/reset moment is unknown. |
| Every custom script is `personal-*` in `~/.local/bin` | CONTRADICTED | Active custom `/usr/local/bin/personal-audio-router` exists, plus locally installed `~/.local/bin/agy`; many `personal-*` scripts remain, and some referenced ones are absent. |
| Ghostty dynamically reloads theme on SIGUSR1 | PARTIALLY_CONFIRMED | Matugen Ghostty template has SIGUSR1 hook; Ghostty config uses generated `personal` theme. The signal and visible reload were not observed directly. |
| Waybar reloads CSS on SIGUSR2 | PARTIALLY_CONFIRMED | Matugen Waybar template hook and `personal-wallpaper` both send SIGUSR2; CSS imports generated `colors.css`. Signal handling was not exercised. |
| Hyprland border theming is wallpaper driven | CONTRADICTED | Live border equals static `colors.lua`/`decorations.lua`, not generated hook's target. |
| `libappindicator-gtk3` installed to fix tray | CONTRADICTED | No installed package with that name in pacman query; no runtime evidence of that fix. Historical installation remains possible. |
| Neovim checkout on `v3` branch | CONFIRMED | `git -C ~/.config/nvim branch --show-current` returned `v3`; personal remote found. Checkout has modified `lazy-lock.json`. |
| Zoxide was added to Zsh | CONFIRMED | `~/.zshrc` has `eval "$(zoxide init zsh --cmd cd)"`; zoxide installed. Shell initialization in each app was not tested. |
| Hyprland gestures were removed | PARTIALLY_CONFIRMED | No active `hl.gesture` in `inputs.lua`; intent and older history cannot be proven from current file alone. |
| Floating App Store script was purged | PARTIALLY_CONFIRMED | No such active bind or matching `~/.local/bin` script was found; the historical creation/purge account cannot be proven. |
| `hyprctl dispatch exit` failed due to Lua interception, so `loginctl` workaround is needed | UNVERIFIED | Power menu does use `loginctl terminate-session`; no safe test of logout mechanism was run. The asserted cause has no independent evidence. |
| Backgrounding `awww-daemon` failed | PARTIALLY_CONFIRMED | `personal-wallpaper` has commented kill/nohup lines; live daemon comes from Hyprland startup. The historical failure mechanism is unverified. |
| Flatpak apps may not appear in Fuzzel until restart | UNVERIFIED | Two Flatpak apps are installed, but app discovery was not exercised and no session restart was allowed. |
| `personal-audio-router` exists and handles Bluetooth/headphone handoff | PARTIALLY_CONFIRMED | Enabled active root unit launches `/usr/local/bin/personal-audio-router`; source watches headphone events and Pulse sinks. Actual handoff behavior not exercised. Hardcoded user, sink and event device make it machine specific. |
| LUKS/Plymouth preboot chain | PARTIALLY_CONFIRMED | Current system has dm-crypt kernel workers and Plymouth/CachyOS packages; preboot prompt behavior cannot be reconstructed from this running session without rebooting. |
| `swayosd` udev reload made input permissions work | UNVERIFIED | Server runs; no read-only evidence proves historical `udevadm` action or raw input access success. |

The most consequential differences are the unproven Astronaut theme, active Waybar workspaces, the indirect Matugen wallpaper setter, and the Hyprland border hook's absent runtime effect. These should be treated as findings, not silently reconciled.
