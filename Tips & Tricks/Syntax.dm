/**INHERITANCE allows an object type to inherit characteristics from its parent.
 * This creates a structured hierarchy and facilitates code reusability.
 * You can use indentations, semicolons, or curly braces. This depends on your STYLE!
 */


// mob
// 	verb 
// 		Warm_Up() 
// 			usr << "You warm up like an aspiring new DM programmer."

// mob/verb/Warm_Up()
//    usr << "You warm up like a pretty neat guy."

// mob {
// 	verb/Warm_Up() {
// 		usr << "You warm up like a C or Java programmer."
// 	}
// }

mob {verb/Warm_Up() {usr << "You warm up like a crazy person."}}





Warmup_Types
	var/one = "Arm circles", two = "Lunges", three = "Neck tilts"
	//This is equivalent to the following syntax:

	var/four = "Jumping jacks"
	var/five = "Air squats" 
	var/six = "Rotations"

	var
		seven = "Wall angels"; eight = "YTWL"; nine = "Knee raises";
	//This is equivalent to the following syntax:

	var
		ten = "Spider fingers"
		eleven = "Towel stretch"
		twelve = "Cat cow"


//DANGER ZONE//
//You can use single spaces if you are a masochist.
Forbidden_Warmup
 var
  thirteen="Weighted good-mornings"
//END OF DANGER ZONE//


mob/verb/Show_Options()
	 var/Warmup_Types/warmupTypes = new

	 var/list/varNames = list("one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve")

	 for(var/i in varNames)
		  usr << "[i]: [warmupTypes.vars[i]]"



