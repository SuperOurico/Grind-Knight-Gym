// mob
//    appearance_flags = LONG_GLIDE

// proc
//    GlobalMovementLoop()
//       set waitfor = FALSE
//       var/mob/M
//       while(TRUE)
//          sleep(world.tick_lag)
//          for(M in playerList)
//             if(M.canMove)
//                M.client.CustomMove()

// client
//    key_down() {}
//    key_repeat() {}

//    proc
//       CustomMove()
//          var/D
//          if(keys["north"]) D |= NORTH
//          if(keys["south"]) D |= SOUTH
//          if(keys["east"]) D |= EAST
//          if(keys["west"]) D |= WEST