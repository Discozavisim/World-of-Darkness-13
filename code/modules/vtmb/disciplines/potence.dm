/datum/discipline/potence
	name = "Potence"
	desc = "Boosts melee and unarmed damage."
	icon_state = "potence"
	power_type = /datum/discipline_power/potence

/datum/discipline_power/potence
	name = "Potence power name"
	desc = "Potence power description"

	activate_sound = 'code/modules/wod13/sounds/potence_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/potence_deactivate.ogg'

	var/datum/component/tackler

/datum/discipline_power/potence/activate()
	. = ..()
	var/speed_mod
	var/skill_mod
	if(level >= 5)
		speed_mod = 2
		skill_mod = 3
	else if(level == 4)
		speed_mod = 2
		skill_mod = 2
	else if(level == 3)
		speed_mod = 1
		skill_mod = 2
	else
		speed_mod = 1
		skill_mod = 1

	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 0.5 SECONDS, range = 3+level, speed = speed_mod, skill_mod = skill_mod, min_distance = 0)
	owner.attributes.potence_bonus += level
	owner.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'

/datum/discipline_power/potence/deactivate()
	. = ..()
	owner.attributes.potence_bonus -= level
	owner.dna.species.attack_sound = initial(owner.dna.species.attack_sound)
	owner.remove_overlay(POTENCE_LAYER)
	tackler.RemoveComponent()
	qdel(tackler)

//POTENCE 1
/datum/discipline_power/potence/one
	name = "Potence 1"
	desc = "Enhance your muscles. Never hit softly."

	level = 1

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 3 TURNS



	grouped_powers = list(
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)

//POTENCE 2
/datum/discipline_power/potence/two
	name = "Potence 2"
	desc = "Become powerful beyond your muscles. Wreck people and things."

	level = 2

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 3 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)

//POTENCE 3
/datum/discipline_power/potence/three
	name = "Potence 3"
	desc = "Become a force of destruction. Lift and break the unliftable and the unbreakable."

	level = 3

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 3 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)

//POTENCE 4
/datum/discipline_power/potence/four
	name = "Potence 4"
	desc = "Become an unyielding machine for as long as your Vitae lasts."

	level = 4

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 3 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/five
	)

//POTENCE 5
/datum/discipline_power/potence/five
	name = "Potence 5"
	desc = "The people could worship you as a god if you showed them this."

	level = 5

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 3 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four
	)
