/datum/chi_discipline/jade_shintai
	name = "Jade Shintai"
	desc = "Manipulate own weight and capabilities."
	icon_state = "jade"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	activate_sound = 'code/modules/wod13/sounds/jadeshintai_activate.ogg'

/obj/item/melee/powerfist/stone
	name = "stone-fist"
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "stonefist"
	desc = "A stone gauntlet to punch someone."
	item_flags = DROPDEL

/obj/item/tank/internals/oxygen/stone_shintai
	item_flags = DROPDEL
	alpha = 0

/obj/item/melee/powerfist/stone/Initialize(mapload)
	. = ..()
	tank = new /obj/item/tank/internals/oxygen/stone_shintai()

/obj/item/melee/powerfist/stone/updateTank(obj/item/tank/internals/thetank, removing = 0, mob/living/carbon/human/user)
	return FALSE

/datum/chi_discipline/jade_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			var/obj/structure/bury_pit/burial_pit = new (get_turf(caster))
			burial_pit.icon_state = "pit1"
			caster.forceMove(burial_pit)
		if(2)
			caster.pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
			ADD_TRAIT(caster, TRAIT_SUPERNATURAL_DEXTERITY, "jade shintai 2")
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.pass_flags = initial(caster.pass_flags)
					REMOVE_TRAIT(caster, TRAIT_SUPERNATURAL_DEXTERITY, "jade shintai 2")
		if(3)
			ADD_TRAIT(caster, TRAIT_PASS_THROUGH_WALLS, "jade shintai 3")
			caster.invisibility = INVISIBILITY_LEVEL_OBFUSCATE
			caster.alpha = 100
			caster.obfuscate_level = 3
			caster.add_movespeed_modifier(/datum/movespeed_modifier/wall_passing)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.obfuscate_level = 0
					caster.alpha = 255
					caster.invisibility = initial(caster.invisibility)
					REMOVE_TRAIT(caster, TRAIT_PASS_THROUGH_WALLS, "jade shintai 3")
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/wall_passing)
		if(4)
			caster.dna.species.ToggleFlight(caster)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.dna.species.ToggleFlight(caster)
		if(5)
			caster.remove_overlay(POTENCE_LAYER)
			var/mutable_appearance/fortitude_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "[caster.base_body_mod]rock", -POTENCE_LAYER)
			caster.overlays_standing[POTENCE_LAYER] = fortitude_overlay
			caster.apply_overlay(POTENCE_LAYER)
			caster.attributes.stamina_bonus += 3
			caster.drop_all_held_items()
			var/obj/item/melee/powerfist/stone/righthand_stonefist = new (caster)
			var/obj/item/melee/powerfist/stone/lefthand_stonefist = new (caster)
			caster.put_in_r_hand(righthand_stonefist)
			caster.put_in_l_hand(lefthand_stonefist)
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.attributes.stamina_bonus -= 3
					caster.remove_overlay(POTENCE_LAYER)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
					if(righthand_stonefist)
						qdel(righthand_stonefist)
					if(lefthand_stonefist)
						qdel(lefthand_stonefist)
