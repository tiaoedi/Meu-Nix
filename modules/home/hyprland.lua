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

	scale = 1.0,
})

-- ── Ambiente ─────────────────────────────────────────────────────
hl.env("TZ", "America/Sao_Paulo")
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

-- ── Cursor ───────────────────────────────────────────────────────
hl.config({
	cursor = {
		enable_hyprcursor = false,
	},
})

-- ── Input ────────────────────────────────────────────────────────
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "intl",
		repeat_delay = 250,
		repeat_rate = 50,
		follow_mouse = 1,
		numlock_by_default = true,
		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = true,
			disable_while_typing = true,
		},
	},
})

-- ── Geral ────────────────────────────────────────────────────────
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 2,
		["col.active_border"] = "rgba(7aa2f7aa)",
		["col.inactive_border"] = "rgba(414868aa)",
		layout = "scrolling",
		resize_on_border = true,
		extend_border_grab_area = 5,
	},
})

-- ── Scrolling Layout ─────────────────────────────────────────────
hl.config({
	scrolling = {
		column_width = 0.5,
		follow_focus = true,
		fullscreen_on_one_column = false,
	},
})

-- ── Decoração ────────────────────────────────────────────────────
hl.config({
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
})

-- ── Animações ────────────────────────────────────────────────────
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.config({
	animations = {
		enabled = true,
		animation = {
			{ name = "windows", enable = true, speed = 7, curve = "myBezier" },
			{ name = "windowsOut", enable = true, speed = 7, curve = "default", style = "popin 80%" },
			{ name = "border", enable = true, speed = 10, curve = "default" },
			{ name = "fade", enable = true, speed = 7, curve = "default" },
			{ name = "workspaces", enable = true, speed = 6, curve = "default" },
		},
	},
})

-- ── Layout Master ────────────────────────────────────────────────
hl.config({
	master = {
		new_status = "master",
		mfact = 0.5,
	},
})

-- ── Misc ─────────────────────────────────────────────────────────
hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
	},
	binds = {
		workspace_back_and_forth = true,
	},
})

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
hl.bind(
	mainMod .. " + equal",
	hl.dsp.exec_cmd(
		"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
	)
)
hl.bind(
	mainMod .. " + minus",
	hl.dsp.exec_cmd(
		"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
	)
)
hl.bind(mainMod .. " + SHIFT + 0", hl.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))
hl.bind(mainMod .. " + SHIFT + R", hl.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dispatch("killactive"))
hl.bind(mainMod .. " + Q", hl.dispatch("killactive"))
hl.bind(mainMod .. " + SHIFT + E", hl.dispatch("exit"))
hl.bind(mainMod .. " + F", hl.exec_cmd("colresize-toggle"))
hl.bind(mainMod .. " + SHIFT + F", hl.dispatch("fullscreen 0"))
hl.bind(mainMod .. " + V", hl.dispatch("togglefloating"))

-- Apps
hl.bind(mainMod .. " + Return", hl.exec_cmd(term))
hl.bind(mainMod .. " + T", hl.exec_cmd(term))
hl.bind(mainMod .. " + SHIFT + Return", hl.exec_cmd(files))
hl.bind(mainMod .. " + F1", hl.exec_cmd("brave"))
hl.bind(mainMod .. " + F2", hl.exec_cmd(browser))
hl.bind(mainMod .. " + F3", hl.exec_cmd("firefox"))
hl.bind(mainMod .. " + F4", hl.exec_cmd("gimp"))
hl.bind(mainMod .. " + F5", hl.exec_cmd("noctalia-shell ipc call launcher clipboard"))
hl.bind(mainMod .. " + F6", hl.exec_cmd("vlc"))
hl.bind(mainMod .. " + F8", hl.exec_cmd(files))
hl.bind(mainMod .. " + F11", hl.exec_cmd("rofi -show drun -show-icons"))
hl.bind(mainMod .. " + P", hl.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + A", hl.exec_cmd("rofi -show window"))
hl.bind(mainMod .. " + F12", hl.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind(mainMod .. " + X", hl.exec_cmd("noctalia-shell ipc call sessionMenu toggle"))
hl.bind(mainMod .. " + D", hl.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + E", hl.exec_cmd("code"))
hl.bind("SUPER + ALT + L", hl.exec_cmd("swaylock"))
hl.bind(mainMod .. " + O", hl.exec_cmd("overview-toggle"))
--hl.bind(mainMod .. " + G", hl.dispatch("togglegroup"))
hl.bind(mainMod .. " + G", hl.exec_cmd("hyprctl dispatch togglegroup"))


-- Foco (Setas)
hl.bind(mainMod .. " + left",  hl.dsp.window.movefocus("l"))
hl.bind(mainMod .. " + right", hl.dsp.window.movefocus("r"))
hl.bind(mainMod .. " + up",    hl.dsp.window.movefocus("u"))
hl.bind(mainMod .. " + down",  hl.dsp.window.movefocus("d"))

-- Foco (Vim-style)
hl.bind(mainMod .. " + h", hl.dsp.window.movefocus("l"))
hl.bind(mainMod .. " + l", hl.dsp.window.movefocus("r"))
hl.bind(mainMod .. " + k", hl.dsp.window.movefocus("u"))
hl.bind(mainMod .. " + j", hl.dsp.window.movefocus("d"))


-- Mover janelas
hl.bind(mainMod .. " + CTRL + H", hl.dispatch("movewindow l"))
hl.bind(mainMod .. " + CTRL + L", hl.dispatch("movewindow r"))
hl.bind(mainMod .. " + CTRL + K", hl.dispatch("movewindow u"))
hl.bind(mainMod .. " + CTRL + J", hl.dispatch("movewindow d"))
hl.bind(mainMod .. " + SHIFT + left", hl.dispatch("movewindow l"))
hl.bind(mainMod .. " + SHIFT + right", hl.dispatch("movewindow r"))
hl.bind(mainMod .. " + SHIFT + up", hl.dispatch("movewindow u"))
hl.bind(mainMod .. " + SHIFT + down", hl.dispatch("movewindow d"))

-- Workspaces
hl.bind(mainMod .. " + period", hl.dispatch("workspace e+1"))
hl.bind(mainMod .. " + comma", hl.dispatch("workspace e-1"))
hl.bind(mainMod .. " + tab", hl.dispatch("workspace m+1"))
hl.bind(mainMod .. " + SHIFT + tab", hl.dispatch("workspace m-1"))
hl.bind("ALT + tab", hl.dispatch("workspace m+1"))
hl.bind("ALT + SHIFT + tab", hl.dispatch("workspace m-1"))
hl.bind(mainMod .. " + SHIFT + U", hl.dispatch("movetoworkspace special"))
hl.bind(mainMod .. " + U", hl.dispatch("togglespecialworkspace"))

-- Workspaces 1-9
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dispatch("workspace i"))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dispatch("movetoworkspace i"))
end

-- Layout
hl.bind(mainMod .. " + I", hl.dispatch("layoutmsg addmaster"))
hl.bind(mainMod .. " + CTRL + Return", hl.dispatch("layoutmsg swapwithmaster"))

-- Mídia
hl.bind("XF86AudioRaiseVolume", hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"))
hl.bind("XF86AudioLowerVolume", hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"))
hl.bind("XF86AudioMute", hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay", hl.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.exec_cmd("playerctl stop"))

-- Brilho
hl.bind("XF86MonBrightnessUp", hl.exec_cmd("brightnessctl --class=backlight set +10%"))
hl.bind("XF86MonBrightnessDown", hl.exec_cmd("brightnessctl --class=backlight set 10%-"))

-- Redimensionar (repeating)
hl.bind(mainMod .. " + SHIFT + H", hl.dispatch("resizeactive -50 0 }), { repeating = true")
hl.bind(mainMod .. " + SHIFT + L", hl.dispatch("resizeactive 50 0 }), { repeating = true")
hl.bind(mainMod .. " + SHIFT + K", hl.dispatch("resizeactive 0 -50 }), { repeating = true")
hl.bind(mainMod .. " + SHIFT + J", hl.dispatch("resizeactive 0 50 }), { repeating = true")

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dispatch("movewindow"), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dispatch("resizewindow"), { mouse = true })
