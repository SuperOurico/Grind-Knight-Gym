area
	exercise_room
		Entered(mob/M)
			M << "You have entered the exercise room!"
		Exited(mob/M)
			M << "You have left the exercise room!"
	spooky_area
		Entered(mob/M)
			M << "<font color='#aa22af'><b>Beware! There are no rules in the spooky area.</b></font>"