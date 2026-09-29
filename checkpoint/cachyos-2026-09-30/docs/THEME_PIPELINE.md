# Theme and wallpaper pipeline

```text
selected local wallpaper (not preserved here)
  -> ~/.local/bin/personal-wallpaper
  -> matugen image ... --mode dark --type scheme-content --source-color-index 0
  -> ~/.config/matugen/config.toml + templates/
       -> generated/palette.json -> Quickshell Commons/Theme.qml
                                -> personal-theme-apply -> Hyprland border keywords
       -> ~/.config/waybar/colors.css -> style.css import
       -> ~/.config/ghostty/themes/personal -> Ghostty theme = personal
  -> awww display path (the helper's `awww img` line is currently commented)
```

**Source:** the wallpaper helper and theme apply script under `home/.local/bin/`, Matugen `config.toml` and `templates/`, Quickshell `Commons/{Theme,Color,Style,Border}.qml`, Waybar source CSS, Ghostty source config, and Hyprland Lua modules. `Color.qml` retains legacy Omarchy compatibility readers; do not assume that makes old paths active or safe to delete. No theme regeneration occurred during checkpoint creation.

**Generated references:** `generated-reference/home/.config/matugen/generated/palette.json`, Waybar `colors.css`, Ghostty `themes/personal`, and Noctalia-created GTK/Qt colors. These are known-good output snapshots, not the canonical editing source. Restore them as a temporary reference only or regenerate after the wallpaper and packages are in place. Production palette SHA-256: `7d93e7cb2e5816cdc33df4d75173a5c7d542f04e6163ec42216b9c956cc7b8be`.

Quickshell `Theme.qml` reads palette JSON directly and validates it. `Style.qml`, `Color.qml`, and `Border.qml` coexist during the Stage B migration. Waybar and Ghostty consume separate Matugen output templates. The current wallpaper helper checks for an awww daemon, invokes Matugen, invokes `personal-theme-apply`, and signals Waybar. Its actual `awww img` command is commented; record that behavior rather than assuming the helper sets the image. An earlier project investigation found runtime Hyprland borders matching static Lua settings despite the configured theme hook; this remains unresolved.
