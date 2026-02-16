/mob/living/carbon/human/npc/proc/Aggro(mob/M, attacked = FALSE)
	if(M == src)
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.vampire_faction == vampire_faction || presence_master == H)
			return
	if(istype(M,/mob/living/carbon/human/npc))
		var/mob/living/carbon/human/npc/H = M
		if(H && !H.presence_master)
			return
	if(CheckMove(hardlock = TRUE))
		return
	if(danger_source != M)
		var/theirpower = secret_vampireroll(max(get_a_manipulation(M), get_a_strength(M))+get_a_intimidation(M), get_a_willpower(src), M, TRUE)
		if(theirpower == -1)
			fights_anyway = TRUE
			if(!my_weapon)
				my_weapon = new /obj/item/gun/ballistic/automatic/vampire/deagle(src)
		else if(fights_anyway || my_weapon)
			if(theirpower >= 3 && !presence_master)
				fights_anyway = FALSE
				QDEL_NULL(my_weapon)
				my_weapon = null
	if((stat != DEAD) && !HAS_TRAIT(M, TRAIT_DEATHCOMA))
		danger_source = M
		if(attacked)
			last_attacker = M
			if(health != last_health)
				last_health = health
				last_damager = M
	if((last_danger_meet + 2 SECONDS) < world.time)
		last_danger_meet = world.time
		if(prob(50))
			if(!my_weapon)
				if(prob(50))
					emote("scream")
				else
					RealisticSay(pick(socialrole.help_phrases))
			else
				RealisticSay(pick(socialrole.help_phrases))
