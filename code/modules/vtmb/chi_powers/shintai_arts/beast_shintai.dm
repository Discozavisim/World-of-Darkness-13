/datum/chi_discipline/beast_shintai
	name = "Beast Shintai"
	desc = "Use the chi energy flow to control animals or become one."
	icon_state = "beast"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	activate_sound = 'code/modules/wod13/sounds/beastshintai_activate.ogg'

/obj/effect/proc_holder/spell/targeted/shapeshift/werewolf_like
	name = "Crinos Form"
	desc = "Take on the shape a Crinos."
	charge_max = 50
	cooldown_min = 50
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/crinos_beast

/mob/living/simple_animal/hostile/crinos_beast
	name = "Wolf-like Beast"
	desc = "The peak of abominations damage. Unbelievably deadly..."
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "beast_crinos"
	icon_living = "beast_crinos"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	speed = -1
	maxHealth = 575
	health = 575
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	melee_damage_lower = 35
	melee_damage_upper = 50
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dodging = TRUE

/datum/chi_discipline/beast_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/limit = get_a_charisma(caster)+get_a_empathy(caster)
	if(length(caster.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/random_beast = pick(caster.beastmaster)
		random_beast.death()
	switch(level_casting)
		if(1)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/stay_action = new()
				stay_action.Grant(caster)
				var/datum/action/beastmaster_deaggro/deaggro_action = new()
				deaggro_action.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/rat/rat = new(get_turf(caster))
			caster.beastmaster |= rat
			rat.beastmaster = caster
		if(2)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/stay_action = new()
				stay_action.Grant(caster)
				var/datum/action/beastmaster_deaggro/deaggro_action = new()
				deaggro_action.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/cat/cat = new(get_turf(caster))
			caster.beastmaster |= cat
			cat.beastmaster = caster
		if(3)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/stay_action = new()
				stay_action.Grant(caster)
				var/datum/action/beastmaster_deaggro/deaggro_action = new()
				deaggro_action.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/dog = new(get_turf(caster))
			caster.beastmaster |= dog
			dog.beastmaster = caster
		if(4)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/stay_action = new()
				stay_action.Grant(caster)
				var/datum/action/beastmaster_deaggro/deaggro_action = new()
				deaggro_action.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/rat/flying/bat = new(get_turf(caster))
			caster.beastmaster |= bat
			bat.beastmaster = caster
		if(5)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/crinos_beast, caster, TRUE)
