mob/var/tmp/obj/screen/Interface_Overlay = new

obj
	screen
		screen_loc = "1, 1"
		plane = 1



	buttons
		icon = 'interface_button.dmi'
		maptext_height = 24
		maptext_width = 64
		alpha = 100
		New(px, py)
			pixel_x = px
			pixel_y = py
			maptext = "<span style='font-size: 10px; font-family: Tahoma, sans-serif; vertical-align: middle;'><center>[name]</center></span>"
		MouseEntered(location, control, params)
			alpha = 255
			. = ..()
		MouseExited(location, control, params)
			alpha = 100
			. = ..()
		Exercise
			name = "Exercise"
		Punch
			name = "Punch"
			MouseDown(location, control, params)
				usr.Jab()
				. = ..()			
		Kick
			name = "Kick"
			MouseDown(location, control, params)
				usr.Roundhouse()
				. = ..()
		Talk
			name = "Talk"
		
obj
	action_buttons
		actions
			New()
				var X = 8
				var Y = 8
				vis_contents = list(
					new/obj/buttons/Exercise(X, Y),
					new/obj/buttons/Punch(X, Y + 26),
					new/obj/buttons/Kick(X, Y + 52),
					new/obj/buttons/Talk(X, Y + 78),
				)
				
			
obj		
	resource_bar_holder
		icon = 'bar_holder.dmi'
		maptext_height = 16
		maptext_width = 80
		alpha = 200
		New(px, py, owner)
			pixel_x = px
			pixel_y = py
			maptext = "<span style='font-size: 10px; font-family: Tahoma, sans-serif; vertical-align: middle;'><center>[name]</center></span>"
		Player_Stamina
			name = "Stamina"

obj
	resource_bars
		resources
			New()
				var X = 8
				var Y = 264
				vis_contents = list(
					new/obj/resource_bar_holder/Player_Stamina(X, Y)
				)

obj
	resource_visuals
		icon = 'resource_visual.dmi'
		New(px, py)
			pixel_x = px
			pixel_y = py

		Stamina_Visual
			New()
				..()
				color += "#f7d749"

obj
	resource_dynamic_bars
		resource_values
			New()
				var X = 9
				var Y = 265
				vis_contents = list(
					new/obj/resource_visuals/Stamina_Visual(X, Y)
				)