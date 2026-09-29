-- Layer rules for desktop surfaces

-- Floating Waybar glass effect.
hl.layer_rule({
    match = {
        namespace = "waybar",
    },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.15,
})
