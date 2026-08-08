---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("[float;center;size 500 500] kitty"))
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd("kitty"))
local closeWindowBind = hl.bind(mainMod .. " + W", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi", { float = true, center = true, size = { 900, 500 } }))
hl.bind(
	mainMod .. " + C",
	hl.dsp.exec_cmd("kitty -e yazi ~/.config/", { float = true, center = true, size = { 900, 500 } })
)
hl.bind(
	mainMod .. " + P",
	hl.dsp.exec_cmd("kitty -e yazi Projects/", { float = true, center = true, size = { 900, 500 } })
)
hl.bind(mainMod .. "+ SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + V", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind("ALT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind("ALT + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)
hl.bind("ALT + SHIFT + S", hl.dsp.exec_cmd('~/.config/hypr/scripts/screenshot.sh'))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move window in a direction
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "previous" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
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
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Wallpaper submap
hl.bind(mainMod .. " + SHIFT + E", function()
	hl.dispatch(hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh on"))
	hl.dispatch(hl.dsp.submap("wallpaper"))
end)

hl.define_submap("wallpaper", function()
	hl.bind("right", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh right"))
	hl.bind("left", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh left"))
	hl.bind("up", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh up"))
	hl.bind("down", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh down"))
	hl.bind("escape", function()
		hl.dispatch(hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh off"))
		hl.dispatch(hl.dsp.submap("reset"))
	end)
end)
