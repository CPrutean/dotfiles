local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar({
	color = colors.barbg,
	height = settings.height + 10,
	padding_right = 6,
	padding_left = 6,
	sticky = "on",
	topmost = "window",
	y_offset = 0,
	border_width = 2,
	border_color = colors.accent_transparent,
	corner_radius = 15,
	notch_width = 200,
})
