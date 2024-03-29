obj
	step_size = 8
	density = 1
	var/canBeDamaged = 0
	var/hitPoints = 1
	Exercise_Equipment
		icon = 'equipment.dmi'

		Treadmill
			icon_state = "treadmill"
			verb
				Use_Treadmill()
					set src in oview(1)
					usr.Exercise("speed")

		Barbell
			icon_state = "barbell"
			layer = MOB_LAYER + 1			
			verb
				
				Lift_Barbell()
					set src in oview(1)					
					usr.canMove = FALSE
					usr.loc = locate(src.x, src.y, src.z)
					usr.step_x = src.step_x
					usr.step_y = src.step_y
					usr.dir = SOUTH
					animate(src, pixel_y = 16, time = 8)
					animate(pixel_y = 0, time = 5)
					spawn(15)
						usr.Exercise("strength")
						usr << sound('Sounds/Clank_10.mp3', 0, volume = 100, channel = 1)
						sleep(2)
						usr.canMove = TRUE
					usr << "You begin to lift the barbell."

	Vending_Machine
		icon = 'vending_machine.dmi'
		verb
			Purchase_Creatine()
				set src in oview(1)
				usr.Give_Item(/item/creatine)	// Give the usr 1 creatine using our new proc!

	Dirt_Spot
		icon = 'dirt_spot.dmi'
		alpha = 150
		verb
			Clean_Dirt()
				set src in oview(1)
				usr << "You cleaned up the dirt!"
				usr.dirtCleaned = 1
				del src
				
	Billboard
		icon = 'billboard.dmi'
		density = 1
		verb
			Read_Billboard()
				set src in oview(1)
				usr.AccessBillboard()


obj		
	Punching_Bag
		icon = 'punchingbag.dmi'
		name = "Punching Bag"
		canBeDamaged = 1	//could also be written as canBeDamaged = TRUE
		hitPoints = 50