/datum/discipline/dt_path_fires_of_inferno
	name = "Dark Thaumaturgy: The Fires of the Inferno"
	desc = "This path of Dark Thaumaturgy allows the thaumaturge to control supernatural flames summoned from the depths of Hades."
	icon_state = "dt_path_fires_of_inferno"
	learnable_by_clans = list(/datum/vampireclane/baali)
	power_type = /datum/discipline_power/dt_path_fires_of_inferno

/datum/discipline/dt_path_fires_of_inferno/post_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DARK_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/dttome)

/datum/discipline_power/dt_path_fires_of_inferno
	name = "Dark Thaumaturgy: The Fires of the Inferno power name"
	desc = "Dark Thaumaturgy: The Fires of the Inferno description"

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	target_type = TARGET_MOB | TARGET_OBJ | TARGET_TURF
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE
	range = 7

	cooldown_length = 3 TURNS
	var/success_roll
	var/fire_damage
	var/fortitude_hardness
	var/fortitude_absorb = 1

/datum/discipline_power/dt_path_fires_of_inferno/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll < 0)
		to_chat(owner, span_danger("You lose the control of the flames as they coat you!"))
		fires_of_inferno_botch_effect()
		return FALSE
	else if(success_roll == 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE



/datum/discipline_power/dt_path_fires_of_inferno/proc/fires_of_inferno_botch_effect()
	var/turf/start = get_turf(owner)
	var/obj/projectile/magic/aoe/fireball/baali/created_fireball = new(start)
	created_fireball.damage_type = CLONE
	created_fireball.damage = fire_damage
	created_fireball.firer = owner
	created_fireball.preparePixelProjectile(owner, start)
	created_fireball.fire(direct_target = owner)

/datum/discipline_power/dt_path_fires_of_inferno/lighter
	name = "Lighter"
	desc = "Control supernatural flames summoned from the depths of Hades"
	level = 1
	fire_damage = 25
	fortitude_hardness = 3
	grouped_powers = list(
		/datum/discipline_power/dt_path_fires_of_inferno/stovetop,
		/datum/discipline_power/dt_path_fires_of_inferno/blowtorch,
		/datum/discipline_power/dt_path_fires_of_inferno/flamethrower,
		/datum/discipline_power/dt_path_fires_of_inferno/conflagration
	)

/datum/discipline_power/dt_path_fires_of_inferno/stovetop
	name = "Stovetop"
	desc = "Control supernatural flames summoned from the depths of Hades"
	level = 2
	fire_damage = 50
	fortitude_hardness = 4
	grouped_powers = list(
		/datum/discipline_power/dt_path_fires_of_inferno/lighter,
		/datum/discipline_power/dt_path_fires_of_inferno/blowtorch,
		/datum/discipline_power/dt_path_fires_of_inferno/flamethrower,
		/datum/discipline_power/dt_path_fires_of_inferno/conflagration
	)

/datum/discipline_power/dt_path_fires_of_inferno/blowtorch
	name = "Blowtorch"
	desc = "Control supernatural flames summoned from the depths of Hades"
	level = 3
	fire_damage = 75
	fortitude_hardness = 5
	grouped_powers = list(
		/datum/discipline_power/dt_path_fires_of_inferno/stovetop,
		/datum/discipline_power/dt_path_fires_of_inferno/lighter,
		/datum/discipline_power/dt_path_fires_of_inferno/flamethrower,
		/datum/discipline_power/dt_path_fires_of_inferno/conflagration
	)

/datum/discipline_power/dt_path_fires_of_inferno/flamethrower
	name = "Flame-thrower"
	desc = "Control supernatural flames summoned from the depths of Hades"
	level = 4
	fire_damage = 100
	fortitude_hardness = 7
	grouped_powers = list(
		/datum/discipline_power/dt_path_fires_of_inferno/stovetop,
		/datum/discipline_power/dt_path_fires_of_inferno/blowtorch,
		/datum/discipline_power/dt_path_fires_of_inferno/lighter,
		/datum/discipline_power/dt_path_fires_of_inferno/conflagration
	)

/datum/discipline_power/dt_path_fires_of_inferno/conflagration
	name = "Conflagration"
	desc = "Control supernatural flames summoned from the depths of Hades"
	level = 5
	fire_damage = 125
	fortitude_hardness = 9
	grouped_powers = list(
		/datum/discipline_power/dt_path_fires_of_inferno/stovetop,
		/datum/discipline_power/dt_path_fires_of_inferno/blowtorch,
		/datum/discipline_power/dt_path_fires_of_inferno/flamethrower,
		/datum/discipline_power/dt_path_fires_of_inferno/lighter
	)


/datum/discipline_power/dt_path_fires_of_inferno/activate(atom/target)
	. = ..()
	if(istype(target, /mob/living))
		if(get_fortitude_dices(target))
			fortitude_absorb = max(1, secret_vampireroll(get_fortitude_dices(target), fortitude_hardness, target))
	var/turf/start = get_turf(owner)
	var/obj/projectile/magic/aoe/fireball/baali/created_fireball = new(start)
	created_fireball.damage_type = CLONE
	created_fireball.damage = fire_damage/fortitude_absorb
	created_fireball.firer = owner
	created_fireball.preparePixelProjectile(target, start)
	created_fireball.fire(direct_target = target)
