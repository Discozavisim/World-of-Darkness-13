/datum/job/vamp/red_stick
	title = "Red Stick"
	department_head = list("Red Dragon")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = " Red Dragon"
	selection_color = "#bb9d3d"

	outfit = /datum/outfit/job/red_stick

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TRIAD_STICK
	exp_type_department = EXP_TYPE_GANG

	allowed_species = list("Kuei-Jin")
	minimal_generation = 13

	duty = "Ты - сила триады. Защищай её, уничтожай врагов и следуй указам Красного Дракона"
	experience_addition = 0
	minimal_masquerade = 0

/datum/outfit/job/red_stickr/pre_equip(mob/living/carbon/human/H)
	..()
	H.grant_language(/datum/language/cantonese)
	H.vampire_faction = "Triad"
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/datum/outfit/job/red_stick
	name = "Red Stick"
	jobtype = /datum/job/vamp/red_stick
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	belt = /obj/item/storage/belt/vampire/sheathe/sabre
	id = /obj/item/cockclock
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/vamp/phone/red_stick
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/triads
	r_hand = /obj/item/police_radio
	backpack_contents = list(/obj/item/passport=1, /obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/vamp/creditcard/rich=1, /obj/item/clothing/mask/vampire/balaclava =1)

/obj/effect/landmark/start/red_stick
	name = "Red Stick"
	icon_state = "china_power_1"
