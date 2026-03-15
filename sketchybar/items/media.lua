local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local whitelist = {
	["Google Chrome"] = true,
	["Firefox"] = true,
	["Music"] = true,
	["Plexamp"] = true,
	["Safari"] = true,
	["Spotify"] = true,
	["LibreWolf"] = true,
}

-- Function to get the appropriate background color based on media app
local function get_media_app_color(app_name)
	if app_name == "Music" then
		return colors.red_bright
	elseif app_name == "Plexamp" then
		return colors.yellow
	elseif app_name == "Spotify" then
		return colors.spotify_green
	elseif app_name == "Safari" or app_name == "Firefox" or app_name == "Google Chrome" or app_name == "LibreWolf" then
		return colors.blue_bright
	else
		return colors.default
	end
end

-- Launch the media event provider (uses media-control to bypass macOS 15.4+ MediaRemote restrictions)
sbar.exec(
	"killall -f media_provider.sh >/dev/null 2>&1; $CONFIG_DIR/helpers/event_providers/media/media_provider.sh media_update &"
)

local now_playing = sbar.add("item", {
	position = "right",
	drawing = false,
	background = {
		color = colors.spotify_green,
	},
	icon = {
		padding_left = settings.padding.icon_label_item.icon.padding_left,
		padding_right = settings.padding.icon_label_item.icon.padding_right,
		string = "󰐌",
	},
	label = {
		highlight = false,
		padding_left = settings.padding.icon_label_item.label.padding_left,
		padding_right = settings.padding.icon_label_item.label.padding_right,
	},
	popup = { align = "center" },
})

-- Previous state tracking to detect when media starts playing
local was_playing = false

now_playing:subscribe("media_update", function(env)
	if whitelist[env.app] then
		local is_playing = (env.state == "playing")
		local app_color = get_media_app_color(env.app)

		-- Check if we're transitioning from not playing to playing
		local started_playing = (not was_playing and is_playing)

		now_playing:set({
			background = { color = app_color },
			drawing = is_playing,
			label = { string = env.title .. " - " .. env.artist },
		})

		-- Add animation when media starts playing
		if started_playing then
			sbar.animate("sin", 10, function()
				now_playing:set({
					background = { color = colors.with_alpha(app_color, 0.67) },
				})
			end)
			sbar.animate("sin", 10, function()
				now_playing:set({
					background = { color = app_color },
				})
			end)
		end

		-- Update the state tracker
		was_playing = is_playing
	end
end)
