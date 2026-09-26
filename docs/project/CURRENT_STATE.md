# Current State

**Last updated:** 2026-09-26 (Asia/Kolkata)

This is a living summary of the [frozen forensic audit](../audit/SYSTEM_AUDIT.md), observed on 2026-09-26, with later runtime verification noted below. It does not establish that every configured action works. For claim corrections and detailed lifecycle paths, see [Gemini Claim Verification](../audit/GEMINI_CLAIM_VERIFICATION.md) and the [Dependency Graph](../audit/DEPENDENCY_GRAPH.md).

## Verified participation in the audited session

- CachyOS runs a Wayland Hyprland session launched through enabled SDDM autologin and `/usr/bin/start-hyprland`. Greetd is installed but disabled/inactive. The audited boot alone did not establish interactive greeter rendering; the later logout test below did.
- `~/.config/hypr/hyprland.lua` and its `config/*.lua` modules are the evident configuration graph, corroborated by runtime Lua binds and matching startup children. Exact implicit file loading was inferred, not traced. Hyprland starts Waybar, `qs -p ~/.config/quickshell/personal`, awww, SwayOSD and the keyboard OSD daemon.
- Waybar is the live bar and renders `hyprland/workspaces`; the Quickshell `WorkspaceIndicator.qml` exists but is not instantiated. The active Quickshell root, `personal/shell.qml`, instantiates Calendar, Network, Bluetooth, Audio, Battery, WifiQR, Speedtest, Polkit and, since Task 003B, notification components. The older components' individual interactions were not exercised in the audit.
- awww displays a Downloads image that matched saved wallpaper state at audit time. The startup wallpaper/Matugen chain is strongly supported by configuration and generated-file timestamps. Matugen generates Waybar CSS, a Ghostty theme and palette JSON; these outputs are not source files. Live Hyprland borders still matched static Lua settings rather than the configured palette hook.
- PipeWire/WirePlumber, NetworkManager, Bluetooth and power-profile services were active. A separate `personal-audio-router.service` ran as root with machine-specific user, sink and event-device values; actual routing transitions were not tested.

## Logout and interactive login verified after the audit

- On 2026-09-26, Super+Escape → Logout with `personal-power-menu` running `hyprctl dispatch "hl.dsp.exit()"` exited Hyprland and displayed SDDM's interactive Astronaut greeter. The user selected plain **Hyprland**, signed in, and returned to a working desktop without a reboot or SDDM restart. The verified Wayland session was active on tty1 and followed `sddm` → `sddm-helper` → `/usr/bin/start-hyprland` → `Hyprland`.
- The same boot's SDDM journal records the previous helper exiting successfully at 13:15:15, greeter startup with `/usr/bin/sddm-greeter-qt6 --theme /usr/share/sddm/themes/sddm-astronaut-theme`, a login request at 13:15:50, and a new `/usr/bin/start-hyprland` Wayland session. This verifies one complete logout-to-greeter-to-desktop cycle, including interactive greeter rendering.
- `/etc/sddm.conf.d/autologin.conf` still sets `Session=hyprland`; the boot journal resolved it to `/usr/share/wayland-sessions/hyprland.desktop` with `Exec=/usr/bin/start-hyprland`. **Hyprland (uwsm-managed)** is a separate session entry, `/usr/share/wayland-sessions/hyprland-uwsm.desktop`, with `Exec=uwsm start -e -D Hyprland hyprland.desktop`. Neither autologin nor the verified manual login used UWSM.
- The earlier `loginctl terminate-session` path killed the SDDM helper with the session scope and was followed by a black screen. Changing only the Logout action resolved the observed failure in this controlled test; the exact internal reason SDDM did not start a greeter after the forced termination remains unproven.

## Notifications verified after the audit

- Quickshell 0.3.1 is the active notification server and owns `org.freedesktop.Notifications`. The implementation lives in the personal Quickshell configuration at `~/.config/quickshell/personal/shell.qml` and `panels/notifications/ToastHost.qml`, outside this repository. Its `NotificationServer` tracks received notifications in memory; the toast view uses that tracked state without a separate history model.
- Basic top-right toasts were manually verified on this machine's one active internal display, including application name, summary, plain-text body and dismissal. Action labels and invocation were manually verified. Runtime checks covered empty bodies, missing icons, timeout behavior, critical and zero-timeout retention, replacement and remote close. At most three cards appear at once; a fourth tracked notification appeared when a visible card was dismissed.
- `keepOnReload` was manually verified across a real configuration reload: one persistent notification survived exactly once and remained dismissible. Action hover contrast and a movement artifact were found, repaired and manually rechecked. Process-restart persistence is not provided or verified. A notification center, durable history, DND, image rendering, inline replies, final shared styling/Matugen integration and sophisticated multi-monitor routing remain future work; multi-monitor behavior was not tested.

## Configured, uncertain, or absent

- Super+Space/Fuzzel, screenshot binds, panel IPC and other on-demand actions are configured; most were not triggered by the audit. Super+Escape/power-menu Logout and Quickshell notifications were subsequently tested as described above.
- SwayOSD and a Dell keyboard LED watcher were running, but the user reports no visible OSD when the hardware backlight changes.
- Active Quickshell color code references absent Omarchy theme paths. Its built-in fallback likely supplies colors; generated Matugen JSON is not proven to color active Quickshell panels. DNS helper paths conflict with a legacy Omarchy-named NetworkManager file; effective DNS behavior was not audited.
- No canonical repo layout, Stow setup, or live-config symlink to this repository was found. The audit package inventory is not a future manifest. The local hardware/path assumptions and scripts need later intentionality and portability decisions; see the [Portability Matrix](../audit/PORTABILITY_MATRIX.md).

When updating this file, prefer current observable behavior, loaded configuration, process/service state, package state, then git/symlink/timestamp evidence, inactive configuration and historical claims. Preserve the difference between exists, active, loaded, working, portable and intentional. Recheck the runtime after implementation rather than promoting an audit hypothesis to fact.
