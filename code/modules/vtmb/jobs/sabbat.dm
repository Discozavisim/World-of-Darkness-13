/datum/outfit/job/sabbatist
	name = "Sabbatist"
//	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/sabbat
//	suit = /obj/item/clothing/suit/vampire/trench
	id = /obj/item/cockclock
	backpack_contents = list(/obj/item/passport=1, /obj/item/vampire_stake=3, /obj/item/gun/ballistic/vampire/revolver=1, /obj/item/melee/vampirearms/knife=1, /obj/item/vamp/keys/hack=1, /obj/item/melee/vampirearms/katana/kosa=1)

/datum/outfit/job/sabbatist/pre_equip(mob/living/carbon/human/H)
	..()
	H.vampire_faction = "Sabbat"
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/vampire
		if(H.clane)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
	else
		shoes = /obj/item/clothing/shoes/vampire/heels
		if(H.clane)
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/datum/outfit/job/sabbatist/post_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.add_antag_datum(/datum/antagonist/sabbatist)
	GLOB.sabbatites += H

	var/my_name = "Tyler"
	if(H.gender == MALE)
		my_name = pick(GLOB.first_names_male)
	else
		my_name = pick(GLOB.first_names_female)
	var/my_surname = pick(GLOB.last_names)
	H.fully_replace_character_name(null,"[my_name] [my_surname]")
//Commented out code for future sabbat character setup
/*
	H.generation = 13
	H.clane = null

	H.maxHealth = round((initial(H.maxHealth)-initial(H.maxHealth)/4)+(initial(H.maxHealth)/4)*(H.physique+13-H.generation))
	H.health = round((initial(H.health)-initial(H.health)/4)+(initial(H.health)/4)*(H.physique+13-H.generation))
	REMOVE_TRAIT(H, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	QDEL_NULL(H.clane)
	var/obj/item/organ/eyes/NV = new()
	NV.Insert(H, TRUE, FALSE)
	add_verb(H, /datum/job/sabbatist/verb/setup_character)
*/

	var/list/landmarkslist = list()
	for(var/obj/effect/landmark/start/S in GLOB.start_landmarks_list)
		if(S.name == name)
			landmarkslist += S
	var/obj/effect/landmark/start/D = pick(landmarkslist)
	H.forceMove(D.loc)
	var/list/loadouts = list("Doctor", "Supply Technician", "Street Janitor", "Graveyard Keeper", "Taxi Driver", "Police Officer", "Citizen")
	spawn()
		var/loadout_type = input(H, "Choose your Mask:", "Loadout") as anything in loadouts
		switch(loadout_type)
			if("Doctor")
				H.equipOutfit(/datum/outfit/job/vdoctor)
			if("Supply Technician")
				H.equipOutfit(/datum/outfit/job/supply)
			if("Street Janitor")
				H.equipOutfit(/datum/outfit/job/vjanitor)
			if("Graveyard Keeper")
				H.equipOutfit(/datum/outfit/job/graveyard)
			if("Taxi Driver")
				H.equipOutfit(/datum/outfit/job/taxi)
				new /obj/vampire_car/taxi(get_turf(H))
			if("Police Officer")
				H.equipOutfit(/datum/outfit/job/police_officer)
			if("Chantry Archivist")
				H.equipOutfit(/datum/outfit/job/archivist)
			if("Citizen")
				H.equipOutfit(/datum/outfit/job/citizen)

//Commented out code for future sabbat character setup
/*
/datum/job/sabbatist/verb/setup_character()
	set category = "Sabbat"
	set name = "Set Up Character"
	set desc = "Prepare your character."
	var/list/clans = list("Tzimisce", "Lasombra", "Gangrel", "Brujah", "Toreador", "Ventrue")
	var/list/generations = list(8, 9, 10, 11, 12, 13)
	var/total_points = 10
	var/points_spent = 0

	var/clan_choice = input("Choose your clan:", "Clan Selection") in clans
	var/generation_choice = input("Choose your generation:", "Generation Selection") in generations

	var/discipline1
	var/discipline2
	var/discipline3
	switch(clan_choice)
		if("Tzimisce")
			discipline1 = "Animalism"
			discipline2 = "Auspex"
			discipline3 = "Vicissitude"
		if("Lasombra")
			discipline1 = "Dominate"
			discipline2 = "Obtenebration"
			discipline3 = "Potence"
		if("Gangrel")
			discipline1 = "Animalism"
			discipline2 = "Fortitude"
			discipline3 = "Protean"
		if("Brujah")
			discipline1 = "Celerity"
			discipline2 = "Potence"
			discipline3 = "Presence"
		if("Toreador")
			discipline1 = "Auspex"
			discipline2 = "Celerity"
			discipline3 = "Presence"
		if("Ventrue")
			discipline1 = "Dominate"
			discipline2 = "Fortitude"
			discipline3 = "Presence"
	var/discipline1_level = 0
	var/discipline2_level = 0
	var/discipline3_level = 0

	var/list/generation_costs = list(8 = 5, 9 = 4, 10 = 3, 11 = 2, 12 = 1, 13 = 0)
	generation_choice = 13

	while(points_spent < total_points)
		var/list/choices = list("Discipline 1: [discipline1] (Level: [discipline1_level])", "Discipline 2: [discipline2] (Level: [discipline2_level])", "Discipline 3: [discipline3] (Level: [discipline3_level])", "Finish")
		var/choice = input("Allocate your points. Points remaining: [total_points - points_spent]", "Discipline Allocation") in choices

		if(choice == "Finish")
			break

		if(choice == "Discipline 1: [discipline1] (Level: [discipline1_level])")
			if(points_spent < total_points)
				discipline1_level += 1
				points_spent += 1
		if(choice == "Discipline 2: [discipline2] (Level: [discipline2_level])")
			if(points_spent < total_points)
				discipline2_level += 1
				points_spent += 1
		if(choice == "Discipline 3: [discipline3] (Level: [discipline3_level])")
			if(points_spent < total_points)
				discipline3_level += 1
				points_spent += 1
		if(choice == "Choose Generation (Current: [generation_choice])")
			var/new_generation = input("Choose your generation:", "Generation Selection") in generation_costs
			var/cost = generation_costs[new_generation]
			if(points_spent + cost <= total_points)
				points_spent += cost
				generation_choice = new_generation

	H.skin_tone = get_vamp_skin_color(H.skin_tone)
	H.update_body()
	H.clane = new H.clane.type()
	H.clane.on_gain(H)
	if(H.clane.alt_sprite)
		H.skin_tone = "albino"
		H.update_body()
	H.create_disciplines(FALSE, discipline1, discipline2, discipline3)

//	H.discipline1 = discipline1_level
//	H.discipline2 = discipline2_level
//	H.discipline3 = discipline3_level

	H.generation = generation_choice
	H.maxbloodpool = 10+((13-min(13, H.generation))*3)
	H.clane.enlightenment = H.clane.enlightenment
	H.maxHealth = round((initial(H.maxHealth)-initial(H.maxHealth)/4)+(initial(H.maxHealth)/4)*(H.physique+13-H.generation))
	H.health = round((initial(H.maxHealth)-initial(H.maxHealth)/4)+(initial(H.maxHealth)/4)*(H.physique+13-H.generation))

	to_chat(H, "You have chosen [clan_choice] with generation [generation_choice]. Your disciplines are [discipline1] (Level: [discipline1_level]), [discipline2] (Level: [discipline2_level]) and [discipline3] (Level: [discipline3_level]).")
	remove_verb(H, /datum/job/sabbatist/verb/setup_character)

*/

/obj/effect/landmark/start/sabbatist
	name = "Sabbatist"
	delete_after_roundstart = FALSE

/datum/antagonist/sabbatist
	name = "Sabbatist"
	roundend_category = "sabbattites"
	antagpanel_category = "Sabbat"
	job_rank = ROLE_REV
	antag_moodlet = /datum/mood_event/revolution
	antag_hud_type = ANTAG_HUD_REV
	antag_hud_name = "rev"
	var/datum/team/sabbat_cainites/team

/datum/antagonist/sabbatist/on_gain()
	add_antag_hud(ANTAG_HUD_REV, "rev", owner.current)
	owner.special_role = src
	var/list/objective_list = list(
		/datum/objective/sabbat,
		/datum/objective/sabbat/convert,
		/datum/objective/survive,
	) //Warning! We have additional objective on /datum/team!
	for(var/O in objective_list)
		var/datum/objective/custom_objective = new O()
		custom_objective.owner = owner
		objectives += custom_objective

	var/datum/team/sabbat_cainites/team = locate(/datum/team/sabbat_cainites) in GLOB.antagonist_teams
	if(!team)
		team = new()
	team.add_member(owner)

	owner.current.playsound_local(get_turf(owner.current), 'code/modules/wod13/sounds/evil_start.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	return ..()

/datum/antagonist/sabbatist/on_removal()
	..()
	to_chat(owner.current,"<span class='userdanger'>You are no longer the Sabbat Shovelhead!</span>")
	owner.special_role = null
	team?.UnregisterSignal(owner.current, COMSIG_KILL)

/datum/antagonist/sabbatist/greet()
	to_chat(owner.current, "<span class='alertsyndie'>You are the Sabbat Shovelhead.</span>")
	owner.announce_objectives()

/datum/antagonist/sabbatist/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	if(team)
		team.UnregisterSignal(old_body, COMSIG_KILL)
		team.RegisterSignal(new_body, COMSIG_KILL, TYPE_PROC_REF(/datum/team/sabbat_cainites, count_kills))

//TEAM
/datum/team/sabbat_cainites
	name = "Cainites" //I geniuly dont know how to call them cause just "sabbat" is taken by the fucking revs. Why? Not to me

/datum/team/sabbat_cainites/New(starting_members)
	. = ..()
	var/datum/objective/sabbat/mass_murder/obj = new()
	objectives += obj
	obj.team = src

/datum/team/sabbat_cainites/add_member(datum/mind/new_member)
	. = ..()
	var/datum/antagonist/sabbatist/A = new_member.has_antag_datum(/datum/antagonist/sabbatist)
	if(!A) return //Say NO to admeme!
	A.team = src
	RegisterSignal(new_member.current, COMSIG_KILL, PROC_REF(count_kills))

	var/need_kills = 4 * length(members)
	for(var/datum/objective/sabbat/mass_murder/obj in objectives) //Do we have 1 objective? Good. Did admeme happen? No bugs
		obj.needed = need_kills
		obj.update_explanation_text()

		A.objectives += obj

	for(var/datum/mind/M in members)
		to_chat(M.current, "<span class='alertsyndie'>Now we need to kill [need_kills] mortals!</span>")

/datum/team/sabbat_cainites/proc/count_kills()
	for(var/datum/objective/sabbat/mass_murder/obj in objectives)
		obj.kills++
		if(obj.needed < obj.kills)
			return
		for(var/datum/mind/M in members)
			to_chat(M.current, "<span class='notice'> We [obj.kills == obj.needed ? "achieved" : "need to kill [obj.needed - obj.kills] more to achieve"] our goals in blood.</span>")
