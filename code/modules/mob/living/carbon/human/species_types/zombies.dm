#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/zombie
	// 1spooky
	name = "Zombie"
	id = "zombie"
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LIMBATTACHMENT, TRAIT_VIRUSIMMUNE, TRAIT_NOBLEED, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_NOMETABOLISM, TRAIT_TOXIMMUNE, TRAIT_NOCRITDAMAGE, TRAIT_FAKEDEATH, TRAIT_UNMASQUERADE)
	use_skintones = TRUE
	limbs_id = "rotten2"
	mutantbrain = /obj/item/organ/brain/vampire //to prevent brain transplant surgery
	mutanteyes = /obj/item/organ/eyes/night_vision/zombie
	brutemod = 0.5
	heatmod = 1
	burnmod = 2
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"

/datum/species/zombie/infectious
	name = "Infectious Zombie"
	id = "memezombies"
	limbs_id = "zombie"
	mutanthands = /obj/item/zombie_hand
	armor = 20 // 120 damage to KO a zombie, which kills it
	speedmod = 1.6
	mutanteyes = /obj/item/organ/eyes/night_vision/zombie
	var/heal_rate = 1
	var/regen_cooldown = 0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN

/// Zombies do not stabilize body temperature they are the walking dead and are cold blooded
/datum/species/zombie/body_temperature_core(mob/living/carbon/human/humi)
	return

/datum/species/zombie/infectious/check_roundstart_eligible()
	return FALSE

/datum/species/zombie/infectious/spec_stun(mob/living/carbon/human/H,amount)
	. = min(20, amount)

/datum/species/zombie/infectious/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, spread_damage = FALSE, forced = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE)
	. = ..()
	if(.)
		regen_cooldown = world.time + REGENERATION_DELAY

/datum/species/zombie/infectious/spec_life(mob/living/carbon/C)
	. = ..()
	C.a_intent = INTENT_HARM // THE SUFFERING MUST FLOW

	//Zombies never actually die, they just fall down until they regenerate enough to rise back up.
	//They must be restrained, beheaded or gibbed to stop being a threat.
	if(regen_cooldown < world.time)
		var/heal_amt = heal_rate
		if(HAS_TRAIT(C, TRAIT_CRITICAL_CONDITION))
			heal_amt *= 2
		C.heal_overall_damage(heal_amt,heal_amt)
		C.adjustToxLoss(-heal_amt)
		for(var/i in C.all_wounds)
			var/datum/wound/iter_wound = i
			if(prob(4-iter_wound.severity))
				iter_wound.remove_wound()

//Congrats you somehow died so hard you stopped being a zombie
/datum/species/zombie/infectious/spec_death(gibbed, mob/living/carbon/C)
	. = ..()
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(infection)
		qdel(infection)

/datum/species/zombie/infectious/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()

	// Deal with the source of this zombie corruption
	//  Infection organ needs to be handled separately from mutant_organs
	//  because it persists through species transitions
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(!infection)
		infection = new()
		infection.Insert(C)

// Your skin falls off
/datum/species/krokodil_addict
	name = "Human"
	id = "goofzombies"
	limbs_id = "zombie" //They look like zombies
	sexes = 0
	meat = /obj/item/food/meat/slab/human/mutant/zombie
	mutanttongue = /obj/item/organ/tongue/zombie
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN
	species_traits = list(HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER,TRAIT_EASILY_WOUNDED)

/datum/species/zombie/check_roundstart_eligible()
	return FALSE

/datum/species/zombie/on_species_gain(mob/living/carbon/human/C)
	..()
	C.skin_tone = "albino"
	C.hairstyle = "Bald"
	C.unique_body_sprite = "rotten2"
	C.base_body_mod = ""
	C.update_body_parts()
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/aboutme/infor = new()
	infor.host = C
	infor.Grant(C)

	C.maxHealth = 300 //tanky
	C.health = 300

	C.yang_chi = 0
	C.max_yang_chi = 0
	C.yin_chi = 6
	C.max_yin_chi = 6

	C.add_movespeed_modifier(/datum/movespeed_modifier/zombie)

	//zombies resist vampire bites better than mortals
	RegisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_zombie_bitten))

/datum/species/zombie/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	C.remove_movespeed_modifier(/datum/movespeed_modifier/zombie)
	UnregisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED)
	for(var/datum/action/aboutme/infor in C.actions)
		if(infor)
			infor.Remove(C)

/datum/species/zombie/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(HAS_TRAIT(H, TRAIT_UNMASQUERADE))
		if(H.CheckEyewitness(H, H, 7, FALSE))
			if(H.zombie_owner)
				var/mob/living/carbon/human/churka = H.zombie_owner
				churka.AdjustMasquerade(-1)

/datum/species/zombie/proc/on_zombie_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	if(iszombie(being_bitten))
		return COMPONENT_RESIST_VAMPIRE_KISS

#undef REGENERATION_DELAY
