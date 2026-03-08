/datum/species/garou
	name = "Werewolf"
	id = "garou"
	default_color = "FFFFFF"
	toxic_food = PINEAPPLE
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_PERFECT_ATTACKER, TRAIT_NIGHT_VISION)
	use_skintones = TRUE
	limbs_id = "human"
	wings_icon = "Dragon"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 0.75
	stunmod = 0.5
	heatmod = 1
	burnmod = 1
	dust_anim = "dust-h"
	punchdamagelow = 15
	punchdamagehigh = 15
	whitelisted = TRUE
	selectable = TRUE
	species_language_holder = /datum/language_holder/werewolf
	var/glabro = FALSE

/datum/species/garou/on_species_gain(mob/living/carbon/human/C)
	. = ..()
//	ADD_TRAIT(C, TRAIT_NOBLEED, HIGHLANDER)
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/aboutme/infor = new()
	infor.host = C
	infor.Grant(C)
	var/datum/action/gift/glabro/glabro = new()
	glabro.Grant(C)
	var/datum/action/gift/rage_heal/GH = new()
	GH.Grant(C)
	var/datum/action/gift/howling/howl = new()
	howl.Grant(C)
	C.grant_language(/datum/language/primal_tongue, TRUE, FALSE)
	C.grant_language(/datum/language/garou_tongue, TRUE, TRUE)
	C.transformator = new(C)
	C.transformator.human_form = WEAKREF(C)
	C.wolf_recov = TRUE

	var/mob/living/carbon/werewolf/lupus/lupus = C.transformator.lupus_form?.resolve()
	var/mob/living/carbon/werewolf/crinos/crinos = C.transformator.crinos_form?.resolve()
	var/mob/living/carbon/werewolf/lupus/corvid/corvid = C.transformator.corvid_form?.resolve()
	var/mob/living/carbon/werewolf/corax/corax_crinos/corax_crinos = C.transformator.corax_form?.resolve()

	RegisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))
	RegisterSignal(lupus, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))
	RegisterSignal(crinos, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))
	RegisterSignal(corvid, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))
	RegisterSignal(corax_crinos, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_garou_bitten))

/datum/species/garou/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	for(var/datum/action/aboutme/VI in C.actions)
		if(VI)
			VI.Remove(C)
	for(var/datum/action/gift/G in C.actions)
		if(G)
			G.Remove(C)
	C.remove_language(/datum/language/primal_tongue, TRUE, TRUE)
	C.remove_language(/datum/language/garou_tongue, TRUE, TRUE)
	C.wolf_recov = FALSE

	var/mob/living/carbon/werewolf/lupus/lupus = C.transformator.lupus_form?.resolve()
	var/mob/living/carbon/werewolf/crinos/crinos = C.transformator.crinos_form?.resolve()
	var/mob/living/carbon/werewolf/lupus/corvid/corvid = C.transformator.corvid_form?.resolve()
	var/mob/living/carbon/werewolf/corax/corax_crinos/corax_crinos = C.transformator.corax_form?.resolve()

	UnregisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(lupus, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(crinos, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(corvid, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(corax_crinos, COMSIG_MOB_VAMPIRE_SUCKED)

	UnregisterSignal(C, COMSIG_LIVING_REVIVE)

	REMOVE_TRAIT(src, TRAIT_NIGHT_VISION, SPECIES_TRAIT)

/datum/species/garou/check_roundstart_eligible()
	return FALSE

/**
 * On being bit by a vampire
 *
 * This handles vampire bite sleep immunity and any future special interactions.
 */
/datum/species/garou/proc/on_garou_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	if(isgarou(being_bitten) || iswerewolf(being_bitten))
		return COMPONENT_RESIST_VAMPIRE_KISS

/proc/adjust_rage(amount, mob/living/carbon/C, sound = TRUE)
	if(amount > 0)
		if(C?.auspice.rage < 10)
			if(sound)
				SEND_SOUND(C, sound('code/modules/wod13/sounds/rage_increase.ogg', 0, 0, 75))
			to_chat(C, "<span class='userdanger'><b>RAGE INCREASES</b></span>")
			C.auspice.rage = min(10, C.auspice.rage+amount)
	if(amount < 0)
		if(C.auspice.rage > 0)
			C.auspice.rage = max(0, C.auspice.rage+amount)
			if(sound)
				SEND_SOUND(C, sound('code/modules/wod13/sounds/rage_decrease.ogg', 0, 0, 75))
			to_chat(C, "<span class='userdanger'><b>RAGE DECREASES</b></span>")
	C.update_rage_hud()

	if(amount && sound)
		if(prob(20))
			spawn()
				C.emote("growl")
				if(iscrinos(C))
					playsound(get_turf(C), 'code/modules/wod13/sounds/crinos_growl.ogg', 75, FALSE)
				if(islupus(C))
					playsound(get_turf(C), 'code/modules/wod13/sounds/lupus_growl.ogg', 75, FALSE)
				if(isgarou(C))
					if(C.gender == FEMALE)
						playsound(get_turf(C), 'code/modules/wod13/sounds/female_growl.ogg', 75, FALSE)
					else
						playsound(get_turf(C), 'code/modules/wod13/sounds/male_growl.ogg', 75, FALSE)

/proc/adjust_gnosis(amount, mob/living/carbon/C, sound = TRUE)
	if(amount > 0)
		if(C.auspice.gnosis < C.auspice.start_gnosis)
			if(sound)
				SEND_SOUND(C, sound('code/modules/wod13/sounds/humanity_gain.ogg', 0, 0, 75))
			to_chat(C, "<span class='boldnotice'><b>GNOSIS INCREASES</b></span>")
			C.auspice.gnosis = min(C.auspice.start_gnosis, C.auspice.gnosis+amount)
	if(amount < 0)
		if(C.auspice.gnosis > 0)
			C.auspice.gnosis = max(0, C.auspice.gnosis+amount)
			if(sound)
				SEND_SOUND(C, sound('code/modules/wod13/sounds/rage_decrease.ogg', 0, 0, 75))
			to_chat(C, "<span class='boldnotice'><b>GNOSIS DECREASES</b></span>")
	C.update_rage_hud()

/mob/living/carbon/proc/is_base_breed()
	if(islupus(src) && auspice?.breed_form == FORM_LUPUS)
		return TRUE
	if(isgarou(src) && auspice?.breed_form == FORM_HOMID)
		return TRUE
	if(iscrinos(src) && auspice?.breed_form == FORM_CRINOS)
		return TRUE
	return FALSE

/mob/living/carbon/Life()
	. = ..()
	if(wolf_recov)
		if(stat != DEAD)
			if(!is_base_breed() || auspice?.breed_form == FORM_CRINOS)
				if(lastattacked_time + 30 SECONDS < world.time)
					var/stamina_roll = secret_vampireroll(get_a_stamina(src), 8, src, TRUE)
					if(stamina_roll >= 1)
						adjustBruteLoss(-25, TRUE)
						adjustFireLoss(-25, TRUE)
				else
					adjustBruteLoss(-25, TRUE)
					adjustFireLoss(-25, TRUE)
	if((isgarou(src) || iswerewolf(src)) && auspice?.rage >= 1 && stat > CONSCIOUS && stat < DEAD && last_wake + 1 SCENES < world.time)
		last_wake = world.time
		var/rage_roll = secret_vampireroll(auspice?.start_rage, 8, src, TRUE)
		if(rage_roll >= 1)
			adjust_rage(-1, src)
			adjustBruteLoss(-25*rage_roll, TRUE)
			adjustFireLoss(-25*rage_roll, TRUE)
			adjustCloneLoss(-25*rage_roll, TRUE)
			adjustOxyLoss(-25*rage_roll, TRUE)
			enter_frenzymod()
			addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100)
			frenzy_hardness = 1
