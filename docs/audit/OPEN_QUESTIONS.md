# Questions that require later safe evidence or a user decision

1. Did the Astronaut theme ever render as intended, and should SDDM autologin and the theme be part of the eventual design? This session proves autologin only; verifying the greeter needs a future login transition and explicit timing chosen by the user.
2. Should the current `/home/snehil/Downloads/onePiece.png` wallpaper be considered intentional source artwork? The saved state and live awww image agree, but the file lives outside `~/Pictures/wallpapers` and the original selection event is unknown.
3. Why are Hyprland's current borders static despite the Matugen palette hook and direct helper call? An early socket race, failed script, or later reload could explain it, but none was proven. Do not repair during this audit.
4. Are Quickshell popup interactions, Polkit prompts, battery refresh, WifiQR, speed test, and the root audio router actually working? Their QML/scripts or service are loaded, but the actions were not triggered. Several missing helper references and the absent Omarchy theme directory should be resolved in a later design phase.
5. Is the legacy `/etc/NetworkManager/conf.d/20-omarchy-dns.conf` effective, and what intended DNS behavior should survive? Current `personal-dns` expects a differently named config. Avoid copying NetworkManager profiles or secret values.
6. Which packages among Noctalia, greetd, older CachyOS utilities, and development tools are intentionally retained? Installation alone does not decide future manifest membership.
7. Is `~/repos/sfb/Hyprland` related to the installed Hyprland package, or simply an upstream source checkout? No build linkage was established.
8. Which machine-specific defaults should be autodetected versus offered as machine overrides later: monitor layout, battery/keyboard LED, audio event/sink, login user, and wallpaper path?

These are evidence limits and future decisions, not requests to modify the live desktop now.
