-- hyprland.lua
-- Translated from hyprland.conf (Lua API, Hyprland >= 0.55)
-- https://wiki.hypr.land/Configuring/Start/

-- ─────────────────────────────────────────
-- VARIABLES
-- ─────────────────────────────────────────
local mod = "SUPER"
local left = "h"
local down = "j"
local up_key = "k"
local right = "l"

local term = "ghostty"
local menu = "fuzzel"
local fileManager = "thunar"
local home = os.getenv("HOME")
local wallpapers_path = home .. "/.config/hypr/wallpapers"
local lockscreen_wallpapers_path = home .. "/.config/hypr/lockscreen_wallpapers"
local lockscreen_img = lockscreen_wallpapers_path .. "/grotesqueimpalement.jpg"

-- ─────────────────────────────────────────
-- MONITORS
-- ─────────────────────────────────────────
-- auto-detect monitors
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- Workspace 7 pinned to secondary monitor
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1", default = true })

-- ─────────────────────────────────────────
-- ENVIRONMENT VARIABLES
-- ─────────────────────────────────────────

-- Wayland & Toolkit Backends
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")

-- Hyprland Desktop Identity
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt Configuration
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- GTK & Styling
hl.env("GTK_THEME", "Adwaita-One-Dark")

-- Java fix
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
-- Fix dead keys in ghostty
hl.env("GTK_IM_MODULE", "ibus")
hl.env("QT_IM_MODULE", "ibus")
hl.env("XMODIFIERS", "@im=ibus")

-- ─────────────────────────────────────────
-- INPUT
-- ─────────────────────────────────────────
hl.config({
	input = {
		kb_layout = "us,us,ru,gr",
		kb_variant = "intl,altgr-intl,,",
		kb_options = "grp:alt_shift_toggle",
		follow_mouse = 1,
		-- FIX:
		-- cursor = {
		-- 	inactive_timeout = 10,
		-- },
		touchpad = {
			disable_while_typing = true,
			tap_to_click = true,
			natural_scroll = true,
			middle_button_emulation = true,
			scroll_factor = 0.3,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
hl.gesture({
	fingers = 4,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

-- ─────────────────────────────────────────
-- LOOK AND FEEL
-- ─────────────────────────────────────────
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 4,
		border_size = 2,
		col = {
			active_border = "rgb(64727d)",
			inactive_border = "rgb(2e3440)",
		},
		layout = "dwindle",
	},
	-- Keeping Hyprland flat (no shadows / blur), mirroring the commented-out
	-- Sway-style decoration block from the original config.
	decoration = {
		--FIX:
		-- drop_shadow = false,
		rounding = 6,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
	gestures = {
		workspace_swipe_distance = 700,
		workspace_swipe_cancel_ratio = 0.2,
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_direction_lock = true,
		workspace_swipe_direction_lock_threshold = 10,
		workspace_swipe_create_new = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
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
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
--

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
		default_split_ratio = 1.0,

		-- Force new windows to open on the right or bottom instead of following cursor
		force_split = 2,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- ─────────────────────────────────────────
-- GTK / THEME (exec-once on startup)
-- ─────────────────────────────────────────
hl.on("hyprland.start", function()
	hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences theme Adwaita-One-Dark")
	hl.exec_cmd('gsettings set org.gnome.desktop.interface font-name "Arimo Nerd Font"')
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita-One-Dark")
	hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
	hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme Adwaita")

	-- Daemons
	hl.exec_cmd("gammastep")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("swaync")
	hl.exec_cmd("waybar")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Clipboard
	hl.exec_cmd("wl-paste --watch cliphist store")

	-- Core apps
	hl.exec_cmd("firefox")
	hl.exec_cmd("spotify-launcher")

	-- Wallpaper (hyprpaper with random image)
	hl.exec_cmd("hyprctl hyprpaper || hyprpaper &")
	hl.exec_cmd('hyprctl dispatch output "*" bg "$(find ' .. wallpapers_path .. ' -type f | shuf -n 1)"')
end)

-- ─────────────────────────────────────────
-- WINDOW RULES
-- ─────────────────────────────────────────
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
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

-- Floating windows
hl.window_rule({ name = "float-float_term", match = { class = "^(com.mitchellh.float_term)$" }, float = true })
hl.window_rule({ name = "float-sway-rec", match = { title = "^(Sway recorder)$" }, float = true })
hl.window_rule({ name = "float-floating", match = { class = "^(floating)$" }, float = true })

-- Generic dialog / popup float rules
hl.window_rule({ name = "float-popup", match = { title = "^(pop-up)$" }, float = true })
hl.window_rule({ name = "float-bubble", match = { title = "^(bubble)$" }, float = true })
hl.window_rule({ name = "float-dialog", match = { title = "^(dialog)$" }, float = true })
hl.window_rule({ name = "float-task_dialog", match = { title = "^(task_dialog)$" }, float = true })
hl.window_rule({ name = "float-menu", match = { title = "^(menu)$" }, float = true })

-- Matplotlib floating figures
hl.window_rule({
	name = "float-matplotlib",
	match = { class = "^(Matplotlib)$", title = "^(Figure .*)$" },
	float = true,
	size = "380 300",
})

-- R x11 floating figures
hl.window_rule({
	name = "float-r-x11",
	match = { class = "^(R_x11)$", title = "^(r_x11)$" },
	float = true,
	size = "380 300",
})

-- Inhibit idle when fullscreen
hl.window_rule({
	name = "idle-inhibit-fullscreen",
	match = { class = "^(.*)$" },
	--FIX:
	-- idleinhibit = "fullscreen",
})

-- App-to-workspace pinning
hl.window_rule({ name = "ws1-spotify", match = { class = "^(Spotify)$" }, workspace = "1" })
hl.window_rule({ name = "ws1-spotify-lc", match = { class = "^(spotify)$" }, workspace = "1" })
hl.window_rule({ name = "ws2-firefox", match = { class = "^(firefox)$" }, workspace = "2" })
hl.window_rule({ name = "ws6-bitwig", match = { class = "^(com.bitwig.BitwigStudio)$" }, workspace = "6" })
hl.window_rule({ name = "ws8-discord", match = { class = "^(discord)$" }, workspace = "8" })
hl.window_rule({ name = "ws8-vesktop", match = { class = "^(vesktop)$" }, workspace = "8" })
hl.window_rule({ name = "ws9-steam", match = { class = "^(steam)$" }, workspace = "9" })
hl.window_rule({ name = "ws10-retroarch", match = { class = "^(org.libretro.RetroArch)$" }, workspace = "10" })
hl.window_rule({ name = "ws10-appimage", match = { class = "^(AppRun.wrapped)$" }, workspace = "10" })

-- ─────────────────────────────────────────
-- KEYBINDINGS
-- ─────────────────────────────────────────

-- Terminal & Launcher
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd("ghostty --class=com.mitchellh.float_term"))
local closeWindowBind = hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprctl dispatch exit"))

hl.bind(
	mod .. " + SHIFT + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
-- hl.bind(mod .. " + P", hl.dsp.window.pseudo()) -- No sé qué hace

-- Window Layout
hl.bind(mod .. " + B", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + A", hl.dsp.focus({ window = "previous" })) -- back-and-forth / last focus

-- Scratchpad
-- hl.bind(mod .. " + SHIFT + Minus", hl.dsp.window.move({ workspace = "special" }))
-- hl.bind(mod .. " + Minus", hl.dsp.workspace.toggle_special())
hl.bind(mod .. " + SHIFT + Minus", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mod .. " + Minus", hl.dsp.workspace.toggle_special("magic"))

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Clipboard picker
-- hl.bind(mod .. " + C", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("bash ~/.config/hypr/scripts/cliphist.sh"))

-- Screenshots
hl.bind(mod .. " + P", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(mod .. " + SHIFT + P", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty -f -'))

-- Screen recorder toggle
hl.bind(mod .. " + X", hl.dsp.exec_cmd(home .. "/.config/sway/scripts/toggleSwayRecorder.sh"))

-- Multi-monitor output script
hl.bind(mod .. " + SHIFT + Escape", hl.dsp.exec_cmd(home .. "/.config/hypr/scripts/output.sh"))

-- Media keys (locked = runs on lockscreen)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Volume (locked, with 1.2 limit)
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
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.2"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.2"),
	{ locked = true, repeating = true }
)

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

-- Directional focus – Vim keys
hl.bind(mod .. " + " .. left, hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + " .. down, hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + " .. up_key, hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + " .. right, hl.dsp.focus({ direction = "right" }))

-- Directional focus – Arrow keys
hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "right" }))

-- Move window – Vim keys
hl.bind(mod .. " + SHIFT + " .. left, hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + " .. down, hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + " .. up_key, hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + " .. right, hl.dsp.window.move({ direction = "right" }))

-- Move window – Arrow keys
hl.bind(mod .. " + SHIFT + Left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))

-- Switch workspaces

for i = 1, 10 do
	local key = i % 10 -- key 0 → workspace 10
	local target = i -- capture loop variable

	hl.bind(mod .. " + " .. key, function()
		local current_ws = hl.get_active_workspace()
		local current_mon = hl.get_active_monitor()
		local target_ws = hl.get_workspace(target)

		if not target_ws then
			hl.dispatch(hl.dsp.focus({ workspace = tostring(target) }))
		elseif current_ws and current_ws.id == target then
			hl.dispatch(hl.dsp.focus({ last = true }))
		elseif target_ws.active and target_ws.monitor.name ~= current_mon.name then
			hl.dispatch(hl.dsp.focus({ monitor = target_ws.monitor.name }))
		elseif target_ws.monitor.name ~= current_mon.name then
			hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(target), monitor = current_mon.name }))
		else
			hl.dispatch(hl.dsp.focus({ workspace = tostring(target) }))
		end
	end)
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = target }))
end

-- Alt+Tab: previous workspace
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Mouse drag / resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ─────────────────────────────────────────
-- RESIZE SUBMAP
-- ─────────────────────────────────────────
--FIX: la verdad nunca lo he usado
hl.bind(mod .. " + R", function()
	hl.submap("resize", function(sm)
		-- Vim keys
		sm.binde(left, hl.dsp.window.resize_active({ delta = "-10 0" }))
		sm.binde(down, hl.dsp.window.resize_active({ delta = "0 10" }))
		sm.binde(up_key, hl.dsp.window.resize_active({ delta = "0 -10" }))
		sm.binde(right, hl.dsp.window.resize_active({ delta = "10 0" }))
		-- Arrow keys
		sm.binde("Left", hl.dsp.window.resize_active({ delta = "-10 0" }))
		sm.binde("Down", hl.dsp.window.resize_active({ delta = "0 10" }))
		sm.binde("Up", hl.dsp.window.resize_active({ delta = "0 -10" }))
		sm.binde("Right", hl.dsp.window.resize_active({ delta = "10 0" }))
		-- Exit submap
		sm.bind("Return", sm.reset)
		sm.bind("Escape", sm.reset)
	end)
end)

-- ─────────────────────────────────────────
-- HARDWARE LID SWITCH → lockscreen
-- ─────────────────────────────────────────
-- FIX: uses swaylock instead of hyprlock
hl.bind("switch:on:Lid Status", hl.dsp.exec_cmd("swaylock -f -e -i " .. lockscreen_img), { locked = true })
