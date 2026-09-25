# Portability matrix

This is a classification for later repository design. It does not authorize copying files or implementing overrides now. `portable` means reusable as a source candidate after review, not that every configured action works. Multiple labels apply when a source file contains a machine-bound value.

| Path or component | Classification | Reason / later disposition |
|---|---|---|
| `~/.config/hypr/hyprland.lua`, `config/{animations,binds,decorations,inputs,layers,misc,windowrules,workspaces}.lua` | portable, uncertain | Handwritten source graph. Check obsolete Noctalia rule and empty workspace monitor variables later. |
| `~/.config/hypr/config/autostart.lua` | portable, machine-specific | Source startup sequence; hardcoded home layout and QML import path. Session ordering matters. |
| `~/.config/hypr/config/monitors.lua` | machine-specific | Hardcodes `eDP-1`, 1920×1080@60, scale 1; machine override later. |
| `~/.config/hypr/config/{colors,variables,environment}.lua` | portable, uncertain | Static Cachy palette and app defaults; environment contains examples only. Need intentionality review. |
| `~/.config/hypr/hyprlock.conf`, `~/.config/hypr/xdph.conf` | portable, uncertain | Present source candidates; lock/portal behavior not exercised. |
| `~/.config/quickshell/personal/shell.qml`, `panels/**`, `Ui/**`, `Commons/**` | portable, machine-specific, uncertain | Active QML source tree; hardcoded `BAT0`, home paths, old Omarchy IDs and missing helper references require later decisions. |
| `~/.config/quickshell/personal/qs/{Ui,Commons}` | portable | Internal symlinks to the same tree, required for `qs.Ui` and `qs.Commons` imports; preserve relationship later. |
| `~/.config/quickshell/personal/Commons/Color.qml` theme inputs | stale/dead, uncertain | Looks for absent `~/.local/state/omarchy/current/theme/{colors,shell}.toml` and `~/.config/omarchy/shell.toml`; current built-in fallback likely supplies colors. |
| `~/.config/quickshell/personal/{TopBar,WorkspaceIndicator,Anchor,qs_apps,qs_test_fileview,test_*}.qml`, `~/.config/quickshell/shell.qml` | stale/dead, uncertain | Present but not imported by active `personal/shell.qml`; some may be experiments. |
| `~/.config/quickshell/personal.backup*`, `*.before-*`, `*.tmp` | stale/dead | Historical snapshots, not active source. |
| `~/.config/waybar/{config.jsonc,style.css}` | portable, machine-specific | Active source; absolute `/home/snehil` click path, embedded fixed calendar colors. |
| `~/.config/waybar/colors.css` | generated | Matugen output. Recreate from source template. |
| `~/.config/matugen/config.toml`, `templates/*` | portable | Canonical source of palette generation and hooks; current border hook failure requires review. |
| `~/.config/matugen/generated/palette.json`, `~/.config/ghostty/themes/personal` | generated | Matugen outputs. Do not adopt as source. |
| `~/.config/ghostty/config`, `~/.config/fuzzel/fuzzel.ini`, `~/.zshrc` | portable, uncertain | Personal source config; review fonts, installed plugins, and retained Omarchy lines later. |
| `~/.local/bin/personal-{wallpaper,theme-apply,power-menu,screenshot}` | portable, uncertain | Intended desktop scripts; wallpaper state divergence and border mismatch make some behavior uncertain. |
| `~/.local/bin/personal-kbd-osd*` | machine-specific | Dell LED path and two-level OSD; autodetect later. |
| `~/.local/bin/personal-{audio-*,bluetooth-*,network-*}` | portable, uncertain | Feature scripts called by active QML graph. Network password/QR **outputs** are secret/private; never save outputs. Some optional helpers absent. |
| `~/.local/bin/personal-{dns,font-set,launch-browser,launch-floating-terminal-with-presentation}` | stale/dead, uncertain | Refer to absent helpers, old Omarchy paths/identities or UWSM assumptions. Their presence does not prove usability. |
| `/usr/local/bin/personal-audio-router`, `/etc/systemd/system/personal-audio-router.service` | machine-specific | Active unowned root customization with hardcoded user/UID, sink, event device. Machine override or autodetect later. |
| `/etc/sddm.conf.d/{autologin,theme}.conf` | machine-specific, uncertain | Autologin works for current user; theme selection exists but appearance unverified. Login policy must be configurable later. |
| `/usr/share/sddm/themes/sddm-astronaut-theme` | package/default, uncertain | Package owned AUR theme; no confirmed interactive render. |
| `/etc/systemd/system/autovt@.service` | uncertain | Unowned copied-looking unit; effective role not established. |
| `/etc/NetworkManager/conf.d/20-omarchy-dns.conf` | stale/dead, uncertain | Legacy named config; precise effective DNS state not audited. Do not copy blindly. |
| `~/Pictures/wallpapers/test.jpg`, `~/.local/state/personal-wallpaper/current` | machine-specific, generated | Test image is fallback; state points to the live Downloads image. Runtime state is not source configuration. |
| `~/Downloads/onePiece.png` | machine-specific, uncertain | Actual displayed and saved image at audit time, outside proposed wallpaper library; intentionality unknown. |
| `~/.config/nvim` Git checkout | portable, uncertain | Separate personal `v3` repository; modified lockfile, distinct maintenance decision. |
| `~/repos/sfb/Hyprland` | uncertain | Upstream source checkout; no proof current package binary came from it. |
| `~/.local/bin/agy` | uncertain | Large local ELF executable unrelated to established desktop startup. |
| SDDM/Hyprland/Waybar/Quickshell/Ghostty/Fuzzel/Matugen/awww packages | package/default | Installation inputs later; installed does not establish intended inclusion of every package. |
| Flatpak apps and browser profiles | package/default, secret/private | App IDs are safe inventory; user data, profiles, tokens and credentials must be excluded. |
| NetworkManager profiles, Wi-Fi/QR outputs, keyring, browser data, LUKS material, private environment values | secret/private | Never copy or print; only document that some features depend on them. |

Current package-role classes: **CORE_DESKTOP** Hyprland, current SDDM login path, Waybar, Quickshell, Ghostty, Fuzzel, PipeWire/WirePlumber, NetworkManager; **FEATURE_DEPENDENCY** Matugen, awww, SwayOSD, Hyprlock, Grim, Slurp, wl-clipboard, BlueZ, UPower/power profiles, `evtest`, `jq`, Qt and fonts; **DEVELOPMENT_ONLY** Neovim toolchain; **HARDWARE_SPECIFIC** Dell backlight/audio event setup; **OPTIONAL_APPLICATION** Zen, Nautilus, Stremio and Blanket; **LEFTOVER_OR_UNKNOWN** greetd, Noctalia pieces and untraced CachyOS utilities. This is deliberately not a package manifest.
