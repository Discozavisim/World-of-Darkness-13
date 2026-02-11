/mob/living/proc/kislota_trip()
	if(client)
		animate(client, color = GLOB.hapi_palaci, time = 10, delay=1)
		animate(client, color = GLOB.kent, time = 5, delay=10)
		animate(client, color = GLOB.xorek, time = 5, delay=10)
		animate(client, color = GLOB.meomoor, time = 5, delay=10)
		animate(client, color = GLOB.trip_black, time = 5, delay=10)
		animate(client, color = GLOB.xorek, time = 5, delay=10)
		animate(client, color = GLOB.meomoor, time = 5, delay=10)
		animate(client, color = GLOB.kent, time = 5, delay=10)
		animate(client, color = GLOB.meomoor, time = 5, delay=10)
		animate(client, color = GLOB.trip_black, time = 5, delay=10)

/mob/living/proc/crazy_screen(start = TRUE, x, y, size)
	if(!x)
		x = 5
	if(!y)
		y = 10
	if(!size)
		size = 5
	var/filter
	var/list/screens = list(hud_used.plane_masters["[FLOOR_PLANE]"], hud_used.plane_masters["[LIGHTING_PLANE]"], hud_used.plane_masters["[O_LIGHTING_VISUAL_PLANE]"],  hud_used.plane_masters["[GAME_PLANE]"])
	if(client)
		switch(start)
			if(TRUE)
				for(var/atom/whole_screen in screens)
					for(var/i in 1 to 7)
						whole_screen.add_filter("wibbly-[i]", 5, wave_filter(x = x, y = y, size = size, offset = rand()))
			else
				for(var/atom/whole_screen in screens)
					for(var/i in 1 to 7)
						filter = whole_screen.get_filter("wibbly-[i]")
						animate(filter)
						whole_screen.remove_filter("wibbly-[i]")


/mob/living/proc/rotation_screen(rotation = 0, start = TRUE)
	var/list/screens = list(hud_used.plane_masters["[FLOOR_PLANE]"], hud_used.plane_masters["[LIGHTING_PLANE]"], hud_used.plane_masters["[O_LIGHTING_VISUAL_PLANE]"],  hud_used.plane_masters["[GAME_PLANE]"])
	if(client)
		switch(start)
			if(TRUE)
				for(var/atom/negr_screen in screens)
					animate(negr_screen, transform = matrix(rotation, MATRIX_ROTATE), time = 2.0 SECONDS, easing = QUAD_EASING, loop = -1)
					animate(transform = matrix(-rotation, MATRIX_ROTATE), time = 1.0 SECONDS, easing = QUAD_EASING)
			else
				for(var/atom/negr_screen in screens)
					animate(negr_screen, transform = matrix(), time = 0.5 SECONDS, easing = QUAD_EASING)


/*
/mob/living/ghostize/(can_reenter_corpse = TRUE, aghosted = FALSE)
	. = ..()
	src.client << sound(null)

*/
