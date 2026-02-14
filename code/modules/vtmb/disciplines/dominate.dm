/datum/discipline/dominate
	name = "Dominate"
	desc = "Supresses will of your targets and forces them to obey you, if their will is not more powerful than yours."
	icon_state = "dominate"
	power_type = /datum/discipline_power/dominate

/datum/discipline/dominate/post_gain()
	. = ..()
	if(level >= 1)
		var/datum/action/dominate/DOMINATE = new()
		DOMINATE.Grant(owner)

/datum/discipline_power/dominate
	name = "Dominate power name"
	desc = "Dominate power description"

	activate_sound = 'code/modules/wod13/sounds/dominate.ogg'
	var/dominate_me = FALSE

/datum/discipline_power/dominate/activate(mob/living/target)
	. = ..()
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			target.mind.dharma?.roll_po(owner, target)
	var/mob/living/carbon/human/TRGT
	if(ishuman(target))
		TRGT = target
		TRGT.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/dominate_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dominate", -MUTATIONS_LAYER)
		dominate_overlay.pixel_z = 2
		TRGT.overlays_standing[MUTATIONS_LAYER] = dominate_overlay
		TRGT.apply_overlay(MUTATIONS_LAYER)
		spawn(2 SECONDS)
			if(TRGT)
				TRGT.remove_overlay(MUTATIONS_LAYER)
	return TRUE

/datum/movespeed_modifier/dominate
	multiplicative_slowdown = 5

/datum/discipline_power/dominate/pre_activation_checks(mob/living/target)
	if(get_trufaith_level(target) >= 2)
		to_chat(owner, "<span class='warning'>Their faith protects their mind from domination.</span>")
		return FALSE
	var/difficulties_dominating = get_a_willpower(target)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if(human_target.clane?.name == "Gargoyle")
			dominate_me = TRUE
			return TRUE
	if(dominate_me)
		difficulties_dominating = 1
	var/mypower = secret_vampireroll(max(get_a_strength(owner), get_a_manipulation(owner))+get_a_intimidation(owner), difficulties_dominating, owner)

	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at dominating!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	if(owner.generation > target.generation)
		if(prob(40))
			to_chat(owner, span_warning("[target]'s blood is too potence to dominate!"))
		return FALSE

	return TRUE

//COMMAND
/datum/discipline_power/dominate/command
	name = "Command"
	desc = "Speak one word and force others to obey."

	level = 1

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 3 SECONDS
	range = 7

/datum/discipline_power/dominate/command/activate(mob/living/target)
	. = ..()
	to_chat(target, "<span class='userdanger'><b>FORGET ABOUT IT</b></span>")
	owner.say("FORGET ABOUT IT!!")
	ADD_TRAIT(target, TRAIT_BLIND, "dominate")

/datum/discipline_power/dominate/command/deactivate(mob/living/target)
	. = ..()
	REMOVE_TRAIT(target, TRAIT_BLIND, "dominate")

//MESMERIZE
/datum/discipline_power/dominate/mesmerize
	name = "Mesmerize"
	desc = "Plant a suggestion in a target's head and force them to obey it."

	level = 2

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	range = 7

/datum/discipline_power/dominate/mesmerize/activate(mob/living/target)
	. = ..()
	target.Immobilize(0.5 SECONDS)
	if(target.body_position == STANDING_UP)
		to_chat(target, "<span class='userdanger'><b>GET DOWN</b></span>")
		target.toggle_resting()
		owner.say("GET DOWN!!")
	else
		to_chat(target, "<span class='userdanger'><b>STAY DOWN</b></span>")
		owner.say("STAY DOWN!!")

//THE FORGETFUL MIND
/datum/discipline_power/dominate/the_forgetful_mind
	name = "The Forgetful Mind"
	desc = "Invade a person's mind and recreate their memories."

	level = 3

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 3 SECONDS
	range = 7

/datum/discipline_power/dominate/the_forgetful_mind/activate(mob/living/target)
	. = ..()
	to_chat(target, "<span class='userdanger'><b>THINK TWICE</b></span>")
	owner.say("THINK TWICE!!")
	target.add_movespeed_modifier(/datum/movespeed_modifier/dominate)

/datum/discipline_power/dominate/the_forgetful_mind/deactivate(mob/living/target)
	. = ..()
	target.remove_movespeed_modifier(/datum/movespeed_modifier/dominate)

//CONDITIONING
/datum/discipline_power/dominate/conditioning
	name = "Conditioning"
	desc = "Break a person's mind over time and bend them to your will."

	level = 4

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 6 SECONDS
	range = 7

/datum/discipline_power/dominate/conditioning/activate(mob/living/target)
	. = ..()
	to_chat(target, "<span class='userdanger'><b>THINK TWICE</b></span>")
	owner.say("THINK TWICE!!")
	target.add_movespeed_modifier(/datum/movespeed_modifier/dominate)

/datum/discipline_power/dominate/conditioning/deactivate(mob/living/target)
	. = ..()
	target.remove_movespeed_modifier(/datum/movespeed_modifier/dominate)

//POSSESSION
/datum/discipline_power/dominate/possession
	name = "Possession"
	desc = "Take full control of your target's mind and body."

	level = 5

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_HUMAN

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	range = 7

/datum/discipline_power/dominate/possession/activate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, "<span class='userdanger'><b>YOU SHOULD KILL YOURSELF NOW</b></span>")
	owner.say("YOU SHOULD KILL YOURSELF NOW!!")
	var/datum/cb = CALLBACK(target, /mob/living/carbon/human/proc/attack_myself_command)
	for(var/i in 1 to 20)
		addtimer(cb, (i - 1) * 1.5 SECONDS)
	target.Immobilize(5 SECONDS, TRUE)
	/*	if(do_mob(target, target, 6 SECONDS))
			if(ishuman(target))
				var/mob/living/carbon/human/suicider = target
				suicider.suicide()
*/
/mob/living/carbon/human/proc/attack_myself_command()
	if(!CheckFrenzyMove())
		a_intent = INTENT_HARM
		var/obj/item/I = get_active_held_item()
		if(I)
			if(I.force)
				ClickOn(src)
			else
				drop_all_held_items()
				ClickOn(src)
		else
			ClickOn(src)
