/datum/job/vamp/giovannielder
	title = "Capo"
	department_head = list("Dis Pater")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Family and the Traditions"
	selection_color = "#cb4aad"

	outfit = /datum/outfit/job/giovannielder

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_GIOVANNIELDER
	exp_type_department = EXP_TYPE_GIOVANNI

	minimal_generation = 11	//Uncomment when players get exp enough
	max_generation = 7

	v_duty = "Pure blood runs through your veins and, with it, old power. Throughout your long life you have learnt to hold onto two things and never let go: money, and family."
	minimal_masquerade = 0
	experience_addition = 0
	allowed_species = list("Vampire")
	allowed_bloodlines = list("Giovanni", "Cappadocian")

/datum/outfit/job/giovannielder
	name = "Capo"
	jobtype = /datum/job/vamp/giovannielder

	uniform = /obj/item/clothing/under/vampire/sheriff
	suit = /obj/item/clothing/suit/vampire/trench/alt
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/giovanni_capo
	r_pocket = /obj/item/vamp/keys/giovanniboss
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/giovanniboss=1, /obj/item/cockclock=1)

/datum/outfit/job/giovannielder/pre_equip(mob/living/carbon/human/H)
	..()
	H.add_to_sect("Giovanni")
//	H.vampire_faction = "Giovanni"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/sheriff/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovannielder
	name = "Capo"

///////////////////////////////////////////////////////////////////////////////////////////////

/datum/job/vamp/giovanniconsig
	title = "Consiglieri"
	department_head = list("Dis Pater and Capo")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Family and the Traditions"
	selection_color = "#cb4aad"

	outfit = /datum/outfit/job/giovanniconsig

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_GIOVANNICONSIG
	exp_type_department = EXP_TYPE_GIOVANNI

	minimal_generation = 11	//Uncomment when players get exp enough
	max_generation = 9

	v_duty = "You are a trusted advisor and respected man of the Family, help your Capo run his business smoothly."
	minimal_masquerade = 0
	experience_addition = 0
	allowed_species = list("Vampire")
	allowed_bloodlines = list("Giovanni", "Cappadocian")

/datum/outfit/job/giovanniconsig
	name = "Consiglieri"
	jobtype = /datum/job/vamp/giovanniconsig

	uniform = /obj/item/clothing/under/vampire/clerk
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/giovanni_capo
	r_pocket = /obj/item/vamp/keys/giovanniboss
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/giovanniboss=1, /obj/item/cockclock=1)

/datum/outfit/job/giovanniconsig/pre_equip(mob/living/carbon/human/H)
	..()
	H.add_to_sect("Giovanni")
//	H.vampire_faction = "Giovanni"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/clerk/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovanniconsig
	name = "Consiglieri"

///////////////////////////////////////////////////////////////////////////////////////////////

/datum/job/vamp/giovanni
	title = "Sgarrista"
	department_head = list("Dis Pater and Capo")
	faction = "Vampire"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Family and the Traditions"
	selection_color = "#cb4aad"

	outfit = /datum/outfit/job/giovanni

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_GIOVANNI
	exp_type_department = EXP_TYPE_GIOVANNI

	v_duty = "As far as you can remember, you always wanted to be a gangster. Now you are a made man, a tough guy. Protect the Family and its greatest secret from outsiders."
	minimal_masquerade = 0
	experience_addition = 0
	max_generation = 10
	allowed_species = list("Vampire")
	allowed_bloodlines = list("Giovanni", "Cappadocian")

/datum/outfit/job/giovanni
	name = "Sgarrista"
	jobtype = /datum/job/vamp/giovanni

	uniform = /obj/item/clothing/under/vampire/clerk
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/giovanni_squadra
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/rich=1, /obj/item/cockclock=1)

/datum/outfit/job/giovanni/pre_equip(mob/living/carbon/human/H)
	..()
	H.add_to_sect("Giovanni")
//	H.vampire_faction = "Giovanni"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/clerk/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovanni
	name = "Sgarrista"

///////////////////////////////////////////////////////////////////////////////////////////////

/datum/job/vamp/giovannimafia
	title = "Famiglia"
	department_head = list("Capo")
	faction = "Vampire"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Family"
	selection_color = "#cb4aad"

	outfit = /datum/outfit/job/giovannimafia

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_GIOVANNIMAFIA
	exp_type_department = EXP_TYPE_GIOVANNI

//	minimal_generation = 11	//Uncomment when players get exp enough

	allowed_species = list("Ghoul", "Human")
	duty = "Your family is a strange one. Maybe you are strange too, because sitting next to your great uncles as an equal is something you are greatly interested in."
	minimal_masquerade = 0
	experience_addition = 0


/datum/outfit/job/giovannimafia
	name = "Famiglia"
	jobtype = /datum/job/vamp/giovannimafia

	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/giovanni_famiglia
	r_pocket = /obj/item/vamp/keys/giovannimafia
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1, /obj/item/cockclock=1)

/datum/outfit/job/giovannimafia/pre_equip(mob/living/carbon/human/H)
	..()
	H.add_to_sect("Giovanni")
//	H.vampire_faction = "Giovanni"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/giovannimafia
	name = "Famiglia"
