#define VEIL_COOLDOWN 20 SECONDS

/mob/living/carbon/werewolf/Life()
	update_icons()
	update_rage_hud()
	return..()

/mob/living/carbon/Life()
	. = ..()
	if(isgarou(src) || iswerewolf(src))
		if(key && stat <= HARD_CRIT)
			var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
			if(P)
				if(P.masquerade != masquerade)
					P.masquerade = masquerade
					P.save_preferences()
					P.save_character()

/mob/living/carbon/werewolf/check_breath(datum/gas_mixture/breath)
	return

/mob/living/carbon/werewolf/handle_status_effects()
	..()
	//natural reduction of movement delay due to stun.
	if(move_delay_add > 0)
		move_delay_add = max(0, move_delay_add - rand(1, 2))

/mob/living/carbon/werewolf/handle_changeling()
	return

/mob/living/carbon/werewolf/handle_fire()//Aliens on fire code
	. = ..()
	if(.) //if the mob isn't on fire anymore
		return
	adjust_bodytemperature(BODYTEMP_HEATING_MAX) //If you're on fire, you heat up!

/mob/living/carbon/proc/adjust_veil(amount, threshold, random, honoradj, gloryadj, wisdomadj, mob/living/carbon/vessel, forced)
	if(iswerewolf(src))
		var/mob/living/carbon/player = transformator.human_form.resolve()
		player.adjust_veil(amount, threshold, random, honoradj, gloryadj, wisdomadj, src)
	if(!GLOB.canon_event)
		return
	if(next_veil_time >= world.time && !forced)
		return
	if(amount > 0)
		if(HAS_TRAIT(src, TRAIT_VIOLATOR))
			return
	if(amount < 0)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.zone_type != "masquerade")
				return
	next_veil_time = world.time + VEIL_COOLDOWN
	var/special_role_name
	if(mind)
		if(mind.special_role)
			var/datum/antagonist/A = mind.special_role
			special_role_name = A.name
	if(!is_special_character(src) || special_role_name == "Ambitious")
		if(!vessel)
			vessel = src
		if(amount < 0)
			if(masquerade > 0 && masquerade > threshold)
				SEND_SOUND(vessel, sound('code/modules/wod13/sounds/veil_violation.ogg', 0, 0, 75))
				to_chat(vessel, "<span class='boldnotice'><b>VEIL VIOLATION</b></span>")
				if(threshold && masquerade+amount < threshold)
					amount = threshold-masquerade
				masquerade = max(0, masquerade+amount)
		if(amount > 0)
			if(masquerade < 5)
				SEND_SOUND(vessel, sound('code/modules/wod13/sounds/humanity_gain.ogg', 0, 0, 75))
				to_chat(vessel, "<span class='boldnotice'><b>VEIL REINFORCEMENT</b></span>")
				if(threshold && masquerade+amount > threshold)
					amount = threshold-masquerade
				masquerade = min(5, masquerade+amount)
		if(random < 0 || random > 0)
			var/random_renown = pick("Honor","Wisdom","Glory")
			switch(random_renown)
				if("Honor")
					adjust_renown("honor", random, vessel = vessel)
				if("Glory")
					adjust_renown("glory", random, vessel = vessel)
				if("Wisdom")
					adjust_renown("wisdom", random, vessel = vessel)
		else
			if(honoradj)
				adjust_renown("honor", honoradj, vessel = vessel)
			if(gloryadj)
				adjust_renown("glory", gloryadj, vessel = vessel)
			if(wisdomadj)
				adjust_renown("wisdom", wisdomadj, vessel = vessel)

		if(src in GLOB.masquerade_breakers_list)
			if(masquerade > 2)
				GLOB.masquerade_breakers_list -= src
		else if(masquerade < 3)
			GLOB.masquerade_breakers_list |= src

	var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
	if(P)
		P.masquerade = masquerade
		P.save_character()
		P.save_preferences()
	var/mob/humanform = src.transformator.human_form

	var/mob/crinosform = src.transformator.crinos_form

	if(amount < 0)
		if(masquerade <= 2)
			var/list/landmarkslist = list()
			for(var/obj/effect/landmark/start/S in GLOB.start_landmarks_list)
				if(S.name == "Caitiff")
					landmarkslist += S
			var/obj/effect/landmark/start/startmark = pick(landmarkslist)
			//H.forceMove(startmark.loc)
			var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as hunter to hunt [humanform] ([crinosform])?", null, null, null, 50, src)
			for(var/mob/dead/observer/G in GLOB.player_list)
				if(G.key)
					to_chat(G, "<span class='ghostalert'>[humanform] ([crinosform]) revealed their abnormal nature, you can play as hunter to punish them.</span>")
			if(LAZYLEN(candidates))
//				var/mob/dead/observer/C = pick(candidates)
				for(var/i in 1 to 5)
					if(length(candidates))
						var/mob/candidate = pick(candidates)
						candidates -= candidate
						var/mob/living/carbon/human/npc/hunter/smallhunter = new (startmark.loc)
						new /obj/item/gun/ballistic/automatic/vampire/ak74 (startmark.loc)
						smallhunter.key = candidate.key
						if(!smallhunter.mind)
							smallhunter.mind = new /datum/mind
						var/datum/antagonist/ANTAG = smallhunter.mind.add_antag_datum(/datum/antagonist/small_hunter)
						var/datum/objective/assassinate/die_objective = new
						die_objective.owner = smallhunter
						die_objective.target = src
						ANTAG.objectives += die_objective
						smallhunter.remove_movespeed_modifier(/datum/movespeed_modifier/npc)

/mob/living/carbon/proc/adjust_renown(attribute, amount, threshold, mob/living/carbon/vessel)
	if(!GLOB.canon_event)
		return
	if(!is_special_character(src))
		if(!vessel)
			vessel = src

		var/current_value
		switch(attribute)
			if("honor")
				current_value = honor
			if("glory")
				current_value = glory
			if("wisdom")
				current_value = wisdom
			else
				return

		if(amount < 0)
			if(threshold && current_value <= threshold)
				return
			if(current_value + amount <= threshold)
				amount = (threshold - current_value)
			to_chat(vessel, span_userdanger("You feel [get_negative_emotion(attribute)]!"))
			current_value = max(0, current_value + amount)

		if(amount > 0)
			if(threshold && current_value >= threshold)
				return
			if(current_value + amount >= threshold)
				amount = (threshold - current_value)
			to_chat(vessel, span_bold("You feel [get_positive_emotion(attribute)]!"))
			current_value = min(10, current_value + amount)
		switch(attribute)
			if("honor")
				honor = current_value
			if("glory")
				glory = current_value
			if("wisdom")
				wisdom = current_value

		var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
		if(P)
			switch(attribute)
				if("honor")
					P.honor = honor
				if("glory")
					P.glory = glory
				if("wisdom")
					P.wisdom = wisdom

			P.renownrank = renownrank
			P.save_character()
			P.save_preferences()



/mob/living/carbon/proc/get_negative_emotion(attribute)
	switch(attribute)
		if("honor")
			return "ashamed"

		if("glory")
			return "humiliated"

		if("wisdom")
			return "foolish"

	return "unsure"

/mob/living/carbon/proc/get_positive_emotion(attribute)
	switch(attribute)

		if("honor")
			return "vindicated"

		if("glory")
			return "brave"

		if("wisdom")
			return "clever"

	return "confident"

/mob/living/carbon/proc/AuspiceRankCheck(mob/living/carbon/user)
	switch(auspice.name)
		if("Ahroun")
			if(glory >= 10 && honor >= 9 && wisdom >= 4) return 5
			if(glory >= 9 && honor >= 4 && wisdom >= 2) return 4
			if(glory >= 6 && honor >= 3 && wisdom >= 1) return 3
			if(glory >= 4 && honor >= 1 && wisdom >= 1) return 2
			if(glory >= 2 || honor >= 1) return 1
			return FALSE

		if("Galliard")
			if(glory >= 9 && honor >= 5 && wisdom >= 9) return 5
			if(glory >= 7 && honor >= 2 && wisdom >= 6) return 4
			if(glory >= 4 && honor >= 2 && wisdom >= 4) return 3
			if(glory >= 4 && wisdom >= 2) return 2
			if(glory >= 2 && wisdom >= 1) return 1
			return FALSE

		if("Philodox")
			if(glory >= 4 && honor >= 10 && wisdom >= 9) return 5
			if(glory >= 3 && honor >= 8 && wisdom >= 4) return 4
			if(glory >= 2 && honor >= 6 && wisdom >= 2) return 3
			if(glory >= 1 && honor >= 4 && wisdom >= 1) return 2
			if(honor >= 3) return 1
			return FALSE

		if("Theurge")
			if(glory >= 4 && honor >= 9 && wisdom >= 10) return 5
			if(glory >= 4 && honor >= 2 && wisdom >= 9) return 4
			if(glory >= 2 && honor >= 1 && wisdom >= 7) return 3
			if(glory >= 1 && wisdom >= 5) return 2
			if(wisdom >= 3) return 1
			return FALSE

		if("Ragabash")
			if((glory+honor+wisdom) >= 25) return 5
			if((glory+honor+wisdom) >= 19) return 4
			if((glory+honor+wisdom) >= 13) return 3
			if((glory+honor+wisdom) >= 7) return 2
			if((glory+honor+wisdom) >= 3) return 1
			return FALSE

	return FALSE

#undef VEIL_COOLDOWN
