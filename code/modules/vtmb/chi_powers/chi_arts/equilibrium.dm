/datum/chi_discipline/equilibrium
	name = "Equilibrium"
	desc = "Equilibrium can be used to create grotesque Chi imbalances in individuals who displease the user."
	icon_state = "equilibrium"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	cost_yin = 1
	discipline_type = "Chi"
	activate_sound = 'code/modules/wod13/sounds/equilibrium.ogg'

/datum/chi_discipline/equilibrium/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			caster.attributes.strength_bonus += 2
			caster.attributes.dexterity_bonus += 2
			caster.attributes.stamina_bonus += 2
			ADD_TRAIT(caster, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
			caster.do_jitter_animation(1 SECONDS)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.attributes.strength_bonus -= 2
					caster.attributes.dexterity_bonus -= 2
					caster.attributes.stamina_bonus -= 2
					REMOVE_TRAIT(caster, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
		if(2)
			caster.yin_chi += 1
			caster.yang_chi += 1		//Redeeming for the shift
			var/yang_shift = input(caster, "Where do you want to shift your Yang Chi?", "Chi Shift") as null|anything in list("Yin Pool", "Demon Pool", "Nowhere")
			if(yang_shift == "Yin Pool")
				var/init_yin = caster.yin_chi
				var/actually_shifted = min(min(caster.max_yin_chi, caster.yin_chi + caster.yang_chi) - init_yin, caster.yang_chi)
				caster.yang_chi -= actually_shifted
				caster.yin_chi += actually_shifted
				to_chat(caster, "<span class='warning'>You put your Yang into your Yin.</span>")
			if(yang_shift == "Demon Pool")
				var/init_demon = caster.demon_chi
				var/actually_shifted = min(min(caster.max_demon_chi, caster.demon_chi + caster.yang_chi) - init_demon, caster.yang_chi)
				caster.yang_chi -= actually_shifted
				caster.demon_chi += actually_shifted
				to_chat(caster, "<span class='warning'>You put your Yang into your Demon.</span>")

			var/yin_shift = input(caster, "Where do you want to shift your Yin Chi?", "Chi Shift") as null|anything in list("Yang Pool", "Demon Pool", "Nowhere")
			if(yin_shift == "Yang Pool")
				var/init_yang = caster.yang_chi
				var/actually_shifted = min(min(caster.max_yang_chi, caster.yang_chi + caster.yin_chi) - init_yang, caster.yin_chi)
				caster.yin_chi -= actually_shifted
				caster.yang_chi += actually_shifted
				to_chat(caster, "<span class='warning'>You put your Yin into your Yang.</span>")
			if(yin_shift == "Demon Pool")
				var/init_demon = caster.demon_chi
				var/actually_shifted = min(min(caster.max_demon_chi, caster.demon_chi + caster.yin_chi) - init_demon, caster.yin_chi)
				caster.yin_chi -= actually_shifted
				caster.demon_chi += actually_shifted
				to_chat(caster, "<span class='warning'>You put your Yin into your Demon.</span>")

			var/demon_shift = input(caster, "Where do you want to shift your Demon Chi?", "Chi Shift") as null|anything in list("Yin Pool", "Yang Pool", "Nowhere")
			if(demon_shift == "Yin Pool")
				var/init_yin = caster.yin_chi
				var/actually_shifted = min(min(caster.max_yin_chi, caster.yin_chi + caster.demon_chi) - init_yin, caster.demon_chi)
				caster.demon_chi -= actually_shifted
				caster.yin_chi += actually_shifted
				to_chat(caster, "<span class='warning'>You put your Demon into your Yin.</span>")
			if(demon_shift == "Yang Pool")
				var/init_yang = caster.yang_chi
				var/actually_shifted = min(min(caster.max_yang_chi, caster.yang_chi + caster.demon_chi) - init_yang, caster.demon_chi)
				caster.demon_chi -= actually_shifted
				caster.yang_chi += actually_shifted
				to_chat(caster, "<span class='warning'>You put your Demon into your Yang.</span>")
		if(3)
			for(var/mob/living/carbon/human/affected_mob in oviewers(7, caster))
				affected_mob.attributes.strength_bonus += 2
				affected_mob.attributes.dexterity_bonus += 2
				affected_mob.attributes.stamina_bonus += 2
				ADD_TRAIT(affected_mob, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
				var/obj/effect/celerity/celerity_effect = new(get_turf(affected_mob))
				celerity_effect.appearance = affected_mob.appearance
				celerity_effect.dir = affected_mob.dir
				var/matrix/double_size = matrix(affected_mob.transform)
				double_size.Scale(2, 2)
				animate(celerity_effect, transform = double_size, alpha = 0, time = 1 SECONDS)
				spawn(delay+caster.discipline_time_plus)
					qdel(celerity_effect)
					if(affected_mob)
						affected_mob.attributes.strength_bonus -= 2
						affected_mob.attributes.dexterity_bonus -= 2
						affected_mob.attributes.stamina_bonus -= 2
						REMOVE_TRAIT(affected_mob, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
		if(4)
			for(var/mob/living/affected_mob in oviewers(7, caster))
				affected_mob.AdjustKnockdown(2 SECONDS, TRUE)
				affected_mob.emote("scream")
				playsound(get_turf(affected_mob), 'code/modules/wod13/sounds/vicissitude.ogg', 75, FALSE)
				step_away(affected_mob, caster)
		if(5)
			caster.yin_chi += 1
			caster.yang_chi += 1
			var/area/current_area = get_area(caster)
			if(current_area.yang_chi)
				caster.yang_chi = min(caster.yang_chi + current_area.yang_chi, caster.max_yang_chi)
				to_chat(caster, "<span class='engradio'>Some <b>Yang</b> Chi energy enters you...</span>")
			if(current_area.yin_chi)
				caster.yin_chi = min(caster.yin_chi + current_area.yin_chi, caster.max_yin_chi)
				to_chat(caster, "<span class='medradio'>Some <b>Yin</b> Chi energy enters you...</span>")
