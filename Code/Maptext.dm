obj
	notifyText

		New(tile, X, Y)
			..()
			loc = tile; step_x = X; step_y = Y			
		
		maptext_width = 256
		maptext_height = 32
		maptext_x = -112
		maptext_y = 16
		layer = MOB_LAYER + 1
	
		proc
			Send(string, colorOutline = "#000000", colorBody = "#ffffff")
				pixel_y = 6			
				maptext = "<span style='-dm-text-outline: 1px [colorOutline]; color: [colorBody]; font-size: 8px; font-family: Verdana, sans-serif; vertical-align: bottom;'><center>[string]</center></span>"
				animate(src, alpha = 0, pixel_y = 20, time = 15)
				spawn(15) src.loc = null