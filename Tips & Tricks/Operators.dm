//DOT OPERATOR (.) Used to access procs and vars of an object.
player.Health

// ASSIGNMENT OPERATOR (=) Used to assign a value to a variable.
mob/var
	Health = 100

//ARITHMETIC OPERATORS (+, -, *, /, %) Used to perform basic math.
damage = (baseDamage + bonusDamage) * 1.5

//COMPARISON OPERATORS (==, !=, <, >, <=, >=) Compare values and return a boolean result.
if(damage >= 150) //true or false?
	target.Flinch()

//LOGICAL OPERATORS (&&, ||, !) Combine conditions and perform logical operations.
if(Health <= 10 && isInjured)
	Bleed()

//INCREMENT/DECREMENT OPERATORS (++, --) Increase or decrease the value by 1.
mob/verb
	Rest()
		sleep(50)
		Health ++

//MEMBERSHIP OPERATOR (in) Used to check for items in a list.
mob/verb
	Get_Rid_of_the_Evidence()
		for(var/i in inventory)
			Drop(i)