/datum/job/vamp/thug
	title = "Bandit"
	faction = "Vampire"
	total_positions = 8
	spawn_positions = 8
	supervisors = " Yourself and your consience"
	selection_color = "#bb9e3d"

	total_positions = 6
	spawn_positions = 6

	outfit = /datum/outfit/job/thug

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_GANGSTER
	exp_type_department = EXP_TYPE_GANG

	allowed_species = list("Human", "Ghoul")
	max_generation = 11

	duty = "Воровская жизнь не легкая, но её надо придерживаться."
	experience_addition = 0
	minimal_masquerade = 0

/datum/outfit/job/thug/pre_equip(mob/living/carbon/human/H)
	..()
	r_pocket = pick(/obj/item/gun/ballistic/vampire/revolver, /obj/item/gun/ballistic/vampire/revolver/snub, /obj/item/gun/ballistic/automatic/vampire/m1911,/obj/item/gun/ballistic/automatic/vampire/glock19)

/datum/outfit/job/thug
	name = "Bandit"
	jobtype = /datum/job/vamp/thug
	uniform = /obj/item/clothing/under/vampire/bandit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/gun/ballistic/automatic/vampire/glock19
	backpack_contents = list(/obj/item/passport=1, /obj/item/vamp/creditcard=1, /obj/item/melee/vampirearms/knife=1,/obj/item/flashlight=1)

/datum/outfit/job/thug/proc/choose_side(mob/living/carbon/owner)
	var/list/loadouts = list(
		"Junky",
	//	"Robber",
		"Weeder",
		"Killer",
		"Sprortik"
	)
	var/syrgines_types = pick(/obj/item/reagent_containers/syringe/contraband/heroin,
	/obj/item/reagent_containers/syringe/contraband/morphine,
	/obj/item/reagent_containers/syringe/contraband/fentanyl,
	/obj/item/reagent_containers/syringe/contraband/bath_salts)

	var/packet_type = pick(/obj/item/reagent_containers/food/drinks/meth/cocaine,
	/obj/item/reagent_containers/food/drinks/meth/mephedrone,
	/obj/item/reagent_containers/food/drinks/meth)


	var/loadout_type = input(owner, "Choose your thug loadout:", "Loadout Selection") in loadouts
	switch(loadout_type)
		if("Junky")
			owner.put_in_r_hand(new syrgines_types(owner))
			owner.put_in_l_hand(new packet_type(owner))
//		if("Robber")
//			owner.put_in_r_hand(new (owner))
//			owner.put_in_l_hand(new (owner))
		if("Weeder")
			owner.put_in_r_hand(new /obj/item/weedpack(owner))
		if("Killer")
			owner.put_in_r_hand(new /obj/item/gun/ballistic/automatic/vampire/sniper(owner))
			owner.put_in_l_hand(new /obj/item/ammo_box/vampire/c556(owner))
		if("Sprortik")
			owner.put_in_r_hand(new /obj/item/vamp/keys/hack(owner))
			owner.put_in_l_hand(new /obj/item/clothing/mask/vampire/balaclava(owner))



/datum/outfit/job/thug/post_equip(mob/living/carbon/human/H)
	..()
	choose_side(H)



/obj/effect/landmark/start/thug
	name = "Bandit"
	icon_state = "china_power_3"

