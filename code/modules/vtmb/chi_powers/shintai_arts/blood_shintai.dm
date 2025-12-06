/datum/chi_discipline/blood_shintai
	name = "Blood Shintai"
	desc = "Manipulate the liquid flow inside."
	icon_state = "blood"
	ranged = FALSE
	delay = 10 SECONDS
	cost_yin = 1
	activate_sound = 'code/modules/wod13/sounds/bloodshintai_activate.ogg'

/datum/movespeed_modifier/blood_fat
	multiplicative_slowdown = 1

/datum/movespeed_modifier/necroing
	multiplicative_slowdown = 2

/datum/movespeed_modifier/wall_passing
	multiplicative_slowdown = 5

/datum/movespeed_modifier/blood_slim
	multiplicative_slowdown = -0.5

/obj/item/reagent_containers/spray/pepper/kuei_jin
	stream_mode = 1
	stream_range = 5
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/consumable/condensedcapsaicin = 50, /datum/reagent/blood = 20)

/mob/living/simple_animal/hostile/bloodcrawler/kuei_jin
	name = "blood splatter"
	desc = "Just a moving blood splatter on the floor..."
	icon = 'icons/effects/blood.dmi'
	icon_state = "floor1"
	icon_living = "floor1"
	speed = 3
	maxHealth = 100
	health = 100
	melee_damage_lower = 1
	melee_damage_upper = 1
	a_intent = INTENT_HELP
	attack_verb_continuous = "splashes"
	attack_verb_simple = "splash"

/mob/living/simple_animal/hostile/bloodcrawler/kuei_jin/Initialize(mapload)
	. = ..()
	icon_state = "floor[rand(1, 7)]"
	icon_living = "floor[rand(1, 7)]"

/mob/living/simple_animal/hostile/bloodcrawler/kuei_jin/Crossed(atom/movable/O)
	. = ..()
	if(ishuman(O))
		var/mob/living/carbon/C = O
		to_chat(C, "<span class='notice'>You slipped[ O ? " on the [O.name]" : ""]!</span>")
		playsound(C.loc, 'sound/misc/slip.ogg', 50, TRUE)

		SEND_SIGNAL(C, COMSIG_ON_CARBON_SLIP)
		for(var/obj/item/I in C.held_items)
			C.accident(I)

//		var/olddir = C.dir
		C.moving_diagonally = 0 //If this was part of diagonal move slipping will stop it.
		C.Knockdown(2 SECONDS)

/obj/effect/proc_holder/spell/targeted/shapeshift/bloodcrawler/kuei_jin
	shapeshift_type = /mob/living/simple_animal/hostile/bloodcrawler/kuei_jin

/obj/item/gun/magic/blood_shintai
	name = "blood spit"
	desc = "Spit blood on your targets."
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "leaper"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	ammo_type = /obj/item/ammo_casing/magic/blood_shintai
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	item_flags = DROPDEL

/obj/item/ammo_casing/magic/blood_shintai
	name = "blood spit"
	desc = "A spit."
	projectile_type = /obj/projectile/blood_wave
	caliber = CALIBER_TENTACLE
	firing_effect_type = null
	item_flags = DROPDEL

/obj/item/gun/magic/blood_shintai/process_fire()
	. = ..()
	if(charges == 0)
		qdel(src)

/obj/projectile/blood_wave
	name = "blood wave"
	icon_state = "leaper"
	speed = 20
	animate_movement = SLIDE_STEPS
	ricochets_max = 5
	ricochet_chance = 100
	ricochet_decay_chance =1
	ricochet_decay_damage = 1

	damage = 75
	damage_type = BRUTE
	armour_penetration = 50
	range = 50
	stun = 20
	eyeblur = 20
	dismemberment = 20

	impact_effect_type = /obj/effect/temp_visual/impact_effect

	hit_stunned_targets = TRUE

/datum/chi_discipline/blood_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			var/result = alert(caster, "How do you manage your shape?",,"Shrink","Inflate")
			if(result == "Inflate")
				var/matrix/inflating_matrix = matrix()
				inflating_matrix.Scale(1.2, 1)
				var/matrix/initial = caster.transform
				animate(caster, transform = inflating_matrix, 1 SECONDS)
				caster.attributes.bloodshield_bonus += level
				caster.add_movespeed_modifier(/datum/movespeed_modifier/blood_fat)
				spawn(delay+caster.discipline_time_plus)
					if(caster)
						animate(caster, transform = initial, 1 SECONDS)
						caster.attributes.bloodshield_bonus -= 0
						caster.remove_movespeed_modifier(/datum/movespeed_modifier/blood_fat)
			else if(result == "Shrink")
				var/matrix/shrinking_matrix = matrix()
				shrinking_matrix.Scale(0.8, 1)
				var/matrix/initial = caster.transform
				animate(caster, transform = shrinking_matrix, 1 SECONDS)
				caster.add_movespeed_modifier(/datum/movespeed_modifier/blood_slim)
				spawn(delay+caster.discipline_time_plus)
					if(caster)
						animate(caster, transform = initial, 1 SECONDS)
						caster.remove_movespeed_modifier(/datum/movespeed_modifier/blood_slim)
		if(2)
			playsound(get_turf(caster), 'code/modules/wod13/sounds/spit.ogg', 50, FALSE)
			spawn(1 SECONDS)
				var/obj/item/reagent_containers/spray/pepper/kuei_jin/sprayer = new (get_turf(caster))
				//spits the weird pepper spray 3 tiles ahead of the caster
				var/turf/sprayed_at_turf = get_turf(caster)
				for (var/i in 1 to 3)
					sprayed_at_turf = get_step(sprayed_at_turf, caster.dir)
				sprayer.spray(sprayed_at_turf, caster)
				qdel(sprayer)
		if(3)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/bloodcrawler/kuei_jin, caster, TRUE)
		if(4)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/gun/magic/blood_shintai(caster))
		if(5)
			var/obj/item/melee/vampirearms/katana/blood/blood_katana = new (caster)
			caster.drop_all_held_items()
			caster.put_in_active_hand(blood_katana)
			spawn(delay+caster.discipline_time_plus)
				if(blood_katana)
					qdel(blood_katana)
