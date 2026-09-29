# Machine and user assumptions

- Host at capture: `linux`; CachyOS rolling, kernel `7.2.8-1-cachyos`; primary user account `snehil` (UID 1000 in the audio router). Replace account names and hardcoded `/home/snehil` paths deliberately on another machine.
- Internal display: `eDP-1`, `1920x1080@60`, scale 1, position `0x0` in the Hyprland Lua monitor module.
- Keyboard backlight: `/sys/class/leds/dell::kbd_backlight`. The verified watcher waits for `brightness_hw_changed` and reads `brightness`; brightness maximum was 2 on this Dell hardware. The watcher is launched by Hyprland autostart.
- The system audio router hardcodes `alsa_output.pci-0000_00_1f.3.analog-stereo`, the headset input device name `HDA Intel PCH Headphone Mic`, UID 1000, and user `snehil`. Review those before restoring its root-run service.
- Battery uses `Quickshell.Services.UPower` and `UPower.displayDevice`; `BAT0` is not the canonical Battery data source.
- Quickshell and some Waybar entries contain `/home/snehil` paths. The session uses `~/.local/bin` in PATH. The plain Hyprland session is active; the separately installed UWSM entry is not the current session.
- GPU and output assumptions should be checked on the new installation. MPV currently requests Vulkan/VA-API. No hardware serial, MAC, machine ID, or private UUID is recorded here.
- The selected wallpaper is `~/Downloads/onePiece.png`, SHA-256 `a086e38bdc598c84b67f04ca1b1239bca1e8f8464d5920b45cfc7f959d08e8d4` (291 KiB observed). It is **not in this public checkpoint**. Privately retain or replace that file, then set the local wallpaper path. `personal-wallpaper` defaults to `~/Pictures/wallpapers/test.jpg` only if no saved state exists; the live saved state pointed to the Downloads image.
