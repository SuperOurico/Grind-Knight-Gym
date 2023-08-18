/*
	These are simple defaults for your project.
 */

world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default
	mob = /mob/player
	view = "16x9"
	New()
		Global_Master_Loop()
var
	list/playerList = new()
	
proc/Global_Master_Loop()
	set waitfor = FALSE
	try
		var/mob/M
		while(TRUE)
			sleep(5)
			for(M in playerList)				
				M.client.UpdateBars()
	catch()

client
	proc
		UpdateBars()
			var/matrix/M = matrix() // Create a new transformation matrix
			var/stamPercent = mob.stamina / 100 // Calculate the stamina percentage
			var/canUpdate = findElementInVisContents(/obj/resource_visuals/Stamina_Visual) // Find the stamina visual object in vis_contents
			stamPercent = clamp(stamPercent, 0, 1) // Clamp the stamina percentage between 0 and 1
			var/translatePos = (78 - (78 * stamPercent)) / 2  // Calculate the translation position; 78 is the pixel width of the resource bars
			M.Scale(stamPercent, 1) // Scale the matrix by the stamina percentage
			M.Translate(-translatePos, 0) // Translate the matrix by the calculated position
			if(canUpdate) // Check if the stamina visual object was found
				animate(canUpdate, transform = M, time = world.tick_lag) // Animate the stamina visual object with the transformation

client
	proc
		findElementInVisContents(typeToFind, obj/container = mob.Interface_Overlay)
			var/list/toCheck = list(container) // Initialize a list with the container as the starting point
			while(toCheck.len) // Continue as long as there are elements to check
				var/obj/element = toCheck[1] // Get the first element from the list
				toCheck -= element // Remove the element from the list
				if(istype(element, typeToFind)) // Check if the element matches the specified type
					return element // Return the element if it matches
				toCheck += element.vis_contents // Add the element's vis_contents to the list to be checked
			return null // Return null if no matching element was found

//This version uses a list toCheck as a queue to hold the elements that need to be checked. 
//It starts with the container and checks its vis_contents, adding them to the list to be checked. 
//It continues this process until it either finds a matching element or exhausts all the elements to check.
