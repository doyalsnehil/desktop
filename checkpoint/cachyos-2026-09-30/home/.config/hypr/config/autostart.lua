-- Personal Hyprland autostart

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("$HOME/.local/bin/personal-wallpaper")
    hl.exec_cmd("$HOME/.local/bin/personal-kbd-osd-daemon")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("waybar")
    hl.exec_cmd(
        "env PATH=$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin " ..
        "QML2_IMPORT_PATH=$HOME/.config/quickshell/personal " ..
        "QML_IMPORT_PATH=$HOME/.config/quickshell/personal " ..
        "qs -p $HOME/.config/quickshell/personal"
    )
end)
