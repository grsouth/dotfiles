----------------
--- MONITORS ---
----------------

hl.monitor({
    output = "DP-1",
    mode = "3440x1440@165",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "DP-2",
    mode = "3440x1440@100",
    position = "0x-1440",
    scale = 1,
})

for workspace = 1, 3 do
    hl.workspace_rule({ workspace = tostring(workspace), monitor = "DP-1" })
end

for workspace = 4, 6 do
    hl.workspace_rule({ workspace = tostring(workspace), monitor = "DP-2" })
end

hl.config({
    layout = {
        single_window_aspect_ratio = { 6, 5 },
        single_window_aspect_ratio_tolerance = 0.1,
    },
})


-------------------
--- MY PROGRAMS ---
-------------------

local terminal = "alacritty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local runner = "rofi -show run"
local browser = "vivaldi"


-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("udiskie")
end)


-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 5,

        border_size = 3,

        col = {
            active_border = {
                colors = { "rgba(ffb454cc)", "rgba(ff8f40cc)" },
                angle = 45,
            },
            inactive_border = "rgba(3f4a59aa)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        blur = {
            enabled = false,
        },

        shadow = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})
hl.curve("md3_standard", {
    type = "bezier",
    points = { { 0.2, 0 }, { 0, 1 } },
})
hl.curve("md3_decel", {
    type = "bezier",
    points = { { 0.05, 0.7 }, { 0.1, 1 } },
})
hl.curve("md3_accel", {
    type = "bezier",
    points = { { 0.3, 0 }, { 0.8, 0.15 } },
})
hl.curve("overshot", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.1 } },
})
hl.curve("crazyshot", {
    type = "bezier",
    points = { { 0.1, 1.5 }, { 0.76, 0.92 } },
})
hl.curve("hyprnostretch", {
    type = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.0 } },
})
hl.curve("fluent_decel", {
    type = "bezier",
    points = { { 0.1, 1 }, { 0, 1 } },
})
hl.curve("easeInOutCirc", {
    type = "bezier",
    points = { { 0.85, 0 }, { 0.15, 1 } },
})
hl.curve("easeOutCirc", {
    type = "bezier",
    points = { { 0, 0.55 }, { 0.45, 1 } },
})
hl.curve("easeOutExpo", {
    type = "bezier",
    points = { { 0.16, 1 }, { 0.3, 1 } },
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 3,
    bezier = "md3_decel",
    style = "popin 60%",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 2.5,
    bezier = "md3_decel",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 3.5,
    bezier = "easeOutExpo",
    style = "slide",
})
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 3,
    bezier = "md3_decel",
    style = "slidevert",
})


-------------
--- INPUT ---
-------------

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        numlock_by_default = true,
    },
})


-----------------
--- KEYBINDS ---
-----------------

local mainMod = "SUPER"

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd([=[grim -g "$(slurp)" - | wl-copy]=])
)

hl.bind(
    "SUPER + ALT + 6",
    hl.dsp.exec_cmd("/usr/lib/hyprwhspr/config/hyprland/hyprwhspr-tray.sh record"),
    { description = "Speech-to-text" }
)

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
    mainMod .. " + M",
    hl.dsp.exec_cmd(
        "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
    )
)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(runner))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -d -sw"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })
)

-- Move focus with mainMod + arrow keys.
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys.
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { locked = true }
)
hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)
hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)
hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true }
)

for group = 1, 3 do
    hl.bind(
        mainMod .. " + " .. group,
        hl.dsp.exec_cmd("~/.config/hypr/scripts/workspace-group.sh " .. group)
    )
end

-- Move the focused window to the primary monitor's side of each group.
for workspace = 1, 3 do
    hl.bind(
        mainMod .. " + SHIFT + " .. workspace,
        hl.dsp.window.move({ workspace = workspace })
    )
end


------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

hl.window_rule({
    -- Ignore maximize requests from all apps.
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland.
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run",
    },
    move = "20 monitor_h-120",
    float = true,
})
