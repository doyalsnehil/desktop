# Current State

**Last updated:** 2026-09-26 (Asia/Kolkata)

This is a living summary of the [frozen forensic audit](../audit/SYSTEM_AUDIT.md), observed on 2026-09-26. It does not establish that every configured action works. For claim corrections and detailed lifecycle paths, see [Gemini Claim Verification](../audit/GEMINI_CLAIM_VERIFICATION.md) and the [Dependency Graph](../audit/DEPENDENCY_GRAPH.md).

## Verified participation in the audited session

- CachyOS runs a Wayland Hyprland session launched through enabled SDDM autologin and `/usr/bin/start-hyprland`. Greetd is installed but disabled/inactive. This proves the boot path for the audited session, not interactive SDDM greeter rendering or future boot reliability.
- `~/.config/hypr/hyprland.lua` and its `config/*.lua` modules are the evident configuration graph, corroborated by runtime Lua binds and matching startup children. Exact implicit file loading was inferred, not traced. Hyprland starts Waybar, `qs -p ~/.config/quickshell/personal`, awww, SwayOSD and the keyboard OSD daemon.
- Waybar is the live bar and renders `hyprland/workspaces`; the Quickshell `WorkspaceIndicator.qml` exists but is not instantiated. The active Quickshell root, `personal/shell.qml`, instantiates Calendar, Network, Bluetooth, Audio, Battery, WifiQR, Speedtest and Polkit components. Their individual interactions were not exercised in the audit.
- awww displays a Downloads image that matched saved wallpaper state at audit time. The startup wallpaper/Matugen chain is strongly supported by configuration and generated-file timestamps. Matugen generates Waybar CSS, a Ghostty theme and palette JSON; these outputs are not source files. Live Hyprland borders still matched static Lua settings rather than the configured palette hook.
- PipeWire/WirePlumber, NetworkManager, Bluetooth and power-profile services were active. A separate `personal-audio-router.service` ran as root with machine-specific user, sink and event-device values; actual routing transitions were not tested.

## Configured, uncertain, or absent

- Super+Space/Fuzzel, Super+Escape/power menu, screenshot binds, panel IPC and other on-demand actions are configured; most were not triggered by the audit. The user's subsequent report confirms the logout action currently fails. The audit found no separate notification daemon; the user reports notifications do not appear.
- SwayOSD and a Dell keyboard LED watcher were running, but the user reports no visible OSD when the hardware backlight changes. Interactive Astronaut greeter rendering remains unproven despite its theme selection file.
- Active Quickshell color code references absent Omarchy theme paths. Its built-in fallback likely supplies colors; generated Matugen JSON is not proven to color active Quickshell panels. DNS helper paths conflict with a legacy Omarchy-named NetworkManager file; effective DNS behavior was not audited.
- No canonical repo layout, Stow setup, or live-config symlink to this repository was found. The audit package inventory is not a future manifest. The local hardware/path assumptions and scripts need later intentionality and portability decisions; see the [Portability Matrix](../audit/PORTABILITY_MATRIX.md).

When updating this file, prefer current observable behavior, loaded configuration, process/service state, package state, then git/symlink/timestamp evidence, inactive configuration and historical claims. Preserve the difference between exists, active, loaded, working, portable and intentional. Recheck the runtime after implementation rather than promoting an audit hypothesis to fact.
