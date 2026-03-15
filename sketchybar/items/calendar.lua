local settings = require("settings")
local colors = require("colors")

local time = sbar.add("item", "items.calendar.time", {
	icon = {
		family = settings.font.text,
		style = settings.font.style_map["Regular"],
		size = settings.font.size,
	},
	label = {
		align = "right",
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = settings.font.size,
		},
		padding_right = 10,
	},
	position = "right",
	update_freq = 30,
	padding_left = 1,
	padding_right = 1,
})

local cal = sbar.add("item", "items.calendar.cal", {
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = settings.font.size,
		},
		color = colors.black,
		padding_left = 8,
	},
	label = {
		align = "right",

		font = {
			family = settings.font.text,
			style = settings.font.style_map["Regular"],
			size = settings.font.size,
		},
		padding_right = 10,
		drawing = off,
	},
	background = { color = colors.white },
	position = "right",
	update_freq = 30,
	padding_left = 1,
	padding_right = 1,
})
local bracket = sbar.add("bracket", "items.calendar.bracket", {
	cal.name,
	time.name,
}, {
	background = { color = colors.bg1 },
	popup = { align = "center", height = settings.height },
})

time:subscribe({ "forced", "routine", "system_woke" }, function(env)
	time:set({ label = os.date("%I:%M %p") })
end)

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({ icon = os.date("%a %b %d ") })
end)
