# Known Issues

Active bugs and investigations only. Priorities reflect the current roadmap; causes remain hypotheses until verified. Remove resolved entries from this living list and preserve any important resolution in appropriate project history. See the [frozen audit](../audit/SYSTEM_AUDIT.md) for baseline evidence.

## Audit findings and open investigations

| Priority | Finding | Evidence limit / next question |
|---|---|---|
| P1 | Wallpaper-derived Hyprland border effect is absent. | Runtime border colors/size matched static Lua values, despite the configured Matugen hook. Failure, timing and reload explanations remain unproven. |
| P2 | Quickshell color source retains Omarchy paths that do not exist. | Fallback colors are likely active; rendered colors and Matugen use in live panels were not verified. Resolve with the UI foundation. |
| P2 | DNS switching is broken or at least unverified. | `personal-dns` expects a missing `/usr/bin/personal-dns` and `20-personal-dns.conf`, while a legacy `20-omarchy-dns.conf` exists. Its effective policy and intended behavior need safe investigation. |
| P2 | Several configured helpers and panel behaviors need validation. | Polkit references missing `personal-hw-laptop-closed`; captive-portal and terminal helpers retain missing commands or Omarchy/UWSM assumptions. Battery refresh, WifiQR, speed test and audio-router transitions were not exercised. Avoid recording credential-bearing output. |

Calendar, battery and tray redesigns are planned product work in the [Roadmap](ROADMAP.md), not evidence of a diagnosed failure. Additional unresolved decisions remain in the frozen [Open Questions](../audit/OPEN_QUESTIONS.md).
