# Roadmap

**Current stage: B — UI foundation (in progress).** Stage A critical stability is complete. The first verified Stage B slice connects the Matugen raw palette to a Quickshell semantic Theme singleton, an opt-in shared panel surface, and Battery as its first representative consumer. Stages express dependency and intent, not completion claims or a detailed issue tracker. Validate changes on the current machine before advancing. See [Known Issues](KNOWN_ISSUES.md) for active faults and [Current State](CURRENT_STATE.md) for the evidence baseline.

| Stage | Outcome | Key dependency or boundary |
|---|---|---|
| A — Critical stability | Repair logout, establish visible notifications, restore keyboard-backlight OSD. | Prove session transitions safely; working autologin does not prove greeter behavior. |
| B — UI foundation | Shared Quickshell primitives/tokens and coherent Matugen color integration. | Extend the verified semantic theme path incrementally; migrate legacy color consumers before broad UI rewrites. |
| C — Core desktop UI | Interactive month calendar, redesigned battery panel, coherent tray context menus, notification center. | Build on B; retain useful actions and information. |
| D — System Command Center | Super+Alt+Space hierarchy and extensible action entry point. | Keep Super+Space for applications; integrate underlying tools without forcing one UI technology. |
| E — System tools | Package install/remove/update for Arch/CachyOS, AUR and Flatpak; wallpaper picker; clean DNS switching. | Expose through D; investigate existing DNS behavior before replacing it. |
| F — Utilities | Emoji picker, searchable keybinding helper, screenshot-to-annotation flow, screen recorder with audio choices and visible stop/record state. | Integrate through D where useful; reuse suitable existing editing tools. |
| G — Web Apps | URL-to-launcher creator, initially Helium oriented, with metadata/icon retrieval where feasible and future browser choice. | Add to D's Install hierarchy; generated `.desktop` entries should appear in the normal launcher. |
| H — Cleanup | Remove remaining inappropriate Omarchy assumptions, dead helpers, inactive configuration and legacy components. | Decide intentionality from observed use; avoid deleting merely because a file looks old. |
| I — Polish | Consistent animation, UX, errors and edge cases. | Follow functioning core workflows. |
| J — Verification | Reboot, login/logout, suspend/resume, networking, Bluetooth, audio and hardware end-to-end checks. | Confirm the mature desktop on this machine before portability claims. |
| K — Reproduction | Canonical config layout, package manifest, machine abstraction and installation/bootstrap system. | Begin only after the desktop is mature and verified; exclude private state and generated outputs. |

Stage C's future rich notification pass should evaluate and, where supported by the sending application and protocol, implement default action/click-to-open, richer actions, inline replies, images/avatars, categories and appropriate presentation, and urgency-aware presentation. It should also cover a notification center/history, DND, clear-one/clear-all, a bell/count entry point, multi-monitor behavior, and a persistence/history policy. These are planned capabilities, not unresolved Task 003 stability bugs.

## Workflow requirements to carry forward

- Command Center hierarchy: Applications (install Arch/CachyOS, AUR, Flatpak or Web App; remove; update), Desktop (wallpaper, appearance, display), Utilities (screenshot, recording, emoji, keybindings), and System actions/diagnostics as needed.
- Calendar: a real interactive month view with previous/next month navigation and clear current-date presentation. Network: preserve useful connection, signal, known-network, QR/password, ping/loss, traffic, IP/gateway, DNS and speed-test information or controls.
- Screenshot: capture display, window or region, open annotation immediately (including blur, arrows and drawing), then copy or save. Recording: choose display/window/region and desktop audio/microphone combinations, with clear recording and stop controls.
- Web Apps: paste a URL, obtain useful metadata/icon where possible, create a launcher visible through Super+Space; favor Chromium-family app-mode behavior with Helium initially, without binding the architecture to one browser.

Media controls and track information are low-priority backlog, to revisit after the core workflow is stable.
