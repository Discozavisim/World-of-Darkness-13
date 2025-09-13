/datum/job/vamp/paper_wind
	title = "Paper Wind"
	department_head = list("Red Dragon")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = " Red Dragon"
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/red_dragon

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TRIAD_WIND
	exp_type_department = EXP_TYPE_GANG

	allowed_species = list("Kuei-Jin", "Human")
	minimal_generation = 13

	duty = "Ты - кошелек триады. Управляй её финансами, распределяй ресурсы и слушай Красного Дракона "
	experience_addition = 0
	minimal_masquerade = 0

/datum/outfit/job/paper_wind/pre_equip(mob/living/carbon/human/H)
	..()
	H.grant_language(/datum/language/cantonese)
	H.vampire_faction = "Triad"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/datum/outfit/job/paper_wind
	name = "Paper Wind"
	jobtype = /datum/job/vamp/paper_wind
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone/paper_wind
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/triads
	backpack_contents = list(/obj/item/passport=1, /obj/item/vamp/creditcard/paper_wind=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/vampire/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/melee/vampirearms/knife)

/obj/effect/landmark/start/paper_wind
	name = "Red Stick"
	icon_state = "china_power_2"
