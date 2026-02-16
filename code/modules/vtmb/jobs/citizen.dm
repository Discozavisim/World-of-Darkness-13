
/datum/job/vamp/citizen
	title = "Citizen"
	faction = "Vampire"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Traditions"
	selection_color = "#df7058"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/citizen
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.

	access = list(ACCESS_MAINT_TUNNELS)
	liver_traits = list(TRAIT_GREYTIDE_METABOLISM)

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_CITIZEN

	allowed_species = list("Vampire", "Ghoul", "Human", "Werewolf", "Kuei-Jin")

	v_duty = "Follow the traditions of the Camarilla. Obey the Prince and their authority. The city belongs to him. Aligning yourself with your clan members would be of benefit."
	duty = "Obey the authorities... Or don't. You are up late tonight for one reason or another."
	minimal_masquerade = 0
	max_generation = 13
	allowed_bloodlines = list("True Brujah", "Daughters of Cacophony", "Salubri", "Baali", "Brujah", "Tremere", "Ventrue", "Nosferatu", "Gangrel", "Toreador", "Malkavian", "Banu Haqim", "Banu Haqim Sorcerer", "Banu Haqim Vizier", "Giovanni", "Followers of Set", "Tzimisce", "Lasombra", "Caitiff", "Old Clan Tzimisce", "Kiasyd", "Cappadocian", "Salubri Warrior")

/datum/outfit/job/citizen
	name = "Citizen"
	jobtype = /datum/job/vamp/citizen
	l_pocket = /obj/item/vamp/phone
	id = /obj/item/cockclock

/datum/outfit/job/citizen/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes
	else
		uniform = /obj/item/clothing/under/vampire/emo
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
	if(!H.clane)
		backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)
	if(H.clane && H.clane.name != "Lasombra")
		backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/obj/effect/landmark/start/citizen
	name = "Citizen"
	icon_state = "Assistant"

/obj/effect/landmark/start/elder
	name = "Elder"
	icon_state = "Assistant"

/obj/effect/landmark/start/hobo
	name = "Hobo"
	icon_state = "Assistant"

/datum/job/proc/scale_with_pop()
	return TRUE

/datum/job/vamp/elder/scale_with_pop()
	var/maximum_elders = ceil(length(GLOB.player_list)/10)
	if(GLOB.elders_joined >= maximum_elders)
		return FALSE
	return TRUE

/datum/job/vamp/elder
	title = "Elder"
	faction = "Vampire"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Traditions"
	selection_color = "#df7058"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/elder
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.

	access = list(ACCESS_MAINT_TUNNELS)
	liver_traits = list(TRAIT_GREYTIDE_METABOLISM)

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_ELDER

	allowed_species = list("Vampire")

	v_duty = "Follow the traditions of the Camarilla. Obey the Prince and their authority. The city belongs to him. Aligning yourself with your clan members would be of benefit."
	duty = "Obey the authorities... Or don't. You are up late tonight for one reason or another."
	minimal_masquerade = 0
	minimal_generation = 9
	max_generation = 7
	allowed_bloodlines = list("True Brujah", "Daughters of Cacophony", "Salubri", "Baali", "Brujah", "Tremere", "Ventrue", "Nosferatu", "Gangrel", "Toreador", "Malkavian", "Banu Haqim", "Banu Haqim Sorcerer", "Banu Haqim Vizier",  "Giovanni", "Followers of Set", "Tzimisce", "Lasombra", "Caitiff", "Old Clan Tzimisce", "Kiasyd", "Cappadocian", "Salubri Warrior")

/datum/outfit/job/elder
	name = "Elder"
	jobtype = /datum/job/vamp/elder
	l_pocket = /obj/item/vamp/phone
	id = /obj/item/cockclock

/datum/outfit/job/elder/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes
	else
		uniform = /obj/item/clothing/under/vampire/emo
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
	if(H.clane)
		if(H.clane.name == "Lasombra")
			backpack_contents = list(/obj/item/passport =1, /obj/item/vamp/creditcard=1)
	if(!H.clane)
		backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)
	if(H.clane && H.clane.name != "Lasombra")
		backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/elder/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(!visualsOnly)
//		to_chat(world, "Elder joined")
		GLOB.elders_joined += 1

/datum/job/vamp/hobo
	title = "Hobo"
	faction = "Vampire"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the Capitalism"
	selection_color = "#df7058"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/hobo
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.

	access = list(ACCESS_MAINT_TUNNELS)
	liver_traits = list(TRAIT_GREYTIDE_METABOLISM)

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_CITIZEN

	allowed_species = list("Vampire", "Ghoul", "Human", "Werewolf", "Kuei-Jin")

	v_duty = "Survive in the capitalist world."
	duty = "Obey the authorities... Or don't. You are up late tonight for one reason or another."
	minimal_masquerade = 0
	max_generation = 11
	allowed_bloodlines = list("Daughters of Cacophony", "Salubri", "Baali", "Brujah", "Tremere", "Nosferatu", "Gangrel", "Toreador", "Malkavian", "Banu Haqim", "Banu Haqim Sorcerer", "Banu Haqim Vizier", "Followers of Set", "Tzimisce", "Caitiff", "Kiasyd", "Cappadocian", "Salubri Warrior")

/datum/outfit/job
	var/hobo_job = FALSE

/datum/outfit/job/hobo
	name = "Hobo"
	hobo_job = TRUE
	jobtype = /datum/job/vamp/hobo

/datum/outfit/job/hobo/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/vampire/jackboots/work
		uniform = /obj/item/clothing/under/vampire/homeless
		suit = /obj/item/clothing/suit/vampire/coat
		head = /obj/item/clothing/head/vampire/beanie/black
		gloves = /obj/item/clothing/gloves/vampire/work
		neck = pick(list(/obj/item/clothing/neck/vampire/scarf/red,
							/obj/item/clothing/neck/vampire/scarf,
							/obj/item/clothing/neck/vampire/scarf/blue,
							/obj/item/clothing/neck/vampire/scarf/green,
							/obj/item/clothing/neck/vampire/scarf/white))
	else
		shoes = /obj/item/clothing/shoes/vampire/brown
		uniform = /obj/item/clothing/under/vampire/homeless/female
		suit = /obj/item/clothing/suit/vampire/coat/alt
		head = /obj/item/clothing/head/vampire/beanie/homeless
