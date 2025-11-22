//WARRIOR VALEREN 3 - BURNING TOUCH
/datum/status_effect/burning_touch
	id = "burning_touch"
	status_type = STATUS_EFFECT_REFRESH
	duration = 6 SECONDS //Two turns
	tick_interval = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/burning_touch
	var/mob/living/carbon/human/source

/atom/movable/screen/alert/status_effect/burning_touch
	name = "Burning Touch"
	desc = "THE PAIN!!! IT HURTS!!!"
	icon_state = "fire"

/datum/status_effect/burning_touch/on_creation(mob/living/carbon/new_owner, mob/living/carbon/human/new_source)
	. = ..()
	source = new_source

/datum/status_effect/burning_touch/tick()
	var/mob/living/carbon/grabber = owner
	if(source.pulling == grabber)
		grabber.adjustStaminaLoss(60, forced = TRUE)
		grabber.emote("scream")
		grabber.apply_status_effect(STATUS_EFFECT_BURNING_TOUCH, owner)

/datum/status_effect/burning_touch/Destroy()
	source = null
	return ..()

/datum/status_effect/slow_oxyloss
	id = "slow_oxyloss"
	status_type = STATUS_EFFECT_REFRESH
	duration = 2 SECONDS
	tick_interval = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/slow_oxyloss
	var/mob/living/carbon/human/source

/atom/movable/screen/alert/status_effect/slow_oxyloss
	name = "Losing Breath"
	desc = "YOU CAN'T BREATHE!!"
	icon_state = "slow_oxyloss"

/datum/status_effect/slow_oxyloss/on_creation(mob/living/carbon/new_owner, mob/living/carbon/human/new_source)
	. = ..()
	source = new_source

/datum/status_effect/slow_oxyloss/tick()
	owner.adjustOxyLoss(15, forced = TRUE)
	owner.emote("gasp")
	owner.apply_status_effect(STATUS_EFFECT_SLOW_OXYLOSS, owner)

/datum/status_effect/slow_oxyloss/Destroy()
	source = null
	return ..()

/datum/status_effect/slow_death
	id = "slow_death"
	status_type = STATUS_EFFECT_REFRESH
	duration = 2 SECONDS
	tick_interval = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/slow_death
	var/mob/living/carbon/human/source
	var/timer_active = FALSE

/atom/movable/screen/alert/status_effect/slow_death
	name = "Approaching Death"
	desc = "YOU CAN'T WITHSTAND, YOUR SOUL IS BEING SIPPED AWAY!!!"
	icon_state = "slow_death"

/datum/status_effect/slow_death/on_creation(mob/living/carbon/new_owner, mob/living/carbon/human/new_source)
	. = ..()
	source = new_source

/datum/status_effect/slow_death/tick()
	owner.apply_status_effect(STATUS_EFFECT_SLOW_DEATH, owner)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.willpower_auto != TRUE)
			to_chat(owner, span_danger("Your soul trembles as Duat begins to consume it..."))
			if(!timer_active)
				addtimer(CALLBACK(src, PROC_REF(check_willpower_auto)), 15 SECONDS)
				timer_active = TRUE
	else
		to_chat(owner, span_danger("Your soul trembles as Duat begins to consume it..."))
		if(!timer_active)
			addtimer(CALLBACK(src, PROC_REF(check_willpower_auto)), 15 SECONDS)
			timer_active = TRUE

/datum/status_effect/slow_death/proc/check_willpower_auto()
	if(!ishuman(owner))
		to_chat(owner, span_bolddanger("Duat takes your soul..."))
		owner.death()
	var/mob/living/carbon/human/H = owner
	if(H.willpower_auto != TRUE)
		to_chat(owner, span_bolddanger("Duat takes your soul..."))
		if(iskindred(owner) || iscathayan(owner))
			owner.torpor("curse_of_ra")
		else
			owner.death()
	else
		to_chat(owner, span_bolddanger("You manage to resist Duat's relentless assaults, but it's not over yet."))
		timer_active = FALSE
		return

/datum/status_effect/slow_death/Destroy()
	source = null
	timer_active = FALSE
	return ..()
