/datum/chi_discipline/ghost_flame_shintai
	name = "Ghost Flame Shintai"
	desc = "Manipulate fire and temperature."
	icon_state = "ghostfire"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	activate_sound = 'code/modules/wod13/sounds/ghostflameshintai_activate.ogg'

/mob/living/simple_animal/hostile/beastmaster/fireball
	name = "fireball"
	desc = "FIREBALL!!"
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "fireball"
	icon_living = "fireball"
	del_on_death = TRUE
	attack_verb_continuous = "burns"
	attack_verb_simple = "burn"
	attack_sound = 'sound/effects/extinguish.ogg'
	speak_chance = 0
	turns_per_move = 5
	see_in_dark = 6
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_UNDEAD
	density = FALSE
	minbodytemp = 200
	maxbodytemp = 400
	unsuitable_atmos_damage = 1
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	bloodpool = 0
	maxbloodpool = 0
	maxHealth = 30
	health = 30
	yang_chi = 1
	max_yang_chi = 1
	yin_chi = 0
	max_yin_chi = 0
	melee_damage_lower = 15
	melee_damage_upper = 30
	melee_damage_type = BURN
	speed = 2
	dodging = TRUE

/obj/item/gun/magic/ghostflame_shintai
	name = "fire spit"
	desc = "Spit fire on your targets."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "fireball"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	ammo_type = /obj/item/ammo_casing/magic/ghostflame_shintai
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	item_flags = DROPDEL

/obj/item/ammo_casing/magic/ghostflame_shintai
	name = "fire spit"
	desc = "A spit."
	projectile_type = /obj/projectile/magic/aoe/fireball/firebreath
	caliber = CALIBER_TENTACLE
	firing_effect_type = null
	item_flags = DROPDEL

/obj/item/gun/magic/ghostflame_shintai/process_fire()
	. = ..()
	if(charges == 0)
		qdel(src)

/datum/chi_discipline/ghost_flame_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/limit = get_a_charisma(caster)+get_a_empathy(caster)
	if(length(caster.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/random_beast = pick(caster.beastmaster)
		random_beast.death()
	switch(level_casting)
		if(1)
			target.overlay_fullscreen("ghostflame", /atom/movable/screen/fullscreen/see_through_darkness)
			caster.set_light(1.4,5,"#ff8c00")
			spawn()
				burning_aura_loop(caster, delay + caster.discipline_time_plus)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					target.clear_fullscreen("ghostflame", 5)
					caster.set_light(0)
		if(2)
			if(!length(caster.beastmaster))
				var/datum/action/beastmaster_stay/stay_action = new()
				stay_action.Grant(caster)
				var/datum/action/beastmaster_deaggro/deaggro_action = new()
				deaggro_action.Grant(caster)
			var/mob/living/simple_animal/hostile/beastmaster/fireball/living_fireball = new(get_turf(caster))
			living_fireball.my_creator = caster
			caster.beastmaster |= living_fireball
			living_fireball.beastmaster = caster
		if(3)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/gun/magic/ghostflame_shintai(caster))
		if(4)
			caster.drop_all_held_items()
			var/obj/item/melee/vampirearms/katana/fire/firekatana = new (caster)
			caster.put_in_active_hand(firekatana)
			spawn(delay+caster.discipline_time_plus)
				if(firekatana)
					qdel(firekatana)
		if(5)
			caster.dna.species.burnmod = 0
			ADD_TRAIT(caster, TRAIT_PERMANENTLY_ONFIRE, MAGIC_TRAIT)
			ADD_TRAIT(caster, TRAIT_RESISTHEAT, MAGIC_TRAIT)
			ADD_TRAIT(caster, TRAIT_CLOTHES_BURN_IMMUNE, MAGIC_TRAIT)
			caster.set_fire_stacks(7)
			caster.IgniteMob()
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_PERMANENTLY_ONFIRE, MAGIC_TRAIT)
					REMOVE_TRAIT(caster, TRAIT_RESISTHEAT, MAGIC_TRAIT)
					REMOVE_TRAIT(caster, TRAIT_CLOTHES_BURN_IMMUNE, MAGIC_TRAIT)
					caster.extinguish_mob()
					if(caster.mind.dharma)
						switch(caster.mind.dharma.animated)
							if("Yang")
								caster.dna.species.burnmod = 0.5
							if("Yin")
								caster.dna.species.burnmod = initial(caster.dna.species.burnmod)
					else
						caster.dna.species.burnmod = initial(caster.dna.species.burnmod)
					caster.bodytemperature = BODYTEMP_NORMAL
					caster.coretemperature = BODYTEMP_NORMAL

/datum/chi_discipline/ghost_flame_shintai/proc/burning_aura_loop(mob/living/carbon/human/caster, duration)
	var/loop_started_time = world.time
	while (world.time <= (loop_started_time + duration))
		for(var/mob/living/carbon/burned_mob in oviewers(7, caster))
			burned_mob.adjustFireLoss(10, TRUE)
			burned_mob.adjust_bodytemperature(15)

		sleep(2 SECONDS)
