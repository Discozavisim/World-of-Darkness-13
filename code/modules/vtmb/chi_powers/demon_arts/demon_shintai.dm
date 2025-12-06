/datum/chi_discipline/demon_shintai
	name = "Demon Shintai"
	desc = "Transform into the P'o."
	icon_state = "demon"
	ranged = FALSE
	delay = 12 SECONDS
	cost_demon = 1
	discipline_type = "Demon"
	activate_sound = 'code/modules/wod13/sounds/demonshintai_activate.ogg'
	var/current_form = "Samurai"

/datum/chi_discipline/demon_shintai/post_gain(mob/living/carbon/human/user)
	var/datum/action/choose_demon_form/demon_form_action = new()
	demon_form_action.Grant(user)

/datum/action/choose_demon_form
	name = "Choose Demon Form"
	desc = "Choose your form of a Demon."
	button_icon_state = "demon_form"
	button_icon = 'code/modules/wod13/UI/kuei_jin.dmi'
	background_icon_state = "discipline"
	icon_icon = 'code/modules/wod13/UI/kuei_jin.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/choose_demon_form/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/user = usr
		var/new_form = input(user, "Choose your Demon Form", "Demon Form") as null|anything in list("Samurai", "Tentacles", "Demon", "Giant", "Foul")
		if(new_form)
			to_chat(user, "Your new form is [new_form].")
			for(var/datum/action/chi_discipline/chi_action in user.actions)
				if(chi_action)
					if(istype(chi_action.discipline, /datum/chi_discipline/demon_shintai))
						var/datum/chi_discipline/demon_shintai/demon_shintai = chi_action.discipline
						demon_shintai.current_form = new_form
		button.color = "#970000"
		animate(button, color = "#ffffff", time = 2 SECONDS, loop = 1)

/datum/movespeed_modifier/tentacles1
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/demonform1
	multiplicative_slowdown = -0.5
/datum/movespeed_modifier/demonform2
	multiplicative_slowdown = -1
/datum/movespeed_modifier/demonform3
	multiplicative_slowdown = -2
/datum/movespeed_modifier/demonform4
	multiplicative_slowdown = -3
/datum/movespeed_modifier/demonform5
	multiplicative_slowdown = -5

/datum/chi_discipline/demon_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(current_form)
		if("Samurai")
			caster.remove_overlay(UNICORN_LAYER)
			var/mutable_appearance/potence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "samurai", -UNICORN_LAYER)
			caster.overlays_standing[UNICORN_LAYER] = potence_overlay
			caster.apply_overlay(UNICORN_LAYER)
			caster.attributes.stamina_bonus += level_casting
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.attributes.stamina_bonus -= level_casting
					caster.remove_overlay(UNICORN_LAYER)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/demonshintai_deactivate.ogg', 50, FALSE)
		if("Tentacles")
			var/mod = level_casting
			caster.remove_overlay(UNICORN_LAYER)
			var/mutable_appearance/potence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "tentacles", -UNICORN_LAYER)
			caster.overlays_standing[UNICORN_LAYER] = potence_overlay
			caster.apply_overlay(UNICORN_LAYER)
			ADD_TRAIT(caster, TRAIT_SHOCKIMMUNE, SPECIES_TRAIT)
			ADD_TRAIT(caster, TRAIT_PASSTABLE, SPECIES_TRAIT)
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			if(mod > 1)
				caster.add_movespeed_modifier(/datum/movespeed_modifier/tentacles1)
				ADD_TRAIT(caster, TRAIT_PUSHIMMUNE, SPECIES_TRAIT)
				ADD_TRAIT(caster, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
			if(mod > 2)
				ADD_TRAIT(caster, TRAIT_IGNOREDAMAGESLOWDOWN, SPECIES_TRAIT)
				ADD_TRAIT(caster, TRAIT_SLEEPIMMUNE, SPECIES_TRAIT)
			if(mod > 4)
				ADD_TRAIT(caster, TRAIT_STUNIMMUNE, SPECIES_TRAIT)
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(UNICORN_LAYER)
					REMOVE_TRAIT(caster, TRAIT_SHOCKIMMUNE, SPECIES_TRAIT)
					REMOVE_TRAIT(caster, TRAIT_PASSTABLE, SPECIES_TRAIT)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
					if(mod > 1)
						caster.remove_movespeed_modifier(/datum/movespeed_modifier/tentacles1)
						REMOVE_TRAIT(caster, TRAIT_PUSHIMMUNE, SPECIES_TRAIT)
						REMOVE_TRAIT(caster, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
					if(mod > 2)
						REMOVE_TRAIT(caster, TRAIT_IGNOREDAMAGESLOWDOWN, SPECIES_TRAIT)
						REMOVE_TRAIT(caster, TRAIT_SLEEPIMMUNE, SPECIES_TRAIT)
					if(mod > 4)
						REMOVE_TRAIT(caster, TRAIT_STUNIMMUNE, SPECIES_TRAIT)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/demonshintai_deactivate.ogg', 50, FALSE)
		if("Demon")
			var/mod = level_casting
			caster.remove_overlay(UNICORN_LAYER)
			var/mutable_appearance/potence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "demon", -UNICORN_LAYER)
			caster.overlays_standing[UNICORN_LAYER] = potence_overlay
			caster.apply_overlay(UNICORN_LAYER)
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			switch(mod)
				if(1)
					caster.add_movespeed_modifier(/datum/movespeed_modifier/demonform1)
				if(2)
					caster.add_movespeed_modifier(/datum/movespeed_modifier/demonform2)
				if(3)
					caster.add_movespeed_modifier(/datum/movespeed_modifier/demonform3)
				if(4)
					caster.add_movespeed_modifier(/datum/movespeed_modifier/demonform4)
				if(5)
					caster.add_movespeed_modifier(/datum/movespeed_modifier/demonform5)
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(UNICORN_LAYER)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
					switch(mod)
						if(1)
							caster.remove_movespeed_modifier(/datum/movespeed_modifier/demonform1)
						if(2)
							caster.remove_movespeed_modifier(/datum/movespeed_modifier/demonform2)
						if(3)
							caster.remove_movespeed_modifier(/datum/movespeed_modifier/demonform3)
						if(4)
							caster.remove_movespeed_modifier(/datum/movespeed_modifier/demonform4)
						if(5)
							caster.remove_movespeed_modifier(/datum/movespeed_modifier/demonform5)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/demonshintai_deactivate.ogg', 50, FALSE)
		if("Giant")
			caster.remove_overlay(UNICORN_LAYER)
			var/mutable_appearance/potence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "giant", -UNICORN_LAYER)
			caster.overlays_standing[UNICORN_LAYER] = potence_overlay
			caster.apply_overlay(UNICORN_LAYER)
			caster.attributes.strength_bonus += level_casting
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(UNICORN_LAYER)
					caster.attributes.strength_bonus -= level_casting
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/demonshintai_deactivate.ogg', 50, FALSE)
		if("Foul")
			caster.remove_overlay(UNICORN_LAYER)
			var/mutable_appearance/potence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "foul", -UNICORN_LAYER)
			caster.overlays_standing[UNICORN_LAYER] = potence_overlay
			caster.apply_overlay(UNICORN_LAYER)
			spawn()
				foul_aura_loop(caster, delay + caster.discipline_time_plus, level_casting)
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(UNICORN_LAYER)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/demonshintai_deactivate.ogg', 50, FALSE)

/datum/chi_discipline/demon_shintai/proc/foul_aura_loop(mob/living/carbon/human/caster, duration, strength)
	var/loop_started_time = world.time
	while (world.time <= (loop_started_time + duration))
		for(var/mob/living/carbon/grossed_out_mob in oviewers(7, caster))
			if(prob(strength))
				grossed_out_mob.Unconscious(0.5*strength SECONDS)
			grossed_out_mob.adjust_blurriness(strength * 5)

		sleep(3 SECONDS)
