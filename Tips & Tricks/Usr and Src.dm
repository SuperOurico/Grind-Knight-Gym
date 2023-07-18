obj
	Button
		icon = 'button.dmi'
		icon_state = "green"
		verb
			Press()
				set category = "Button"
				set src in orange(1)
				var/list/choices[] = list()
				for(var/mob/M in world)
					choices.Add(M)
				var/troublemaker = input(usr, "Who is the troublemaker?", "Sound Alarm") in choices	
				usr << "<b>[usr] has activated the Lunk Alarm on [troublemaker]!</b>"
				//This is a mob variable (var/mob/usr) containing the mob of the player who executed the current verb,
				//or whose action ultimately called the current proc.

				src.icon_state = "red"
				//This is a variable equal to the object containing the proc or verb. 
				//It is defined to have the same type as that object.

				usr << sound('Sounds/Bells2.mp3', 0, volume = 100, channel = 1)







			Smash()
				set category = "Button"
				var/E = new/obj/Explosion/
				set src in orange(1)
				E:loc = src.loc
				src.loc = null
				usr << sound('Sounds/Explosion3.mp3', 0, volume = 100, channel = 1)

			
	Explosion
		icon = 'explosion.dmi'
		density = 0
		pixel_x = -40
		pixel_y = -32
		New()
			spawn(8) src.loc = null
			..()
