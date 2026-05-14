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

--autostart
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
hl.bind(mainMod .. " + equal",     hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"))
hl.bind(mainMod .. " + minus",     hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen, 1({ type = "colresize-toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ type = "real" }))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
--hl.bind(mainMod .. " + G",         hl.dsp.window.group({ action = "toggle" }))

-- Apps
hl.bind(mainMod .. " + Return",              hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F1",             hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + F2",             hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F3",             hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + F4",             hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + F5",             hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard"))
hl.bind(mainMod .. " + F6",             hl.dsp.exec_cmd("vlc"))
hl.bind(mainMod .. " + F8",             hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F11",            hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mainMod .. " + F12",            hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind(mainMod .. " + X",              hl.dsp.exec_cmd("noctalia-shell ipc call sessionMenu toggle"))
hl.bind(mainMod .. " + D",              hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + P",              hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + A",              hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + O",              hl.dsp.exec_cmd("overview-toggle"))
hl.bind("SUPER + ALT + L",              hl.dsp.exec_cmd("swaylock"))

-- Screenshot
hl.bind("Print",        hl.dsp.exec_cmd("flameshot"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("flameshot screen"))
hl.bind("ALT + Print",  hl.dsp.exec_cmd("flameshot gui"))

-- Foco


-- Mover janelas

-- Workspaces


