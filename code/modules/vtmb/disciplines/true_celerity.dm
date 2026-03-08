/datum/discipline/true_celerity
	name = "True Celerity"
	desc = "Works exactly like the normal one. Boosts your speed. Violates Masquerade."
	icon_state = "celerity"
	learnable_by_clans = list(/datum/vampireclane/true_brujah)
	power_type = /datum/discipline_power/true_celerity

/datum/discipline_power/true_celerity
	name = "True Celerity power name"
	desc = "True Celerity power description"

	activate_sound = 'code/modules/wod13/sounds/celerity_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/celerity_deactivate.ogg'

/datum/discipline_power/true_celerity/proc/celerity_visual(datum/discipline_power/celerity/source, atom/newloc, dir)
	SIGNAL_HANDLER

	spawn()
		var/obj/effect/celerity/C = new(owner.loc)
		C.name = owner.name
		C.appearance = owner.appearance
		C.dir = owner.dir
		if(iscathayan(owner))
			C.color = "#40ffb4"		////WE GIVE IT SANDEVISTAN LOOK YEEEHAAAAW
			animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), color = "#00196e", time = 5)
		else
			animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 5)
		if(owner.CheckEyewitness(owner, owner, 7, FALSE))
			owner.AdjustMasquerade(-1)

/datum/discipline_power/true_celerity/proc/temporis_explode(datum/source, datum/discipline_power/power, atom/target)
	SIGNAL_HANDLER

	if (!istype(power, /datum/discipline_power/temporis/patience_of_the_norns) && !istype(power, /datum/discipline_power/temporis/clothos_gift))
		return

	to_chat(owner, "<span class='userdanger'>You try to use Temporis, but your active True Celerity accelerates your temporal field out of your control!</span>")
	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/living/carbon/human, gib)), 3 SECONDS)

	return POWER_CANCEL_ACTIVATION

/datum/discipline_power/true_celerity/activate()
	. = ..()
	owner.attributes.celerity_bonus += level
	owner.next_move_modifier -= 0.1*level

/datum/discipline_power/true_celerity/deactivate()
	. = ..()
	owner.attributes.celerity_bonus -= level
	owner.next_move_modifier += 0.1*level

/datum/discipline_power/true_celerity/one
	name = "True Celerity 1"
	desc = "Enhances your speed to make everything a little bit easier."

	level = 1

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE


	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five,
		/datum/discipline_power/true_celerity/two,
		/datum/discipline_power/true_celerity/three,
		/datum/discipline_power/true_celerity/four,
		/datum/discipline_power/true_celerity/five
	)

/datum/discipline_power/true_celerity/one/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	//put this out of its misery
	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity)

/datum/discipline_power/true_celerity/one/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity)

/datum/discipline_power/true_celerity/two
	name = "True Celerity 2"
	desc = "Significantly improves your speed and reaction time."

	level = 2

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five,
		/datum/discipline_power/true_celerity/one,
		/datum/discipline_power/true_celerity/three,
		/datum/discipline_power/true_celerity/four,
		/datum/discipline_power/true_celerity/five
	)

/datum/discipline_power/true_celerity/two/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity2)

/datum/discipline_power/true_celerity/two/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity2)

/datum/discipline_power/true_celerity/three
	name = "True Celerity 3"
	desc = "Move faster. React in less time. Your body is under perfect control."

	level = 3

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/true_celerity/one,
		/datum/discipline_power/true_celerity/two,
		/datum/discipline_power/true_celerity/four,
		/datum/discipline_power/true_celerity/five,
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/true_celerity/three/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity3)

/datum/discipline_power/true_celerity/three/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity3)

/datum/discipline_power/true_celerity/four
	name = "True Celerity 4"
	desc = "Breach the limits of what is humanly possible. Move like a lightning bolt."

	level = 4

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/five,
		/datum/discipline_power/true_celerity/one,
		/datum/discipline_power/true_celerity/two,
		/datum/discipline_power/true_celerity/three,
		/datum/discipline_power/true_celerity/five
	)

/datum/discipline_power/true_celerity/four/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity4)

/datum/discipline_power/true_celerity/four/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity4)

/datum/discipline_power/true_celerity/five
	name = "True Celerity 5"
	desc = "You are like light. Blaze your way through the world."

	level = 5

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/true_celerity/one,
		/datum/discipline_power/true_celerity/two,
		/datum/discipline_power/true_celerity/three,
		/datum/discipline_power/true_celerity/four
	)

/datum/discipline_power/true_celerity/five/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/celerity5)

/datum/discipline_power/true_celerity/five/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/celerity5)
