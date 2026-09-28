# Known Issues

Active bugs and investigations only. Priorities reflect the current roadmap; causes remain hypotheses until verified. Remove resolved entries from this living list and preserve any important resolution in appropriate project history. See the [frozen audit](../audit/SYSTEM_AUDIT.md) for baseline evidence.

## Audit findings and open investigations

| Priority | Finding | Evidence limit / next question |
|---|---|---|
| P1 | Wallpaper-derived Hyprland border effect is absent. | Runtime border colors/size matched static Lua values, despite the configured Matugen hook. Failure, timing and reload explanations remain unproven. |
| P2 | Legacy Quickshell `Color.qml` retains compatibility paths for absent Omarchy themes. | The verified `Theme` singleton reads Matugen `palette.json` directly. Battery's panel surface and three power-profile buttons use opt-in shared Theme paths; Network, Speedtest and other legacy Button consumers have not migrated. Remaining `Color.qml` consumers need migration/cleanup; their rendered colors were not individually verified. |
| P2 | DNS switching is broken or at least unverified. | `personal-dns` expects a missing `/usr/bin/personal-dns` and `20-personal-dns.conf`, while a legacy `20-omarchy-dns.conf` exists. Its effective policy and intended behavior need safe investigation. |
| P2 | Several configured helpers and panel behaviors need validation. | Polkit references missing `personal-hw-laptop-closed`; captive-portal and terminal helpers retain missing commands or Omarchy/UWSM assumptions. WifiQR and speed test passed manual 005C regression checks; audio-router transitions were not exercised. Avoid recording credential-bearing output. |
| P3 | Network emitted height binding-loop warnings during manual 005C interaction. | Warnings appeared for a section header and row text while Network was used, then stopped after interaction. No functional failure was observed, and causation by 005C is not established. Investigate if they recur in relevant work. |

Calendar, battery and tray visual redesigns remain planned product work in the [Roadmap](ROADMAP.md). Task 006's verified Battery data repair is recorded in [Current State](CURRENT_STATE.md). Additional unresolved decisions remain in the frozen [Open Questions](../audit/OPEN_QUESTIONS.md).
