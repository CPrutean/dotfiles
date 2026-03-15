local settings = require("settings")
local icons = require("icons")
local colors = require("colors")
local sbar = require("sketchybar")

local BINARY = "/usr/local/bin/mullvad"

local mullvad = sbar.add("item", {
	position = "right",
	update_freq = 3,
	icon = {
		padding_left = settings.padding.icon_item.icon.padding_left,
		padding_right = settings.padding.icon_item.icon.padding_right,
		string = icons.mullvad.disconnected,
		color = colors.red,
	},
	label = { drawing = false },
})

local function update_vpn_icon()
	sbar.exec(BINARY .. " status", function(status_info)
		sbar.animate("tanh", 10, function()
			if string.match(status_info, "Disconnected") then
				mullvad:set({
					icon = {
						string = icons.mullvad.disconnected,
						color = colors.red,
					},
				})
			else
				mullvad:set({
					icon = {
						string = icons.mullvad.connected,
						color = colors.green,
					},
				})
			end
		end)
	end)
end

mullvad:subscribe({ "routine", "forced", "system_woke" }, update_vpn_icon)

mullvad:subscribe("mouse.clicked", function()
	sbar.exec(BINARY .. " status", function(status_info)
		if string.match(status_info, "Disconnected") then
			sbar.exec(BINARY .. " connect", function()
				update_vpn_icon()
			end)
		else
			sbar.exec(BINARY .. " disconnect", function()
				update_vpn_icon()
			end)
		end
	end)
end)
