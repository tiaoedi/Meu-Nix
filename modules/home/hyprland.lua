-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           Meu-Nix Hyprland Config — Lua Edition              ║
-- ║                     Hyprland 0.55+                           ║
-- ╚═══════════════════════════════════════════════════════════════╝

local mainMod = "SUPER"
local files   = "nautilus"
local browser = "google-chrome-stable"
local term    = "kitty"

-- ── Monitor ──────────────────────────────────────────────────────
hl.monitor({
  output   = "HDMI-A-1",
  mode     = "1920x1080@60",
  position = "0x0",
  scale    = 1.0,
})

-- ── Ambiente ─────────────────────────────────────────────────────
hl.env("TZ",                                  "America/Sao_Paulo")
hl.env("XDG_CURRENT_DESKTOP",                 "Hyprland")
hl.env("XDG_SESSION_TYPE",                    "wayland")
hl.env("XDG_SESSION_DESKTOP",                 "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR",         "1")
hl.env("QT_QPA_PLATFORM",                     "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME",                "qt6ct")
hl.env("HYPRCURSOR_THEME",                    "ArcAurora-Cursors")
hl.env("XCURSOR_THEME",                       "ArcAurora-Cursors")
hl.env("HYPRCURSOR_SIZE",                     "24")

-- ── Config ───────────────────────────────────────────────────────
hl.config({
  cursor = {
    enable_hyprcursor = false,
  },
  input = {
    kb_layout          = "us",
    kb_variant         = "intl",
    repeat_delay       = 250,
    repeat_rate        = 50,
    follow_mouse       = 1,
    numlock_by_default = true,
    touchpad = {
      natural_scroll       = true,
      tap_to_click         = true,
      drag_lock            = true,
      disable_while_typing = true,
    },
  },
  general = {
    gaps_in                 = 5,
    gaps_out                = 5,
    border_size             = 2,
    col = {
      active_border   = { colors = {"rgba(7aa2f7aa)", "rgba(c4a7e7aa)"}, angle = 45 },
      inactive_border = "rgba(414868aa)",
    },
    layout                  = "scrolling",
    resize_on_border        = true,
    extend_border_grab_area = 5,
  },
  scrolling = {
    column_width             = 0.5,
    follow_focus             = true,
    fullscreen_on_one_column = false,
  },
  decoration = {
    rounding         = 12,
    active_opacity   = 0.92,
    inactive_opacity = 0.75,
    shadow = {
      enabled        = true,
      range          = 20,
      render_power   = 4,
      color          = "rgba(00000066)",
      color_inactive = "rgba(00000033)",
    },
    blur = {
      enabled           = true,
      size              = 8,
      passes            = 3,
      new_optimizations = true,
      xray              = false,
      ignore_opacity    = false,
      special           = true,
      popups            = true,
      noise             = 0.02,
      contrast          = 1.1,
      brightness        = 0.9,
      vibrancy          = 0.2,
      vibrancy_darkness = 0.1,
    },
  },
  master = {
    new_status = "master",
    mfact      = 0.5,
  },
  misc = {
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    mouse_move_enables_dpms  = true,
  },
  binds = {
    workspace_back_and_forth = true,
  },
})

-- ── Animações ────────────────────────────────────────────────────
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "default" })

-- ── Autostart ────────────────────────────────────────────────────
hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("noctalia-shell")
  hl.exec_cmd("qs -c overview")
  hl.exec_cmd("kdeconnect-indicator")
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

-- ── Keybinds ─────────────────────────────────────────────────────

-- Sistema
hl.bind(mainMod .. " + equal",     "exec", "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')")
hl.bind(mainMod .. " + minus",     "exec", "hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')")
hl.bind(mainMod .. " + SHIFT + 0", "exec", "hyprctl -q keyword cursor:zoom_factor 1")
hl.bind(mainMod .. " + SHIFT + R", "exec", "hyprctl reload")
hl.bind(mainMod .. " + SHIFT + Q", "killactive")
hl.bind(mainMod .. " + Q",         "killactive")
hl.bind(mainMod .. " + SHIFT + E", "exit")
hl.bind(mainMod .. " + F",         "exec", "colresize-toggle")
hl.bind(mainMod .. " + SHIFT + F", "fullscreen", "0")
hl.bind(mainMod .. " + V",         "togglefloating")
hl.bind(mainMod .. " + G",         "togglegroup")

-- Apps
hl.bind(mainMod .. " + Return",         "exec", term)
hl.bind(mainMod .. " + T",              "exec", term)
hl.bind(mainMod .. " + SHIFT + Return", "exec", files)
hl.bind(mainMod .. " + F1",             "exec", "brave")
hl.bind(mainMod .. " + F2",             "exec", browser)
hl.bind(mainMod .. " + F3",             "exec", "firefox")
hl.bind(mainMod .. " + F4",             "exec", "gimp")
hl.bind(mainMod .. " + F5",             "exec", "noctalia-shell ipc call launcher clipboard")
hl.bind(mainMod .. " + F6",             "exec", "vlc")
hl.bind(mainMod .. " + F8",             "exec", files)
hl.bind(mainMod .. " + F11",            "exec", "rofi -show drun -show-icons")
hl.bind(mainMod .. " + F12",            "exec", "noctalia-shell ipc call launcher toggle")
hl.bind(mainMod .. " + X",              "exec", "noctalia-shell ipc call sessionMenu toggle")
hl.bind(mainMod .. " + D",              "exec", "fuzzel")
hl.bind(mainMod .. " + E",              "exec", "code")
hl.bind(mainMod .. " + P",              "exec", "hyprshot -m region")
hl.bind(mainMod .. " + A",              "exec", "rofi -show window")
hl.bind(mainMod .. " + O",              "exec", "overview-toggle")
hl.bind("SUPER + ALT + L",              "exec", "swaylock")

-- Screenshot
hl.bind("Print",        "exec", "flameshot")
hl.bind("CTRL + Print", "exec", "flameshot screen")
hl.bind("ALT + Print",  "exec", "flameshot gui")

-- Foco
hl.bind(mainMod .. " + left",  "movefocus", "l")
hl.bind(mainMod .. " + right", "movefocus", "r")
hl.bind(mainMod .. " + up",    "movefocus", "u")
hl.bind(mainMod .. " + down",  "movefocus", "d")
hl.bind(mainMod .. " + H",     "movefocus", "l")
hl.bind(mainMod .. " + L",     "movefocus", "r")
hl.bind(mainMod .. " + K",     "movefocus", "u")
hl.bind(mainMod .. " + J",     "movefocus", "d")

-- Mover janelas
hl.bind(mainMod .. " + CTRL + H",      "movewindow", "l")
hl.bind(mainMod .. " + CTRL + L",      "movewindow", "r")
hl.bind(mainMod .. " + CTRL + K",      "movewindow", "u")
hl.bind(mainMod .. " + CTRL + J",      "movewindow", "d")
hl.bind(mainMod .. " + SHIFT + left",  "movewindow", "l")
hl.bind(mainMod .. " + SHIFT + right", "movewindow", "r")
hl.bind(mainMod .. " + SHIFT + up",    "movewindow", "u")
hl.bind(mainMod .. " + SHIFT + down",  "movewindow", "d")

-- Workspaces
hl.bind(mainMod .. " + period",      "workspace", "e+1")
hl.bind(mainMod .. " + comma",       "workspace", "e-1")
hl.bind(mainMod .. " + tab",         "workspace", "m+1")
hl.bind(mainMod .. " + SHIFT + tab", "workspace", "m-1")
hl.bind("ALT + tab",                 "workspace", "m+1")
hl.bind("ALT + SHIFT + tab",         "workspace", "m-1")
hl.bind(mainMod .. " + SHIFT + U",   "movetoworkspace", "special")
hl.bind(mainMod .. " + U",           "togglespecialworkspace")

-- Workspaces 1-9
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i,         "workspace", tostring(i))
  hl.bind(mainMod .. " + SHIFT + " .. i, "movetoworkspace", tostring(i))
end

-- Layout
hl.bind(mainMod .. " + I",             "layoutmsg", "addmaster")
hl.bind(mainMod .. " + CTRL + Return", "layoutmsg", "swapwithmaster")

-- Mídia
hl.bind("XF86AudioRaiseVolume", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0")
hl.bind("XF86AudioLowerVolume", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-")
hl.bind("XF86AudioMute",        "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
hl.bind("XF86AudioMicMute",     "exec", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
hl.bind("XF86AudioPlay",        "exec", "playerctl play-pause")
hl.bind("XF86AudioNext",        "exec", "playerctl next")
hl.bind("XF86AudioPrev",        "exec", "playerctl previous")
hl.bind("XF86AudioStop",        "exec", "playerctl stop")

-- Brilho
hl.bind("XF86MonBrightnessUp",   "exec", "brightnessctl --class=backlight set +10%")
hl.bind("XF86MonBrightnessDown", "exec", "brightnessctl --class=backlight set 10%-")

-- Redimensionar (repeating)
hl.bind(mainMod .. " + SHIFT + H", "resizeactive", "-50 0",  { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", "resizeactive", "50 0",   { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", "resizeactive", "0 -50",  { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", "resizeactive", "0 50",   { repeating = true })

-- Mouse
hl.bind(mainMod .. " + mouse:272", "movewindow",   nil, { mouse = true })
hl.bind(mainMod .. " + mouse:273", "resizewindow", nil, { mouse = true })
