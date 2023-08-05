mob
	Login()
		..()
		playerList += src
		loc = locate(10, 6, 1)

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
		strikingCooldown = 0
		questsCompleted = 0
		list/inventory = list()
		tmp
			dirtCleaned = 0

	verb
		Say(T as text)
			if(CheckArea(/area/spooky_area/))
				src << "<font color='#aa22af'><b>Nothing happens...</b></font>"
				return
			view(5, src) << "[src] says: [T]"

	npc
		Trainer
			Timothy
				icon = 'timothy.dmi'
			Daisy
				icon = 'daisy.dmi'
			Chad
				icon = 'chad.dmi'
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
		icon = 'BaseWhite.dmi'
		pixel_x = -16
		pixel_y = -12
		bound_width = 32
		bound_height = 32
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
				F["x"] << src.x
				F["y"] << src.y
				F["z"] << src.z
			Load_Progress()
				if(fexists("savefile.sav"))
					var/savefile/F = new("savefile.sav")
					Read(F)
					var/x; var/y; var/z
					F["x"] >> x
					F["y"] >> y
					F["z"] >> z
					loc = (locate(x, y, z))

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



			Yell(T as text)
				if(CheckArea(/area/spooky_area/))
					src << "<font color='#aa22af'><b>Nobody can hear you yell in the spooky area!</b></font>"
					return
				world << "<b>[src] yells: [T]</b>"



		Stat()
			if(statpanel("Stats"))
				stat("Name: ", name)
				stat("Speed: ", speed)
				stat("Strength: ", strength)
				stat("Stamina: ", stamina)
				stat("Completed Quests: ", questsCompleted)

	proc

		CheckArea(area/passedArea)
			for(var/area/A in range(0, src.loc))
				if(A.type == passedArea)
					return TRUE

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
				src.strength += 5

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