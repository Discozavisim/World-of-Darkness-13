
/datum/job/vamp/priest
	title = "Priest"
	department_head = list("Abbot")
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = "God and Abbot"
	selection_color = "#fff700"

	outfit = /datum/outfit/job/priest

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_PRIEST
	exp_type_department = EXP_TYPE_CHURCH

	allowed_species = list("Vampire", "Ghoul", "Human")
	max_generation = 11
	allowed_bloodlines = list("Cappadocian", "Toreador", "Lasombra", "Salubri", "Salubri Warrior")

	duty = "Pray salvation of mortal souls, obey the Abbot and seek wisdom of the Reverend."
	minimal_masquerade = 5


/datum/outfit/job/priest
	name = "Priest"
	jobtype = /datum/job/vamp/priest

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/hooded/chaplain_hoodie
	id = /obj/item/card/id/hunter
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/church
	backpack_contents = list(/obj/item/storage/fancy/candle_box=1, /obj/item/storage/book/bible=1, /obj/item/passport=1, /obj/item/vamp/creditcard=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/priest/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		suit = /obj/item/clothing/suit/vampire/nun

/obj/effect/landmark/start/priest
	name = "Priest"
	icon_state = "Camarilla Agent"

//////////////////////////////////////////////////////////////////////////

/datum/job/vamp/reverend
	title = "Reverend"
	department_head = list("Abbot")
	faction = "Vampire"
	total_positions = 0
	spawn_positions = 0
	supervisors = "God and Abbot"
	selection_color = "#fff700"

	outfit = /datum/outfit/job/reverend

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_REVEREND
	exp_type_department = EXP_TYPE_CHURCH

	allowed_species = list("Vampire", "Human")
	allowed_bloodlines = list("Cappadocian", "Toreador", "Lasombra", "Salubri", "Salubri Warrior")

	duty = "Be a symbol of piety and righteousness for those faithful."
	minimal_masquerade = 5

/datum/outfit/job/reverend
	name = "Reverend"
	jobtype = /datum/job/vamp/reverend

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/hooded/chaplain_hoodie/leader
	id = /obj/item/card/id/hunter
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/church
	backpack_contents = list(/obj/item/storage/fancy/candle_box=1, /obj/item/storage/book/bible=1, /obj/item/passport=1, /obj/item/vamp/creditcard=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/datum/outfit/job/reverend/pre_equip(mob/living/carbon/human/H)
	..()
	H.resistant_to_disciplines = TRUE
	to_chat(H, "<span class='alertsyndie'>Your faith in God is made of iron. None could shake it, and even in the darkest moments it holds you up.</span>")

/datum/outfit/job/reverend/post_equip(mob/living/carbon/human/H)
	..()
	// True Faith abilities come only from trufaith_level in Character List, not from Reverend role
/obj/effect/landmark/start/reverend
	name = "Reverend"
	icon_state = "Sheriff"

//////////////////////////////////////////////////////////////////////////

/datum/job/vamp/abbot
	title = "Abbot"
	department_head = list("Abbot")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "God"
	selection_color = "#fff700"

	outfit = /datum/outfit/job/abbot

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_ABBOT
	exp_type_department = EXP_TYPE_CHURCH

	allowed_species = list("Human")

	duty = "Be a shepherd of the flock of San Francisco, lead the faithful to salvation."
	minimal_masquerade = 0


/datum/outfit/job/abbot
	name = "Abbot"
	jobtype = /datum/job/vamp/abbot

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/chaplainsuit/bishoprobe
	head = /obj/item/clothing/head/bishopmitre
	id = /obj/item/card/id/hunter
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/church
	backpack_contents = list(/obj/item/storage/fancy/candle_box=1, /obj/item/storage/book/bible=1, /obj/item/passport=1, /obj/item/vamp/creditcard/rich=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/abbot
	name = "Abbot"
	icon_state = "Prince"
