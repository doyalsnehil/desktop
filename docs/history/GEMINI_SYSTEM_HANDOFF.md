# System Handoff

## 1. Executive Overview
This machine runs a heavily customized Arch-based Linux desktop (CachyOS) using Hyprland (Wayland) as the compositor. The system has explicitly migrated away from the "Omarchy" dotfiles ecosystem to establish a distinct, personally tailored architecture.

The environment utilizes `Ghostty` as the terminal, `Zsh` as the shell, `Waybar` for the top panel, and a custom `Quickshell` implementation for interactive overlays (Network, Bluetooth, Audio dropdowns). Wallpaper and dynamic system-wide colors are orchestrated via `awww`, `Matugen`, and an array of interconnected shell scripts. 

The entire desktop boot process is secured by a LUKS (Plymouth) pre-boot prompt, followed by `SDDM` (running the Astronaut theme) which is explicitly configured to auto-login to Hyprland to prevent double-password entry.

## 2. Current Desktop Architecture
The desktop reaches its running state via the following flow:
1. LUKS Decryption (Plymouth).
2. `SDDM` launches. Due to `/etc/sddm.conf.d/autologin.conf`, it immediately launches `Hyprland`.
3. Hyprland loads its primary configuration via a custom Lua wrapper.
4. `~/.config/hypr/config/autostart.lua` executes, spawning background daemons:
   - `dbus-update-activation-environment`
   - `awww-daemon` (Wallpaper engine)
   - `swayosd-server` (Hardware indicator engine)
   - `personal-kbd-osd-daemon` (Custom Python script to monitor Dell hardware brightness)
   - `waybar` (Top bar)
   - `qs` (Quickshell UI overlays)
5. `autostart.lua` also triggers `~/.local/bin/personal-wallpaper` which:
   - Sets the wallpaper via `awww`.
   - Runs `matugen` to extract a color palette.
   - Triggers `SIGUSR1` to reload Ghostty colors and `SIGUSR2` to reload Waybar CSS.

## 3. Hyprland
VERIFIED: Hyprland is configured via a custom Lua wrapper. All active configurations reside in `~/.config/hypr/config/*.lua`.

**Autostart:**
VERIFIED: `~/.config/hypr/config/autostart.lua` handles all `exec-once` behavior using `hl.exec_cmd(...)`.

**Keybindings (`binds.lua`):**
VERIFIED: Syntax uses concatenated strings: `hl.bind("CTRL + SHIFT + I", hl.dsp.exec_cmd("..."))`.
- `Super + 1..9`: Switch workspace.
- `Super + Shift + 1..9`: Move window to workspace.
- `Super + L`: `hyprlock`.
- `Super + Escape`: Launches `~/.local/bin/personal-power-menu`.
- `Super + Ctrl + W`: Triggers Quickshell WiFi overlay (`qs ipc -p ... call personal.network toggle`).
- `Super + Ctrl + B`: Triggers Quickshell Bluetooth overlay.
- `Print`: Select rectangular area and copy to clipboard (`personal-screenshot`).
- `Super + Print`: Full screen screenshot directly to clipboard (`grim - | wl-copy`).

**Window Rules (`windowrules.lua`):**
VERIFIED: Syntax uses tables: `hl.window_rule({ match = { class = "..." }, float = true })`.
Handles Picture-in-Picture resizing, XWayland drag fixes, floating modals, and `noctalia` layer blurs.

**Gestures (`inputs.lua`):**
VERIFIED: 3-finger and 4-finger workspace swipe gestures (`hl.gesture`) were intentionally removed. The touchpad functions strictly as a standard pointing device.

## 4. Quickshell
VERIFIED: Quickshell runs locally from `~/.config/quickshell/personal/`.
- **Entry Point:** Started in `autostart.lua` via `qs -p $HOME/.config/quickshell/personal`.
- **Modules:** Panels exist for Audio, Battery, Bluetooth, Calendar, Network, Polkit, Speedtest, and WifiQR. 
- **IPC Interface:** All interaction between Waybar and Quickshell goes through `qs ipc` calls (e.g., `qs ipc -p ~/.config/quickshell/personal call personal.network toggle`).
- **Workspace Indicator:** The workspace indicator is rendered by Quickshell (`WorkspaceIndicator.qml`), not Waybar, to allow smooth capsule animations.

## 5. Matugen and Theming
VERIFIED: Theming is entirely dynamic and wallpaper-driven.
- **Entry:** `~/.local/bin/personal-wallpaper` invokes `matugen image "$image" --mode dark --type scheme-content`.
- **Configuration:** `~/.config/matugen/config.toml` dictates outputs.
- **Outputs:**
  - Ghostty Theme: `~/.config/ghostty/themes/personal`.
  - Waybar CSS: `~/.config/waybar/colors.css`.
  - JSON Palette: `~/.config/matugen/generated/palette.json`.
- **Reloading:** Matugen `post_hook` commands trigger `pkill -SIGUSR1 ghostty` and `pkill -SIGUSR2 waybar`.
- **Hyprland Borders:** `~/.local/bin/personal-theme-apply` reads the generated JSON and uses `hyprctl keyword general:col.active_border` to theme window borders.

## 6. Startup / Session Lifecycle
(See Section 2: Current Desktop Architecture). 
INFERRED: The system relies strictly on Hyprland's `autostart.lua` to sequence the boot process. Systemd user services are generally avoided for core UI components (like `awww-daemon`) to ensure they run inside the correct Wayland environment scope.

## 7. Custom Scripts
VERIFIED: ALL custom scripts are centralized in `~/.local/bin/` and strictly prefixed with `personal-`.
- `personal-wallpaper`: Manages `awww-daemon` and `matugen`.
- `personal-power-menu`: Fuzzel-based script. Uses `loginctl terminate-session $XDG_SESSION_ID` to safely exit Hyprland.
- `personal-screenshot`: Wraps `slurp`, `grim`, and `wl-copy`.
- `personal-kbd-osd-daemon`: A highly specific Python `POLLPRI` daemon that watches sysfs for Dell keyboard backlight changes.
- `personal-theme-apply`: Updates Hyprland borders from Matugen JSON.

## 8. Services and Daemons
- **SDDM:** Replaced `greetd`. `systemctl enable sddm.service` is active.
- **SwayOSD:** `swayosd-server` runs in the background. Handled via Hyprland autostart, not systemd, to ensure Wayland variable propagation.
- **Python Kbd Daemon:** Runs in the background via Hyprland autostart to monitor `/sys/class/leds/dell::kbd_backlight/brightness`.

## 9. Packages and Manually Installed Software
VERIFIED:
- **Display:** `sddm`, `sddm-astronaut-theme` (AUR), `qt6-declarative`, `qt6-svg`.
- **Terminal UI:** `ghostty`, `fuzzel`.
- **Indicators:** `swayosd`, `libappindicator-gtk3` (AUR) installed to fix tray icons for Electron/Flutter apps (Stremio, LocalSend).
- **Editor:** `neovim` (cloned from user's `v3` branch). Dependencies `npm`, `rustup`, `tree-sitter-cli` explicitly installed.
- **Shell:** `zoxide`.

## 10. System-Level Changes
VERIFIED: 
- `/etc/sddm.conf.d/autologin.conf`: Forcefully boots the user session without a second password prompt.
- `/etc/sddm.conf.d/theme.conf`: Sets `Current=sddm-astronaut-theme`.
- `udevadm control --reload-rules`: Triggered to ensure `swayosd` has raw `/dev/input` and `video` hardware access.

## 11. Shell / Terminal / Developer Environment Relevant to Desktop
VERIFIED: 
- **Ghostty:** `~/.config/ghostty/config` utilizes `theme = personal`. `window-padding-x = 12` added for spacing.
- **Zsh:** `~/.zshrc` explicitly disables `ENABLE_CORRECTION="true"` (set to `"false"`) to suppress `[nyae]?` prompts.
- **Zoxide:** Injected into `~/.zshrc` via `eval "$(zoxide init zsh --cmd cd)"`.

## 12. Keybindings and User Workflows
(See Section 3: Hyprland). The workflow is keyboard-first, relying on Vim-style navigation (`Alt+H/J/K/L`) for focus changing without moving windows, and `Super+Shift+1..9` to throw windows.

## 13. Hardware-Specific Configuration
VERIFIED: 
- **Dell Keyboard Backlight:** The Dell Embedded Controller intercepts `Fn+F10` invisibly. Linux receives no keypress event. The `personal-kbd-osd-daemon` hardcodes the path `/sys/class/leds/dell::kbd_backlight/brightness` to watch for hardware-level electrical changes. This will fail on any non-Dell laptop.
- **Monitors:** (Previous context notes scaling issues on `eDP-1`, though `monitors.lua` currently handles it).

## 14. Machine-Specific vs Portable Configuration
- **Portable:** Hyprland rules, Waybar config, Quickshell UI, Matugen templates, Fuzzel power menu, Zsh configuration.
- **Machine-Specific:** SDDM Auto-login (requires specific `$USER`), `personal-kbd-osd-daemon` (requires Dell sysfs paths).

## 15. Failed / Reverted Approaches
VERIFIED: 
- **hyprctl dispatch exit:** Failed in the Fuzzel power menu because the custom Lua wrapper intercepts `hyprctl`. Reverted to `loginctl terminate-session $XDG_SESSION_ID`.
- **sed CSS Surgery:** Attempting to use `sed` to modify Waybar's `style.css` previously corrupted the file and crashed the modules. Do not attempt blind `sed` regex on multiline CSS or Lua.
- **App Store Script:** A terminal-based `fzf` script ("Floating App Store") was created and bound to `Ctrl+Shift+I`. The user hated it because it felt rudimentary. It was entirely purged.
- **awww-daemon backgrounding:** Attempting to `pkill awww-daemon` and launch it via `nohup` inside a bash script failed because systemd killed the daemon when the bash script exited. `awww-daemon` must be launched persistently from `autostart.lua`.

## 16. Important Historical Decisions and Why
- **Python Polling Daemon:** We use a Python `select.POLLPRI` script instead of standard Hyprland binds for the keyboard backlight because the hardware intercepts the key. `inotify-tools` was missing, so a zero-overhead Python script was the most robust solution.
- **Renaming to personal-*:** We used a global find-and-replace to change all `omarchy-*` scripts to `personal-*` to permanently strip the old ecosystem branding. This required heavily patching Quickshell QML files.

## 17. Known Bugs / Fragile Areas
UNCERTAIN: Flatpak apps (like Stremio) installed via CLI will not appear in Fuzzel until the session restarts because `XDG_DATA_DIRS` is not dynamically evaluated by Wayland mid-session.
VERIFIED: The Lua syntax in Hyprland is highly fragile. Any typo in `binds.lua` or `windowrules.lua` causes the wrapper to crash and throw a massive red error bar on the screen.

## 18. Unfinished Work
INFERRED: The user still desires a highly polished "App Store" UI (likely native Quickshell or a heavily customized Rofi/Fuzzel) to replace the failed `fzf` terminal script.

## 19. Security / Secrets That Must NOT Be Migrated
SECRET REQUIRED: LUKS Disk Encryption keys.
SECRET REQUIRED: User password for SDDM auto-login configuration (if hardcoded elsewhere).

## 20. Candidate Items for Future `desktop` Repository
- **Portable:** `~/.config/hypr/`, `~/.config/waybar/`, `~/.config/quickshell/`, `~/.config/matugen/`, `~/.config/ghostty/`, `~/.local/bin/personal-*`
- **Machine-Specific (Do Not Track As-Is):** `/etc/sddm.conf.d/autologin.conf`, `personal-kbd-osd-daemon` (needs parameterization for `/sys/class/leds/*`).

## 21. Unknowns and Unverified Claims
UNCERTAIN: It is unknown if the user actually successfully rebooted to load the `swayosd` udev rules. If they have not rebooted, the OSD will still not have access to raw input devices.
UNCERTAIN: Bluetooth routing. A `personal-audio-router` service exists but has not been deeply verified for Bluetooth headset handoffs in the current session.

## 22. Evidence / Verification Appendix
- `ls -la ~/.local/bin/` confirmed 21 custom `personal-*` scripts.
- `cat ~/.config/hypr/config/binds.lua` confirmed strict Lua concatenation syntax.
- `cat /etc/sddm.conf.d/autologin.conf` confirmed SDDM bypass.
- `cat ~/.local/bin/personal-power-menu` confirmed `loginctl` usage.
- `cat ~/.config/hypr/config/inputs.lua` confirmed absence of `hl.gesture` lines.
