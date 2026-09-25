# Known Issues

Active bugs and investigations only. Priorities reflect the current roadmap; causes remain hypotheses until verified. Remove resolved entries from this living list and preserve any important resolution in appropriate project history. See the [frozen audit](../audit/SYSTEM_AUDIT.md) for baseline evidence.

## Confirmed user-visible bugs

| Priority | Issue | Investigation context |
|---|---|---|
| P0 | Logout from the Super+Escape power menu leaves an illuminated black screen and requires reboot to recover through the GUI. | First planned engineering repair. The menu is configured to use `loginctl terminate-session`; the audit did not exercise logout, so the failing layer/cause is unknown. Preserve the working SDDM autologin-to-Hyprland path. |
| P1 | Notifications do not appear. | User confirmed; the audit found no separate notification daemon running. Determine the intended infrastructure and then provide a useful notification center. |
| P1 | Hardware keyboard-backlight changes have no visible OSD, although the backlight changes. | SwayOSD and the Dell LED-watching daemon ran in the audit. Event delivery and display were not exercised there; diagnose the full path. |

## Audit findings and open investigations

| Priority | Finding | Evidence limit / next question |
|---|---|---|
| P1 | Wallpaper-derived Hyprland border effect is absent. | Runtime border colors/size matched static Lua values, despite the configured Matugen hook. Failure, timing and reload explanations remain unproven. |
| P2 | Quickshell color source retains Omarchy paths that do not exist. | Fallback colors are likely active; rendered colors and Matugen use in live panels were not verified. Resolve with the UI foundation. |
| P2 | DNS switching is broken or at least unverified. | `personal-dns` expects a missing `/usr/bin/personal-dns` and `20-personal-dns.conf`, while a legacy `20-omarchy-dns.conf` exists. Its effective policy and intended behavior need safe investigation. |
| P2 | Several configured helpers and panel behaviors need validation. | Polkit references missing `personal-hw-laptop-closed`; captive-portal and terminal helpers retain missing commands or Omarchy/UWSM assumptions. Battery refresh, WifiQR, speed test and audio-router transitions were not exercised. Avoid recording credential-bearing output. |
| P2 | Interactive SDDM/Astronaut greeter is unproven. | Autologin worked in the audited boot. Do not infer that logout should reach a working greeter or that the theme renders; test at an appropriate later session transition. |

Calendar, battery and tray redesigns are planned product work in the [Roadmap](ROADMAP.md), not evidence of a diagnosed failure. Additional unresolved decisions remain in the frozen [Open Questions](../audit/OPEN_QUESTIONS.md).
