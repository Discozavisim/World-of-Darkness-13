
/datum/job/vamp/bogatyr
	title = "Bogatyr"
	department_head = list("Voivode")
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/bogatyr

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BOGATYR
	exp_type_department = EXP_TYPE_TZIMISCE

	allowed_species = list("Vampire")
	allowed_bloodlines = list("Old Clan Tzimisce", "True Brujah")
	minimal_generation = 13	//Uncomment when players get exp enough

	v_duty = "Whether you are a Tal'Mahe'Ra survivor or Voivode's blood you are tasked to defend the Mansion and the sarcophagus at all costs. Only Molochim Baali are tolerated in the Mansion."
	experience_addition = 0
	minimal_masquerade = 2
	max_generation = 10
	my_contact_is_important = TRUE
	known_contacts = list("Prince", "Baron", "Sheriff")


/datum/outfit/job/bogatyr
	name = "Bogatyr"
	jobtype = /datum/job/vamp/bogatyr
	id = /obj/item/card/id/bogatyr
	uniform = /obj/item/clothing/under/vampire/bogatyr
	suit = /obj/item/clothing/suit/vampire/caftan
	head = /obj/item/clothing/head/berendeyka
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	gloves = /obj/item/clothing/gloves/vampire/work
	belt = /obj/item/storage/belt/vampire/sheathe/sabre
	l_pocket = /obj/item/vamp/phone/bogatyr
	r_pocket = /obj/item/vamp/keys/old_clan_tzimisce
	backpack_contents = list(/obj/item/flashlight/lantern=1, /obj/item/cockclock=1, /obj/item/passport=1, /obj/item/vamp/creditcard=1)

/obj/effect/landmark/start/bogatyr
	name = "Bogatyr"
