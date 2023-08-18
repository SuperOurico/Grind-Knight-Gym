//Passing an argument means providing values to a function or a procedure when it is called.
//Arguments allow us to pass data to a function, enabling the function to perform specific tasks with that data. 

mob/verb

	// Jab()
	// 	set category = "Striking"
	// 	flick("punch", usr)
	// 	for(var/obj/O in get_step(usr, dir))
	// 		if(O.canBeDamaged)
	// 			var/damage = strength * 1.25 + 5
	// 			var/obj/notifyText/N = new
	// 			N.loc = loc; N.step_x = step_x; N.step_y = step_y
	// 			N.Send("We dealt [damage] damage!")

	// Roundhouse()
	// 	set category = "Striking"
	// 	flick("punch", usr)
	// 	for(var/obj/O in get_step(usr, usr.dir))
	// 		if(O.canBeDamaged)
	// 			var/damage = strength * 2 + 5
	// 			var/obj/notifyText/N = new
	// 			N.loc = loc; N.step_x = step_x; N.step_y = step_y
	// 			N.Send("We dealt [damage] damage!")






	Jab()
		set category = "Striking"
		var staminacost = 10
		if(world.time < strikingCooldown || stamina < staminacost) return
		flick("punch", usr)
		for(var/obj/O in get_step(usr, dir))
			if(O.canBeDamaged)
				strikingCooldown = world.time + 20
				stamina -= staminacost
				var/modStrength = strength * 1.25
				var/modSpeed = speed * 1.25
				var/staticDamage = 5
				var/color = "#ff6565"				
				Damage(modStrength, modSpeed, staticDamage, O, "punching", color)

	Roundhouse()
		set category = "Striking"
		var staminacost = 15
		if(world.time < strikingCooldown || stamina < staminacost) return
		flick("punch", usr)
		for(var/obj/O in get_step(usr, dir))
			if(O.canBeDamaged)
				strikingCooldown = world.time + 40
				stamina -= staminacost
				var/modStrength = strength * 3
				var/staticDamage = 8
				var/color = "#7e75fa"			
				Damage(modStrength, bonus = staticDamage, target = O, type = "kicking", body = color)