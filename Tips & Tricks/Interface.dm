//Create an invisible overlay for our map pane.
//This facilitates all of our cool interface elements!
mob/var/tmp/obj/screen/Interface_Overlay = new

//This is a list of objects that are displayed on the user's screen. 
obj
	screen	
		screen_loc = "1, 1" //The object's screen_loc variable controls where it appears (if it appears at all). 
		plane = 1


client
	proc
		SetupHUD()
			screen.Add(mob.Interface_Overlay)

			// Add action buttons and resource bars to the Interface_Overlay screen object.
			var/action_buttons = new/obj/action_buttons/actions
			var/resource_values = new/obj/resource_dynamic_bars/resource_values
			var/resources = new/obj/resource_bars/resources

			mob.Interface_Overlay.vis_contents.Add(action_buttons, resource_values, resources)

client
	proc
		UpdateBars()
			var/stamPercent = clamp(mob.stamina / 100, 0, 1) // Calculate and clamp the stamina percentage
			var/staminaVisual = findElementInVisContents(/obj/resource_visuals/Stamina_Visual) // Find the stamina visual object so we know what to scale.
			
			if(staminaVisual) // Check if the stamina visual object was found
				var/translatePos = (78 - (78 * stamPercent)) / 2  // Calculate the translation position
				var/matrix/M = matrix().Scale(stamPercent, 1).Translate(-translatePos, 0) // Create and transform the matrix
				animate(staminaVisual, transform = M, time = world.tick_lag) // Animate the stamina visual object

client	// This proc just checks for the specified type (typeToFind) and returns it so we can use it in the above code.
	proc	// In this case we're finding /Stamina_Visual which is our stamina bar.
		findElementInVisContents(typeToFind, obj/container = mob.Interface_Overlay)
			var/list/toCheck = list(container) // Initialize a list with the container as the starting point
			while(toCheck.len) // Continue as long as there are elements to check
				var/obj/element = toCheck[1] // Get the first element from the list
				toCheck -= element // Remove the element from the list
				if(istype(element, typeToFind)) // Check if the element matches the specified type
					return element // Return the element if it matches
				toCheck += element.vis_contents // Add the element's vis_contents to the list to be checked
			return null // Return null if no matching element was found

//Buttons are defined below.
obj
	buttons
		icon = 'interface_button.dmi'
		maptext_height = 24
		maptext_width = 64
		alpha = 100
		New(px, py)
			pixel_x = px
			pixel_y = py
			maptext = "<span style='font-size: 10px; font-family: Tahoma, sans-serif; vertical-align: middle;'><center>[name]</center></span>"
			//The string above displays the font for each button.
			//HTML format will determine the size, color, and orientation of the text.
		MouseEntered()
			alpha = 255
			..()
		MouseExited()
			alpha = 100
			..()

//These are our four different buttons.
		Exercise 	//Exercise is a proc called when object verbs are used. We will re-design this later.
			name = "Exercise"

		Punch
			name = "Punch"
			MouseDown()
				usr.Jab()
				..()			
		Kick
			name = "Kick"
			MouseDown()
				usr.Roundhouse()
				..()
		Talk		//Talk is a verb tied to NPCs. This works, but will also need a re-design.
			name = "Talk"
			MouseDown()
				for(var/mob/npc/M in get_step(usr, dir))
					M:Talk()
				..()



//Individual buttons created here!
		
obj
	action_buttons
		actions
			New()	//This is called on Login() and added to vis_contents of our Interface_Overlay.
				var X = 8	//Default coordinates move it a few pixels out of the bottom left corner.
				var Y = 8
				vis_contents = list(
					new/obj/buttons/Exercise(X, Y),
					new/obj/buttons/Punch(X, Y + 26), //Y value increases by 26 for each button, spacing them evenly.
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