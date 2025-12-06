/datum/chi_discipline/yang_prana
	name = "Yang Prana"
	desc = "Allows to tap into and manipulate Kuei-Jin internal Yang energy"
	icon_state = "yang_prana"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 2
	discipline_type = "Chi"
	activate_sound = 'code/modules/wod13/sounds/yang_prana.ogg'
	var/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/jaunt

/datum/chi_discipline/yang_prana/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	if(!jaunt)
		jaunt = new(caster)
	switch(level_casting)
		if(1)
			var/new_say = input(caster, "What are you trying to say?", "Say") as null|text
			new_say = sanitize_text(new_say)
			if(new_say)
				caster.say(new_say)

				for(var/mob/living/carbon/human/victim in oviewers(7, caster))
					victim.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_MAGIC)
					victim.gain_trauma(new /datum/brain_trauma/hypnosis(new_say), TRAUMA_RESILIENCE_MAGIC)

					spawn(30 SECONDS)
						if(victim)
							victim.cure_trauma_type(/datum/brain_trauma/hypnosis, TRAUMA_RESILIENCE_MAGIC)
		if(2)
			caster.remove_overlay(HALO_LAYER)
			var/mutable_appearance/fortitude_overlay = mutable_appearance('icons/effects/96x96.dmi', "boh_tear", -HALO_LAYER)
			fortitude_overlay.pixel_x = -32
			fortitude_overlay.pixel_y = -32
			fortitude_overlay.alpha = 128
			caster.overlays_standing[HALO_LAYER] = fortitude_overlay
			caster.apply_overlay(HALO_LAYER)
			caster.set_light(2, 5, "#ffffff")
			spawn()
				yang_mantle_loop(caster, delay + caster.discipline_time_plus)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(HALO_LAYER)
					caster.set_light(0)
		if(3)
			ADD_TRAIT(caster, TRAIT_ENHANCED_MELEE_DODGE, "yang prana 3")
			to_chat(caster, "<span class='notice'>Your muscles relax and start moving on their own. You feel like you could dodge any strike...</span>")
			if(prob(50))
				dancefirst(caster)
			else
				dancesecond(caster)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_ENHANCED_MELEE_DODGE, "yang prana 3")
					to_chat(caster, "<span class='warning'>Your muscles feel normal again.</span>")
		if(4)
			ADD_TRAIT(caster, TRAIT_HANDS_BLOCK_PROJECTILES, "yang prana 4")
			to_chat(caster, "<span class='notice'>Your muscles relax and start moving on their own. You feel like you could deflect bullets...</span>")
			if(prob(50))
				dancefirst(caster)
			else
				dancesecond(caster)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_HANDS_BLOCK_PROJECTILES, "yang prana 4")
					to_chat(caster, "<span class='warning'>Your muscles feel normal again.</span>")
		if(5)
			jaunt.cast(list(caster), caster)

/datum/chi_discipline/yang_prana/proc/yang_mantle_loop(mob/living/carbon/human/caster, duration)
	var/loop_started_time = world.time
	while (world.time <= (loop_started_time + duration))
		for(var/mob/living/viewing_mantle in oviewers(7, caster))
			if(prob(20))
				viewing_mantle.flash_act(affect_silicon = 1)

		sleep(2 SECONDS)
