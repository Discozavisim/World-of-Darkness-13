/datum/job/vamp/hound
	title = "Hound"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Prince")
	faction = "Vampire"
	total_positions = 8
	spawn_positions = 8
	supervisors = "the Prince"
	selection_color = "#bd3327"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/hound

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM) // See /datum/job/officer/get_access()
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_HOUND
	bounty_types = CIV_JOB_SEC
	known_contacts = list("Prince", "Sheriff")

	v_duty = "You are the Prince's enforcer. You report to the Sheriff and uphold the Traditions."
	minimal_masquerade = 4
	max_generation = 10
	experience_addition = 0
	allowed_bloodlines = list("True Brujah", "Daughters of Cacophony", "Brujah", "Tremere", "Ventrue", "Nosferatu", "Gangrel", "Toreador", "Malkavian", "Banu Haqim", "Banu Haqim Sorcerer", "Banu Haqim Vizier", "Giovanni", "Followers of Set", "Lasombra", "Gargoyle", "Kiasyd", "Cappadocian")

/datum/outfit/job/hound
	name = "Hound"
	jobtype = /datum/job/vamp/hound

	ears = /obj/item/p25radio
	id = /obj/item/card/id/camarilla
	uniform = /obj/item/clothing/under/vampire/agent
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	r_pocket = /obj/item/vamp/keys/camarilla
	l_pocket = /obj/item/vamp/phone/hound
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/ammo_box/magazine/m44=1, /obj/item/ammo_box/vampire/c44=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/masquerade_contract=1, /obj/item/vamp/keys/hack=1, /obj/item/vamp/creditcard=1, /obj/item/vampire_stake=2)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/hound/pre_equip(mob/living/carbon/human/H)
	..()
	H.vampire_faction = "Camarilla"

/obj/effect/landmark/start/hound
	name = "Hound"
	icon_state = "Camarilla Agent"

//////////////////////////////////////////////////////////////////////////

/datum/job/vamp/milleniumsecurity
	title = "Millenium security"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Prince")
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Prince"
	selection_color = "#bd3327"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/milleniumsecurity

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM) // See /datum/job/officer/get_access()
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_MILSEC
	bounty_types = CIV_JOB_SEC
	known_contacts = list("Prince", "Sheriff")

	v_duty = "You are the Millenium security. Protect Millenium assets at all costs."
	minimal_masquerade = 4
	experience_addition = 0
	allowed_species = list("Ghoul")


/datum/outfit/job/milleniumsecurity
	name = "Millenium security"
	jobtype = /datum/job/vamp/milleniumsecurity

	ears = /obj/item/p25radio
	id = /obj/item/card/id/chunk
	uniform = /obj/item/clothing/under/vampire/guard
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/vest
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/camarilla
	l_pocket = /obj/item/vamp/phone/hound
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/glock19=1, /obj/item/ammo_box/magazine/glock9mm=1, /obj/item/ammo_box/vampire/c9mm=1, /obj/item/melee/classic_baton/vampire=1, /obj/item/storage/firstaid/ifak=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/milleniumsecurity/pre_equip(mob/living/carbon/human/H)
	..()
	H.vampire_faction = "Camarilla"

/obj/effect/landmark/start/milleniumsecurity
	name = "Millenium security"
	icon_state = "Camarilla Agent"
