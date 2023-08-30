
/*

	BYOND controls the camera in the game by using a few variables and settings that can be modified at runtime.

	To make things a little more confusing, some of the variables might have the same name, or might do some zany things.

	Below are the basic tools that you need in order to take control of the game camera so that you can make sure that
	everything that you need to see is on camera at any given time.

	At some point, if wanted, I might make this into a deep dive breaking apart some tricks that I used to get a 
	1080p gui while maintaining the lower resolution that I did for Hazordhu, so if you'd like to see that, be sure to head over
	to my Patreon page at https://www.patreon.com/f0lak

	*/

world
	// world.view is what we use to set the default value for the camera size.  The best way to think about this is commented on the lines of code below
	view = 5 // The player can see up to 5 tiles away from the center.  This does not include the center tile (where the player stands)
	view = "11x11" // The players camera (or view size) is 11 x 11 tiles.

client
	view = 5		// This is the default view size for players in your game.
	view = "11x11"	// This can also be set as a string
					// Setting this will override the world default


	// This isn't the more intuitive system, so let's create a system using a simple camera manager.
client
	verb
		Test_Resolution_Change(n as num, n2 as num)
			camera.SetResolution(round(n, 32), round(n2, 32))

client
	var/camera/camera
	New()
		..()
		camera = new(src, 640, 480) // We'll create a new camera for the client which will control the resolution


camera
	// The width and height of the camera, in pixels.  Together they are the resolution of the camera
	var/width
	var/height
	var/tmp/client/owner	// This is the player that the camera belongs to

	New(client/_owner, _width, _height)
		owner = _owner
		SetResolution(_width, _height)

	proc
		// Sets the resolution of the camera and will modify the size of the players viewport
		SetResolution(_width, _height)
			width = _width
			height = _height
			owner.view = SetViewFromResolution(width, height) // Sets the size of the viewport given the resolution in pixels

		// Calculate the resolution of the camera based on the world.icon_size, given th resolution in pixels
		SetViewFromResolution(_width, _height)

			// This will calculate the camera size given a non-square icon_size, ie "24x32"
			if(istext(world.icon_size))
				var/x = findtext(world.icon_size, "x")

				width = copytext(world.icon_size, 1, x)
				height = copytext(world.icon_size, x+1, length(world.icon_size))

				width = text2num(width)
				height = text2num(height)

			// This calculates the camera size given a numeric, or square icon_size, ie: 32
			else 
				width = world.icon_size
				height = world.icon_size
				
			width = _width / width 
			height = _height / height

			return "[width]x[height]" // We return this as a string because we're using this to Set the view size
