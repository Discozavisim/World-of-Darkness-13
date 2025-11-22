SUBSYSTEM_DEF(city_time)
	name = "City Time"
	init_order = INIT_ORDER_DEFAULT
	wait = 150
	priority = FIRE_PRIORITY_DEFAULT

	var/hour = 21
	var/minutes = 0

	var/timeofnight = "21:00"

/proc/get_next_hour(number)
	if(number == 23)
		return 0
	else
		return number+1

/proc/get_watch_number(number)
	if(number < 10)
		return "0[number]"
	else
		return "[number]"

/datum/controller/subsystem/city_time/fire()
	if(minutes == 59)
		minutes = 0
		hour =  get_next_hour(hour)
	else
		minutes = max(0, minutes+1)

	timeofnight = "[get_watch_number(hour)]:[get_watch_number(minutes)]"

	if(hour == 0 && minutes == 0)
		var/won
		var/last_winner_points = 0
		if(length(SSfactionwar.marks_camarilla) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_camarilla)
			won = "Camarilla"
		if(length(SSfactionwar.marks_anarch) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_anarch)
			won = "Anarchs"
		if(length(SSfactionwar.marks_giovanni) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_giovanni)
			won = "Giovanni"
		if(length(SSfactionwar.marks_triad) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_triad)
			won = "Triad"
		if(length(SSfactionwar.marks_sabbat) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_sabbat)
			won = "Sabbat"
//		for(var/mob/living/carbon/werewolf/W in GLOB.player_list)
//			if(W)
//				if(W.stat != DEAD)
//					if(W.key)
//						var/datum/preferences/P = GLOB.preferences_datums[ckey(W.key)]
//						if(P)
//							P.add_experience(get_a_intelligence(W))
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H)
				if(H.stat != DEAD)
					if(H.key)
						var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
						if(P)
//							P.old_enough_to_get_exp = TRUE
							if(!iskindred(H) && !isghoul(H) && !iscathayan(H) && !isgarou(H))
								P.add_experience(10) // Буст экспы хуманам
							if(isghoul(H))
								P.add_experience(5) // Буст экспы для гулей чтобы чаще на них играли
//							P.add_experience(get_a_intelligence(H))
							if(H.mind)
								if("[H.mind.assigned_role]" == "Prince" || "[H.mind.assigned_role]" == "Baron")
									P.add_experience(5)
							if(!HAS_TRAIT(H, TRAIT_NON_INT))
								if(won)
									if(H.vampire_faction == won)
										P.add_experience(5)
//								if(H.total_contracted > 1)
//									P.add_experience(1)
//									H.total_contracted = 0
/*								var/toreador_bonus = 0
								if(iskindred(H) && H.clane)
									if(H.clane.name == "Toreador")
										toreador_bonus = 1*/
								if(H.total_erp > 4500)
									P.add_experience(5)
									H.total_erp = 0
								if(H.total_cleaned > 25)
									P.add_experience(5)
									H.total_cleaned = 0
									call_dharma("cleangrow", H)
								if(H.mind)
									if(H.mind.assigned_role == "Graveyard Keeper")
										if(SSgraveyard.total_good > SSgraveyard.total_bad)
											P.add_experience(5)
							P.save_preferences()
							P.save_character()

	if(hour == 3 && minutes == 0)
		var/won
		var/last_winner_points = 0
		if(length(SSfactionwar.marks_camarilla) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_camarilla)
			won = "Camarilla"
		if(length(SSfactionwar.marks_anarch) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_anarch)
			won = "Anarchs"
		if(length(SSfactionwar.marks_giovanni) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_giovanni)
			won = "Giovanni"
		if(length(SSfactionwar.marks_triad) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_triad)
			won = "Triad"
		if(length(SSfactionwar.marks_sabbat) > last_winner_points)
			last_winner_points = length(SSfactionwar.marks_sabbat)
			won = "Sabbat"
//		for(var/mob/living/carbon/werewolf/W in GLOB.player_list)
//			if(W)
//				if(W.stat != DEAD)
//					if(W.key)
//						var/datum/preferences/P = GLOB.preferences_datums[ckey(W.key)]
//						if(P)
//							P.add_experience(get_a_intelligence(W))
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			if(H)
				if(H.stat != DEAD)
					if(H.key)
						var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
						if(P)
//							P.add_experience(get_a_intelligence(H))
							if(H.mind)
								if("[H.mind.assigned_role]" == "Prince" || "[H.mind.assigned_role]" == "Baron")
									P.add_experience(5)
							if(!HAS_TRAIT(H, TRAIT_NON_INT))
								if(won)
									if(H.vampire_faction == won)
										P.add_experience(5)
//								if(H.total_contracted > 1)
//									P.add_experience(3)
//									H.total_contracted = 0
/*								var/toreador_bonus = 0
								if(iskindred(H) && H.clane)
									if(H.clane.name == "Toreador")
										toreador_bonus = 1*/
								if(H.total_erp > 4500)
									P.add_experience(5)
									H.total_erp = 0
								if(H.total_cleaned > 25)
									P.add_experience(5)
									H.total_cleaned = 0
									call_dharma("cleangrow", H)
								if(H.mind)
									if(H.mind.assigned_role == "Graveyard Keeper")
										if(SSgraveyard.total_good > SSgraveyard.total_bad)
											P.add_experience(5)
							P.save_preferences()
							P.save_character()

	if(hour == 5 && minutes == 30)
		to_chat(world, "<span class='ghostalert'>The night is ending...</span>")

	if(hour == 5 && minutes == 45)
		to_chat(world, "<span class='ghostalert'>First rays of the sun illuminate the sky...</span>")
		for(var/mob/living/carbon/human/ohvampire in GLOB.player_list)
			if(ohvampire)
				if(ohvampire.MyPath)
					ohvampire.MyPath.trigger_morality("suncoming")

	if(hour == 6 && minutes == 0)
		to_chat(world, "<span class='ghostalert'>THE NIGHT IS OVER.</span>")
		SSticker.force_ending = 1
		SSticker.current_state = GAME_STATE_FINISHED
		toggle_ooc(TRUE) // Turn it on
		toggle_dooc(TRUE)
		SSticker.declare_completion(SSticker.force_ending)
		Master.SetRunLevel(RUNLEVEL_POSTGAME)
//		var/won
//		if(length(SSfactionwar.marks_camarilla) > length(SSfactionwar.marks_anarch) && length(SSfactionwar.marks_camarilla) > length(SSfactionwar.marks_sabbat))
//			won = "camarilla"
//		if(length(SSfactionwar.marks_anarch) > length(SSfactionwar.marks_camarilla) && length(SSfactionwar.marks_anarch) > length(SSfactionwar.marks_sabbat))
//			won = "anarch"
//		if(length(SSfactionwar.marks_sabbat) > length(SSfactionwar.marks_anarch) && length(SSfactionwar.marks_sabbat) > length(SSfactionwar.marks_camarilla))
//			won = "sabbat"
		for(var/mob/living/carbon/human/H in GLOB.human_list)
			var/area/vtm/V = get_area(H)
			if(iskindred(H) && V.upper)
				H.death()
			if(iscathayan(H) && V.upper)
				H.death()
//			if(won)
//				if(H.vampire_faction == won)
//					if(H.key)
//						var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
//						if(P)
//							var/mode = 1
//							if(HAS_TRAIT(H, TRAIT_NON_INT))
//								mode = 2
//							P.exper = min(calculate_mob_max_exper(H), P.exper+(1000/mode))
//		switch(won)
//			if("camarilla")
//				to_chat(world, "Camarilla takes control over the city...")
//			if("anarch")
//				to_chat(world, "Anarchs take control over the city...")
//			if("sabbat")
//				to_chat(world, "Sabbat takes control over the city...")
//			else
//				to_chat(world, "The city remains neutral...")
