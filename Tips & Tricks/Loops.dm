mob
	var/tmp
		jumpCount = 0
		quitFlag = FALSE
		lungCapacity = 10
	
	verb		
		Jumping_Jacks()
			var/jumps = input("Enter the number of jumping jacks to perform.") as num
			while(usr.jumpCount < jumps) // while() loop
				if(usr.quitFlag)
					usr << "After completing [usr.jumpCount] reps, you are taking a short <b>break</b>!"
					break
				usr.jumpCount ++
				usr << "Performing jump number [usr.jumpCount]." 
				usr.Jump()					
				sleep(10)   // 1 second between executions of this loop
			usr.jumpCount = 0

		Quit()
			usr.quitFlag = TRUE			
			sleep(10)
			usr.quitFlag = FALSE
		




		// for() loop
		Hold_Breath()
			var/i
			for(i = 1, i <= usr.lungCapacity, i++)
				sleep(10)
				usr << "You hold your breath for [i] second\s" 	// \s will insert 's' if [] was plural
			usr << "<b>You can hold your breath no longer!</b>"




		// for() list
		Read_Names()
			for(var/mob/npc/Trainer/T in view(5, usr))
				T.Jump()
				T.Say("Hello, my name is [T.name].")
				sleep(10)


				






	proc
		Jump()
			animate(src, pixel_y = 16, time = 1)
			sleep(1)
			animate(src, pixel_y = 0, time = 1)