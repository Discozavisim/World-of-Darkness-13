/datum/chi_discipline/tapestry
	name = "Tapestry"
	desc = "Kuei-jin can manipulate the dragon lines that flow beneath the Middle Kingdom."
	icon_state = "tapestry"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	cost_yin = 1
	discipline_type = "Chi"
	activate_sound = 'code/modules/wod13/sounds/tapestry.ogg'
	var/prev_z


/obj/penumbra_ghost
	var/last_umbra_move

/obj/penumbra_ghost/relaymove(mob/living/user, direction)
	if(last_umbra_move+5 < world.time)
		last_umbra_move = world.time
		dir = direction
		forceMove(get_step(src, direction))


/obj/effect/anomaly/grav_kuei
	name = "gravitational anomaly"
	icon_state = "shield2"
	density = FALSE
	var/boing = 0
	aSignal = /obj/item/assembly/signaler/anomaly/grav
	drops_core = FALSE
	var/mob/owner

/obj/effect/anomaly/grav_kuei/process(delta_time)
	anomalyEffect()		//so it's kinda more faster?
	if(death_time < world.time)
		if(loc)
			detonate()
		qdel(src)

/obj/effect/anomaly/grav_kuei/anomalyEffect()
	..()
	boing = TRUE
	for(var/obj/affected_object in orange(4, src))
		if(!affected_object.anchored)
			step_towards(affected_object, src)

	for(var/mob/living/affected_mob in (range(0, src) - owner))
		gravShock(affected_mob)

	for(var/mob/living/affected_mob in (orange(4, src) - owner))
		if(!affected_mob.mob_negates_gravity())
			step_towards(affected_mob, src)

	for(var/obj/affected_object in range(0, src))
		if(!affected_object.anchored)
			if(isturf(affected_object.loc))
				var/turf/object_turf = affected_object.loc
				if(object_turf.intact && HAS_TRAIT(affected_object, TRAIT_T_RAY_VISIBLE))
					continue
			var/mob/living/target = locate() in view(4,src) - owner
			if(target && !target.stat)
				affected_object.throw_at(target, 5, 10)

/obj/effect/anomaly/grav_kuei/Crossed(atom/movable/AM)
	. = ..()
	gravShock(AM)

/obj/effect/anomaly/grav_kuei/Bump(atom/A)
	gravShock(A)

/obj/effect/anomaly/grav_kuei/Bumped(atom/movable/AM)
	gravShock(AM)

/obj/effect/anomaly/grav_kuei/proc/gravShock(mob/living/affected_mob)
	if(boing && isliving(affected_mob) && !affected_mob.stat)
		affected_mob.Paralyze(4 SECONDS)
		var/atom/target = get_edge_target_turf(affected_mob, get_dir(src, get_step_away(affected_mob, src)))
		affected_mob.throw_at(target, 5, 1)
		boing = FALSE

/datum/chi_discipline/tapestry/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			caster.client.prefs.chat_toggles ^= CHAT_DEAD
			caster.see_invisible = SEE_INVISIBLE_OBSERVER
			notify_ghosts("All ghosts are being called by [caster]!", source = caster, action = NOTIFY_ORBIT, header = "Ghost Summoning")
			spawn(30 SECONDS)
				if(caster)
					caster.client?.prefs.chat_toggles &= ~CHAT_DEAD
					caster.update_sight()
		if(2)
			var/chosen_z
			var/obj/penumbra_ghost/ghost
			var/in_umbra = FALSE

			if(istype(caster.loc, /obj/penumbra_ghost))
				ghost = caster.loc
				in_umbra = TRUE

			for(var/area/vtm/interior/penumbra/penumbra in world)
				if(penumbra)
					chosen_z = penumbra.z

			if(in_umbra)
				chosen_z = prev_z
			else
				prev_z = caster.z

			var/turf/caster_turf = get_turf(caster)
			var/turf/to_wall = locate(caster_turf.x, caster_turf.y, chosen_z)
			var/area/cross_area = get_area(to_wall)
			if(cross_area && cross_area.wall_rating > 1)
				to_chat(caster, span_warning("<b>GAUNTLET</b> rating there is too high!"))
				caster.yin_chi++
				caster.yang_chi++
				return

			if(do_mob(caster, caster, delay))
				if(in_umbra)
					var/atom/myloc = caster.loc
					caster.forceMove(locate(myloc.x, myloc.y, chosen_z))
					qdel(ghost)
					prev_z = null
				else
					caster.z = chosen_z
					ghost = new (get_turf(caster))
					ghost.appearance = caster.appearance
					ghost.name = caster.name
					ghost.alpha = 128
					caster.forceMove(ghost)

				playsound(get_turf(caster), 'code/modules/wod13/sounds/portal.ogg', 100, TRUE)
		if(3)
			ADD_TRAIT(caster, TRAIT_SUPERNATURAL_LUCK, "tapestry 3")
			to_chat(caster, "<b>You feel insanely lucky!</b>")
			spawn(30 SECONDS)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_SUPERNATURAL_LUCK, "tapestry 3")
					to_chat(caster, "<span class='warning'>Your luck wanes...</span>")
		if(4)
			var/teleport_to
			teleport_to = input(caster, "Dragon Nest to travel to:", "BOOYEA", teleport_to) as null|anything in GLOB.teleportlocs
			if(teleport_to)
				if(do_mob(caster, caster, delay))
					var/area/thearea = GLOB.teleportlocs[teleport_to]

					var/datum/effect_system/smoke_spread/smoke = new
					smoke.set_up(2, caster.loc)
					smoke.attach(caster)
					smoke.start()
					var/list/available_turfs = list()
					for(var/turf/area_turf in get_area_turfs(thearea.type))
						if(!area_turf.is_blocked_turf())
							available_turfs += area_turf

					if(!available_turfs.len)
						to_chat(caster, "<span class='warning'>There are no available destinations in that area!</span>")
						return

					if(do_teleport(caster, pick(available_turfs), forceMove = TRUE, channel = TELEPORT_CHANNEL_MAGIC, forced = TRUE))
						smoke.start()
					else
						to_chat(caster, "<span class='warning'>Something disrupted your travel!</span>")
		if(5)
			var/obj/effect/anomaly/grav_kuei/grav_anomaly = new (get_turf(caster))
			grav_anomaly.owner = caster
			spawn(30 SECONDS)
				qdel(grav_anomaly)
