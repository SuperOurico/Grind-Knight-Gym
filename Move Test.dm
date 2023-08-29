mob/verb
	TestTele()
		Move(locate(7,7,1))
	TestTeleOut()
		Move(locate(8,8,1))
	
area
	TestArea
		Entered(atom/movable/a)
			a << "We MOVED here!"
		Exited(atom/movable/a)
			a << "We EXITED from here!"