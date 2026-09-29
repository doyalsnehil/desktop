local mainMod = "SUPER"

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

-- Close focused window
hl.bind(mainMod .. " + W", hl.dsp.window.close())

-- Maximize focused window within the workspace
-- Other tiled windows are hidden; bar/working area remains visible.
hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({
        mode = "maximized",
        action = "toggle",
    })
)

-- True fullscreen
-- Covers the entire physical screen, including the bar.
hl.bind(
    mainMod .. " + SHIFT + F",
    hl.dsp.window.fullscreen( {
        mode = "fullscreen",
        action = "toggle",
    })
)

-----------------------------
---- WINDOW FOCUS ---------
---------------------------

-- Vim-style focus navigation
-- These ONLY change focus. They do not move windows.
hl.bind("ALT + H", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + J", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + K", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + L", hl.dsp.focus({ direction = "right" }))

---------------------------
---- LAUNCH APPLICATIONS --
-- App Launcher
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("fuzzel"))
------------------------------

-- Terminal
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("ghostty"))

-- File manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(FILE_MANAGER))

-- Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen"))

------------------------------
---- WORKSPACES -----------
---------------------------

-- Switch workspace: Super + 1..9
for i = 1, 9 do
    hl.bind(
        mainMod .. " + " .. i,
        hl.dsp.focus({ workspace = i })
    )
end

-- Move focused window: Super + Shift + 1..9
for i = 1, 9 do
    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i })
    )
end

---------------------------
---- SPECIAL WORKSPACE ----
---------------------------

-- Toggle special workspace
hl.bind(
    mainMod .. " + S",
    hl.dsp.focus({ workspace = "special" })
)

-- Move focused window to special workspace
hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.window.move({ workspace = "special" })
)

---------------------------
---- SCREENSHOT -----------
---------------------------

-- PrintScreen: select an area, copy screenshot to clipboard
hl.bind(
    "PRINT",
    hl.dsp.exec_cmd("$HOME/.local/bin/personal-screenshot")
)

-- Super + PrintScreen: full screen to clipboard
hl.bind(
    "SUPER + PRINT",
    hl.dsp.exec_cmd("grim - | wl-copy")
)


---------------------------
---- MEDIA & BRIGHTNESS ---
---------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl prev"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Custom Quick Menus
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.local/bin/personal-power-menu"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("qs ipc -p ~/.config/quickshell/personal call personal.network toggle"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("qs ipc -p ~/.config/quickshell/personal call personal.bluetooth toggle"))
