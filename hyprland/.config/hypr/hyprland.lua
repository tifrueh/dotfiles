-- APPS
app_terminal = "kitty"
app_filemanager = "kitty nnn"
app_menu = "tofi-drun --terminal kitty | xargs -I-- hyprctl dispatch 'hl.exec_cmd(\"--\")'"

-- COLORS
col_black = "#282c34"
col_red = "#e06c75"
col_green = "#98c379"
col_yellow = "#e5c07b"
col_blue = "#61afef"
col_magenta = "#c678dd"
col_cyan = "#56b6c2"
col_white = "#dcdfe4"

-- GENERAL
hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 16,
        col = {
            active_border = col_blue,
            inactive_border = col_black,
        },
        layout = "dwindle",
        resize_on_border = false,
        allow_tearing = false,
    }
})

-- DECORATION
hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 4,
        active_opacity = 1.0,
        inactive_opacity = 0.8,
        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            vibrancy = 0.1696,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "#1a1a1aee",
        },
    }
})

-- CURVES
hl.curve( "easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } } )
hl.curve( "easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } } )
hl.curve( "linear", { type = "bezier", points = { {0, 0}, {1, 1} } } )
hl.curve( "almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } } )
hl.curve( "quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } } )

-- ANIMATIONS
hl.config({
    animations = {
        enabled = true,
    }
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- INPUT
hl.config({
    input = {
        follow_mouse = true,
    }
})

-- MISC
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        font_family = "Inter Display"
    }
})

-- ECOSYSTEM
hl.config({
    ecosystem = {
        enforce_permissions = true,
    }
})

-- BINDS

-- Configure some general binds.
hl.bind("SUPER + E", hl.dsp.exec_cmd(app_filemanager), { locked = false} )
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("hyprshutdown"), { locked = true })
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { locked = false })
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"), { locked = false })
hl.bind("SUPER + P", hl.dsp.window.pin({}), { locked = false })
hl.bind("SUPER + Q", hl.dsp.window.close({}), { locked = false })
hl.bind("SUPER + Return", hl.dsp.exec_cmd(app_terminal), { locked = false })
hl.bind("SUPER + Space", hl.dsp.exec_cmd(app_menu), { locked = false })
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }), { locked = false })

-- Configure binds for moving focus.
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "u" }), { locked = false })
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "r" }), { locked = false })
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "d" }), { locked = false })
hl.bind("SUPER + Left", hl.dsp.focus({ direction = "l" }), { locked = false })

-- Configure binds for moving windows.
hl.bind("SUPER + CTRL + Up", hl.dsp.window.move({ direction = "u" }), { locked = false })
hl.bind("SUPER + CTRL + Right", hl.dsp.window.move({ direction = "r" }), { locked = false })
hl.bind("SUPER + CTRL + Down", hl.dsp.window.move({ direction = "d" }), { locked = false })
hl.bind("SUPER + CTRL + Left", hl.dsp.window.move({ direction = "l" }), { locked = false })

-- Configure binds for switching workspace.
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }), { locked = false })
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }), { locked = false })
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }), { locked = false })
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }), { locked = false })
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }), { locked = false })
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }), { locked = false })
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }), { locked = false })
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }), { locked = false })
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }), { locked = false })
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }), { locked = false })

-- Configure binds for moving windows to workspaces.
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }), { locked = false })
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }), { locked = false })
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }), { locked = false })
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }), { locked = false })
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }), { locked = false })
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }), { locked = false })
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }), { locked = false })
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }), { locked = false })
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }), { locked = false })
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }), { locked = false })

-- Configure binds for special workspaces.
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"), { locked = false })
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), { locked = false })
hl.bind("SUPER + M", hl.dsp.focus({ workspace = "name:MUSIC" }), { locked = false })
hl.bind("SUPER + SHIFT + M", hl.dsp.window.move({ workspace = "name:MUSIC" }), { locked = false })
hl.bind("SUPER + G", hl.dsp.focus({ workspace = "name:GAME" }), { locked = false })
hl.bind("SUPER + SHIFT + G", hl.dsp.window.move({ workspace = "name:GAME" }), { locked = false })

-- Configure move/resize with SUPER + LMB/RMB and dragging.
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { locked = false, mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { locked = false, mouse = true })

-- Bind multimedia keys for volume and LCD brightness.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = false })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = false })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = false })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = false })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"), { locked = false })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"), { locked = false })

-- Requires playerctl.
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = false })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = false })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = false })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = false })

-- WINDOWRULES

-- Visually distinguish Xwayland windows.
hl.window_rule({
    name = "xwayland-visual",
    match = {
        xwayland = true
    },
    border_color = col_black,
})

-- AUTOSTART
hl.on("hyprland.start", function ()
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
end)

-- OVERRIDE-HOOK
require("override-hook")
