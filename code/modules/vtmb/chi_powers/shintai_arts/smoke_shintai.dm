/datum/chi_discipline/smoke_shintai
	name = "Smoke Shintai"
	desc = "Use the chi energy flow to control fumes and smokes."
	icon_state = "smoke"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	activate_sound = 'code/modules/wod13/sounds/smokeshintai_activate.ogg'

/obj/effect/proc_holder/spell/targeted/shapeshift/smoke_form
	name = "Smoke Form"
	desc = "Take on the shape a Smoke."
	charge_max = 50
	cooldown_min = 50
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/smokecrawler

/obj/effect/proc_holder/spell/targeted/shapeshift/hidden_smoke_form
	name = "Smoke Form"
	desc = "Take on the shape a Smoke."
	charge_max = 50
	cooldown_min = 50
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/smokecrawler/hidden

/mob/living/simple_animal/hostile/smokecrawler
	name = "Smoke Form"
	desc = "Levitating fumes."
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	icon_living = "smoke"
	mob_biotypes = MOB_ORGANIC
	density = FALSE
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	speak_chance = 0
	speed = 3
	maxHealth = 100
	health = 100
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	harm_intent_damage = 5
	melee_damage_lower = 1
	melee_damage_upper = 1
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 0
	maxbloodpool = 0

/mob/living/simple_animal/hostile/smokecrawler/hidden
	alpha = 10
	speed = 3

/datum/chi_discipline/smoke_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			var/datum/effect_system/smoke_spread/bad/smoke = new
			smoke.set_up(4, caster)
			smoke.start()
			playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)
		if(2)
			var/list/available_turfs = list()
			for(var/turf/open/O in view(7, caster))
				if(O)
					available_turfs += O
			if(length(available_turfs))
				var/turf/to_move = pick(available_turfs)
				var/atom/movable/visual1 = new (get_turf(caster))
				visual1.density = FALSE
				visual1.anchored = TRUE
				visual1.layer = ABOVE_ALL_MOB_LAYER
				visual1.icon = 'code/modules/wod13/icons.dmi'
				visual1.icon_state = "puff"
				playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)
				caster.forceMove(to_move)
				var/atom/movable/visual2 = new (to_move)
				visual2.density = FALSE
				visual1.anchored = TRUE
				visual2.layer = ABOVE_ALL_MOB_LAYER
				visual2.icon = 'code/modules/wod13/icons.dmi'
				visual2.icon_state = "puff"
				spawn(2 SECONDS)
					qdel(visual1)
					qdel(visual2)
		if(3)
			var/atom/movable/visual1 = new (get_step(caster, caster.dir))
			visual1.density = TRUE
			visual1.anchored = TRUE
			visual1.layer = ABOVE_ALL_MOB_LAYER
			visual1.icon = 'icons/effects/effects.dmi'
			visual1.icon_state = "smoke"
			var/atom/movable/visual2 = new (get_step(get_step(caster, caster.dir), turn(caster.dir, 90)))
			visual2.density = TRUE
			visual2.anchored = TRUE
			visual2.layer = ABOVE_ALL_MOB_LAYER
			visual2.icon = 'icons/effects/effects.dmi'
			visual2.icon_state = "smoke"
			var/atom/movable/visual3 = new (get_step(get_step(caster, caster.dir), turn(caster.dir, -90)))
			visual3.density = TRUE
			visual3.anchored = TRUE
			visual3.layer = ABOVE_ALL_MOB_LAYER
			visual3.icon = 'icons/effects/effects.dmi'
			visual3.icon_state = "smoke"
			playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)
			spawn(delay+caster.discipline_time_plus)
				qdel(visual1)
				qdel(visual2)
				qdel(visual3)
		if(4)
			playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/smokecrawler, caster, TRUE)
		if(5)
			playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/smokecrawler/hidden, caster, TRUE)
