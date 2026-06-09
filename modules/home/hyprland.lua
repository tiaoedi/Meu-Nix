-- ╔═══════════════════════════════════════════════════════════════╗
-- ║           Meu-Nix Hyprland Config — Lua Edition              ║
-- ║                     Hyprland 0.55+                           ║
-- ╚═══════════════════════════════════════════════════════════════╝

local mainMod = "SUPER"
local files = "nautilus"
local browser = "google-chrome-stable"
local term = "kitty"

-- ── Monitor ──────────────────────────────────────────────────────
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

-- ── Ambiente ─────────────────────────────────────────────────────
hl.env("TZ", "America/Sao_Paulo")
hl.env("TZDIR", "/etc/zoneinfo")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("HYPRCURSOR_THEME", "ArcAurora-Cursors")
hl.env("XCURSOR_THEME", "ArcAurora-Cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/renderD128")
-- ── Config ───────────────────────────────────────────────────────
hl.config({
	cursor = {
		enable_hyprcursor = false,
	},
	input = {
		kb_layout = "us",
		kb_variant = "alt-intl",
		repeat_delay = 200,
		repeat_rate = 40,
		follow_mouse = 1,
		numlock_by_default = true,
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
			disable_while_typing = true,
		},
	},
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(7aa2f7aa)", "rgba(c4a7e7aa)" }, angle = 45 },
			inactive_border = "rgba(414868aa)",
		},
		layout = "scrolling",
		resize_on_border = true,
		extend_border_grab_area = 5,
	},
	scrolling = {
		column_width = 0.5,
		follow_focus = true,
		fullscreen_on_one_column = false,
	},
	decoration = {
		rounding = 12,
		active_opacity = 0.92,
		inactive_opacity = 0.75,
		shadow = {
			enabled = true,
			range = 20,
			render_power = 4,
			color = "rgba(00000066)",
			color_inactive = "rgba(00000033)",
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			new_optimizations = true,
			xray = false,
			ignore_opacity = false,
			special = true,
			popups = true,
			noise = 0.02,
			contrast = 1.1,
			brightness = 0.9,
			vibrancy = 0.2,
			vibrancy_darkness = 0.1,
		},
	},
	master = {
		new_status = "master",
		mfact = 0.5,
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
	},
	binds = {
		workspace_back_and_forth = true,
	},
})

-- ── Animações ────────────────────────────────────────────────────
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

--autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("qs -c overview")
	hl.exec_cmd("kdeconnect-indicator")
	hl.exec_cmd("nm-applet --indicator")
	hl.exec_cmd("wl-paste --watch cliphist store")
end)

-- ── Keybinds ─────────────────────────────────────────────────────

-- Sistema
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
--hl.bind(mainMod .. " + G",         hl.dsp.window.group({ action = "toggle" }))

-- Apps

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("vlc"))
hl.bind(mainMod .. " + F8", hl.dsp.exec_cmd(files))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("overview-toggle"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd("swaylock"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("flameshot"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("flameshot screen"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("flameshot gui"))

-- Foco
hl.bind("SUPER + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("Return", hl.dsp.submap("reset"))
end)
-- Mover janelas
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Workspaces

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("ALT + SHIFT + tab", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("CONTROL + ALT + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind("CONTROL + ALT + left", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local function zoomfunction(value)
	local zoomvalue = hl.get_config("cursor:zoom_factor")
	if (zoomvalue + value) > 3.0 then
		hl.config({ cursor = { zoom_factor = 3.0 } })
	elseif (zoomvalue + value) < 1.0 then
		hl.config({ cursor = { zoom_factor = 1.0 } })
	else
		hl.config({ cursor = { zoom_factor = zoomvalue + value } })
	end
end
hl.bind("SUPER + Minus", function()
	zoomfunction(-0.3)
end, { repeating = true, description = "Screen: Zoom out" })
hl.bind("SUPER + Equal", function()
	zoomfunction(0.3)
end, { repeating = true, description = "Screen: Zoom in" })

-- This loads Noctalia-generated Hyprland colors.
dofile("/home/pc120/.config/hypr/noctalia/noctalia-colors.lua")
