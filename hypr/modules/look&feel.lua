-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 2,

		border_size = 1,

		col = {
			active_border = { colors = { "#7FBBB3", "#A7C080" }, angle = 45 },
			inactive_border = "#859289",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 1,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.90,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("ease", {
    type = "bezier",
    points = {
        { 0.25, 0.1 },
        { 0.25, 1.0 },
    },
})

hl.curve("overshot", {
    type = "bezier",
    points = {
        { 0.13, 0.99 },
        { 0.29, 1.05 },
    },
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 4,
    bezier = "ease",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4,
    bezier = "overshot",
    style = "slide",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 8,
    bezier = "ease",
    style = "slide",
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 4,
    bezier = "overshot",
    style = "slide",
})

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 4,
    bezier = "ease",
    style = "slide",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3,
    bezier = "ease",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 2,
    bezier = "ease",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "overshot",
    style = "slide",
})

-- this is for the screenshot selection thing
hl.layer_rule({
    name = "selection-layer-no-anim",
    match = {
        namespace = "selection",
    },
    no_anim = true,
})

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

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
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
