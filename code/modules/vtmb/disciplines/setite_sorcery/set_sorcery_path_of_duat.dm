/datum/discipline/set_sorcery_path_of_duat
	name = "Setite Sorcery: Path of Duat"
	desc = "Harness the symbols of the Egyptian Underworld to mentally manipulate and terrify your enemies. Requires focus and a talisman to maintain, affecting the mind rather than the body."
	icon_state = "set_sorcery_path_of_duat"
	learnable_by_clans = list(/datum/vampireclane/setite)
	power_type = /datum/discipline_power/set_sorcery_path_of_duat

/datum/discipline/set_sorcery_path_of_duat/post_gain()
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/item/onyx_talisman/talisman = new(get_turf(H))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(talisman, slots, FALSE)

/datum/discipline_power/set_sorcery_path_of_duat
	name = "Setite Sorcery: Path of Duat power name"
	desc = "Setite Sorcery: Path of Duat description"

	activate_sound = 'code/modules/wod13/sounds/serpentis.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED | DISC_CHECK_DIRECT_SEE
	target_type = TARGET_MOB
	range = 7
	vitae_cost = 0

	duration_length = 15 SECONDS
	cooldown_length = 15 SECONDS

	var/obj/item/I_held
	var/success_roll
	var/do_after_ref

/datum/discipline_power/set_sorcery_path_of_duat/pre_activation_checks(mob/living/target)
	. = ..()
	I_held = owner.get_active_held_item()
	if(!istype(I_held, /obj/item/onyx_talisman))
		to_chat(owner, span_warning("You need to hold an onyx talisman inhand!"))
		return FALSE
	success_roll = secret_vampireroll(get_a_charisma(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/set_sorcery_path_of_duat/sending_the_snakes
	name = "Sending the Snakes"
	desc = "Curse the victim with visions of serpents born from Duat, filling their sight with endless slithering terrors."
	level = 1

	duration_length = 30 SECONDS
	cooldown_length = 30 SECONDS

	grouped_powers = list(
		/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat,
		/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb,
		/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house,
		/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat
	)

/datum/discipline_power/set_sorcery_path_of_duat/sending_the_snakes/activate(mob/living/target)
	. = ..()
	to_chat(target, span_userdanger("You hear an agressive hiss!"))
	new /datum/hallucination/sending_snakes(target, TRUE)


/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat
	name = "Darkness of Duat"
	desc = "Blind the victim with the eternal night, leaving them in complete darkness."
	level = 2

	grouped_powers = list(
		/datum/discipline_power/set_sorcery_path_of_duat/sending_the_snakes,
		/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb,
		/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house,
		/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat
	)

/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat/activate(mob/living/target)
	. = ..()
	ADD_TRAIT(target, TRAIT_BLIND, DISCIPLINE_TRAIT)
	target.update_blindness()
	to_chat(owner, span_warning("Don't move and stay concentrated in order to continue casting."))
	to_chat(target, span_warning("You feel a pair of eyes on you."))
	do_after_ref = do_after(owner, 15 SECONDS)
	if(!do_after_ref)
		deactivate(target)

/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat/deactivate(mob/living/target)
	. = ..()
	REMOVE_TRAIT(target, TRAIT_BLIND, DISCIPLINE_TRAIT)
	target.update_blindness()
	qdel(do_after_ref)
	do_after_ref = null

/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb
	name = "Suffocation of Tomb"
	desc = "Take the breath and voice away from the victim, rendering them mute and breathless."
	level = 3

	grouped_powers = list(
		/datum/discipline_power/set_sorcery_path_of_duat/sending_the_snakes,
		/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat,
		/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house,
		/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat
	)

/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb/activate(mob/living/target)
	. = ..()
	ADD_TRAIT(target, TRAIT_MUTE, DISCIPLINE_TRAIT)
	target.apply_status_effect(STATUS_EFFECT_SLOW_OXYLOSS)
	to_chat(owner, span_warning("Don't move and stay concentrated in order to continue casting."))
	to_chat(target, span_warning("You feel a pair of eyes on you."))
	do_after_ref = do_after(owner, 15 SECONDS)
	if(!do_after_ref)
		deactivate(target)

/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb/deactivate(mob/living/target)
	. = ..()
	REMOVE_TRAIT(target, TRAIT_MUTE, DISCIPLINE_TRAIT)
	target.remove_status_effect(STATUS_EFFECT_SLOW_OXYLOSS)
	qdel(do_after_ref)
	do_after_ref = null

/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house
	name = "The Narrow House"
	desc = "Impose the terror of entombment, paralyzing the victim."
	level = 4

	grouped_powers = list(
		/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat,
		/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb,
		/datum/discipline_power/set_sorcery_path_of_duat/sending_the_snakes,
		/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat
	)


/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house/activate(mob/living/target)
	. = ..()
	ADD_TRAIT(target, TRAIT_IMMOBILIZED, DISCIPLINE_TRAIT)
	to_chat(owner, span_warning("Don't move and stay concentrated in order to continue casting."))
	to_chat(target, span_warning("You feel a pair of eyes on you."))
	do_after_ref = do_after(owner, 15 SECONDS)
	if(!do_after_ref)
		deactivate(target)

/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house/deactivate(mob/living/target)
	. = ..()
	REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, DISCIPLINE_TRAIT)
	qdel(do_after_ref)
	do_after_ref = null

/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat
	name = "Consignment to Duat"
	desc = "Send the victim’s mind into Duat, killing mortals and forcing vampires into torpor."
	level = 5

	duration_length = 1 MINUTES
	cooldown_length = 30 SECONDS

	grouped_powers = list(
		/datum/discipline_power/set_sorcery_path_of_duat/sending_the_snakes,
		/datum/discipline_power/set_sorcery_path_of_duat/darkness_of_duat,
		/datum/discipline_power/set_sorcery_path_of_duat/suffocation_of_tomb,
		/datum/discipline_power/set_sorcery_path_of_duat/the_narrow_house
	)

/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat/activate(mob/living/target)
	. = ..()
	owner.MyPath?.willpower = max(owner.MyPath?.willpower-1, 0)
	to_chat(owner, span_warning("You spend a willpower point in order to activate the discipline."))
	target.apply_status_effect(STATUS_EFFECT_SLOW_DEATH)
	to_chat(owner, span_warning("Don't move and stay concentrated in order to continue casting."))
	to_chat(target, span_warning("You feel a pair of eyes on you."))
	do_after_ref = do_after(owner, 1 MINUTES)
	if(!do_after_ref)
		deactivate(target)

/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat/deactivate(mob/living/target)
	. = ..()
	target.remove_status_effect(STATUS_EFFECT_SLOW_DEATH)
	qdel(do_after_ref)
	do_after_ref = null

/datum/discipline_power/set_sorcery_path_of_duat/consignment_to_duat/pre_activation_checks(mob/living/target)
	. = ..()
	if(!istype(I_held, /obj/item/onyx_talisman))
		to_chat(owner, span_warning("You need to hold an onyx talisman inhand!"))
		return FALSE
	if(owner.MyPath?.willpower < 1)
		to_chat(owner, span_warning("You can't send their mind as you lack the willpower!"))
		return FALSE
	success_roll = secret_vampireroll(get_a_charisma(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/obj/item/onyx_talisman
	name = "onyx talisman"
	desc = "A small onyx amulet that strengthens your control over illusions."
	icon_state = "onyxBadge"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	is_magic = TRUE
