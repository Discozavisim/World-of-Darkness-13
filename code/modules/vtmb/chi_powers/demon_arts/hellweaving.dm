/datum/chi_discipline/hellweaving
	name = "Hellweaving"
	desc = "Translate the view of Hell to someone."
	icon_state = "hellweaving"
	ranged = TRUE
	delay = 12 SECONDS
	cost_demon = 1
	activate_sound = 'code/modules/wod13/sounds/hellweaving_activate.ogg'
	discipline_type = "Demon"

/atom/movable/screen/fullscreen/yomi_world
	icon = 'icons/hud/fullscreen.dmi'
	icon_state = "hall"
	layer = CURSE_LAYER
	plane = FULLSCREEN_PLANE

/atom/movable/screen/fullscreen/yomi_world/Initialize(mapload)
	. = ..()
	dir = pick(NORTH, EAST, WEST, SOUTH, SOUTHEAST, SOUTHWEST, NORTHEAST, NORTHWEST)

/obj/effect/particle_effect/smoke/bad/yomi
	name = "dark red smoke"
	color = "#6f0000"
	opaque = FALSE

/datum/effect_system/smoke_spread/bad/yomi
	effect_type = /obj/effect/particle_effect/smoke/bad/yomi

/obj/effect/particle_effect/smoke/bad/yomi/smoke_mob(mob/living/carbon/inhaling_mob)
	. = ..()
	if(.)
		inhaling_mob.adjustCloneLoss(10, TRUE)
		inhaling_mob.emote(pick("scream", "groan", "cry"))
		return TRUE

/datum/movespeed_modifier/yomi_flashback
	multiplicative_slowdown = 6

/datum/chi_discipline/hellweaving/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mypower = secret_vampireroll(max(get_a_strength(caster), get_a_manipulation(caster))+get_a_intimidation(caster), get_a_willpower(target), caster)
	if(mypower < 1)
		to_chat(caster, "<span class='warning'>You fail at hellweaving!</span>")
		if(mypower == -1)
			caster.Stun(3 SECONDS)
			caster.do_jitter_animation(10)
		return
	switch(level_casting)
		if(1)
			target.overlay_fullscreen("yomi", /atom/movable/screen/fullscreen/yomi_world)
			spawn(5 SECONDS)
				if(target)
					target.clear_fullscreen("yomi", 5)
		if(2)
			playsound(get_turf(target), 'code/modules/wod13/sounds/portal.ogg', 100, TRUE)
			var/datum/effect_system/smoke_spread/bad/yomi/smoke = new
			smoke.set_up(2, target)
			smoke.start()
		if(3)
			target.overlay_fullscreen("yomi", /atom/movable/screen/fullscreen/yomi_world)
			target.add_movespeed_modifier(/datum/movespeed_modifier/yomi_flashback)
			target.emote("cry")
			spawn(7 SECONDS)
				if(target)
					target.clear_fullscreen("yomi", 5)
					target.remove_movespeed_modifier(/datum/movespeed_modifier/yomi_flashback)
		if(4)
			target.overlay_fullscreen("yomi", /atom/movable/screen/fullscreen/yomi_world)
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				var/datum/cb = CALLBACK(human_target, TYPE_PROC_REF(/mob/living/carbon/human, attack_myself_command))
				for(var/i in 1 to 20)
					addtimer(cb, (i - 1) * 1.5 SECONDS)
				target.emote("scream")
				target.do_jitter_animation(3 SECONDS)
			spawn(10 SECONDS)
				if(target)
					target.clear_fullscreen("yomi", 5)
		if(5)
			target.emote(pick("cry", "scream", "groan"))
			target.point_at(caster)
			target.resist_fire()
			target.overlay_fullscreen("yomi", /atom/movable/screen/fullscreen/yomi_world)
			spawn(20 SECONDS)
				if(target)
					target.clear_fullscreen("yomi", 5)

