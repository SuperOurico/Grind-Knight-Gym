mob/proc

	//Damage(modStrength, modSpeed, staticDamage, O, "punching", color)

	//////////////
	// var/modStrength = strength * 1.25
	// var/modSpeed = speed * 1.25
	// var/staticDamage = 5
	// for(var/obj/O in get_step(usr, dir))
	// "punching"
	// var/color = "#ff6565"
	//////////////

	Damage(modStrength, modSpeed, bonus, obj/target, type = "physical", body = "#000000")
		var/amount = modStrength + modSpeed + bonus
		var/obj/notifyText/N = new(loc, step_x, step_y)
		N.Send("We dealt [amount] [type] damage to [target.name]!", colorBody = body)
		target.hitPoints -= amount
		if(target.hitPoints <= 0)
			var/obj/Explosion/E = new
			E.loc = target.loc
			target.loc = null
			usr << sound('Sounds/Explosion3.mp3', 0, volume = 100, channel = 1)

		

	// Damage(modStrength, bonus = staticDamage, target = O, type = "kicking", body = color)