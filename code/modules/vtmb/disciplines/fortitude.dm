/datum/discipline/fortitude
	name = "Fortitude"
	desc = "Boosts armor."
	icon_state = "fortitude"
	power_type = /datum/discipline_power/fortitude

/datum/discipline/fortitude/post_gain()
	. = ..()
	owner.attributes.passive_fortitude = level

/datum/discipline_power/fortitude
	name = "Fortitude power name"
	desc = "Fortitude power description"

	activate_sound = 'code/modules/wod13/sounds/fortitude_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/fortitude_deactivate.ogg'

//FORTITUDE 1
/datum/discipline_power/fortitude/one
	name = "Fortitude 1"
	desc = "Harden your muscles. Become sturdier than the bodybuilders."

	level = 1

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS
//	owner.attributes.passive_fortitude = level

	grouped_powers = list(
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/four,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/one/activate()
	. = ..()
	owner.attributes.fortitude_bonus = level

/datum/discipline_power/fortitude/one/deactivate()
	. = ..()
	owner.attributes.fortitude_bonus = 0

//FORTITUDE 2
/datum/discipline_power/fortitude/two
	name = "Fortitude 2"
	desc = "Become as stone. Let nothing breach your protections."

	level = 2

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS
//	owner.attributes.passive_fortitude = level

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/four,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/two/activate()
	. = ..()
	owner.attributes.fortitude_bonus = level

/datum/discipline_power/fortitude/two/deactivate()
	. = ..()
	owner.attributes.fortitude_bonus = 0

//FORTITUDE 3
/datum/discipline_power/fortitude/three
	name = "Fortitude 3"
	desc = "Look down upon those who would try to kill you. Shrug off grievous attacks."

	level = 3

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS
//	owner.attributes.passive_fortitude = level

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/four,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/three/activate()
	. = ..()
	owner.attributes.fortitude_bonus = level

/datum/discipline_power/fortitude/three/deactivate()
	. = ..()
	owner.attributes.fortitude_bonus = 0

//FORTITUDE 4
/datum/discipline_power/fortitude/four
	name = "Fortitude 4"
	desc = "Be like steel. Walk into fire and come out only singed."

	level = 4

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS
//	owner.attributes.passive_fortitude = level

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/four/activate()
	. = ..()
	owner.attributes.fortitude_bonus = level

/datum/discipline_power/fortitude/four/deactivate()
	. = ..()
	owner.attributes.fortitude_bonus = 0

//FORTITUDE 5
/datum/discipline_power/fortitude/five
	name = "Fortitude 5"
	desc = "Reach the pinnacle of toughness. Never fear anything again."

	level = 5

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS
//	owner.attributes.passive_fortitude = level

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/four
	)

/datum/discipline_power/fortitude/five/activate()
	. = ..()
	owner.attributes.fortitude_bonus = level

/datum/discipline_power/fortitude/five/deactivate()
	. = ..()
	owner.attributes.fortitude_bonus = 0
