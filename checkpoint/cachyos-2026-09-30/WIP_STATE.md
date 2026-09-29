# Development state at the pre-wipe checkpoint

Captured 2026-09-30 (Asia/Kolkata), before a planned Windows 11 + CachyOS reinstall. Development intentionally stops here. Repository base HEAD was `620e2591e7a51f257333aea91beba8ebe8b4d708`; the repository was clean before checkpoint work.

- Stage A is complete. Stage B, the UI foundation, is in progress.
- Tasks 005B and 005C are complete. Task 006, the reactive Battery data repair, is complete.
- Task 007 investigation was completed. Task 007B is **paused**, partially validated, and **not complete**. Task 007 as a whole is **not complete**.
- The current live Calendar semantic migration is preserved in `home/.config/quickshell/personal/panels/calendar/Panel.qml`, SHA-256 `616ada7104bf2866e10dd44ac24fbca2d2a791cfa844a5f2443c38abdbba3a58`.
- Calendar uses `KeyboardPanel.useThemeSurface = true`, `Theme.textPrimary` for primary text, `Theme.textSecondary` for secondary weekdays, `Theme.selected` for the current-day fill, and `Theme.onAccentSoft` for current-day text. Calendar behavior remains the existing simple/static behavior; interactive month navigation is future Stage C work.
- During Task 007B validation, a pre-existing Waybar bug was found: the valid Quickshell IPC command had been placed in `clock.actions.on-click`, which Waybar interpreted as an internal clock action. The unchanged command now sits at clock module top-level `on-click`: `qs ipc -p ~/.config/quickshell/personal call personal.calendar toggle`. The original Calendar and subsequently the migrated Calendar were manually observed opening through this path.
- An extreme alternate palette visibly affected Calendar semantic coloring. The original production palette was restored byte-for-byte. Its live and checkpoint SHA-256 is `7d93e7cb2e5816cdc33df4d75173a5c7d542f04e6163ec42216b9c956cc7b8be`.
- Evidence limit: when the original palette was restored, the Calendar layer was no longer mapped during the runtime check. There was no independent observation of an already-open Calendar transitioning back to original colors live. Do not claim that observation.
- Final Task 007B Calendar, Network, and notification regressions were not completed. Task 007 documentation was not finalized. Do not mark Task 007 or Stage B complete based on this checkpoint.
- The DNS switcher still refers to missing/problematic paths; the legacy `20-omarchy-dns.conf` exists. DNS switching remains unresolved/unverified.

## Resume sequence

1. Restore the checkpoint and verify the desktop runtime.
2. Confirm Calendar and production-palette hashes, and the Waybar clock command location.
3. Test Waybar clock → Quickshell IPC → Calendar popup.
4. Run the remaining Task 007B Calendar, Network, and notification manual regressions.
5. Complete Task 007 documentation only after verification.
6. Decide the next Stage B slice.

Do not substitute older `before-v*` recovery files for the active snapshot. The living project docs and frozen `docs/audit/*` have different purposes; audit files are historical evidence.
