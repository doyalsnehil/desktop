# Vision

Build a polished, dependable personal CachyOS/Arch Hyprland desktop that behaves as its owner intends. First make the current machine useful, stable, and coherent; verify it there; then turn the mature system into a reproducible repository and installer. Installation automation is a late outcome, not a current design driver.

## Product principles

- Utility and readable information come before decoration. Visual consistency matters; animation and effects must preserve usability.
- Prefer dark, mostly opaque or sufficiently opaque surfaces that stay legible against colorful wallpapers. Avoid transparency as a default aesthetic.
- Keep Super+Space as the application launcher. Add Super+Alt+Space as a System Command Center entry point for desktop and system actions. Underlying tools may use different implementations.
- Preserve useful workflows when redesigning UI. In particular, the network panel should retain connection controls and diagnostics, Wi-Fi QR sharing, DNS controls, and speed testing. A specialized speed-test view may be larger than a standard popup. Improve tray context menus without replacing the tray merely for appearance.
- Make Quickshell UI coherent through shared semantic colors and reusable surfaces, controls, spacing, typography, and interaction states. Let each tool use a layout suited to its job. Matugen should eventually provide wallpaper-derived theming; its exact integration is undecided.
- Keep machine-specific behavior explicit. Detect, parameterize, or deliberately override device names, display settings, user paths, and login policy when reproduction work begins.

## Architectural discipline

The repository is the long-term project memory; conversations are not authoritative project state. `docs/project/` holds living direction and status. `docs/audit/` is a frozen evidence baseline, and `docs/history/` preserves historical claims and intent. Prefer observed behavior, loaded configuration, and runtime state over mere file presence or old handoffs. Distinguish **exists**, **active**, **loaded**, **working**, **portable**, and **intentional**; none implies the next.

Treat generated Waybar colors, Ghostty themes, and Matugen palettes as outputs, not canonical source. Installed packages are evidence, not an installation manifest. Do not migrate passwords, tokens, Wi-Fi credentials, browser profiles or cookies, SSH/VPN keys, credential stores, LUKS material, machine identity, or secret environment values.
