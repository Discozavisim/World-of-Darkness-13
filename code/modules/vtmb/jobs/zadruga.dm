/datum/job/vamp/zadruga
	title = "Zadruga"
	department_head = list("Voivode")
	faction = "Vampire" //[Lucifernix] - Change this to vampire when I actually fix this.
	total_positions = 4
	spawn_positions = 4
	supervisors = " the Laws of Hospitality"
	selection_color = "#953d2d"

	outfit = /datum/outfit/job/zadruga

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_ZADRUGA
	exp_type_department = EXP_TYPE_TZIMISCE

	allowed_species = list("Ghoul")
	minimal_generation = 13

	duty = "Ты родился в услужении у хозяина поместья: твой отец служил воеводе, как и его отец. Теперь в тебе течет их кровь, а вместе с ней и их обязанности."
	experience_addition = 0
	minimal_masquerade = 2
	known_contacts = list("Prince", "Baron", "Sheriff")

/datum/outfit/job/zadruga
	name = "zadruga"
	jobtype = /datum/job/vamp/zadruga
	uniform = /obj/item/clothing/under/vampire/bogatyr
	suit = /obj/item/clothing/suit/vampire/caftan/blue
	head = /obj/item/clothing/head/berendeyka/blue
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone/zadruga
	r_pocket = /obj/item/vamp/keys/old_clan_tzimisce
	backpack_contents = list(/obj/item/flashlight/lantern=1, /obj/item/cockclock=1, /obj/item/passport=1, /obj/item/vamp/creditcard=1)

/obj/effect/landmark/start/zadruga
	name = "Zadruga"
