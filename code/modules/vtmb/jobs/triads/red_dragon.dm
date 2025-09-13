/datum/job/vamp/red_dragon
	title = "Red Dragon"
	department_head = list("Triad Leadership")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = " the Triads"
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/red_dragon

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TRIAD_DRAGON
	exp_type_department = EXP_TYPE_GANG

	allowed_species = list("Kuei-Jin")
	minimal_generation = 13

	duty = "Управляй китайским городком, развивай триаду, укрывайся от копов."
	experience_addition = 0
	minimal_masquerade = 0

/datum/outfit/job/red_dragon/pre_equip(mob/living/carbon/human/H)
	..()
	H.grant_language(/datum/language/cantonese)
	H.vampire_faction = "Triad"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/red_dragon/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/datum/outfit/job/red_dragon
	name = "Red Dragon"
	jobtype = /datum/job/vamp/red_dragon
	uniform =/obj/item/clothing/under/vampire/suit/red_dragon
	shoes = /obj/item/clothing/shoes/vampire/jackboots/red_dragon
	glasses = /obj/item/clothing/glasses/vampire/red
	suit = /obj/item/clothing/suit/vampire/trench/armored/red
	belt = /obj/item/storage/belt/vampire/sheathe/sabre
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone/red_dragon
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/triads
	r_hand = /obj/item/police_radio
	backpack_contents = list(/obj/item/passport=1, /obj/item/vamp/creditcard/rich=1, /obj/item/clothing/mask/vampire/balaclava =1)


/obj/effect/landmark/start/red_dragon
	name = "Red Dragon"
	icon_state = "china_power"
