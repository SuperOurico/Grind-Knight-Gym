/*
	These are simple defaults for your project.
 */

world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default
	mob = /mob/player
	view = 9		// show up to 6 tiles outward from center (13x13 view)
var
	list/playerList = new()

// Make objects move 8 pixels per tick when walking

area
	exercise_room

turf
	Floors
		icon = 'floor.dmi'

		Wood_Floor
			icon_state = "wood"

obj
	step_size = 8
	density = 1
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
						sleep(2)
						usr.canMove = TRUE
					usr << "You begin to lift the barbell."

	Vending_Machine
		icon = 'vending_machine.dmi'
		verb
			Purchase_Creatine()
				set src in oview(1)
				usr.GetCreatine()

	Dirt_Spot
		icon = 'dirt_spot.dmi'
		alpha = 150
		verb
			Clean_Dirt()
				set src in oview(1)
				usr << "You cleaned up the dirt!"
				usr.dirtCleaned = 1
				del src
				
mob
	Login()
		..()
		playerList += src

	Move()
		if(canMove)
			..()

	step_size = 8
	var
		canMove = TRUE
		speed = 1
		strength = 1
		stamina = 100
		exerciseCooldown = 0
		creatineCooldown = 0
		questsCompleted = 0
		dirtCleaned = 0
		list/inventory = list()
	
	npc
		Trainer
			icon = 'trainer.dmi'
			verb
				Talk()
					set src in oview(1)
					var/response = alert(usr, "Hi, I'm your personal trainer. What can I help you with?", "Personal Trainer", "Can I get a job?", "Just some encouragement.", "Never mind.")

					switch(response)
						if("Can I get a job?")
							usr << "Sure, you can clean up some dirt on the gym floor! Accept the quest?"
							var/accept_quest = alert(usr, "Do you want to accept the quest?", "", "Yes", "No")
							if(accept_quest == "Yes")
								usr << "Great! There's a dirt spot on the floor at (10, 10). Go clean it up and come back to me when you're done."
								new/obj/Dirt_Spot(locate(10, 10, 1))
						if("Just some encouragement.")
							usr << "You're doing great! Keep up the hard work, and you'll reach your fitness goals in no time."
						if("Never mind.")
							usr << "Alright, let me know if you need anything."
				Complete_Quest()
					set src in oview(1)
					if(usr.dirtCleaned == 1)
					//if(!locate(/obj/Dirt_Spot) in world)
						usr.questsCompleted += 1
						usr << "Great job! You've completed the quest. You now have [usr.questsCompleted] quests completed."
						usr.dirtCleaned = 0
					else
						usr << "Go clean up the dirt, lazy bones!"

	player
		icon = 'player.dmi'
		Login()
			..()
			RegenerateStamina()
		verb
			Check_Online_Players()
				usr << "=-=Players Online=-="
				for(var/mob/i in playerList)
					usr << i
				usr << "=-=-=-=-=-=-=-=-=-=-="

			Check_Inventory()
				usr << "=-=Inventory=-="
				for(var/i in usr.inventory)
					usr << i
				usr << "=-=-=-=-=-=-=-=-=-="


			Save_Progress()
				if(fexists("savefile.sav"))
					fdel("savefile.sav")
				var/savefile/F = new("savefile.sav")
				Write(F)
			Load_Progress()
				if(fexists("savefile.sav"))
					var/savefile/F = new("savefile.sav")
					Read(F)

			Choose_Name()
				usr.name = input(usr, "What is your name?", "Name") as text

			Consume_Creatine()
				if(world.time < src.creatineCooldown)
					src << "It's too soon for another serving!"
					return
				if("creatine" in src.inventory)
					src.inventory -= "creatine"
					src.stamina += 20
					creatineCooldown = world.time + 3000
					src << "You took a heaping scoop of creatine! Your stamina regeneration is temporarily increased."
				else
					src << "You don't have any creatine."

			Say(T as text)
				view(5, src) << "[src] says: [T]"

			Yell(T as text)
				world << "<b>[src] yells: [T]</b>"


		Stat()
			if(statpanel("Stats"))
				stat("Name: ", name)
				stat("Speed: ", speed)
				stat("Strength: ", strength)
				stat("Stamina: ", stamina)
				stat("Completed Quests: ", questsCompleted)

	proc
		CustomMove(direction)
			if(!canMove)
				return
			step(src, direction)

		Exercise(stat)
			if(src.exerciseCooldown > world.time)
				src << "You need to rest before exercising again."
				return

			if(src.stamina < 10)
				src << "You are too tired to exercise!"
				return

			src.stamina -= 10
			src.exerciseCooldown = world.time + 50

			if(stat == "speed")
				src.speed += 1
			else if(stat == "strength")
				src.strength += 1

			src << "Your [stat] increased to [src.vars[stat]]!"

		RegenerateStamina()
			if(src.stamina < 100)
				src.stamina += 1

			spawn(10)
				RegenerateStamina()

		GetCreatine()
			if("creatine" in src.inventory)
				src << "You already have creatine in your inventory!"
				return

			src.inventory += "creatine"
			src << "You got some creatine! It is now in your inventory."




