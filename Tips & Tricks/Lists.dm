/**Lists are used to represent groups of objects. 
 * Like objects, they have vars and procs associated with them.
 * In order to access these attributes, list vars must be declared of type /list.
 * Built-in variable: len	- The length of the list!
*/
var/list/L = new/list() 
var/list/N = new()
var/M = new/list()

var/list/great_places = list("Grind Knight's Castle")

//Coffee menu - fairywinkle juice not available
var/list/coffee_menu = list("Medium", "Dark", "Mud")

//Trainers and costs
var/list/personal_training = list("Timothy" = "$5", "Daisy" = "$30", "Chad" = "$100")	

//Merchandise
var/list/merch_store = list("Shirt", "Mug", "Hat")         

//An empty list, eight items in length
var/blank_space[8]		//blank_space.len == 8	





//Our billboard options. This list is empty - FOR NOW!
var/list/billboard_list = list()


mob  
	proc
		AccessBillboard()
			billboard_list = list(
				"Coffee Menu" = coffee_menu,
				"Personal Training" = personal_training,
				"Merchandise" = merch_store,
				"Blank Space" = blank_space,
				"Greatest Place" = great_places,
				)
			var/choice = input("What do you want to read?", "Billboard") as null | anything in billboard_list








			if(choice) 
				alert("You have selected [choice]!", "[choice]")
				switch(choice)
					if("Coffee Menu", "Merchandise", "Greatest Place")
						for(var/i in billboard_list[choice])
							usr << i
					if("Personal Training")
						for(var/i in personal_training)
							usr << "[i] costs [personal_training[i]] per hour."
					if("Blank Space")
						var/wantToWrite = alert("Write in the blank space?", "???", "Yes", "No")						
						if(wantToWrite == "Yes")
							var/t = input("What would you like to write?", "???")
							blank_space.Insert(1, t)
							usr << "<i>You scribble something on the board...</i>"
						sleep(10)
						var/wantToRead = alert("Read what is written?", "???", "Yes", "No")
						if(wantToRead == "No") return
						if(wantToRead == "Yes")
							usr << "The board now reads as follows:"
							usr << "_______________________________"
							for(var/i in blank_space)								
								usr << i





								

/** 
Procs
* Add()          Appends the specified items to the list.
* Copy()         Copy into a new list.
* Cut()          Remove elements, decreasing list size.
* Find()         Find the first position of an element in list.
* Insert()       Insert values into a list at a specific point. 
* Join()         Any items in List that are not already text will be converted to text.
* Remove()       Removes the specified items from the list.
* RemoveAll()    Removes all copies of the specified items from the list.
* Splice()       Cuts out items from a list, and inserts new items in their place.
* Swap()         Swap two items in a list. 
*/