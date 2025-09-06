/datum/chi_discipline/black_wind
	name = "Black Wind"
	desc = "Gain control over speed of reaction."
	icon_state = "blackwind"
	ranged = FALSE
	activate_sound = 'code/modules/wod13/sounds/blackwind_activate.ogg'
	delay = 12 SECONDS
	cost_demon = 1
	discipline_type = "Demon"

/datum/chi_discipline/black_wind/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity)
			caster.celerity_visual = TRUE
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/blackwind_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity)
					caster.celerity_visual = FALSE
		if(2)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity2)
			caster.celerity_visual = TRUE
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/blackwind_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity2)
					caster.celerity_visual = FALSE
		if(3)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity3)
			caster.celerity_visual = TRUE
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/blackwind_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity3)
					caster.celerity_visual = FALSE
		if(4)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity4)
			caster.celerity_visual = TRUE
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/blackwind_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity4)
					caster.celerity_visual = FALSE
		if(5)
			caster.add_movespeed_modifier(/datum/movespeed_modifier/celerity5)
			caster.celerity_visual = TRUE
			spawn((delay)+caster.discipline_time_plus)
				if(caster)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/blackwind_deactivate.ogg', 50, FALSE)
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/celerity5)
					caster.celerity_visual = FALSE
