/datum/discipline/dt_path_pain
	name = "Dark Thaumaturgy: Path of Pain"
	desc = "This Path feeds on physical discomfort - with experience in its use, the Path of Pain can tear flesh from bones, crush bones, and rip internal organs with a single glance or word."
	icon_state = "dt_path_pain"
	learnable_by_clans = list(/datum/vampireclane/baali)
	power_type = /datum/discipline_power/dt_path_pain

/datum/discipline/dt_path_pain/post_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DARK_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/dttome)

/datum/discipline_power/dt_path_pain
	name = "Dark Thaumaturgy: Path of Pain power name"
	desc = "Dark Thaumaturgy: Path of Pain description"

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = FALSE
	range = 7

	cooldown_length = 3 TURNS
	var/success_roll
	var/use_counter = 0

/datum/discipline_power/dt_path_pain/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		owner.visible_message(span_notice("You see [owner] shudder in pain, their whole body jerking."), span_danger("You shudder in pain, your body shaking."))
		pain_botch_effect()
		return FALSE
	return TRUE


/datum/discipline_power/dt_path_pain/proc/pain_botch_effect()
	if(maxlevel <= 2)
		return
	if(!owner.has_status_effect(/datum/status_effect/pain_botch) && owner.willpower_auto != TRUE)
		owner.apply_status_effect(/datum/status_effect/pain_botch)
		use_counter = 0
	to_chat(owner, span_warning("You scratch your own skin, thirsting for pain."))
	owner.Stun(1 SECONDS)
	owner.do_jitter_animation(3 SECONDS)

/datum/discipline_power/dt_path_pain/activate(atom/target)
	. = ..()
	if(owner.has_status_effect(/datum/status_effect/pain_botch))
		use_counter++
		if(use_counter == 3)
			owner.remove_status_effect(/datum/status_effect/pain_botch)
			use_counter = 0



/datum/discipline_power/dt_path_pain/numbing
	name = "Numbing"
	desc = "Tear flesh from bones, crush bones, and rip internal organs with a single glance or word"
	level = 1
	toggled = TRUE
	duration_length = 45 SECONDS
	grouped_powers = list(
		/datum/discipline_power/dt_path_pain/anguish,
		/datum/discipline_power/dt_path_pain/shattering,
		/datum/discipline_power/dt_path_pain/agony_within,
		/datum/discipline_power/dt_path_pain/hundred_deaths
	)

/datum/discipline_power/dt_path_pain/numbing/activate(atom/target)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.adjustStaminaLoss(50)
	ADD_TRAIT(owner, TRAIT_PAIN_NUMBING, DISCIPLINE_TRAIT)
	ADD_TRAIT(owner, TRAIT_IGNOREDAMAGESLOWDOWN, PAIN_TRAIT)
	owner.visible_message(span_notice("[owner] twitches in pleasure!"), span_warning("You twitch in pleasure!"))

/datum/discipline_power/dt_path_pain/numbing/deactivate(atom/target)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PAIN_NUMBING, DISCIPLINE_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_IGNOREDAMAGESLOWDOWN, PAIN_TRAIT)

/datum/discipline_power/dt_path_pain/anguish
	name = "Anguish"
	desc = "Tear flesh from bones, crush bones, and rip internal organs with a single glance or word"
	level = 2
	range = 1
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/dt_path_pain/numbing,
		/datum/discipline_power/dt_path_pain/shattering,
		/datum/discipline_power/dt_path_pain/agony_within,
		/datum/discipline_power/dt_path_pain/hundred_deaths
	)


/datum/discipline_power/dt_path_pain/anguish/activate(atom/target)
	. = ..()
	var/stamina_loss = min(success_roll * 25, 200)
	var/mob/living/tar = target
	tar.adjustStaminaLoss(stamina_loss)
	tar.visible_message(span_notice("[target] grabs by the heart!"), span_danger("You grab by your heart, feeling burning pain!"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.adjustStaminaLoss(stamina_loss)
		owner.visible_message(span_notice("[owner] grabs by the heart!"), span_danger("You grab by your heart, feeling burning pain!"))


/datum/discipline_power/dt_path_pain/shattering
	name = "Shattering"
	desc = "Tear flesh from bones, crush bones, and rip internal organs with a single glance or word"
	level = 3
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/dt_path_pain/anguish,
		/datum/discipline_power/dt_path_pain/numbing,
		/datum/discipline_power/dt_path_pain/agony_within,
		/datum/discipline_power/dt_path_pain/hundred_deaths
	)

	var/brute_loss = 25
	var/willpower_resist


/datum/discipline_power/dt_path_pain/shattering/activate(atom/target)
	. = ..()
	brute_loss = clamp(success_roll * 25, 25, 200)
	willpower_resist = secret_vampireroll(get_a_willpower(target), 6, target)
	owner.adjustBruteLoss(25)
	var/mob/living/tar = target
	tar.adjustBruteLoss(brute_loss/willpower_resist)
	tar.visible_message(span_warning("You hear [tar]'s bones crunch!"), span_danger("You hear your bones crunch!"))
	playsound(tar, "sound/effects/wounds/crack1.ogg", 50)
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		willpower_resist = secret_vampireroll(get_a_willpower(owner), 6, owner)
		owner.adjustBruteLoss(brute_loss/willpower_resist)
		owner.visible_message(span_warning("You hear [owner]'s bones crunch!"), span_danger("You hear your bones crunch!"))
		playsound(owner, "sound/effects/wounds/crack2.ogg", 50)

/datum/discipline_power/dt_path_pain/agony_within
	name = "Agony Within"
	desc = "Tear flesh from bones, crush bones, and rip internal organs with a single glance or word"
	level = 4
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/dt_path_pain/anguish,
		/datum/discipline_power/dt_path_pain/shattering,
		/datum/discipline_power/dt_path_pain/numbing,
		/datum/discipline_power/dt_path_pain/hundred_deaths
	)

	var/success_roll_buff = 0
	var/success_roll_defender = 0
	var/success_roll_total = 0
	var/total_health_loss


/datum/discipline_power/dt_path_pain/agony_within/pre_activation_checks(atom/target)
	. = ..()
	total_health_loss = owner.get_health_difficulty()
	if(total_health_loss < 1)
		to_chat(owner, span_warning("You're not suffering from pain enough to use this ability!"))
		owner.bloodpool += 1
		return FALSE
	return TRUE

/datum/discipline_power/dt_path_pain/agony_within/activate(atom/target)
	. = ..()

	total_health_loss = owner.get_health_difficulty()

	success_roll_buff = clamp(success_roll+max(1, total_health_loss), 0, 10)

	success_roll_defender = secret_vampireroll(get_a_willpower(target), clamp(6+success_roll_buff, 6, 10), target)

	success_roll_total = max(0, success_roll_buff - floor(max(0, success_roll_defender/2)))

	var/mob/living/tar = target

	tar.adjustBruteLoss(25*success_roll_total)

	tar.visible_message(span_warning("You hear [tar]'s spine snap!"), span_danger("You hear your spine snap!"))

	playsound(tar, "sound/effects/wounds/crack1.ogg", 50)
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		success_roll_defender = secret_vampireroll(get_a_willpower(owner), 6, owner)

		success_roll_total = max(0, success_roll_buff - floor(max(0, success_roll_defender/2)))

		owner.adjustBruteLoss(25*success_roll_total)

		owner.visible_message(span_warning("You hear [owner]'s spine snap!"), span_danger("You hear your spine snap!"))

		playsound(owner, "sound/effects/wounds/crack2.ogg", 50)

/datum/discipline_power/dt_path_pain/hundred_deaths
	name = "Hundred Deaths"
	desc = "Tear flesh from bones, crush bones, and rip internal organs with a single glance or word"
	level = 5
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/dt_path_pain/anguish,
		/datum/discipline_power/dt_path_pain/shattering,
		/datum/discipline_power/dt_path_pain/agony_within,
		/datum/discipline_power/dt_path_pain/numbing
	)

	var/success_needed = 0
	var/total_brute = 0

/datum/discipline_power/dt_path_pain/hundred_deaths/activate(atom/target)
	. = ..()
	success_needed = secret_vampireroll(get_a_willpower(owner), 6, owner)
	if(success_needed <= 0)
		to_chat(owner, span_warning("You fail to inflict enough wounds to yourself to use that ability!"))
		owner.do_jitter_animation(3 SECONDS)
		return
	owner.adjustCloneLoss(25)
	total_brute = clamp(25*success_needed, 25, 200)
	var/mob/living/tar = target
	tar.adjustCloneLoss(total_brute)
	var/mob/living/carbon/human/H = tar
	if(H.willpower_auto != TRUE)
		H.apply_status_effect(/datum/status_effect/hundred_deaths)
	playsound(H, "sound/effects/wounds/crack1.ogg", 50)
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.adjustCloneLoss(total_brute)
		if(owner.willpower_auto != TRUE)
			owner.apply_status_effect(/datum/status_effect/hundred_deaths)
		playsound(owner, "sound/effects/wounds/crack2.ogg", 50)
