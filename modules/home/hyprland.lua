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
  output  = "HDMI-A-1",
  mode    = "1920x1080@60",


  scale   = 1.0,
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

-- ── Cursor ───────────────────────────────────────────────────────
hl.config({
  cursor = {
    enable_hyprcursor = false,
  },
})

-- ── Input ────────────────────────────────────────────────────────
hl.config({
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
})

-- ── Geral ────────────────────────────────────────────────────────
hl.config({
  general = {
    gaps_in                 = 5,
    gaps_out                = 5,
    border_size             = 2,
    ["col.active_border"] = "rgba(7aa2f7aa) rgba(c4a7e7aa) 45deg",
    ["col.inactive_border"] = "rgba(414868aa)",
    layout                  = "scrolling",
    resize_on_border        = true,
    extend_border_grab_area = 5,
  },
})

-- ── Scrolling Layout ─────────────────────────────────────────────
hl.config({
  scrolling = {
    column_width             = 0.5,
    follow_focus             = true,
    fullscreen_on_one_column = false,
  },
})

-- ── Decoração ────────────────────────────────────────────────────
hl.config({
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
})

-- ── Animações ────────────────────────────────────────────────────
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.config({
  animations = {
    enabled = true,
    animation = {
      { name = "windows",    enable = true, speed = 7,  curve = "myBezier" },
      { name = "windowsOut", enable = true, speed = 7,  curve = "default", style = "popin 80%" },
      { name = "border",     enable = true, speed = 10, curve = "default" },
      { name = "fade",       enable = true, speed = 7,  curve = "default" },
      { name = "workspaces", enable = true, speed = 6,  curve = "default" },
    },
  },
})

-- ── Layout Master ────────────────────────────────────────────────
hl.config({
  master = {
    new_status = "master",
    mfact      = 0.5,
  },
})

-- ── Misc ─────────────────────────────────────────────────────────
hl.config({
  misc = {
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    mouse_move_enables_dpms  = true,
  },
  binds = {
    workspace_back_and_forth = true,
  },
})

-- ── Autostart ────────────────────────────────────────────────────
hl.exec_once("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
hl.exec_once("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
hl.exec_once("noctalia-shell")
hl.exec_once("qs -c overview")
hl.exec_once("kdeconnect-indicator")
hl.exec_once("nm-applet --indicator")
hl.exec_once("wl-paste --watch cliphist store")

-- ── Keybinds ─────────────────────────────────────────────────────

-- Sistema
hl.bind(mainMod .. " + equal",     hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"))
hl.bind(mainMod .. " + minus",     hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + F",         hl.dsp.exec_cmd("colresize-toggle"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ type = "real" }))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))

-- Apps
hl.bind(mainMod .. " + Return",         hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + T",              hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F1",             hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + F2",             hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F3",             hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + F4",             hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + F5",             hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard"))
hl.bind(mainMod .. " + F6",             hl.dsp.exec_cmd("vlc"))
hl.bind(mainMod .. " + F8",             hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F11",            hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mainMod .. " + P",              hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + A",              hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + F12",            hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind(mainMod .. " + X",              hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu toggle"))
hl.bind(mainMod .. " + D",              hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd("code"))
hl.bind("SUPER + ALT + L",              hl.dsp.exec_cmd("swaylock"))
hl.bind(mainMod .. " + O",              hl.dsp.exec_cmd("overview-toggle"))
hl.bind(mainMod .. " + G",              hl.dsp.window.group({ action = "toggle" }))

-- Screenshot
hl.bind("Print",        hl.dsp.exec_cmd("flameshot"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("flameshot screen"))
hl.bind("ALT + Print",  hl.dsp.exec_cmd("flameshot gui"))

-- Foco
hl.bind(mainMod .. " + left",  hl.dsp.focus.column({ dir = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus.column({ dir = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus.window({ dir = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus.window({ dir = "d" }))
hl.bind(mainMod .. " + H",     hl.dsp.focus.column({ dir = "l" }))
hl.bind(mainMod .. " + L",     hl.dsp.focus.column({ dir = "r" }))
hl.bind(mainMod .. " + K",     hl.dsp.focus.window({ dir = "u" }))
hl.bind(mainMod .. " + J",     hl.dsp.focus.window({ dir = "d" }))

-- Mover janelas
hl.bind(mainMod .. " + CTRL + H",      hl.dsp.window.move({ dir = "l" }))
hl.bind(mainMod .. " + CTRL + L",      hl.dsp.window.move({ dir = "r" }))
hl.bind(mainMod .. " + CTRL + K",      hl.dsp.window.move({ dir = "u" }))
hl.bind(mainMod .. " + CTRL + J",      hl.dsp.window.move({ dir = "d" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ dir = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ dir = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ dir = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ dir = "d" }))

-- Workspaces
hl.bind(mainMod .. " + period",      hl.dsp.workspace({ dir = "e+1" }))
hl.bind(mainMod .. " + comma",       hl.dsp.workspace({ dir = "e-1" }))
hl.bind(mainMod .. " + tab",         hl.dsp.workspace({ dir = "m+1" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.workspace({ dir = "m-1" }))
hl.bind("ALT + tab",                 hl.dsp.workspace({ dir = "m+1" }))
hl.bind("ALT + SHIFT + tab",         hl.dsp.workspace({ dir = "m-1" }))
hl.bind(mainMod .. " + SHIFT + U",   hl.dsp.window.to_workspace({ workspace = "special" }))
hl.bind(mainMod .. " + U",           hl.dsp.workspace.toggle_special())

-- Workspaces 1-9
for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i,         hl.dsp.workspace({ id = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.to_workspace({ workspace = i }))
end

-- Layout
hl.bind(mainMod .. " + I",             hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"))

-- Mídia
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop",        hl.dsp.exec_cmd("playerctl stop"))

-- Brilho
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl --class=backlight set +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --class=backlight set 10%-"))

-- Redimensionar (repeating)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0 }),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.resize({ x = 50,  y = 0 }),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.resize({ x = 0,   y = -50 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.resize({ x = 0,   y = 50 }),  { repeating = true })

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.move_grab(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize_grab(), { mouse = true })
