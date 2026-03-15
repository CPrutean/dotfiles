return {
	default = 0x80ffffff,
	black = 0xff181819,
	white = 0xffffffff,
	red = 0xffff0000,
	red_bright = 0xe0f38ba8,
	green = 0xff9ed072,
	blue = 0xff76cce0,
	blue_bright = 0xe089b4fa,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	grey = 0xff7f8490,
	transparent = 0x00000000,

	bar = {
		bg = 0x65000000,
		border = 0xff2c2e34,
	},

	popup = {
		bg = 0xFF1d1b2d,
		border = 0xff7f8490,
	},
	--bg1 is the defualt color for all backgrounds of components
	bg1 = 0xaa333333,
	bg2 = 0xaaffffff,
	bg3 = 0xFF1d1b2d,
	oldbg = 0x66111111,
	barbg = 0xcc222222,
	--bg3 is what the old bg1 used to be
	--
	accent = 0xFFb482c2,
	accent_bright = 0x33efc2fc,
	accent_transparent = 0x22b482c2,

	spotify_green = 0xe040a02b,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
