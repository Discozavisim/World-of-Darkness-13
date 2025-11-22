/datum/discipline/thaumaturgy_path_of_flames
	name = "Thaumaturgy: The Lure of Flames"
	desc = "A mystical path of Thaumaturgy that allows the summoning of fire and flame. Violates Masquerade."
	icon_state = "thaumaturgy_path_of_flames"
	learnable_by_clans = list(/datum/vampireclane/tremere)
	power_type = /datum/discipline_power/thaumaturgy_path_of_flames

/datum/discipline/thaumaturgy_path_of_flames/post_gain()
	. = ..()
	owner.faction |= "Tremere"
	ADD_TRAIT(owner, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/arctome)

/datum/discipline_power/thaumaturgy_path_of_flames
	name = "Thaumaturgy: The Lure of Flames power name"
	desc = "Thaumaturgy: The Lure of Flames description"

	effect_sound = 'code/modules/wod13/sounds/fireball.ogg'

	var/success_roll

/datum/discipline_power/thaumaturgy_path_of_flames/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/thaumaturgy_path_of_flames/candle
	name = "Candle"
	desc = "Conjure a flame that is the size of a candle. Can be used as a lighter - not much else."

	level = 1
	violates_masquerade = TRUE

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/engulf,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)
	var/list/conjured_candles = list()

/datum/discipline_power/thaumaturgy_path_of_flames/candle/activate()
	. = ..()
	owner.drop_all_held_items()
	var/right_candle = new /obj/item/lighter/conjured/flame/candle(owner)
	var/left_candle = new /obj/item/lighter/conjured/flame/candle(owner)

	owner.put_in_r_hand(right_candle)
	owner.put_in_l_hand(left_candle)

	conjured_candles += WEAKREF(right_candle)
	conjured_candles += WEAKREF(left_candle)

/datum/discipline_power/thaumaturgy_path_of_flames/candle/deactivate()
	. = ..()
	for(var/datum/weakref/candle_ref in conjured_candles)
		var/obj/item/lighter/conjured/flame/candle/candle = candle_ref.resolve()
		if(candle)
			qdel(candle)
	conjured_candles = list()

/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame
	name = "Palm of Flame"
	desc = "Ignite your hands with supernatural fire, adding burn damage to your punches."

	level = 2
	check_flags = DISC_CHECK_CAPABLE
	violates_masquerade = TRUE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/engulf,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)
	var/list/conjured_flames = list()

/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame/activate()
	. = ..()
	owner.drop_all_held_items()

	var/right_flame = new /obj/item/lighter/conjured/flame/palm_of_flame(owner)
	var/left_flame = new /obj/item/lighter/conjured/flame/palm_of_flame(owner)

	owner.put_in_r_hand(right_flame)
	owner.put_in_l_hand(left_flame)

	conjured_flames += WEAKREF(right_flame)
	conjured_flames += WEAKREF(left_flame)

/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame/deactivate()
	. = ..()
	for(var/datum/weakref/flame_ref in conjured_flames)
		var/obj/item/lighter/conjured/flame/palm_of_flame/flame = flame_ref.resolve()
		if(flame)
			qdel(flame)
	conjured_flames.Cut()

/datum/discipline_power/thaumaturgy_path_of_flames/campfire
	name = "Campfire"
	desc = "Summon enough flame that would be in a campfire, and hurl it from your hands."

	level = 3
	violates_masquerade = TRUE
	target_type = TARGET_LIVING
	range = 10

	cooldown_length = 5 SECONDS
	var/flames_range
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/engulf,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)

/datum/discipline_power/thaumaturgy_path_of_flames/campfire/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	switch(success_roll)
		if(-INFINITY to 0)
			to_chat(owner, "You fail to conjure flames anywhere further than your own hand.")
			return FALSE
		if(1)
			flames_range = 2
		if(2)
			flames_range = 3
		if(3)
			flames_range = 5
		if(4 to INFINITY)
			flames_range = 12
	to_chat(owner, span_cult("You have rolled [success_roll] successes and can conjure a flame [flames_range] tiles away."))

	if (get_dist(owner, target) > flames_range)
		to_chat(owner, span_warning("[target] is out of range!"))
		return FALSE
	..()

/datum/discipline_power/thaumaturgy_path_of_flames/campfire/activate(mob/living/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/flames/flamebolt/H = new(start)
	H.firer = owner
	H.damage = 20 + owner.thaum_damage_plus + success_roll
	H.preparePixelProjectile(target, start)
	H.level = 3
	H.fire(direct_target = target)
	to_chat(target, span_danger("A bolt of searing flame flies toward you!"))

/datum/discipline_power/thaumaturgy_path_of_flames/engulf
	name = "Engulf"
	desc = "Surround your target in a raging inferno, dealing continuous burn damage."
	level = 4
	cooldown_length = 10 SECONDS
	violates_masquerade = TRUE
	target_type = TARGET_LIVING
	range = 12
	var/flames_range
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	)

/datum/discipline_power/thaumaturgy_path_of_flames/engulf/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	switch(success_roll)
		if(-INFINITY to 0)
			to_chat(owner, "You fail to conjure flames anywhere further than your own hand.")
			do_cooldown()
			return FALSE
		if(1)
			flames_range = 2
		if(2)
			flames_range = 3
		if(3)
			flames_range = 5
		if(4 to INFINITY)
			flames_range = 12
	to_chat(owner, span_cult("You have rolled [success_roll] successes and can conjure a flame [flames_range] tiles away."))

	if (get_dist(owner, target) > flames_range)
		to_chat(owner, span_warning("[target] is out of range!"))
		return FALSE
	..()

/datum/discipline_power/thaumaturgy_path_of_flames/engulf/activate(mob/living/target)
	. = ..()
	if(!target)
		return

	var/damage_amount = 25 + owner.thaum_damage_plus + success_roll
	target.adjustFireLoss(damage_amount)

	target.adjust_fire_stacks(4 + success_roll)
	target.IgniteMob()

	to_chat(target, span_userdanger("You are engulfed in supernatural flames!"))
	playsound(get_turf(target), effect_sound, 100, TRUE)

/datum/discipline_power/thaumaturgy_path_of_flames/inferno
	name = "Inferno"
	desc = "Unleash a devastating storm of fire that affects multiple targets in an area."
	level = 5
	cooldown_length = 20 SECONDS
	violates_masquerade = TRUE
	target_type = TARGET_TURF | TARGET_LIVING
	range = 12
	var/flames_range
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_flames/candle,
		/datum/discipline_power/thaumaturgy_path_of_flames/palm_of_flame,
		/datum/discipline_power/thaumaturgy_path_of_flames/campfire,
		/datum/discipline_power/thaumaturgy_path_of_flames/engulf
	)

/datum/discipline_power/thaumaturgy_path_of_flames/inferno/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	switch(success_roll)
		if(-INFINITY to 0)
			to_chat(owner, "You fail to conjure flames anywhere further than your own hand.")
			return FALSE
		if(1)
			flames_range = 2
		if(2)
			flames_range = 3
		if(3)
			flames_range = 5
		if(4 to INFINITY)
			flames_range = 12
	to_chat(owner, span_cult("You have rolled [success_roll] successes and can conjure a flame [flames_range] tiles away."))

	if (get_dist(owner, target) > flames_range)
		to_chat(owner, span_warning("[target] is out of range!"))
		return FALSE
	..()

/datum/discipline_power/thaumaturgy_path_of_flames/inferno/activate(atom/target)
	. = ..()

	to_chat(owner, span_notice("You begin channeling a devastating firestorm..."))

	var/turf/center = get_turf(target)

	// minimum one tile away from the center, maximum 3 tiles away from the center
	var/area_range = clamp(success_roll, 1, 4)

	// create the inferno warning on all affected turfs in area_range from center
	var/list/affected_turfs = list()
	for(var/turf/T in range(area_range, center))
		affected_turfs += T
		new /obj/effect/temp_visual/inferno_warning(T)
	owner.visible_message(span_warning("Sparks begin to fly and the temperature begins to climb... what could be happening?!"))

	if(!do_after(owner, 2 SECONDS))
		to_chat(owner, span_warning("Your firestorm casting was interrupted!"))
		for(var/turf/T in affected_turfs) // delete all inferno warnings if casting was interrupted
			for(var/obj/effect/temp_visual/inferno_warning/W in T)
				qdel(W)
		return

	// damage dealt to those standing in the zone is based on successes and so are the fire stacks
	var/base_damage = 20 + (success_roll * 5) + owner.thaum_damage_plus
	var/fire_stacks_amount = 3 + success_roll
	var/ignite_chance = min(60 + (success_roll * 10), 95) // 60% base, +10% per success, max 95%

	// casting succeeded
	for(var/turf/T in affected_turfs)
		// remove inferno warning and insert the actual fire objects
		for(var/obj/effect/temp_visual/inferno_warning/W in T)
			qdel(W)
		new /obj/effect/fire(T)

		// Damage all mobs on each tile
		for(var/mob/living/L in T)
			if(L == owner) // Don't damage self - but caster still gets set on fire
				continue

			L.adjustFireLoss(base_damage)

			// Chance to ignite based on successes
			if(prob(ignite_chance))
				L.adjust_fire_stacks(fire_stacks_amount)
				L.IgniteMob()

			to_chat(L, span_userdanger("You are caught in a supernatural firestorm!"))

	playsound(center, effect_sound, 100, TRUE)
	owner.visible_message(span_danger("[owner] unleashes a devastating firestorm!"))

	// Show success-based feedback to caster
	switch(success_roll)
		if(1)
			to_chat(owner, span_bolddanger("Your firestorm burns with modest intensity."))
		if(2)
			to_chat(owner, span_bolddanger("Your firestorm rages with considerable power."))
		if(3 to INFINITY)
			to_chat(owner, span_bolddanger("Your firestorm burns with devastating supernatural fury!"))

// Warning overlay object
/obj/effect/temp_visual/inferno_warning
	name = "impending inferno"
	desc = "The air shimmers with dangerous heat. Something terrible is about to happen here!"
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	alpha = 150
	duration = 2 SECONDS // Matches the channel time

/obj/effect/temp_visual/inferno_warning/Initialize(mapload)
	. = ..()
	// pulsing animation
	animate(src, alpha = 50, time = 10, loop = -1)
	animate(alpha = 200, time = 10)

	// warning message sent to mobs that stand on the tile
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(warn_entering_mob))

/obj/effect/temp_visual/inferno_warning/proc/warn_entering_mob(datum/source, atom/movable/entered)
	SIGNAL_HANDLER

	if(isliving(entered))
		var/mob/living/L = entered
		to_chat(L, span_warning("You feel intense supernatural heat building in this area!"))

// Projectile for Flame Bolt
/obj/projectile/flames
	name = "flame"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "fireball"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 20
	damage_type = BURN
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = LASER
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_ORANGE
	ricochets_max = 0
	ricochet_chance = 0
	var/level = 1

/obj/projectile/flames/flamebolt
	name = "flame bolt"
	damage = 20

/obj/projectile/flames/flamebolt/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		// Chance to ignite target
		if(prob(10))
			L.adjust_fire_stacks(2)
			L.IgniteMob()
		if(prob(10))
			var/target_turf = get_turf(L)
			new /obj/effect/fire(target_turf)
		L.visible_message(span_danger("[target] is struck by supernatural flames!"), span_userdanger("You are burned by supernatural fire!"))
		playsound(get_turf(target), 'code/modules/wod13/sounds/fireball.ogg', 50, TRUE)

// Mystically conjured items subclassed as lighters to emit light
/obj/item/lighter/conjured
	lit = TRUE
	light_system = MOVABLE_LIGHT
	light_on = TRUE
	damtype = BURN
	item_flags = DROPDEL
	icon = 'code/modules/wod13/icons/paths.dmi'
	lefthand_file = 'code/modules/wod13/icons/paths_inhand_lefthand.dmi'
	righthand_file = 'code/modules/wod13/icons/paths_inhand_righthand.dmi'

// Override parent behavior so that they can't be turned off
/obj/item/lighter/conjured/attack_self(mob/user)
	to_chat(user, span_notice("The supernatural flame cannot be extinguished by normal means."))
	return

/obj/item/lighter/conjured/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)

// Keep the flame always lit
/obj/item/lighter/conjured/set_lit(new_lit)
	if(!new_lit)
		return // Cannot be extinguished
	return ..()

/obj/item/lighter/conjured/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	set_light_on(TRUE)

// Lure of flames conjured weapons
/obj/item/lighter/conjured/flame
	light_range = 3
	light_power = 1
	light_color = COLOR_ORANGE

// afterattack for flame items - includes ignition chance
/obj/item/lighter/conjured/flame/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		// Chance to ignite target - and yourself!
		if(prob(25))
			L.adjust_fire_stacks(1)
			L.IgniteMob()
		if(prob(5))
			user.adjust_fire_stacks(1)
			user.IgniteMob()
		playsound(src, 'code/modules/wod13/sounds/fireball.ogg', 25, TRUE)

	return ..()

// Lure of Flames items
/obj/item/lighter/conjured/flame/candle
	name = "Lure of Flames - Candle"
	desc = "From your finger sprouts out the small flame of a candle."
	icon_state = "candle"
	inhand_icon_state = "candle"
	force = 10

/obj/item/lighter/conjured/flame/palm_of_flame
	name = "hand of flame"
	desc = "Your hand burns with supernatural fire."
	icon_state = "flame"
	inhand_icon_state = "flame"
	force = 25
	fancy = FALSE
