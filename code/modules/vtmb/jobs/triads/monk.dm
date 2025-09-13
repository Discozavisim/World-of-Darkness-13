/datum/job/vamp/monk
	title = "Monk"
	department_head = list("Red Dragon")
	faction = "Vampire"
	total_positions = 10
	spawn_positions = 10
	supervisors = " Red Dragon"
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/monk

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TRIAD_MONK
	exp_type_department = EXP_TYPE_GANG

	allowed_species = list("Kuei-Jin", "Human")
	minimal_generation = 13

	duty = "Живи в китайском городке, помогай триаде, подчиняйся Красному Дракону."
	experience_addition = 0
	minimal_masquerade = 0

/datum/outfit/job/monk/pre_equip(mob/living/carbon/human/H)
	..()
	H.grant_language(/datum/language/cantonese)
	H.vampire_faction = "Triad"

/datum/outfit/job/monk
	name = "Monk"
	jobtype = /datum/job/vamp/monk
	uniform = /obj/item/clothing/under/vampire/bandit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/cockclock
	gloves = /obj/item/clothing/gloves/vampire/leather
	l_pocket = /obj/item/vamp/phone/triads_soldier
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/triads
	backpack_contents = list(/obj/item/passport=1, /obj/item/vamp/creditcard=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/vampire/beretta,/obj/item/ammo_box/magazine/semi9mm, /obj/item/melee/vampirearms/knife)

/obj/effect/landmark/start/monk
	name = "Red Dragon"
	icon_state = "china_power_3"
