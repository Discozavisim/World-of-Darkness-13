/datum/discipline/dt_path_taking_spirit
	name = "Dark Thaumaturgy: The Taking of the Spirit"
	desc = "This path allows a vampire to drain his victims of Willpower, leaving them with a nearly soulless automaton willing to serve the Cainite without question."
	icon_state = "dt_path_taking_spirit"
	learnable_by_clans = list(/datum/vampireclane/baali)
	power_type = /datum/discipline_power/dt_path_taking_spirit

/datum/discipline/dt_path_taking_spirit/post_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DARK_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/dttome)

/datum/discipline_power/dt_path_taking_spirit
	name = "Dark Thaumaturgy: The Taking of the Spirit power name"
	desc = "Dark Thaumaturgy: The Taking of the Spirit description"

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED | DISC_CHECK_LYING | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	aggravating = FALSE
	hostile = TRUE
	violates_masquerade = FALSE
	range = 1

	cooldown_length = 3 TURNS
	var/success_roll_attacker
	var/success_roll_defender
	var/willpower_loss

/datum/discipline_power/dt_path_taking_spirit/pre_activation_checks(atom/target)
	. = ..()
	if(HAS_TRAIT(target, TRAIT_TAKING_SPIRIT_RESISTED))
		return FALSE
	success_roll_attacker = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(HAS_TRAIT(target, TRAIT_TAKING_SPIRIT_USED))
		success_roll_defender = secret_vampireroll(get_a_willpower(target), 7, target)
	if(success_roll_attacker <= 0)
		taking_spirit_botch_effect()
		return FALSE
	if(success_roll_defender > success_roll_attacker)
		taking_spirit_botch_effect()
		ADD_TRAIT(target, TRAIT_TAKING_SPIRIT_RESISTED, DISCIPLINE_TRAIT)
		return FALSE
	return TRUE

/datum/discipline_power/dt_path_taking_spirit/proc/taking_spirit_botch_effect()
	owner.MyPath.willpower = max(owner.MyPath.willpower - willpower_loss, 0)
	to_chat(owner, span_danger("You feel your Willpower being drained!"))

/datum/discipline_power/dt_path_taking_spirit/one
	name = "Dark Thaumaturgy: The Taking of the Spirit One"
	desc = "Drain the victims of Willpower"
	level = 1
	willpower_loss = 1
	grouped_powers = list(
		/datum/discipline_power/dt_path_taking_spirit/two,
		/datum/discipline_power/dt_path_taking_spirit/three,
		/datum/discipline_power/dt_path_taking_spirit/four,
		/datum/discipline_power/dt_path_taking_spirit/five
	)

/datum/discipline_power/dt_path_taking_spirit/two
	name = "Dark Thaumaturgy: The Taking of the Spirit Two"
	desc = "Drain the victims of Willpower"
	level = 2
	willpower_loss = 2
	grouped_powers = list(
		/datum/discipline_power/dt_path_taking_spirit/one,
		/datum/discipline_power/dt_path_taking_spirit/three,
		/datum/discipline_power/dt_path_taking_spirit/four,
		/datum/discipline_power/dt_path_taking_spirit/five
	)

/datum/discipline_power/dt_path_taking_spirit/three
	name = "Dark Thaumaturgy: The Taking of the Spirit Three"
	desc = "Drain the victims of Willpower"
	level = 3
	willpower_loss = 4
	grouped_powers = list(
		/datum/discipline_power/dt_path_taking_spirit/two,
		/datum/discipline_power/dt_path_taking_spirit/one,
		/datum/discipline_power/dt_path_taking_spirit/four,
		/datum/discipline_power/dt_path_taking_spirit/five
	)

/datum/discipline_power/dt_path_taking_spirit/four
	name = "Dark Thaumaturgy: The Taking of the Spirit Four"
	desc = "Drain the victims of Willpower"
	level = 4
	willpower_loss = 6
	grouped_powers = list(
		/datum/discipline_power/dt_path_taking_spirit/two,
		/datum/discipline_power/dt_path_taking_spirit/three,
		/datum/discipline_power/dt_path_taking_spirit/one,
		/datum/discipline_power/dt_path_taking_spirit/five
	)

/datum/discipline_power/dt_path_taking_spirit/five
	name = "Dark Thaumaturgy: The Taking of the Spirit Five"
	desc = "Drain the victims of Willpower"
	level = 5
	willpower_loss = 8
	grouped_powers = list(
		/datum/discipline_power/dt_path_taking_spirit/two,
		/datum/discipline_power/dt_path_taking_spirit/three,
		/datum/discipline_power/dt_path_taking_spirit/four,
		/datum/discipline_power/dt_path_taking_spirit/one
	)


/datum/discipline_power/dt_path_taking_spirit/activate(atom/target)
	. = ..()
	var/mob/living/carbon/human/H = target
	if(H?.MyPath?.willpower || H?.mind?.dharma?.willpower)
		owner.visible_message(span_danger("[owner] reaches out towards [H]'s head, chanting a demonic incantation."), \
					span_notice("You begin to chant a demonic incantation on [H]'s mind..."))
		if(do_after(owner, 15 SECONDS, target = H))
			owner.visible_message(span_danger("[owner] successfully performs a vile chant on [H]'s head."), \
				span_notice("You successfully perform a vile chant on [H]'s mind."))
			to_chat(target, span_danger("You feel your Willpower being drained!"))
			if(H.MyPath)
				H.MyPath.willpower = max(H.MyPath.willpower - willpower_loss, 0)
			else if(H.mind?.dharma)
				H.mind.dharma.willpower = max(H.mind.dharma.willpower - willpower_loss, 0)
			if(!HAS_TRAIT(H, TRAIT_TAKING_SPIRIT_USED))
				ADD_TRAIT(H, TRAIT_TAKING_SPIRIT_USED, DISCIPLINE_TRAIT)
	else
		to_chat(owner, span_notice("You fail to sense Willpower in them."))
