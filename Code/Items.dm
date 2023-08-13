item
   var
      name = "Base Item"
      description = "Default description."
      stackLimit = 1

item
   creatine
      name = "Creatine"
      description = "Get the most out of your workout with this action packed supplement!"
      stackLimit = 3

itemSlot
   var
      item/storedItem = null
      quantity = 0

mob
   var
      list/itemSlot/inventory = list()	// We make sure every entry in our inventory list is an itemSlot. Nothing else!

mob
   New(loc)
      . = ..()
      for(var/i = 0; i < 5; i++)
         src.inventory.Add(new/itemSlot)

mob
   verb
      Check_Inventory()
         src << "=-=Inventory=-="
         for(var/itemSlot/i in src.inventory)
            if(i.storedItem)
               src << "[i.storedItem] x[i.quantity]"
         src << "=-=-=-=-=-=-=-=-=-="

mob
   verb
      Admin_Give_Item() // A verb to magically give the player an item. Not needed, but fun to have!
         var/list/item/possibleChoices = list(
            /item/creatine
         )

         var choice = input("Select an item.") as null | anything in possibleChoices
         src.Give_Item(choice)

mob
   proc
      Give_Item(item/itemToGive) // This gives the player the item we pass when the proc is called. It can be any item!
         if(itemToGive)
            var itemAdded = FALSE // Track whether the item has been added
            
            // Check existing stacks and add to it if possible.
            for(var/itemSlot/i in src.inventory)
               if(i.storedItem && istype(i.storedItem, itemToGive) && i.quantity < i.storedItem.stackLimit)
                  i.quantity++
                  itemAdded = TRUE
                  src << "Added 1 [i.storedItem] to an existing slot."
                  return TRUE

            // If item is not added, look for an empty slot.
            if(!itemAdded)
               for(var/itemSlot/i in src.inventory)
                  if(i.storedItem == null)
                     i.storedItem = new itemToGive
                     i.quantity = 1
                     itemAdded = TRUE
                     src << "Added 1 [i.storedItem] to a new slot."
                     return TRUE

            // The item wasn't added by now which means we didn't have space for it.
            if(!itemAdded)
               src << "We're out of inventory space!"
               return FALSE

mob
   proc
      Use_Item(item/itemToUse)
         // Check if the item is in inventory
         for(var/itemSlot/i in src.inventory)
            if(i.storedItem && istype(i.storedItem, itemToUse) && i.quantity > 0)
               i.quantity--
               src << "Used 1 [i.storedItem]."
               
               // Perform the specific action for using the item, you can add cases or conditions here
               if(istype(i.storedItem, /item/creatine))
                  src.stamina += 20
                  creatineCooldown = world.time + 3000
                  src << "You took a heaping scoop of creatine! Your stamina regeneration is temporarily increased."

               // If the quantity reaches 0, clear the slot
               if(i.quantity == 0)
                  i.storedItem = null

               return TRUE

         // If we got here, the item was not found
         src << "You don't have any [itemToUse] in your inventory!"
         return FALSE