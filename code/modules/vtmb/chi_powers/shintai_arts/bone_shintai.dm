/datum/chi_discipline/bone_shintai
	name = "Bone Shintai"
	desc = "Manipulate the matter static around."
	icon_state = "bone"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yin = 1
	activate_sound = 'code/modules/wod13/sounds/boneshintai_activate.ogg'

/obj/effect/particle_effect/smoke/bad/green/bone_shintai
	name = "green dangerous smoke"

/datum/effect_system/smoke_spread/bad/green/bone_shintai
	effect_type = /obj/effect/particle_effect/smoke/bad/green/bone_shintai

/obj/effect/particle_effect/smoke/bad/green/bone_shintai/smoke_mob(mob/living/carbon/inhaling_mob)
	. = ..()
	if(.)
		inhaling_mob.adjustToxLoss(15, TRUE)
		inhaling_mob.emote("cough")
		return TRUE

/obj/item/melee/vampirearms/knife/bone_shintai
	name = "claws"
	icon_state = "claws"
	w_class = WEIGHT_CLASS_BULKY
	force = 35
	armour_penetration = 100	//It's magical damage
	block_chance = 20
	item_flags = DROPDEL
	masquerade_violating = TRUE
	is_iron = FALSE

/datum/chi_discipline/bone_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			ADD_TRAIT(caster, TRAIT_NOSOFTCRIT, MAGIC_TRAIT)
			ADD_TRAIT(caster, TRAIT_NOHARDCRIT, MAGIC_TRAIT)
			caster.attributes.stamina_bonus += level
			caster.add_movespeed_modifier(/datum/movespeed_modifier/necroing)
			var/initial_limbs_id = caster.dna.species.limbs_id
			caster.dna.species.limbs_id = "rotten1"
			caster.update_body()
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_NOSOFTCRIT, MAGIC_TRAIT)
					REMOVE_TRAIT(caster, TRAIT_NOHARDCRIT, MAGIC_TRAIT)
					caster.attributes.stamina_bonus -= level
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/necroing)
					caster.dna.species.limbs_id = initial_limbs_id
					caster.update_body()
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
		if(2)
			var/initial_hair = caster.hairstyle
			var/initial_facial = caster.facial_hairstyle
			caster.unique_body_sprite = "nothing"
			caster.hairstyle = "Bald"
			caster.facial_hairstyle = "Shaved"
			caster.update_body()
			spawn()
				freezing_aura_loop(caster, delay + caster.discipline_time_plus)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.unique_body_sprite = null
					caster.hairstyle = initial_hair
					caster.facial_hairstyle = initial_facial
					caster.update_body()
		if(3)
			var/obj/item/melee/vampirearms/knife/bone_shintai/righthand_boneknife = new (caster)
			var/obj/item/melee/vampirearms/knife/bone_shintai/lefthand_boneknife = new (caster)
			caster.put_in_r_hand(righthand_boneknife)
			caster.put_in_l_hand(lefthand_boneknife)
			spawn(delay+caster.discipline_time_plus)
				if(righthand_boneknife)
					qdel(righthand_boneknife)
				if(lefthand_boneknife)
					qdel(lefthand_boneknife)
		if(4)
			playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)
			var/datum/effect_system/smoke_spread/bad/green/bone_shintai/smoke = new
			smoke.set_up(4, caster)
			smoke.start()
			qdel(smoke)
		if(5)
			ADD_TRAIT(caster, TRAIT_NOSOFTCRIT, MAGIC_TRAIT)
			ADD_TRAIT(caster, TRAIT_NOHARDCRIT, MAGIC_TRAIT)
			caster.attributes.stamina_bonus += level
			caster.unique_body_sprite = "rotten1"
			caster.update_body()
			caster.set_light(1.4,5,"#34D352")
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_NOSOFTCRIT, MAGIC_TRAIT)
					REMOVE_TRAIT(caster, TRAIT_NOHARDCRIT, MAGIC_TRAIT)
					caster.attributes.stamina_bonus -= level
					caster.unique_body_sprite = null
					caster.update_body()
					caster.set_light(0)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)

/datum/chi_discipline/bone_shintai/proc/freezing_aura_loop(mob/living/carbon/human/caster, duration)
	var/loop_started_time = world.time
	while (world.time <= (loop_started_time + duration))
		for(var/mob/living/carbon/frozen_mob in oviewers(7, caster))
			frozen_mob.do_jitter_animation(1 SECONDS)
			frozen_mob.adjust_bodytemperature(-15)

		sleep(2 SECONDS)
