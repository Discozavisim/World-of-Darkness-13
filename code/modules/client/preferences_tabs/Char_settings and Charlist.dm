#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 4
#define ATTRIBUTE_BASE_LIMIT 5 //Highest level that a base attribute can be upgraded to. Bonus attributes can increase the actual amount past the limit.


/datum/preferences/proc/Character_Settings(mob/user, list/dat)
	if(path)
		var/savefile/S = new /savefile(path)
		if(S)
			dat += "<center>"
			var/name
			var/unspaced_slots = 0
			for(var/i=1, i<=max_save_slots, i++)
				unspaced_slots++
				if(unspaced_slots > 4)
					dat += "<br>"
					unspaced_slots = 0
				S.cd = "/character[i]"
				S["real_name"] >> name
				if(!name)
					name = "Character[i]"
				if(istype(user, /mob/dead/new_player))
					dat += "<a style='white-space:nowrap;' href='byond://?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
			dat += "</center>"

	if(reason_of_death != "None")
		dat += "<center><b>Last death</b>: [reason_of_death]</center>"

	dat += "<center><h2>[make_font_cool("OCCUPATION CHOISES")]</h2>"
	dat += "<a href='byond://?_src_=prefs;preference=job;task=menu'>Set Occupation Preferences</a><br></center>"
	dat += "<h2>[make_font_cool("IDENTITY")]</h2>"
	dat += "<table width='100%'><tr><td width='75%' valign='top'>"
	if(is_banned_from(user.ckey, "Appearance"))
		dat += "<b>You are banned from using custom names and appearances. You can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"
	dat += "<a href='byond://?_src_=prefs;preference=name;task=random'>Random Name</A> "
	dat += "<br><b>Name:</b> "
	dat += "<a href='byond://?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"


	if(!(AGENDER in pref_species.species_traits))
		var/dispGender
		if(gender == MALE)
			dispGender = "Male"
		else if(gender == FEMALE)
			dispGender = "Female"
		else
			dispGender = "Other"
		dat += "<b>Gender:</b> <a href='byond://?_src_=prefs;preference=gender'>[dispGender]</a>"
		if(gender == PLURAL || gender == NEUTER)
			dat += "<BR><b>Body Type:</b> <a href='byond://?_src_=prefs;preference=body_type'>[body_type == MALE ? "Male" : "Female"]</a>"

	var/body_m = "Normal"
	switch(body_model)
		if(1)
			body_m = "Slim"
		if(2)
			body_m = "Normal"
		if(3)
			body_m = "Fat"

	dat += "<BR><b>Shape:</b> <a href='byond://?_src_=prefs;preference=body_model'>[body_m]</a>"

	dat += "<br><b>Biological Age:</b> <a href='byond://?_src_=prefs;preference=age;task=input'>[age]</a>"
	dat += "<br><b>Actual Age:</b> <a href='byond://?_src_=prefs;preference=total_age;task=input'>[max(age, total_age)]</a>"
	dat += "<br><b>Known Languages:</b> <br>English"
	for(var/i in languages)
		var/datum/language/L = i
		dat += "<br>[initial(L.name)]"
	if(length(languages) < Linguistics)
		dat += "<br><a href='byond://?_src_=prefs;preference=languages;task=input'>Learn</a>"
	if(length(languages))
		dat += "<br><a href='byond://?_src_=prefs;preference=languages_reset;task=input'>Reset</a>"

	dat += "</tr></table>"

	dat += "<h2>[make_font_cool("BODY")]</h2>"
			/*
			dat += "<BR>"
			var/max_death = 6
			if(pref_species.name == "Vampire")
				switch(generation)
					if(13)
						max_death = 6
					if(12)
						max_death = 6
					if(11)
						max_death = 5
					if(10)
						max_death = 4
					if(9)
						max_death = 3
					if(8)
						max_death = 2
					if(7)
						max_death = 2
					if(6)
						max_death = 1
					if(5)
						max_death = 1
					if(4)
						max_death = 1
					if(3)
						max_death = 1

			dat += "<b>[pref_species.name == "Vampire" ? "Torpor" : "Clinical Death"] Count:</b> [torpor_count]/[max_death]"
			if(true_experience >= 3*(14-generation) && torpor_count > 0)
				dat += " <a href='byond://?_src_=prefs;preference=torpor_restore;task=input'>Restore ([5*(14-generation)])</a><BR>"
			dat += "<BR>"
			*/
	dat += "<a href='byond://?_src_=prefs;preference=all;task=random'>Random Body</A> "

	dat += "<table width='100%'><tr><td width='24%' valign='top'>"

	dat += "<b>Species:</b><BR><a href='byond://?_src_=prefs;preference=species;task=input'>[pref_species.name]</a><BR>"
	if(pref_species.name == "Vampire")
//		dat += "<b>Path of [enlightenment ? "Enlightenment" : "Humanity"]:</b> [humanity]/10"
		dat += "<b>Humanity:</b> [humanity]/10"
		//if(SSwhitelists.is_whitelisted(parent.ckey, "enlightenment") && !slotlocked)
		if ((true_experience >= (humanity * 2)) && (humanity < 10))
			dat += " <a href='byond://?_src_=prefs;preference=path;task=input'>Restore Humanity ([humanity * 2])</a>"
		dat += "<br>"
		dat += "Consience: [consience]/5 <a href='byond://?_src_=prefs;preference=consience;task=input'>Adjust</a><br>"
		dat += "Self-Control: [selfcontrol]/5 <a href='byond://?_src_=prefs;preference=selfcontrol;task=input'>Adjust</a><br>"
		dat += "Courage: [courage]/5 <a href='byond://?_src_=prefs;preference=courage;task=input'>Adjust</a><br>"
//		if(!slotlocked)
//			dat += "<a href='byond://?_src_=prefs;preference=pathof;task=input'>Switch Path</a><BR>"
	if(pref_species.name == "Kuei-Jin")
		var/datum/dharma/D = new dharma_type()
		dat += "<b>Dharma:</b> [D.name] [dharma_level]/6 <a href='byond://?_src_=prefs;preference=dharmatype;task=input'>Switch</a><BR>"
		dat += "[D.desc]<BR>"
		if(true_experience >= 20 && (dharma_level < 6))
			dat += " <a href='byond://?_src_=prefs;preference=dharmarise;task=input'>Learn (20)</a><BR>"
		dat += "<b>P'o Personality</b>: [po_type] <a href='byond://?_src_=prefs;preference=potype;task=input'>Switch</a><BR>"
		dat += "<b>Awareness:</b> [masquerade]/5<BR>"
		dat += "<b>Yin/Yang</b>: [yin]/[yang] <a href='byond://?_src_=prefs;preference=chibalance;task=input'>Adjust</a><BR>"
		dat += "<b>Hun/P'o</b>: [hun]/[po] <a href='byond://?_src_=prefs;preference=demonbalance;task=input'>Adjust</a><BR>"
	if(pref_species.name == "Werewolf")
		if(!glory)
			glory = 0
		if(!honor)
			honor = 0
		if(!wisdom)
			wisdom = 0
		if(!renownrank)
			renownrank = 0
		dat += "<b>Veil:</b> [masquerade]/5<BR>"
		switch(tribe.name)
			if("Ronin")
				dat += "Renown matters little to you, now.<BR>"
			if("Black Spiral Dancers")
				dat += "<b>Infamy:</b> [glory]/10"
				if(!slotlocked)
					dat +=" <a href='byond://?_src_=prefs;preference=renownglory;task=input'>Change Infamy</a><BR>"
				else
					dat +="<BR>"
				dat += "<b>Power:</b> [honor]/10"
				if(!slotlocked)
					dat +=" <a href='byond://?_src_=prefs;preference=renownhonor;task=input'>Change Power</a><BR>"
				else
					dat +="<BR>"
				dat += "<b>Cunning:</b> [wisdom]/10"
				if(!slotlocked)
					dat +=" <a href='byond://?_src_=prefs;preference=renownwisdom;task=input'>Change Cunning</a><BR>"
				else
					dat +="<BR>"
			else
				dat += "<b>Glory:</b> [glory]/10"
				if(!slotlocked)
					dat +=" <a href='byond://?_src_=prefs;preference=renownglory;task=input'>Change Glory</a><BR>"
				else
					dat +="<BR>"
				dat += "<b>Honor:</b> [honor]/10"
				if(!slotlocked)
					dat +=" <a href='byond://?_src_=prefs;preference=renownhonor;task=input'>Change Honor</a><BR>"
				else
					dat +="<BR>"
				dat += "<b>Wisdom:</b> [wisdom]/10"
				if(!slotlocked)
					dat +=" <a href='byond://?_src_=prefs;preference=renownwisdom;task=input'>Change Wisdom</a><BR>"
				else
					dat +="<BR>"
		dat += "<b>Renown Rank:</b> [RankName(renownrank,src.tribe.name)]<br>"
		if(!slotlocked)
			dat +=" <a href='byond://?_src_=prefs;preference=renownrank;task=input'>Change Renown Rank</a><BR>"
		else
			dat +="<BR>"
		dat += "[RankDesc(renownrank, src.tribe.name)]<BR>"
		dat += "<BR>"
	if(pref_species.name == "Vampire" || pref_species.name == "Ghoul")
		dat += "<b>Masquerade:</b> [masquerade]/5<BR>"
	if(pref_species.name == "Vampire")
		dat += "<b>Generation:</b> [generation-generation_bonus]"
		var/generation_allowed = TRUE
		if(clane)
			if(clane.name == "Caitiff")
				generation_allowed = FALSE
		if(slotlocked)
			generation_allowed = FALSE
		if(generation_allowed)
			dat += " <a href='byond://?_src_=prefs;preference=generation;task=input'>Change</a><BR>"
		else
			dat += "<BR>"
	if(pref_species.name == "Werewolf")
		dat += "<h2>[make_font_cool("TRIBE")]</h2>"
		dat += "<br><b>Werewolf Name:</b> "
		dat += "<a href='byond://?_src_=prefs;preference=werewolf_name;task=input'>[werewolf_name]</a><BR>"
		dat += "<b>Auspice:</b> <a href='byond://?_src_=prefs;preference=auspice;task=input'>[auspice.name]</a><BR>"
		dat += "Description: [auspice.desc]<BR>"
		dat += "<b>Power:</b> •[auspice_level > 1 ? "•" : "o"][auspice_level > 2 ? "•" : "o"]([auspice_level])"
		if(true_experience >= 10*auspice_level && auspice_level != 3)
			dat += "<a href='byond://?_src_=prefs;preference=auspice_level;task=input'>Increase ([10*auspice_level])</a>"
		dat += "<b>Initial Rage:</b> •[auspice.start_rage > 1 ? "•" : "o"][auspice.start_rage > 2 ? "•" : "o"][auspice.start_rage > 3 ? "•" : "o"][auspice.start_rage > 4 ? "•" : "o"]([auspice.start_rage])<BR>"
		var/gifts_text = ""
		var/num_of_gifts = 0
		for(var/i in 1 to auspice_level)
			var/zalupa = tribe.tribal_gifts[i]
			var/datum/action/T = new zalupa()
			gifts_text += "[T.name], "
		for(var/i in auspice.gifts)
			var/datum/action/ACT = new i()
			num_of_gifts = min(num_of_gifts+1, length(auspice.gifts))
			if(num_of_gifts != length(auspice.gifts))
				gifts_text += "[ACT.name], "
			else
				gifts_text += "[ACT.name].<BR>"
			qdel(ACT)
		dat += "<b>Initial Gifts:</b> [gifts_text]"

		var/mob/living/carbon/werewolf/crinos/DAWOF = new (get_turf(parent.mob))
		var/mob/living/carbon/werewolf/lupus/DAWOF2 = new (get_turf(parent.mob))

		DAWOF.sprite_color = werewolf_color
		DAWOF2.sprite_color = werewolf_color

		var/obj/overlay/eyes_crinos = new(DAWOF)
		eyes_crinos.icon = 'code/modules/wod13/werewolf.dmi'
		eyes_crinos.icon_state = "eyes"
		eyes_crinos.layer = ABOVE_HUD_LAYER
		eyes_crinos.color = werewolf_eye_color
		DAWOF.overlays |= eyes_crinos

		var/obj/overlay/scar_crinos = new(DAWOF)
		scar_crinos.icon = 'code/modules/wod13/werewolf.dmi'
		scar_crinos.icon_state = "scar[werewolf_scar]"
		scar_crinos.layer = ABOVE_HUD_LAYER
		DAWOF.overlays |= scar_crinos

		var/obj/overlay/hair_crinos = new(DAWOF)
		hair_crinos.icon = 'code/modules/wod13/werewolf.dmi'
		hair_crinos.icon_state = "hair[werewolf_hair]"
		hair_crinos.layer = ABOVE_HUD_LAYER
		hair_crinos.color = werewolf_hair_color
		DAWOF.overlays |= hair_crinos

		var/obj/overlay/eyes_lupus = new(DAWOF2)
		eyes_lupus.icon = 'code/modules/wod13/werewolf_lupus.dmi'
		eyes_lupus.icon_state = "eyes"
		eyes_lupus.layer = ABOVE_HUD_LAYER
		eyes_lupus.color = werewolf_eye_color
		DAWOF2.overlays |= eyes_lupus

		DAWOF.update_icons()
		DAWOF2.update_icons()
		dat += "[icon2html(getFlatIcon(DAWOF), user)][icon2html(getFlatIcon(DAWOF2), user)]<BR>"
		qdel(DAWOF)
		qdel(DAWOF2)

		dat += "<b>Breed:</b> <a href='byond://?_src_=prefs;preference=breed;task=input'>[breed]</a><BR>"
		dat += "<b>Tribe:</b> <a href='byond://?_src_=prefs;preference=tribe;task=input'>[tribe.name]</a><BR>"
		dat += "<b>Description:</b> [tribe.desc]<BR>"
		dat += "Color: <a href='byond://?_src_=prefs;preference=werewolf_color;task=input'>[werewolf_color]</a><BR>"
		dat += "Scars: <a href='byond://?_src_=prefs;preference=werewolf_scar;task=input'>[werewolf_scar]</a><BR>"
		dat += "Hair: <a href='byond://?_src_=prefs;preference=werewolf_hair;task=input'>[werewolf_hair]</a><BR>"
		dat += "Hair Color: <a href='byond://?_src_=prefs;preference=werewolf_hair_color;task=input'>[werewolf_hair_color]</a><BR>"
		dat += "Eyes: <a href='byond://?_src_=prefs;preference=werewolf_eye_color;task=input'>[werewolf_eye_color]</a><BR>"
	if(pref_species.name == "Vampire")
		dat += "<h2>[make_font_cool("CLANE")]</h2>"
		dat += "<b>Clane/Bloodline:</b> <a href='byond://?_src_=prefs;preference=clane;task=input'>[clane.name]</a><BR>"
		dat += "<b>Description:</b> [clane.desc]<BR>"
		dat += "<b>Curse:</b> [clane.curse]<BR>"
		if(length(clane.accessories))
			if(clane_accessory in clane.accessories)
				dat += "<b>Marks:</b> <a href='byond://?_src_=prefs;preference=clane_acc;task=input'>[clane_accessory]</a><BR>"
			else
				if("none" in clane_accessory)
					clane_accessory = "none"
				else
					clane_accessory = pick(clane.accessories)
				dat += "<b>Marks:</b> <a href='byond://?_src_=prefs;preference=clane_acc;task=input'>[clane_accessory]</a><BR>"
		else
			clane_accessory = null
		dat += "<h2>[make_font_cool("DISCIPLINES")]</h2>"

		for (var/i in 1 to discipline_types.len)
			var/discipline_type = discipline_types[i]
			var/datum/discipline/discipline = new discipline_type
			var/discipline_level = discipline_levels[i]

			var/cost
			if (discipline_level <= 0)
				cost = 10
			else if (clane.name == "Caitiff")
				cost = discipline_level * 6
			else if (discipline.learnable_by_clans.Find(clane.type))
				cost = discipline_level * 6
			else if (clane.clane_disciplines.Find(discipline_type))
				cost = discipline_level * 5
			else
				cost = discipline_level * 7

			dat += "<b>[discipline.name]</b>: [discipline_level > 0 ? "•" : "o"][discipline_level > 1 ? "•" : "o"][discipline_level > 2 ? "•" : "o"][discipline_level > 3 ? "•" : "o"][discipline_level > 4 ? "•" : "o"]([discipline_level])"
			if((true_experience >= cost) && (discipline_level != 5))
				dat += "<a href='byond://?_src_=prefs;preference=discipline;task=input;upgradediscipline=[i]'>Learn ([cost])</a><BR>"
			else
				dat += "<BR>"
			dat += "-[discipline.desc]<BR>"
			qdel(discipline)

		var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal

		for (var/discipline_type in possible_new_disciplines)
			var/datum/discipline/discipline = new discipline_type

			if (discipline.clan_restricted && !(discipline.learnable_by_clans.len))
				possible_new_disciplines -= discipline_type

			if (discipline.learnable_by_clans.len && !(clane.type in discipline.learnable_by_clans))
				possible_new_disciplines -= discipline_type

			if (!discipline.clan_restricted && !discipline.learnable_by_clans.len && clane.name != "Caitiff")
				possible_new_disciplines -= discipline_type

			qdel(discipline)

		if (possible_new_disciplines.len && (true_experience >= 10))
			dat += "<a href='byond://?_src_=prefs;preference=newdiscipline;task=input'>Learn a new Discipline (10)</a><BR>"

	if(pref_species.name == "Ghoul")
		for (var/i in 1 to discipline_types.len)
			var/discipline_type = discipline_types[i]
			var/datum/discipline/discipline = new discipline_type
			dat += "<b>[discipline.name]</b>: •(1)<BR>"
			dat += "-[discipline.desc]<BR>"
			qdel(discipline)

		var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types
		if (possible_new_disciplines.len && (true_experience >= 10))
			dat += "<a href='byond://?_src_=prefs;preference=newghouldiscipline;task=input'>Learn a new Discipline (10)</a><BR>"

	if (pref_species.name == "Kuei-Jin")
		dat += "<h2>[make_font_cool("DISCIPLINES")]</h2><BR>"
		for (var/i in 1 to discipline_types.len)
			var/discipline_type = discipline_types[i]
			var/datum/chi_discipline/discipline = new discipline_type
			var/discipline_level = discipline_levels[i]

			var/cost
			if (discipline_level <= 0)
				cost = 10
			else
				cost = discipline_level * 6

			dat += "<b>[discipline.name]</b> ([discipline.discipline_type]): [discipline_level > 0 ? "•" : "o"][discipline_level > 1 ? "•" : "o"][discipline_level > 2 ? "•" : "o"][discipline_level > 3 ? "•" : "o"][discipline_level > 4 ? "•" : "o"]([discipline_level])"
			if((true_experience >= cost) && (discipline_level != 5))
				dat += "<a href='byond://?_src_=prefs;preference=discipline;task=input;upgradechidiscipline=[i]'>Learn ([cost])</a><BR>"
			else
				dat += "<BR>"
			dat += "-[discipline.desc]. Yin:[discipline.cost_yin], Yang:[discipline.cost_yang], Demon:[discipline.cost_demon]<BR>"
			qdel(discipline)
		var/list/possible_new_disciplines = subtypesof(/datum/chi_discipline) - discipline_types
		var/has_chi_one = FALSE
		var/has_demon_one = FALSE
		var/how_much_usual = 0
		for(var/i in discipline_types)
			if(i)
				var/datum/chi_discipline/C = i
				if(initial(C.discipline_type) == "Shintai")
					how_much_usual += 1
				if(initial(C.discipline_type) == "Demon")
					has_demon_one = TRUE
				if(initial(C.discipline_type) == "Chi")
					has_chi_one = TRUE
		for(var/i in possible_new_disciplines)
			if(i)
				var/datum/chi_discipline/C = i
				if(initial(C.discipline_type) == "Shintai")
					if(how_much_usual >= 3)
						possible_new_disciplines -= i
				if(initial(C.discipline_type) == "Demon")
					if(has_demon_one)
						possible_new_disciplines -= i
				if(initial(C.discipline_type) == "Chi")
					if(has_chi_one)
						possible_new_disciplines -= i
		if (possible_new_disciplines.len && (true_experience >= 10))
			dat += "<a href='byond://?_src_=prefs;preference=newchidiscipline;task=input'>Learn a new Discipline (10)</a><BR>"

	if(true_experience >= 3 && slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=change_appearance;task=input'>Change Appearance (3)</a><BR>"

	dat += "<BR><b>Flavor Text:</b> [flavor_text] <a href='byond://?_src_=prefs;preference=flavor_text;task=input'>Change</a><BR>"
	dat += "<br><br>"

	dat += "<h2>Headshot Image</h2>"
	dat += "<a href='byond://?_src_=prefs;preference=headshot'><b>Set Headshot Image</b></a><br>"
	if(features["headshot_link"])
		dat += "<img style='border:2px solid rgb(255, 255, 255)' src='[features["headshot_link"]]' width='200px' height='200px'>"

	dat += "<h2>[make_font_cool("EQUIP")]</h2>"
	dat += "<br><br>"
	dat += "<b>Underwear:</b><BR><a href ='byond://?_src_=prefs;preference=underwear;task=input'>[underwear]</a>"
//	dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERWEAR]'>[(randomise[RANDOM_UNDERWEAR]) ? "Lock" : "Unlock"]</A>"

	dat += "<br><b>Underwear Color:</b><BR><span style='border: 1px solid #161616; background-color: #[underwear_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=underwear_color;task=input'>Change</a>"
//	dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERWEAR_COLOR]'>[(randomise[RANDOM_UNDERWEAR_COLOR]) ? "Lock" : "Unlock"]</A>"

	dat += "<BR><b>Undershirt:</b><BR><a href ='byond://?_src_=prefs;preference=undershirt;task=input'>[undershirt]</a>"
//	dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_UNDERSHIRT]'>[(randomise[RANDOM_UNDERSHIRT]) ? "Lock" : "Unlock"]</A>"


	dat += "<br><b>Socks:</b><BR><a href ='byond://?_src_=prefs;preference=socks;task=input'>[socks]</a>"
//	dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SOCKS]'>[(randomise[RANDOM_SOCKS]) ? "Lock" : "Unlock"]</A>"


//	dat += "<br><b>Jumpsuit Style:</b><BR><a href ='byond://??_src_=prefs;preference=suit;task=input'>[jumpsuit_style]</a>"
//	dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_JUMPSUIT_STYLE]'>[(randomise[RANDOM_JUMPSUIT_STYLE]) ? "Lock" : "Unlock"]</A>"

	dat += "<br><b>Backpack:</b><BR><a href ='byond://?_src_=prefs;preference=bag;task=input'>[backpack]</a>"
//	dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_BACKPACK]'>[(randomise[RANDOM_BACKPACK]) ? "Lock" : "Unlock"]</A>"

	if(pref_species.name == "Vampire")
		dat += "<BR><b>Fame:</b><BR><a href ='byond://?_src_=prefs;preference=info_choose;task=input'>[info_known]</a>"

	dat += "<BR><BR><b>Relationships:</b><BR>"
	dat += "Have a Friend: <a href='byond://?_src_=prefs;preference=friend'>[friend == TRUE ? "Enabled" : "Disabled"]</A><BR>"
	dat += "What a Friend knows about me: [friend_text] <a href='byond://?_src_=prefs;preference=friend_text;task=input'>Change</a><BR>"
	dat += "<BR>"
	dat += "Have an Enemy: <a href='byond://?_src_=prefs;preference=enemy'>[enemy == TRUE ? "Enabled" : "Disabled"]</A><BR>"
	dat += "What an Enemy knows about me: [enemy_text] <a href='byond://?_src_=prefs;preference=enemy_text;task=input'>Change</a><BR>"
	dat += "<BR>"
	dat += "Have a Lover: <a href='byond://?_src_=prefs;preference=lover'>[lover == TRUE ? "Enabled" : "Disabled"]</A><BR>"
	dat += "What a Lover knows about me: [lover_text] <a href='byond://?_src_=prefs;preference=lover_text;task=input'>Change</a><BR>"

	dat += "<BR><b>Be Ambitious: </b><a href='byond://?_src_=prefs;preference=ambitious'>[ambitious == TRUE ? "Enabled" : "Disabled"]</A><BR>"

	if((HAS_FLESH in pref_species.species_traits) || (HAS_BONE in pref_species.species_traits))
		dat += "<BR><b>Temporal Scarring:</b><BR><a href='byond://?_src_=prefs;preference=persistent_scars'>[(persistent_scars) ? "Enabled" : "Disabled"]</A>"
		dat += "<a href='byond://?_src_=prefs;preference=clear_scars'>Clear scar slots</A>"

//	dat += "<br><b>Antagonist Items Spawn Location:</b><BR><a href ='byond://??_src_=prefs;preference=uplink_loc;task=input'>[uplink_spawn_loc]</a><BR></td>"
//	if (user.client.get_exp_living(TRUE) >= PLAYTIME_VETERAN)
//		dat += "<br><b>Don The Ultimate Gamer Cloak?:</b><BR><a href ='byond://??_src_=prefs;preference=playtime_reward_cloak'>[(playtime_reward_cloak) ? "Enabled" : "Disabled"]</a><BR></td>"
	var/use_skintones = pref_species.use_skintones
	if(use_skintones)

		dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>[make_font_cool("SKIN")]</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=s_tone;task=input'>[skin_tone]</a>"
//		dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SKIN_TONE]'>[(randomise[RANDOM_SKIN_TONE]) ? "Lock" : "Unlock"]</A>"
		dat += "<br>"

	var/mutant_colors
	if((MUTCOLORS in pref_species.species_traits) || (MUTCOLORS_PARTSONLY in pref_species.species_traits))

		if(!use_skintones)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Mutant Color</h3>"

		dat += "<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=mutant_color;task=input'>Change</a><BR>"

		mutant_colors = TRUE

	if(istype(pref_species, /datum/species/ethereal)) //not the best thing to do tbf but I dont know whats better.

		if(!use_skintones)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Ethereal Color</h3>"

		dat += "<span style='border: 1px solid #161616; background-color: #[features["ethcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=color_ethereal;task=input'>Change</a><BR>"


	if((EYECOLOR in pref_species.species_traits) && !(NOEYESPRITES in pref_species.species_traits))

		if(!use_skintones && !mutant_colors)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>[make_font_cool("EYES")]</h3>"
		dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=eyes;task=input'>Change</a>"
//		dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_EYE_COLOR]'>[(randomise[RANDOM_EYE_COLOR]) ? "Lock" : "Unlock"]</A>"

		dat += "<br></td>"
	else if(use_skintones || mutant_colors)
		dat += "</td>"

	if(HAIR in pref_species.species_traits)

		dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>[make_font_cool("HAIR")]</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=hairstyle;task=input'>[hairstyle]</a>"
		dat += "<a href='byond://?_src_=prefs;preference=previous_hairstyle;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_hairstyle;task=input'>&gt;</a>"
//		dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIRSTYLE]'>[(randomise[RANDOM_HAIRSTYLE]) ? "Lock" : "Unlock"]</A>"

		dat += "<br><span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair;task=input'>Change</a>"
//		dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_HAIR_COLOR]'>[(randomise[RANDOM_HAIR_COLOR]) ? "Lock" : "Unlock"]</A>"

		dat += "<BR><h3>[make_font_cool("FACIAL")]</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=facial_hairstyle;task=input'>[facial_hairstyle]</a>"
		dat += "<a href='byond://?_src_=prefs;preference=previous_facehairstyle;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_facehairstyle;task=input'>&gt;</a>"
//		dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIRSTYLE]'>[(randomise[RANDOM_FACIAL_HAIRSTYLE]) ? "Lock" : "Unlock"]</A>"

		dat += "<br><span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=facial;task=input'>Change</a>"
//		dat += "<a href='byond://?_src_=prefs;preference=toggle_random;random_type=[RANDOM_FACIAL_HAIR_COLOR]'>[(randomise[RANDOM_FACIAL_HAIR_COLOR]) ? "Lock" : "Unlock"]</A>"
		dat += "<br></td>"


	if(pref_species.id != "kuei-jin" && pref_species.id != "kindred")
		dat += APPEARANCE_CATEGORY_COLUMN
		dat += "<h3>[make_font_cool("BLOOD TYPE")]</h3>"
		dat += "<br><a href='byond://?_src_=prefs;preference=blood_type;task=input'>[blood_type]</a>"

		dat += "<br></td>"

			//Mutant stuff
	var/mutant_category = 0

	if(pref_species.mutant_bodyparts["tail_lizard"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Tail</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=tail_lizard;task=input'>[features["tail_lizard"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["snout"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Snout</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=snout;task=input'>[features["snout"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["horns"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Horns</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=horns;task=input'>[features["horns"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["frills"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Frills</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=frills;task=input'>[features["frills"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["spines"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Spines</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=spines;task=input'>[features["spines"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["body_markings"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Body Markings</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=body_markings;task=input'>[features["body_markings"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["legs"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Legs</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=legs;task=input'>[features["legs"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["moth_wings"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Moth wings</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=moth_wings;task=input'>[features["moth_wings"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["moth_antennae"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Moth antennae</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=moth_antennae;task=input'>[features["moth_antennae"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["moth_markings"])
		if(!mutant_category)
			dat += APPEARANCE_CATEGORY_COLUMN

		dat += "<h3>Moth markings</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=moth_markings;task=input'>[features["moth_markings"]]</a><BR>"

		mutant_category++
		if(mutant_category >= MAX_MUTANT_ROWS)
			dat += "</td>"
			mutant_category = 0

	if(pref_species.mutant_bodyparts["tail_human"])
		if(pref_species.id != "kindred" && pref_species.id != "ghoul")
			if(!mutant_category)
				dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h3>Tail</h3>"

			dat += "<a href='byond://?_src_=prefs;preference=tail_human;task=input'>[features["tail_human"]]</a><BR>"

			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS)
				dat += "</td>"
				mutant_category = 0

	if(pref_species.mutant_bodyparts["ears"])
		if(pref_species.id != "kindred" && pref_species.id != "ghoul")
			if(!mutant_category)
				dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h3>Ears</h3>"

			dat += "<a href='byond://?_src_=prefs;preference=ears;task=input'>[features["ears"]]</a><BR>"

			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS)
				dat += "</td>"
				mutant_category = 0

			//Adds a thing to select which phobia because I can't be assed to put that in the quirks window
	if("Phobia" in all_quirks)
		dat += "<h3>Phobia</h3>"

		dat += "<a href='byond://?_src_=prefs;preference=phobia;task=input'>[phobia]</a><BR>"

	if(CONFIG_GET(flag/join_with_mutant_humans))

		if(pref_species.mutant_bodyparts["wings"] && GLOB.r_wings_list.len >1)
			if(!mutant_category)
				dat += APPEARANCE_CATEGORY_COLUMN

			dat += "<h3>Wings</h3>"

			dat += "<a href='byond://?_src_=prefs;preference=wings;task=input'>[features["wings"]]</a><BR>"

			mutant_category++
			if(mutant_category >= MAX_MUTANT_ROWS)
				dat += "</td>"
				mutant_category = 0

	if(mutant_category)
		dat += "</td>"
		mutant_category = 0
	dat += "</tr></table>"


/datum/preferences/proc/Character_List(mob/user, list/dat)
	dat += "Awaibal points: [true_experience]<BR>"

	dat += "<h2>[make_font_cool("ATTRIBUTES")]</h2>"

	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=priorities;task=input'>Change Priorities</a><BR>"

	var/datum/species/kindred/K = pref_species
	var/datum/species/ghoul/G = pref_species

	var/physical_priorities = get_freebie_points("Physical")
	var/social_priorities = get_freebie_points("Social")
	var/mental_priorities = get_freebie_points("Mental")
	dat += "<b>PHYSICAL</b>"
	if(physical_priorities)
		dat += "([physical_priorities])"
	dat += "<BR>"
	dat += "Main physical attribute: <b>[uppertext(main_physical_attribute)]</b> "
	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=main_physical;task=input'>Change</a><BR>"
	else
		dat += "<BR>"
	dat += "Secondary physical attribute: <b>[uppertext(secondary_physical_attribute)]</b> "
	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=secondary_physical;task=input'>Change</a><BR>"
	else
		dat += "<BR>"
	dat += "Strength: [build_attribute_score(Strength, get_gen_attribute_limit("Strength"), 5, "strength", physical_priorities)]"
	dat += "Dexterity: [build_attribute_score(Dexterity, get_gen_attribute_limit("Dexterity"), 5, "dexterity", physical_priorities)]"
	dat += "Stamina: [build_attribute_score(Stamina, get_gen_attribute_limit("Stamina"), 5, "stamina", physical_priorities)]"
	dat += "<b>SOCIAL</b>"
	if(social_priorities)
		dat += "([social_priorities])"
	dat += "<BR>"
	dat += "Main social attribute: <b>[uppertext(main_social_attribute)]</b> "
	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=main_social;task=input'>Change</a><BR>"
	else
		dat += "<BR>"
	dat += "Secondary social attribute: <b>[uppertext(secondary_social_attribute)]</b> "
	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=secondary_social;task=input'>Change</a><BR>"
	else
		dat += "<BR>"
	dat += "Charisma: [build_attribute_score(Charisma, get_gen_attribute_limit("Charisma"), 5, "charisma", social_priorities)]"
	dat += "Manipulation: [build_attribute_score(Manipulation, get_gen_attribute_limit("Manipulation"), 5, "manipulation", social_priorities)]"
	dat += "Appearance: [build_attribute_score(Appearance, get_gen_attribute_limit("Appearance"), 5, "appearance", social_priorities)]"
	dat += "<b>MENTAL</b>"
	if(mental_priorities)
		dat += "([mental_priorities])"
	dat += "<BR>"
	dat += "Main mental attribute: <b>[uppertext(main_mental_attribute)]</b> "
	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=main_mental;task=input'>Change</a><BR>"
	else
		dat += "<BR>"
	dat += "Secondary mental attribute: <b>[uppertext(secondary_mental_attribute)]</b> "
	if(!slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=secondary_mental;task=input'>Change</a><BR>"
	else
		dat += "<BR>"
	dat += "Perception: [build_attribute_score(Perception, get_gen_attribute_limit("Perception"), 5, "perception", mental_priorities)]"
	dat += "Intelligence: [build_attribute_score(Intelligence, get_gen_attribute_limit("Intelligence"), 5, "intelligence", mental_priorities)]"
	dat += "Wits: [build_attribute_score(Wits, get_gen_attribute_limit("Wits"), 5, "wits", mental_priorities)]"

	dat += "<h2>[make_font_cool("ABILITIES")]</h2>"

	dat += "<b>TALENTS</b><BR>"
	dat += "Alertness: [build_attribute_score(Alertness, 5, 3, "alertness")]"
	dat += "Athletics: [build_attribute_score(Athletics, 5, 3, "athletics")]"
	dat += "Brawl: [build_attribute_score(Brawl, 5, 3, "brawl")]"
	dat += "Empathy: [build_attribute_score(Empathy, 5, 3, "empathy")]"
	dat += "Intimidation: [build_attribute_score(Intimidation, 5, 3, "intimidation")]"
	dat += "Expression: [build_attribute_score(Expression, 5, 3, "expression")]"
	dat += "<b>SKILLS</b><BR>"
	dat += "Crafts: [build_attribute_score(Crafts, 5, 3, "crafts")]"
	dat += "Melee: [build_attribute_score(Melee, 5, 3, "melee")]"
	dat += "Firearms: [build_attribute_score(Firearms, 5, 3, "firearms")]"
	dat += "Drive: [build_attribute_score(Drive, 5, 3, "drive")]"
	dat += "Security: [build_attribute_score(Security, 5, 3, "security")]"
//	dat += "Performance: [build_attribute_score(Performance, 5, 3, "performance")]"
	if(clane.name == "Tzimisce" || (clane.name == "Old Clan Tzimisce" && K.get_discipline("Vicissitude" )) || (pref_species.name == "Ghoul" && G.get_discipline("Vicissitude")) )
		dat += "Fleshcraft: [build_attribute_score(Fleshcraft, 5, 3, "fleshcraft")]"
	dat += "<b>KNOWLEDGES</b><BR>"
	dat += "Finance: [build_attribute_score(Finance, 5, 3, "finance")]"
	dat += "Investigation: [build_attribute_score(Investigation, 5, 3, "investigation")]"
	dat += "Medicine: [build_attribute_score(Medicine, 5, 3, "medicine")]"
	dat += "Linguistics: [build_attribute_score(Linguistics, 5, 3, "linguistics")]"
	dat += "Occult: [build_attribute_score(Occult, 5, 3, "occult")]"
	// if(clane.name == "Old Clan Tzimiscee" || (clane.name == "Tzimisce" && K.get_discipline("Koldunstvo" )) || (pref_species.name == "Ghoul" && G.get_discipline("Koldunstvo")) )
	//	dat += "Koldun Sorcery: [build_attribute_score(Koldunt, 5, 3, "koldun")]"

	if(CONFIG_GET(flag/roundstart_traits))
		dat += "<center><h2>[make_font_cool("QUIRK SETUP")]</h2>"
		dat += "<a href='byond://?_src_=prefs;preference=trait;task=menu'>Configure Quirks</a><br></center>"
		dat += "<center><b>Current Quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]</center>"

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS
#undef ATTRIBUTE_BASE_LIMIT
