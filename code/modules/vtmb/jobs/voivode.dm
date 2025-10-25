/datum/job/vamp/voivode
	title = "Voivode"
	department_head = list("Eldest")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/voivode

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_VOIVODE
	exp_type_department = EXP_TYPE_TZIMISCE

	allowed_species = list("Vampire")
	allowed_bloodlines = list("Old Clan Tzimisce")
	minimal_generation = 8

	v_duty = "You are a Voivode that rules the Tzimisce Mansion and protects the sarcophagus."
	experience_addition = 0
	minimal_masquerade = 2
	known_contacts = list("Prince", "Baron", "Sheriff")



/datum/outfit/job/voivode
	name = "Voivode"
	jobtype = /datum/job/vamp/voivode
	id = /obj/item/card/id/voivode
	uniform = /obj/item/clothing/under/vampire/voivode
	suit = /obj/item/clothing/suit/vampire/caftan/white
	head = /obj/item/clothing/head/berendeyka/white
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	gloves = /obj/item/clothing/gloves/vampire/work
	belt = /obj/item/storage/belt/vampire/sheathe/sabre
	l_pocket = /obj/item/vamp/phone/voivode
	r_pocket = /obj/item/vamp/keys/old_clan_tzimisce
	backpack_contents = list(/obj/item/flashlight/lantern=1, /obj/item/cockclock=1, /obj/item/passport=1, /obj/item/vamp/creditcard/elder=1)

/obj/effect/landmark/start/voivode
	name = "Voivode"
