/datum/chi_discipline/iron_mountain
	name = "Iron Mountain"
	desc = "Gain the stoicism and endurability of your P'o."
	icon_state = "ironmountain"
	ranged = FALSE
	activate_sound = 'code/modules/wod13/sounds/ironmountain_activate.ogg'
	delay = 24 SECONDS
	cost_demon = 1
	discipline_type = "Demon"

/datum/chi_discipline/iron_mountain/post_gain(mob/living/carbon/human/user)
	user.attributes.passive_fortitude = level

/datum/chi_discipline/iron_mountain/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
//	caster.remove_overlay(FORTITUDE_LAYER)
//	var/mutable_appearance/fortitude_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "mountain", -FORTITUDE_LAYER)
//	caster.overlays_standing[FORTITUDE_LAYER] = fortitude_overlay
//	caster.apply_overlay(FORTITUDE_LAYER)
	caster.attributes.fortitude_bonus = level_casting
	spawn(delay+caster.discipline_time_plus)
		if(caster)
			caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/ironmountain_deactivate.ogg', 50, FALSE)
			caster.attributes.fortitude_bonus = 0
//			caster.remove_overlay(FORTITUDE_LAYER)
