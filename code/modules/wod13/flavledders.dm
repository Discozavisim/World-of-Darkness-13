/obj/manholeup
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "ladder"
	name = "ladder"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/climbing = FALSE

/obj/manholeup/attack_hand(mob/user)
	if(!climbing)
		climbing = TRUE
		if(do_after(user, 50, src))
			climbing = FALSE
			var/turf/destination = get_step_multiz(src, UP)
			var/mob/living/L = user
			if(L.pulling)
				L.pulling.forceMove(destination)
			user.forceMove(destination)
			playsound(src, 'code/modules/wod13/sounds/manhole.ogg', 50, TRUE)
		else
			climbing = FALSE
	..()

/obj/manholedown
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "manhole"
	name = "manhole"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/climbing = FALSE

/obj/manholedown/alt
	name = "ladder"
	icon = 'code/modules/wod13/32x48.dmi'

/obj/manholeup/alt
	icon = 'code/modules/wod13/32x48.dmi'
	layer = ABOVE_MOB_LAYER

/obj/manholedown/Initialize(mapload)
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/manholedown/attack_hand(mob/user)
	if(!climbing)
		climbing = TRUE
		if(do_after(user, 50, src))
			climbing = FALSE
			var/turf/destination = get_step_multiz(src, DOWN)
			var/mob/living/L = user
			if(L.pulling)
				L.pulling.forceMove(destination)
			user.forceMove(destination)
			playsound(src, 'code/modules/wod13/sounds/manhole.ogg', 50, TRUE)
		else
			climbing = FALSE
	..()


/obj/transfer_point_vamp
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "matrix_go"
	name = "transfer point"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/obj/transfer_point_vamp/exit
	var/id = 1

/obj/transfer_point_vamp/Initialize(mapload)
	. = ..()
	if(!exit)
		for(var/obj/transfer_point_vamp/T in world)
			if(T.id == id && T != src)
				exit = T
				T.exit = src

/obj/transfer_point_vamp/backrooms
	id = "backrooms"
	alpha = 0

/obj/transfer_point_vamp/backrooms/map
	density = 0

/obj/transfer_point_vamp/umbral
	name = "Gateway to Earth"
	icon = 'code/modules/wod13/48x48.dmi'
	icon_state = "portal"

/obj/transfer_point_vamp/umbral/Bumped(atom/movable/AM)
	. = ..()
	playsound(get_turf(AM), 'code/modules/wod13/sounds/portal_enter.ogg', 75, FALSE)

/obj/transfer_point_vamp/Bumped(atom/movable/AM)
	. = ..()
	var/turf/T = get_step(exit, get_dir(AM, src))
//	to_chat(world, "Moving from [x] [y] [z] to [exit.x] [exit.y] [exit.z]")
//	to_chat(world, "Actually [T.x] [T.y] [T.z]")
	AM.forceMove(T)

/obj/transfer_point_vamp/umbral/earth
	name = "Gateway to Umbra"
	density = FALSE
	alpha = 0

