/datum/reagent/drug
	name = "Drug"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	var/trippy = TRUE //Does this drug make you trip?
	var/obj/hud_plane_master
	var/list/obj/wave_plane_masters
	var/list/wave_filters
	var/list/saturation_filters
	var/sound/music
	var/high_message
//	var/high_message_eng
//	var/high_message_ru
	var/chosen_z
	var/prev_z
	var/umbra_z
	var/obj/penumbra_ghost/ghost
	var/filter

/datum/reagent/drug/on_mob_end_metabolize(mob/living/M)
	if(trippy)
		SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "[type]_high")

/datum/reagent/drug/space_drugs
	name = "THC"
	description = "An illegal chemical compound used as drug."
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 30

/datum/reagent/drug/space_drugs/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(15)
	M.attributes.wits_reagent = 2
	M.attributes.perception_reagent = 1
	M.attributes.strength_reagent = -1
	M.attributes.dexterity_reagent = -1
	if(isturf(M.loc) && !isspaceturf(M.loc))
		if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED))
			if(prob(10))
				step(M, pick(GLOB.cardinals))
	if(prob(7))
		M.emote(pick("twitch","drool","moan","giggle"))
	..()

/datum/reagent/drug/space_drugs/on_mob_end_metabolize(mob/living/M)
	M.attributes.wits_reagent = 0
	M.attributes.perception_reagent = 0
	M.attributes.strength_reagent = 0
	M.attributes.dexterity_reagent = 0
	..()


/datum/reagent/drug/space_drugs/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>You start tripping hard!</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)

/datum/reagent/drug/space_drugs/overdose_process(mob/living/M)
	if(M.hallucination < volume && prob(20))
		M.hallucination += 5
	..()
/*
/datum/reagent/drug/proc/wave_filter()
	wave_filters = list()
	for(var/obj/our_plane_master in wave_plane_masters)
		our_plane_master.filters += filter(type = "wave", size = 1, x = 32, y = 32, offset = 0)
		var/wave_filter = our_plane_master.filters[length(our_plane_master.filters)]
		wave_filters[our_plane_master] = wave_filter
		animate(wave_filter, offset = 32, size = 2, time = 64 SECONDS, loop = -1, easing = LINEAR_EASING, flags = ANIMATION_PARALLEL)
*/
///////////////////EKRAN////////////////////////////
/*
/atom/movable/screen/fullscreen/Zuki
	layer = CURSE_LAYER
	plane = FULLSCREEN_PLANE

/atom/movable/screen/fullscreen/Zuki/Initialize()
	. =..()
	var/bloom = filter(type="bloom", threshold = "#E700E7", size=1, offset=0.5, alpha = 200)
	filters += bloom

/atom/movable/screen/fullscreen/nzp
	icon = 'icons/hud/screen_gen.dmi'
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	icon_state = "nzp"
*/
var/list/trip_black = list(0.1,0,0,0.2, 0.1,\
						0,1,0,0.2,0.1,\
						0,0,1,0.2, 0.1,\
						0.2,0.2,0.2,0.2,)

var/list/hapi_palaci = list(0.5,0.3,0.6,0,\
						0.0,0.3,0.3,0,\
						0.3,0.3,0.0,0,\
						0.2,0.3,0.2,1,)


var/list/meomoor = list(0.6,0.5,0.5,0,\
						0.3,0.4,0.3,0,\
						0.4,0.2,0.2,0,\
						0.2,0.2,0.2,0.3, 0)

var/list/dilirium = list(0.5,0.4,0.5,0,\
						0.3,0.4,0.3,0,\
						0.4,0.2,0.2,0,\
						0.2,0.2,0.2,1,)

var/list/xorek = list(0.1,0.0,0.1,0,\
						0.0,0.0,0.0,0,\
						0.0,0.0,0.0,0,\
						0.3,0.0,0.0,1,)

var/list/kent = list(0.7,0.6,0.5,0,\
						0.2,0.1,0.0,0,\
						0.3,0.35,0.25,0,\
						0.015,0.0,0.015,1,)
/*
ПОЧТИ НЗП
var/list/hapihapi = list(0.7,0.6,0.5,0,\
						0.2,0.1,0.0,0,\
						0.3,0.35,0.25,0,\
						0.015,0.0,0.015,1,)
*/
//////NZP

var/list/nzp = list(0.7,0.6,0.5,0,\
						0.2,0.1,0.0,0,\
						0.3,0.35,0.25,0,\
						0.015,0.0,0.015,1,)

/////////DEPRESSION

var/list/dpr = list(0.3,0.3,0.3,0,\
						0.3,0.3,0.3,0,\
						0.3,0.3,0.3,0,\
						0.0,0.0,0.0,1,)


/mob/living/proc/kislota_trip()
	animate(client, color = hapi_palaci, time = 10, delay=1)
	animate(client, color = kent, time = 5, delay=10)
	animate(client, color = xorek, time = 5, delay=10)
	animate(client, color = meomoor, time = 5, delay=10)
	animate(client, color = trip_black, time = 5, delay=10)
	animate(client, color = xorek, time = 5, delay=10)
	animate(client, color = meomoor, time = 5, delay=10)
	animate(client, color = kent, time = 5, delay=10)
	animate(client, color = meomoor, time = 5, delay=10)
	animate(client, color = trip_black, time = 5, delay=10)

/*
/datum/reagent/drug/proc/proriv(mob/living/carbon/human/M, vremeno = TRUE, time, location = TRUE)

	var/mob/living/carbon/human/H
//	H.copy_vnesntost(M, H)



	if(istype(M.loc, /obj/penumbra_ghost))
		ghost = M.loc
	if(location)
		for(var/area/vtm/interior/penumbra/penumbra in world)
			if(penumbra)
				chosen_z = penumbra.z
				umbra_z = penumbra.z
	else
		for(var/area/vtm/interior/backrooms/backrooms in world)
			if(backrooms)
				chosen_z = backrooms.z
				umbra_z = backrooms.z

	if(M.z != chosen_z)
		prev_z = M.z
	else
		chosen_z = prev_z
		var/turf/mob_turf = get_turf(M)
		var/turf/to_wall = locate(mob_turf.x, mob_turf.y, chosen_z)
	//	var/area/cross_area = get_area(to_wall)
	//	if(cross_area)
	//		if(cross_area.wall_rating > 1)
	//			to_chat(M, "<span class='warning'><b>GAUNTLET</b> rating there is too high! You can't cross <b>PENUMBRA</b> like this...</span>")
	//			M.yin_chi += 1
	//			M.yang_chi += 1
	//			return

	if(chosen_z != umbra_z)
		var/atom/myloc = M.loc
	//	M.forceMove(locate(myloc.x, myloc.y, chosen_z))
	//	if(ghost)
	//		qdel(ghost)
	else
		M.z = chosen_z
	//	ghost = new (get_turf(M))
	//	ghost.appearance = M.appearance
		H = new (get_turf(M))
		H.appearance = M.appearance
	//	M.forceMove(H)
		ghost.name = M.name
		ghost.alpha = 128
		M.mind.transfer_to(H)
	//	M.forceMove(ghost)
	//	if(vremeno)
	//		spawn(time)
			//	M.grab_ghost()
			//	H.forceMove(M)

/mob/living/proc/proriv(vremeno = TRUE, time)
	if(!time)
		time = 20 SECONDS
	var/chosen_z
	var/umbra_z
	var/obj/penumbra_ghost/ghost

	if(istype(loc, /obj/penumbra_ghost))
		ghost = loc

	for(var/area/vtm/interior/penumbra/penumbra in world)
		if(penumbra)
			chosen_z = penumbra.z
			umbra_z = penumbra.z

	if(z != chosen_z)
		prev_z = z
	else
		chosen_z = prev_z
		var/turf/caster_turf = get_turf()
		var/turf/to_wall = locate(caster_turf.x, caster_turf.y, chosen_z)
		var/area/cross_area = get_area(to_wall)
	if(vremeno)
		spawn(time)
			grab_ghost()
*/

/datum/reagent/drug/nicotine
	name = "Nicotine"
	description = "Slightly reduces stun times. If overdosed it will deal toxin and oxygen damage."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	addiction_threshold = 10
	taste_description = "smoke"
	trippy = FALSE
	overdose_threshold=15
	metabolization_rate = 0.125 * REAGENTS_METABOLISM

	//Nicotine is used as a pesticide IRL.
/datum/reagent/drug/nicotine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustToxic(round(chems.get_reagent_amount(type)))
		mytray.adjustPests(-rand(1,2))

/datum/reagent/drug/nicotine/on_mob_life(mob/living/carbon/M)
	if(prob(1))
		var/smoke_message = pick("You feel relaxed.", "You feel calmed.","You feel alert.","You feel rugged.")
		to_chat(M, "<span class='notice'>[smoke_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "smoked", /datum/mood_event/smoked, name)
	M.AdjustStun(-5)
	M.AdjustKnockdown(-5)
	M.AdjustUnconscious(-5)
	M.attributes.wits_reagent = 1
	M.AdjustParalyzed(-5)
	M.AdjustImmobilized(-5)
	..()
	. = 1

/datum/reagent/drug/nicotine/on_mob_end_metabolize(mob/living/M)
	M.attributes.wits_reagent = 0
	..()

/datum/reagent/drug/nicotine/overdose_process(mob/living/M)
	M.adjustToxLoss(0.1*REM, 0)
	M.adjustOxyLoss(1.1*REM, 0)
	M.attributes.strength_reagent = -1
	..()
	. = 1

/datum/reagent/drug/crank
	name = "Crank"
	description = "Reduces stun times by about 200%. If overdosed or addicted it will deal significant Toxin, Brute and Brain damage."
	reagent_state = LIQUID
	color = "#FA00C8"
	overdose_threshold = 20
	addiction_threshold = 10

/datum/reagent/drug/crank/on_mob_life(mob/living/carbon/M)
	if(prob(5))
		high_message = pick("You feel jittery.", "You feel like you gotta go fast.", "You feel like you need to step it up.")
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustStun(-20)
	M.AdjustKnockdown(-20)
	M.AdjustUnconscious(-20)
	M.attributes.dexterity_reagent = 1
	M.AdjustImmobilized(-20)
	M.AdjustParalyzed(-20)
	..()
	. = 1

/datum/reagent/drug/crank/on_mob_end_metabolize(mob/living/M)
	M.attributes.dexterity_reagent = 0
	..()

/datum/reagent/drug/crank/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2*REM)
	M.adjustToxLoss(2*REM, 0)
	M.adjustBruteLoss(2*REM, FALSE, FALSE, BODYPART_ORGANIC)
	..()
	. = 1

/datum/reagent/drug/crank/addiction_act_stage1(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5*REM)
	..()

/datum/reagent/drug/crank/addiction_act_stage2(mob/living/M)
	M.adjustToxLoss(5*REM, 0)
	..()
	. = 1

/datum/reagent/drug/crank/addiction_act_stage3(mob/living/M)
	M.adjustBruteLoss(5*REM, 0)
	..()
	. = 1

/datum/reagent/drug/crank/addiction_act_stage4(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 3*REM)
	M.adjustToxLoss(5*REM, 0)
	M.adjustBruteLoss(5*REM, 0)
	..()
	. = 1

/datum/reagent/drug/krokodil
	name = "Krokodil"
	description = "Cools and calms you down. If overdosed it will deal significant Brain and Toxin damage. If addicted it will begin to deal fatal amounts of Brute damage as the subject's skin falls off."
	reagent_state = LIQUID
	color = "#0064B4"
	overdose_threshold = 20
	addiction_threshold = 15


/datum/reagent/drug/krokodil/on_mob_life(mob/living/carbon/M)
	high_message = pick("You feel calm.", "You feel collected.", "You feel like you need to relax.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "smacked out", /datum/mood_event/narcotic_heavy, name)
	..()
	M.attributes.stamina_reagent = 1

/datum/reagent/drug/krokodil/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25*REM)
	M.adjustToxLoss(0.25*REM, 0)
	..()
	. = 1

/datum/reagent/drug/krokodil/addiction_act_stage1(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2*REM)
	M.adjustToxLoss(2*REM, 0)
	..()
	. = 1

/datum/reagent/drug/krokodil/addiction_act_stage2(mob/living/M)
	if(prob(25))
		to_chat(M, "<span class='danger'>Your skin feels loose...</span>")
	..()

/datum/reagent/drug/krokodil/addiction_act_stage3(mob/living/M)
	if(prob(25))
		to_chat(M, "<span class='danger'>Your skin starts to peel away...</span>")
	M.adjustBruteLoss(3*REM, 0)
	..()
	. = 1

/datum/reagent/drug/krokodil/addiction_act_stage4(mob/living/carbon/human/M)
	CHECK_DNA_AND_SPECIES(M)
	if(M.dna.species.limbs_id != "nosferatu")
		to_chat(M, "<span class='userdanger'>Your skin falls off easily!</span>")
		M.adjustBruteLoss(50*REM, 0) // holy shit your skin just FELL THE FUCK OFF
		M.dna.species.limbs_id = "nosferatu"
		M.facial_hairstyle = "Shaved"
		M.hairstyle = "Bald"
		M.update_hair()
		M.update_body()
		M.update_body_parts()
		M.update_icon()
	else
		M.adjustBruteLoss(5*REM, 0)
	..()
	. = 1

/datum/reagent/drug/methamphetamine
	name = "Methamphetamine"
	description = "Reduces stun times by about 300%, speeds the user up, and allows the user to quickly recover stamina while dealing a small amount of Brain damage. If overdosed the subject will move randomly, laugh randomly, drop items and suffer from Toxin and Brain damage. If addicted the subject will constantly jitter and drool, before becoming dizzy and losing motor control and eventually suffer heavy toxin damage."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 20
	addiction_threshold = 25 // В ПРОЦЕНТАХ
//	addiction_threshold = 10 В ЮНИТАХ
	metabolization_rate = 0.50 * REAGENTS_METABOLISM


/datum/reagent/drug/methamphetamine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)

/datum/reagent/drug/methamphetamine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
	L.attributes.strength_reagent = 0
	L.attributes.perception_reagent = 0
	L.attributes.stamina_reagent = 0
	..()

/datum/reagent/drug/methamphetamine/on_mob_life(mob/living/carbon/M)
	high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustAllImmobility(-45)
	M.AdjustUnconscious(-40)
	M.adjustStaminaLoss(-2, 0)
	M.attributes.strength_reagent = 1
	M.attributes.perception_reagent = 1
	M.attributes.stamina_reagent = 2

	M.Jitter(2)
	if(prob(5))
		M.emote(pick("twitch", "shiver"))
	if(current_cycle >= 65)
		M.Jitter(2)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1,4))
	..()
	. = 1

/datum/reagent/drug/methamphetamine/overdose_process(mob/living/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i in 1 to 4)
			step(M, pick(GLOB.cardinals))
	if(prob(20))
		M.emote("laugh")
	if(prob(33))
		M.visible_message("<span class='danger'>[M]'s hands flip out and flail everywhere!</span>")
		M.drop_all_held_items()
		M.attributes.intelligence_reagent = -1
	..()
	M.adjustToxLoss(1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, pick(0.5, 0.6, 0.7, 0.8, 0.9, 1))
	. = 1

/datum/reagent/drug/methamphetamine/addiction_act_stage1(mob/living/M)
	M.Jitter(5)
	if(prob(20))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/methamphetamine/addiction_act_stage2(mob/living/M)
	M.Jitter(10)
	M.Dizzy(10)
	M.attributes.intelligence_reagent = -1
	M.attributes.perception_reagent = -1
	if(prob(30))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/methamphetamine/addiction_act_stage3(mob/living/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 4, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(15)
	M.Dizzy(15)
	M.attributes.stamina_reagent = -2
	M.attributes.perception_reagent = -2
	if(prob(40))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/methamphetamine/addiction_act_stage4(mob/living/carbon/human/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(20)
	M.Dizzy(20)
	M.attributes.stamina_reagent = -2
	M.attributes.perception_reagent = -2
	M.attributes.dexterity_reagent = -1
	M.adjustToxLoss(5, 0)
	if(prob(50))
		M.emote(pick("twitch","drool","moan"))
	..()
	. = 1

/datum/reagent/drug/bath_salts
	name = "Bath Salts"
	description = "Makes you impervious to stuns and grants a stamina regeneration buff, but you will be a nearly uncontrollable tramp-bearded raving lunatic."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 20
	addiction_threshold = 10
	taste_description = "salt" // because they're bathsalts?
	var/datum/brain_trauma/special/psychotic_brawling/bath_salts/rage

/datum/reagent/drug/bath_salts/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_STUNIMMUNE, type)
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		rage = new()
		C.gain_trauma(rage, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/drug/bath_salts/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_STUNIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	if(rage)
		QDEL_NULL(rage)
	..()

/datum/reagent/drug/bath_salts/on_mob_life(mob/living/carbon/M)
	high_message = pick("You feel amped up.", "You feel ready.", "You feel like you can push it to the limit.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "salted", /datum/mood_event/stimulant_heavy, name)
	M.adjustStaminaLoss(-5, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 4)
	M.hallucination += 5
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		step(M, pick(GLOB.cardinals))
		step(M, pick(GLOB.cardinals))
	..()
	. = 1

/datum/reagent/drug/bath_salts/overdose_process(mob/living/M)
	M.hallucination += 5
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i in 1 to 8)
			step(M, pick(GLOB.cardinals))
	if(prob(20))
		M.emote(pick("twitch","drool","moan"))
	if(prob(33))
		M.drop_all_held_items()
	..()

/datum/reagent/drug/bath_salts/addiction_act_stage1(mob/living/M)
	M.hallucination += 10
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(5)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(20))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/bath_salts/addiction_act_stage2(mob/living/M)
	M.hallucination += 20
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(10)
	M.Dizzy(10)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(30))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/bath_salts/addiction_act_stage3(mob/living/M)
	M.hallucination += 30
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 12, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(15)
	M.Dizzy(15)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(40))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/bath_salts/addiction_act_stage4(mob/living/carbon/human/M)
	M.hallucination += 30
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 16, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(50)
	M.Dizzy(50)
	M.adjustToxLoss(5, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(50))
		M.emote(pick("twitch","drool","moan"))
	..()
	. = 1

/datum/reagent/drug/aranesp
	name = "Aranesp"
	description = "Amps you up, gets you going, and rapidly restores stamina damage. Side effects include breathlessness and toxicity."
	reagent_state = LIQUID
	color = "#78FFF0"

/datum/reagent/drug/aranesp/on_mob_life(mob/living/carbon/M)
	high_message = pick("You feel amped up.", "You feel ready.", "You feel like you can push it to the limit.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	M.adjustStaminaLoss(-18, 0)
	M.adjustToxLoss(0.5, 0)
	if(prob(50))
		M.losebreath++
		M.adjustOxyLoss(1, 0)
	..()
	. = 1

/datum/reagent/drug/happiness
	name = "Happiness"
	description = "Fills you with ecstasic numbness and causes minor brain damage. Highly addictive. If overdosed causes sudden mood swings."
	reagent_state = LIQUID
	color = "#EE35FF"
	addiction_threshold = 10
	overdose_threshold = 20
	taste_description = "paint thinner"

/datum/reagent/drug/happiness/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_FEARLESS, type)
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "happiness_drug", /datum/mood_event/happiness_drug)

/datum/reagent/drug/happiness/on_mob_delete(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_FEARLESS, type)
	SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "happiness_drug")
	..()

/datum/reagent/drug/happiness/on_mob_life(mob/living/carbon/M)
	M.jitteriness = 0
	M.set_confusion(0)
	M.disgust = 0
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2)
	..()
	. = 1

/datum/reagent/drug/happiness/overdose_process(mob/living/M)
	if(prob(30))
		var/reaction = rand(1,3)
		switch(reaction)
			if(1)
				M.emote("laugh")
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "happiness_drug", /datum/mood_event/happiness_drug_good_od)
			if(2)
				M.emote("sway")
				M.Dizzy(25)
			if(3)
				M.emote("frown")
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "happiness_drug", /datum/mood_event/happiness_drug_bad_od)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.5)
	..()
	. = 1

/datum/reagent/drug/happiness/addiction_act_stage1(mob/living/M)// all work and no play makes jack a dull boy
	var/datum/component/mood/mood = M.GetComponent(/datum/component/mood)
	mood?.setSanity(min(mood.sanity, SANITY_DISTURBED))
	M.Jitter(5)
	if(prob(20))
		M.emote(pick("twitch","laugh","frown"))
	..()

/datum/reagent/drug/happiness/addiction_act_stage2(mob/living/M)
	var/datum/component/mood/mood = M.GetComponent(/datum/component/mood)
	mood?.setSanity(min(mood.sanity, SANITY_UNSTABLE))
	M.Jitter(10)
	if(prob(30))
		M.emote(pick("twitch","laugh","frown"))
	..()

/datum/reagent/drug/happiness/addiction_act_stage3(mob/living/M)
	var/datum/component/mood/mood = M.GetComponent(/datum/component/mood)
	mood?.setSanity(min(mood.sanity, SANITY_CRAZY))
	M.Jitter(15)
	if(prob(40))
		M.emote(pick("twitch","laugh","frown"))
	..()

/datum/reagent/drug/happiness/addiction_act_stage4(mob/living/carbon/human/M)
	var/datum/component/mood/mood = M.GetComponent(/datum/component/mood)
	mood?.setSanity(SANITY_INSANE)
	M.Jitter(20)
	if(prob(50))
		M.emote(pick("twitch","laugh","frown"))
	..()
	. = 1

/datum/reagent/drug/pumpup
	name = "Pump-Up"
	description = "Take on the world! A fast acting, hard hitting drug that pushes the limit on what you can handle."
	reagent_state = LIQUID
	color = "#e38e44"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/drug/pumpup/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)

/datum/reagent/drug/pumpup/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	L.attributes.dexterity_reagent = 0
	..()

/datum/reagent/drug/pumpup/on_mob_life(mob/living/carbon/M)
	M.Jitter(5)
	M.attributes.dexterity_reagent = 1
	if(prob(5))
		to_chat(M, "<span class='notice'>[pick("Go! Go! GO!", "You feel ready...", "You feel invincible...")]</span>")
	if(prob(15))
		M.losebreath++
		M.adjustToxLoss(2, 0)
	..()
	. = 1

/datum/reagent/drug/pumpup/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>You can't stop shaking, your heart beats faster and faster...</span>")

/datum/reagent/drug/pumpup/overdose_process(mob/living/M)
	M.Jitter(5)
	if(prob(5))
		M.drop_all_held_items()
	if(prob(15))
		M.emote(pick("twitch","drool"))
	if(prob(20))
		M.losebreath++
		M.adjustStaminaLoss(4, 0)
	if(prob(15))
		M.adjustToxLoss(2, 0)
	..()

/datum/reagent/drug/maint
	name = "Maintenance Drugs"
	addiction_type = /datum/reagent/drug/maint
	can_synth = FALSE

/datum/reagent/drug/maint/addiction_act_stage1(mob/living/M)
	. = ..()
	M.Jitter(1)

/datum/reagent/drug/maint/addiction_act_stage2(mob/living/M)
	. = ..()
	M.Jitter(2)
	if(prob(15))
		M.emote(pick("twitch","drool"))

/datum/reagent/drug/maint/addiction_act_stage3(mob/living/M)
	. = ..()
	M.Jitter(1)
	M.adjustToxLoss(2)
	if(prob(5))
		M.drop_all_held_items()
	if(prob(15))
		M.emote(pick("twitch","drool"))

/datum/reagent/drug/maint/addiction_act_stage4(mob/living/M)
	. = ..()
	M.Jitter(2)
	M.adjustToxLoss(3)
	if(prob(10))
		M.drop_all_held_items()
	if(prob(30))
		M.emote(pick("twitch","drool"))

/datum/reagent/drug/maint/powder
	name = "Maintenance Powder"
	description = "An unknown powder that you most likely gotten from an assistant, a bored chemist... or cooked yourself. It is a refined form of tar that enhances your mental ability, making you learn stuff a lot faster."
	reagent_state = SOLID
	color = "#ffffff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 15
	addiction_threshold = 6
	can_synth = TRUE

/datum/reagent/drug/maint/powder/on_mob_life(mob/living/carbon/M)
	. = ..()
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN,0.1)
	// 5x if you want to OD, you can potentially go higher, but good luck managing the brain damage.
	var/amt = max(1,round(volume/3,0.1))
	M?.mind?.experience_multiplier_reasons |= type
	M?.mind?.experience_multiplier_reasons[type] = amt

/datum/reagent/drug/maint/powder/on_mob_end_metabolize(mob/living/M)
	. = ..()
	M?.mind?.experience_multiplier_reasons[type] = null
	M?.mind?.experience_multiplier_reasons -= type

/datum/reagent/drug/maint/powder/overdose_process(mob/living/M)
	. = ..()
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN,3)

/datum/reagent/drug/maint/sludge
	name = "Maintenance Sludge"
	description = "An unknown sludge that you most likely gotten from an assistant, a bored chemist... or cooked yourself. Half refined, it fills your body with itself, making it more resistant to wounds, but causes toxins to accumulate."
	reagent_state = LIQUID
	color = "#203d2c"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	overdose_threshold = 25
//	addiction_threshold = 10 В ЮНИТАХ
	can_synth = TRUE

/datum/reagent/drug/maint/sludge/on_mob_metabolize(mob/living/L)

	. = ..()
	ADD_TRAIT(L,TRAIT_HARDLY_WOUNDED,type)

/datum/reagent/drug/maint/sludge/on_mob_life(mob/living/carbon/M)
	. = ..()
	M.adjustToxLoss(0.5)

/datum/reagent/drug/maint/sludge/on_mob_end_metabolize(mob/living/M)
	. = ..()
	REMOVE_TRAIT(M,TRAIT_HARDLY_WOUNDED,type)

/datum/reagent/drug/maint/sludge/overdose_process(mob/living/M)
	. = ..()
	if(!iscarbon(M))
		return
	var/mob/living/carbon/carbie = M
	//You will be vomiting so the damage is really for a few ticks before you flush it out of your system
	carbie.adjustToxLoss(1)
	if(prob(10))
		carbie.adjustToxLoss(5)
		carbie.vomit()

/datum/reagent/drug/maint/tar
	name = "Maintenance Tar"
	description = "An unknown tar that you most likely gotten from an assistant, a bored chemist... or cooked yourself. Raw tar, straight from the floor. It can help you with escaping bad situations at the cost of liver damage."
	reagent_state = LIQUID
	color = "#000000"
	overdose_threshold = 30
	addiction_threshold = 10
	can_synth = TRUE

/datum/reagent/drug/maint/tar/on_mob_life(mob/living/carbon/M)
	. = ..()

	M.AdjustStun(-10)
	M.AdjustKnockdown(-10)
	M.AdjustUnconscious(-10)
	M.AdjustParalyzed(-10)
	M.AdjustImmobilized(-10)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER,1.5)

/datum/reagent/drug/maint/tar/overdose_process(mob/living/M)
	. = ..()

	M.adjustToxLoss(5)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER,3)

/datum/reagent/drug/cocaine
	name = "Cocaine"
	description = "Reduces stun times by about 300%, speeds the user up, and allows the user to quickly recover stamina while dealing a small amount of Brain damage. If overdosed the subject will move randomly, laugh randomly, drop items and suffer from Toxin and Brain damage. If addicted the subject will constantly jitter and drool, before becoming dizzy and losing motor control and eventually suffer heavy toxin damage."
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
	addiction_threshold = 20 // В ПРОЦЕНТАХ
//	addiction_threshold = 10 В ЮНИТАХ
	metabolization_rate = 0.75 * REAGENTS_METABOLISM

/datum/reagent/drug/cocaine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)

/datum/reagent/drug/cocaine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
	L.attributes.wits_reagent = 0
	L.attributes.stamina_reagent = 0
	L.attributes.dexterity_reagent = 0
	..()

/datum/reagent/drug/cocaine/on_mob_life(mob/living/carbon/M)
	high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(prob(5))
		to_chat(M, "<span class='notice'>[high_message]</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	M.AdjustAllImmobility(-30)
	M.AdjustUnconscious(-40)
	M.attributes.wits_reagent = 2
	M.attributes.stamina_reagent = 1
	M.attributes.dexterity_reagent = 1
	M.adjustStaminaLoss(-2, 0)
	M.Jitter(2)
	if(prob(5))
		M.emote(pick("twitch", "shiver"))
	if(current_cycle >= 35)
		M.Jitter(2)
	if(current_cycle >= 65)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1,4))
	..()
	. = 1

/datum/reagent/drug/cocaine/overdose_process(mob/living/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i in 1 to 4)
			step(M, pick(GLOB.cardinals))
	if(prob(20))
		M.emote("laugh")
	if(prob(33))
		M.visible_message("<span class='danger'>[M]'s hands flip out and flail everywhere!</span>")
		M.drop_all_held_items()
	..()
	M.adjustToxLoss(1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, pick(0.5, 0.6, 0.7, 0.8, 0.9, 1))
	. = 1

/datum/reagent/drug/cocaine/addiction_act_stage1(mob/living/M)
	M.Jitter(5)
	if(prob(20))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/cocaine/addiction_act_stage2(mob/living/M)
	M.Jitter(10)
	M.Dizzy(10)
	if(prob(30))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/cocaine/addiction_act_stage3(mob/living/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 4, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(15)
	M.Dizzy(15)
	if(prob(40))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/cocaine/addiction_act_stage4(mob/living/carbon/human/M)
	if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(20)
	M.Dizzy(20)
	M.adjustToxLoss(5, 0)
	if(prob(50))
		M.emote(pick("twitch","drool","moan"))
	..()
	. = 1

//////////////SMESI\СМЕСИ////////////////////////////
/*
/datum/reagent/drug/smes/methcock
	name = "Meth-cocaine"
	description = "Смесь кокаина и метамфетамина"
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
//	addiction_threshold = 10
	metabolization_rate = 0.65 * REAGENTS_METABOLISM
	on_mob_life(mob/living/carbon/M)

	on_mob_metabolize(mob/living/L)

	on_mob_end_metabolize(mob/living/L)

	overdose_process(mob/living/M)

/datum/reagent/drug/smes/methcrank
	name = "Meth-crank"
	description = "Смесь крэнк-кокаина и метамфетамина"
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
//	addiction_threshold = 10
	metabolization_rate = 0.65 * REAGENTS_METABOLISM
	on_mob_life(mob/living/carbon/M)

	on_mob_metabolize(mob/living/L)

	on_mob_end_metabolize(mob/living/L)

	overdose_process(mob/living/M)

/datum/reagent/drug/smes/mephedronemeth
	name = "mephedronemeth"
	description = "Смесь мефедрона и метамфетамина"
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
//	addiction_threshold = 28
	metabolization_rate = 0.65 * REAGENTS_METABOLISM
	on_mob_life(mob/living/carbon/M)

	on_mob_metabolize(mob/living/L)

	on_mob_end_metabolize(mob/living/L)

	overdose_process(mob/living/M)

/datum/reagent/drug/smes/mephedronecocaine
	name = "mephedronecocaine"
	description = "Смесь мефедрона и кокаина"
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
//	addiction_threshold = 28
	metabolization_rate = 0.65 * REAGENTS_METABOLISM
	on_mob_life(mob/living/carbon/M)

	on_mob_metabolize(mob/living/L)

	on_mob_end_metabolize(mob/living/L)

	overdose_process(mob/living/M)
*/
/////////////////////////MEPHEDRONE///////////////////////
/datum/reagent/drug/mephedrone
	name = "Mephedrone"
	description = "Мощный наркотик оказывающий влияние на ЦНС, с ним тебе становится хорошо."
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 20
	addiction_threshold = 15
	metabolization_rate = 1 * REAGENTS_METABOLISM

	on_mob_end_metabolize(mob/living/L)
		L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
		L.attributes.wits_reagent = 0
		L.attributes.strength_reagent = 0
		holder.add_reagent(/datum/reagent/consumable/ethanol/postmephedrone, rand(3, 10))
		..()

	on_mob_life(mob/living/carbon/M)
		high_message = pick("Ты чувствуешь себя энергичнее!", "Ты ощущаешь, что тебе нужно идти быстрее!", "А у меня во дворе...")
		if(prob(5))
			to_chat(M, "<span class='notice'>[high_message]</span>")
			M.emote(pick("twitch", "shiver"))
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
		M.AdjustUnconscious(-50)
		M.attributes.wits_reagent = 2
		M.attributes.strength_reagent = 1
		M.AdjustAllImmobility(-35)
		M.adjustStaminaLoss(-2, 0)
		for(var/datum/reagent/consumable/ethanol/postmephedrone/R in M.reagents.reagent_list)
			M.reagents.remove_reagent(R.type,10)
		..()
		. = 1

	overdose_process(mob/living/M)
		if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
			for(var/i in 1 to 4)
				step(M, pick(GLOB.cardinals))
		if(prob(20))
			M.emote("laugh")
			holder.add_reagent(/datum/reagent/consumable/ethanol/postmephedrone, rand(6, 15))
			M.hallucination += 15
		if(prob(33))
			M.visible_message("<span class='danger'>[M]'s hands flip out and flail everywhere!</span>")
			M.drop_all_held_items()
		..()
		M.adjustToxLoss(1, 0)
		. = 1

	addiction_act_stage1(mob/living/M)
		if(prob(20))
			M.emote(pick("twitch","drool","moan"))
			M.playsound_local(M, 'sound/hallucinations/LOBOTOMIA.ogg', 70, FALSE)
		..()
	addiction_act_stage2(mob/living/M)
		M.Dizzy(10)
		if(prob(20))
			M.overlay_fullscreen("ONI_IDUT", /atom/movable/screen/fullscreen/niggatrip)
			M.clear_fullscreen("ONI_IDUT", 2)
	addiction_act_stage3(mob/living/M)
		M.Dizzy(15)
		if(prob(40))
			M.overlay_fullscreen("ONI_IDUT", /atom/movable/screen/fullscreen/niggatrip)
			M.clear_fullscreen("ONI_IDUT", 4)
	addiction_act_stage4(mob/living/M)
		if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
			for(var/i = 0, i < 4, i++)
				step(M, pick(GLOB.cardinals))
		M.Dizzy(15)
		M.overlay_fullscreen("ONI_IDUT", /atom/movable/screen/fullscreen/niggatrip)
		M.clear_fullscreen("ONI_IDUT", 6)
		if(prob(40))
			M.emote(pick("twitch","drool","moan"))
			M.playsound_local(M, 'sound/hallucinations/LOBOTOMIA.ogg', 100, TRUE)
		..()

/datum/reagent/consumable/ethanol/postmephedrone
	name = "Post-Mephedrone"
	description = "."
	reagent_state = LIQUID
	color = "#ffffff"
	overdose_threshold = 30
	boozepwr = 40
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	on_mob_add(mob/living/L)
		spawn(10)
			L.playsound_local(L, 'sound/hallucinations/TRIPNIGGA.ogg', 70, TRUE)
	on_mob_life(mob/living/carbon/M)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, pick(0.1, 0.2, 0.3, 0.4, 0.5))
		M.emote(pick("twitch","drool","moan"))
		M.drowsyness += 1
		spawn(30)
			M.overlay_fullscreen("ONI_IDUT", /atom/movable/screen/fullscreen/niggatrip)
			M.clear_fullscreen("ONI_IDUT", 6)
			var/mob/living/carbon/human/H = M
			H.hallucination += 20
		if(prob(20))
			M.blind_eyes(5)
			switch(rand(1, 2))
				if(1)
					M.playsound_local(M, 'code/modules/wod13/sounds/CURSE.ogg', 70, TRUE)
				if(2)
					M.playsound_local(M, 'sound/hallucinations/LOBOTOMIA.ogg', 70, TRUE)
		..()
	on_mob_metabolize(mob/living/L)
		..()
		L.attributes.wits_reagent = -1
		L.attributes.stamina_reagent = -1
	on_mob_end_metabolize(mob/living/L)
		L.attributes.wits_reagent = 0
		L.attributes.stamina_reagent = 0
		..()

	on_mob_life(mob/living/carbon/M)
		var/high_message = pick("Ты чувствуешь себя хуево.", "Все хуже и хуже..", "Девочка с каре....", "Пиздос", "Ебать мой хуй", "Я ебу собак", "Как же хочеца...")
		if(prob(5))
			to_chat(M, "<span class='notice'>[high_message]</span>")
			M.emote(pick("twitch", "shiver", "cry"))
			M.set_drugginess(35)
		..()
		. = 1

	overdose_process(mob/living/M)
		if(!HAS_TRAIT(M, TRAIT_IMMOBILIZED) && !ismovable(M.loc))
			for(var/i in 1 to 4)
				step(M, pick(GLOB.cardinals))
		if(prob(20))
			M.emote("cry")
			M.hallucination += 30
			M.playsound_local(M, 'sound/hallucinations/TRIPNIGGA.ogg', 40, TRUE)
		if(prob(33))
			M.visible_message("<span class='danger'>[M]'s hands flip out and flail everywhere!</span>")
			M.drop_all_held_items()
			M.adjustOrganLoss(ORGAN_SLOT_BRAIN, pick(0.5, 0.6, 0.7, 0.8, 0.9, 1))
		..()
		M.adjustToxLoss(1, 0)
		. = 1


/datum/reagent/drug/heroin
	name = "Heroin"
	description = "Strong opioid."
	reagent_state = LIQUID
	color = "#C8A5DC"
	overdose_threshold = 30
	addiction_threshold = 30

	on_mob_metabolize(mob/living/L)
		..()
		L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
		L.attributes.stamina_reagent = 2
		L.attributes.dexterity_reagent = -1
		L.attributes.strength_reagent = -1


	overdose_process(mob/living/carbon/human/M)
		M.drop_all_held_items()
		M.adjustToxLoss(3*REM, 0)
		. = 1
		M.Dizzy(5)
		M.Jitter(5)
		..()

	on_mob_end_metabolize(mob/living/L)
		L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
		L.attributes.stamina_reagent = 0
		L.attributes.dexterity_reagent = 0
		L.attributes.strength_reagent = 0
		animate(L.client, color = null, time = 20)
		..()
	on_mob_life(mob/living/carbon/M)

		if(prob(40))
			M.reagents.add_reagent(/datum/reagent/medicine/morphine, 0.3)
		if(prob(5))
			var/obj/item/organ/heart/heart = M.getorganslot(ORGAN_SLOT_HEART)
			if(heart)
				M.losebreath += rand(2,4)
				M.adjustOxyLoss(rand(1,3))
				heart.applyOrganDamage(-5)
		switch(current_cycle)
			if(11)
				var/nigguh = pick("Ты ЧуВсТвУеШь СиБя УсТаВшиМ...", "В иголке содержится космос...", "Ты ОщУщАеШь НеВеРоЯтНуЮ УсТаЛоСтЬ...")
				to_chat(M, "<span class='reallybig hypnophrase'>[nigguh]</span>" )
				M.attributes.dexterity_reagent = -1
				M.attributes.strength_reagent = -1
			if(22 to 49)
				high_message = pick("ВСЕ ПЛЫВАЕТ, МУЛЬТИКИ НАЧАЛИСЬ!!!", "МУЛЬТ-МЫЛ-БАБАХ!!!", "РЕЛАКСИВНЫЙ УЛЬТ!")
				to_chat(M, "<span class='reallybig hypnophrase'>[high_message]</span>")
				M.kislota_trip()
				M.drowsyness += 1
			if(50 to INFINITY)
				M.Sleeping(40)
				. = 1
		..()

	addiction_act_stage1(mob/living/M)
		if(prob(33))
			M.drop_all_held_items()
			M.Jitter(2)
		animate(M.client, color = dpr, time = 50)
		..()

	addiction_act_stage2(mob/living/M)
		if(prob(33))
			M.drop_all_held_items()
			M.adjustToxLoss(1*REM, 0)
			. = 1
			M.Dizzy(3)
			M.Jitter(3)
		..()

	addiction_act_stage3(mob/living/M)
		if(prob(33))
			M.drop_all_held_items()
			M.adjustToxLoss(2*REM, 0)
			. = 1
			M.Dizzy(4)
			M.Jitter(4)
		..()

	addiction_act_stage4(mob/living/M)
		animate(M.client, color = null, time = 50)
		if(prob(33))
			M.drop_all_held_items()
			M.adjustToxLoss(3*REM, 0)
			. = 1
			M.Dizzy(5)
			M.Jitter(5)
		..()

/////////MUSHROOM/////////////////////////////
/datum/reagent/drug/mushroomhallucinogen/special
	name = "Mushroom Hallucinogen"
	description = "Высушенные грибы содержащие в себе целый коктейль психоделических веществ."
	color = "#E700E7" // rgb: 231, 0, 231
	metabolization_rate = 0.025 * REAGENTS_METABOLISM
	taste_description = "mushroom"
	var/badtrip = 0
	on_mob_add(mob/living/L)
		var/raznitsa = rand(1,4)
		if((L.humanity <= 7) && (L.humanity <= (L.humanity-raznitsa)))
			badtrip = 1
	on_mob_life(mob/living/carbon/M)
		..()
		var/list/screens = list(M.hud_used.plane_masters["[FLOOR_PLANE]"], M.hud_used.plane_masters["[LIGHTING_PLANE]"], M.hud_used.plane_masters["[O_LIGHTING_VISUAL_PLANE]"],  M.hud_used.plane_masters["[GAME_PLANE]"])
		var/rot = 10
		for(var/atom/whole_screen in screens)
			for(var/i in 1 to 7)
				whole_screen.add_filter("wibbly-[i]", 5, wave_filter(x = 5, y = 10, size =5, offset = rand()))
		switch(current_cycle)
		//	if(10 to 96)
		//		rot += 5
		//		for(var/atom/whole_screen in screens)
		//			for(var/i in 1 to 7)
		//				whole_screen.add_filter("wibbly-[i]", 5, wave_filter(x = 5, y = 10, size =5, offset = rand()))
			if(97 to 192)
				rot +=20
				M.overlay_fullscreen("RADUGA",/atom/movable/screen/fullscreen/psychedelic)
				M.kislota_trip()
				var/datum/atom_hud/gribi_hud = GLOB.huds[DATA_HUD_AI_DETECT]
				gribi_hud.add_hud_to(M)
			if(193 to 288)
				rot +=40
				M.hallucination += 40
			//	rot /= 3
				M.see_invisible = SEE_INVISIBLE_OBSERVER
			if(289 to 384)
				var/mob/living/carbon/human/C = M
				if(C.client && prob(85))
					C.ghostize(TRUE, FALSE, TRUE)
					C.soul_state = SOUL_PROJECTING
				spawn(50 SECONDS)
					M.grab_ghost()
		//	if(475)
		//		if(badtrip)
		//			proriv(M, time = 30)


		for(var/atom/negr_screen in screens)
			animate(negr_screen, transform = matrix(rot, MATRIX_ROTATE), time = 2.0 SECONDS, easing = QUAD_EASING, loop = -1)
			animate(transform = matrix(-rot, MATRIX_ROTATE), time = 1.0 SECONDS, easing = QUAD_EASING)
		if(badtrip)
			M.overlay_fullscreen("BADTRIP", /atom/movable/screen/fullscreen/badtrip)
			M.clear_fullscreen("BADTRIP", 8)
	on_mob_metabolize(mob/living/L)
		ADD_TRAIT(L, TRAIT_PACIFISM, type)
		if(L.a_intent != INTENT_HELP)
			L.a_intent_change(INTENT_HELP)
		L.possible_a_intents = INTENT_HELP

	on_mob_end_metabolize(mob/living/L)
		..()
		animate(L.client, color = null, time = 20)
		L.clear_fullscreen("RADUGA")
		REMOVE_TRAIT(L, TRAIT_PACIFISM, type)
		L.possible_a_intents = list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)
		var/datum/atom_hud/gribi_hud = GLOB.huds[DATA_HUD_AI_DETECT]
		gribi_hud.remove_hud_from(L)
		L.see_invisible = initial(L.see_invisible)
		L.reagents.add_reagent(/datum/reagent/drug/Nzp, 0.1)
		to_chat(L, "<span class='notice'>Ты чувствуешь некое... просветвление.</span>")

//////////////////////DMT/////////////////////
/datum/reagent/drug/mushroomhallucinogen/Dmt
	name = "Dimethyltryptamine"
	description = "Мощный галюцаген естественно производящийся во время сна."
	color = "#ffffff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	music = sound('code/modules/wod13/sounds/Skrillex_-_Make_It_Bun_Dem_b64f0d213.ogg', TRUE, wait=1, volume = 80, channel = 30)

	on_mob_metabolize(mob/living/L)
		L.see_invisible = SEE_INVISIBLE_OBSERVER
		var/datum/atom_hud/gribi_hud = GLOB.huds[DATA_HUD_AI_DETECT]
		gribi_hud.add_hud_to(L)
		L.attributes.wits_reagent = 3
		L.attributes.perception_reagent = 2

	on_mob_life(mob/living/carbon/human/M)
		..()
		var/list/screens = list(M.hud_used.plane_masters["[FLOOR_PLANE]"], M.hud_used.plane_masters["[GAME_PLANE]"], M.hud_used.plane_masters["[LIGHTING_PLANE]"])
		if(current_cycle >= 35)
			if(M.client)
				M.kislota_trip()
				M << music
		if(current_cycle >= 50)
			for(var/atom/whole_screen in screens)
				for(var/i in 1 to 7)
					whole_screen.add_filter("wibbly-[i]", 5, wave_filter(x = 40, y = 70, size =10, offset = rand()))
			M.hallucination += 40
			M.overlay_fullscreen("ONI_IDUT", /atom/movable/screen/fullscreen/niggatrip) // Lurkmore on Sperma_na_Ekran
			M.clear_fullscreen("ONI_IDUT", 8)
			if(prob(20))
			//	var/kto = rand(1, 2)
				var/DMTmessage2 = pick("Я ДОЛЖЕН ЕГО ПОКИНУТЬ!!!", "И Я ЗНАЮ СПОСОБ ЕЁ ПОКИНУТЬ!!!", "СМЕРТЬ", "ТОРМОЗ", "ХОЛОКОСТ", "ГЕНОЦИД", "формальность", "любовь", "НАД ЖРАТ ТАБЛТК", "ИДЕМ С НАМИ", "МЫ ЗНАЕМ ВЫХОД")
				var/DMTmessage1 = pick("Этот мир нереален", "НИГЕРНИГЕРНИГЕРНИГЕР", "МЫ ЖИВЕМ В ИЛЛЮЗИИ", "ВЫХОД ИЗ МАТРИЦЫ", "ХОХЛЫ", "ЕВРЕЙ", "НЕГРЫ", "ПЕНДОСЫ", "свобода", "ненависть", "А ТО Я ЗСТРЛС", "ВЫХОД ПРЯМО ТУТ", "МЫ ТЕБЯ СПАСЕМ")
				to_chat(M, "<span class='notice'>[DMTmessage1]</span>","<span class='reallybig hypnophrase'>[DMTmessage2]</span>")
				/*
				switch(kto)
					if(1)
						to_chat(M, "<font size=12>[icon2html('icons/xorek_DMT.png', M)]</font> <span class='comradio'><b>SOMEONE</b></span><span class='notice'>[DMTmessage1]</span>","<span class='reallybig hypnophrase'>[DMTmessage2]</span>")
					if(2)
						to_chat(M, "<font size=12>[icon2html('icons/meomoorDMT.png', M)]</font> <span class='comradio'><b>SOMEONE</b></span><span class='notice'>[DMTmessage1]</span>","<span class='reallybig hypnophrase'>[DMTmessage2]</span>")
						*/
				M.intro_Sperma(DMTmessage1, 10)
			if(do_mob(M, M, 6 SECONDS))
				M.suicide()

	on_mob_end_metabolize(mob/living/L)

		animate(L.client, color = null, time = 20)
		if(L.client && music)
			music.file = null
			L.client << music
		if(music)
			qdel(music)
			music = null
		var/datum/atom_hud/gribi_hud = GLOB.huds[DATA_HUD_AI_DETECT]
		gribi_hud.remove_hud_from(L)
		L.see_invisible = initial(L.see_invisible)
		L.reagents.add_reagent(/datum/reagent/drug/Nzp, 0.1)
		to_chat(L, "<span class='notice'>Ты чувствуешь, что ОНИ дали тебе... Просветвление.</span>")
		..()

/datum/reagent/drug/Nzp
	name = "NZP"
	description = "Наркотик разгонящий твои мысли и интеллект. Помогает в построении новых нейронных связей"
	color = "#E700E7"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 15
	var/atom/movable/screen/fullscreen/warp_effect/warp

	on_mob_life(mob/living/carbon/M)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -0.25)
		var/NZTmessage = pick("E=mc²",  "e = 2,7182818284 5904523536 028747...", "π = 3,1415926535 8979323846 2643383279...", "R=U/I", "S=πr²", "844636272616*263621517/3726261 =5,976×10¹³",
		"Площадь многоугольника с целочисленными вершинами равна B+(Г/2)-1, где В — количество целочисленных точек внутри многоугольника, а Г — количество целочисленных точек на границе многоугольника", "Бизнес — это не место для слабаков. Это место для тех, кто верит в свои идеи и готов трудиться над ними",
		"Истинный признак интеллекта — не знания, а воображение.")
		to_chat(M, "<span class='notice'>[NZTmessage]</span>")

		..()
	on_mob_metabolize(mob/living/L)
		L.attributes.wits_reagent = 3
		L.attributes.intelligence_reagent = 3
		L.attributes.perception_reagent = 2
		animate(L.client, color = nzp, time = 50)
		var/list/screens = list(L.hud_used.plane_masters["[FLOOR_PLANE]"], L.hud_used.plane_masters["[GAME_PLANE]"], L.hud_used.plane_masters["[LIGHTING_PLANE]"])
		for(var/atom/whole_screen in screens)
			animate(L.client, color = nzp, time = 5, easing = QUAD_EASING)
			for(var/i in 1 to 7)
				whole_screen.add_filter("wibbly-[i]", 5, wave_filter(x = 100, y = 100, size =5, offset = rand()))

	on_mob_end_metabolize(mob/living/L)
		L.attributes.wits_reagent = 0
		L.attributes.intelligence_reagent = 0
		L.attributes.perception_reagent = 0
		animate(L.client, color = null, time = 20)
		var/list/screens = list(L.hud_used.plane_masters["[FLOOR_PLANE]"], L.hud_used.plane_masters["[GAME_PLANE]"], L.hud_used.plane_masters["[LIGHTING_PLANE]"])
		for(var/atom/whole_screen in screens)
		//	remove_wibbly_filters(whole_screen)
			for(var/i in 1 to 7)
				filter = whole_screen.get_filter("wibbly-[i]")
				animate(filter)
				whole_screen.remove_filter("wibbly-[i]")

			animate(whole_screen, transform = matrix(), time = 1.0 SECONDS, easing = QUAD_EASING)

	overdose_process(mob/living/M)
		M.AdjustAllImmobility(30)
		M.Jitter(3)
		M.adjustToxLoss(1, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, pick(0.5, 0.6, 0.7, 0.8, 0.9, 1))
		M.hallucination += 50
		M.polnii_pizdec()
		if(prob(20))
			M.AdjustUnconscious(10)
