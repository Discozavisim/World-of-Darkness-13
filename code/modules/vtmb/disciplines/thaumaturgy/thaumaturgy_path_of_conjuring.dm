/datum/discipline/thaumaturgy_path_of_conjuring
	name = "Thaumaturgy: Path of Conjuring"
	desc = "This path of Thaumaturgy makes possible the creation of objects limited only by the mind of the thaumaturge. Violates Masquerade."
	icon_state = "thaumaturgy_path_of_conjuring"
	learnable_by_clans = list(/datum/vampireclane/tremere)
	power_type = /datum/discipline_power/thaumaturgy_path_of_conjuring

/datum/discipline/thaumaturgy_path_of_conjuring/post_gain()
	. = ..()
	owner.faction |= "Tremere"
	ADD_TRAIT(owner, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/arctome)

/datum/discipline_power/thaumaturgy_path_of_conjuring
	name = "Thaumaturgy: Path of Conjuring power name"
	desc = "Thaumaturgy: Path of Conjuring power description"

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	aggravating = FALSE
	hostile = FALSE
	violates_masquerade = TRUE

	cooldown_length = 3 TURNS

	var/success_roll

	var/list/simple_items = list(
		/obj/item/toy/crayon/spraycan,
		/obj/item/storage/pill_bottle/dice,
		/obj/item/melee/vampirearms/shovel,
		/obj/item/melee/vampirearms/baseball,
		/obj/item/melee/vampirearms/tire,
		/obj/item/melee/vampirearms/knife,
		/obj/item/melee/vampirearms/machete,
		/obj/item/vampire_stake,
		/obj/item/vampire_stake/metal,
		/obj/item/clothing/head/vampire/skull
	)

	var/list/normal_items = list(
		/obj/item/drinkable_bloodpack/full,
		/obj/item/drinkable_bloodpack/full/elite,
		/obj/item/melee/vampirearms/rapier,
		/obj/item/melee/vampirearms/sabre,
		/obj/item/melee/vampirearms/katana,
		/obj/item/storage/pill_bottle/potassiodide,
		/obj/item/bailer,
		/obj/item/gun/ballistic/automatic/vampire/deagle,
		/obj/item/ammo_box/magazine/m44,
		/obj/item/gun/ballistic/automatic/vampire/uzi,
		/obj/item/ammo_box/magazine/vamp9mm,
		/obj/item/ammo_box/vampire/c9mm,
		/obj/item/gun/ballistic/shotgun/vampire,
		/obj/item/ammo_box/vampire/c12g,
		/obj/item/ammo_box/vampire/c12g/buck,
		/obj/item/gun/ballistic/shotgun/toy/crossbow/vampire,
		/obj/item/ammo_box/vampire/arrows,
		/obj/item/restraints/handcuffs,
		/obj/item/masquerade_contract,
		/obj/item/gun/ballistic/automatic/vampire/thompson,
		/obj/item/ammo_box/magazine/tommygunm45,
		/obj/item/clothing/suit/vampire/vest,
		/obj/item/clothing/head/vampire/helmet,
		/obj/item/clothing/suit/vampire/vest/medieval,
		/obj/item/clothing/head/vampire/helmet/spain,
		/obj/item/grenade/flashbang,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/melee/classic_baton/vampire
	)

	var/list/hard_items = list(
		/obj/item/radio,
		/obj/item/police_radio,
		/obj/item/vamp/phone,
		/obj/item/melee/vampirearms/longsword,
		/obj/item/melee/vampirearms/chainsaw,
		/obj/item/melee/vampirearms/fireaxe,
		/obj/item/storage/pill_bottle/ephedrine,
		/obj/item/gas_can/full,
		/obj/item/gun/ballistic/automatic/vampire/ar15,
		/obj/item/ammo_box/magazine/vamp556,
		/obj/item/gun/ballistic/automatic/vampire/aug,
		/obj/item/ammo_box/magazine/vampaug,
		/obj/item/gun/ballistic/automatic/vampire/sniper,
		/obj/item/ammo_box/vampire/c556,
		/obj/item/clothing/suit/vampire/vest/army,
		/obj/item/clothing/head/vampire/army
	)

	var/list/living = list(
		"Civilian" = /mob/living/carbon/human/npc/walkby,
		"Hobo" = /mob/living/carbon/human/npc/hobo,
		"Bandit" = /mob/living/carbon/human/npc/bandit,
		"Police" = /mob/living/carbon/human/npc/police,
		"Guard" = /mob/living/carbon/human/npc/guard,
		"Stripper" = /mob/living/carbon/human/npc/stripper
	)

/datum/discipline_power/thaumaturgy_path_of_conjuring/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/atom
	var/conjured = FALSE

/atom/proc/vanish_after(duration)
	if(!duration || duration == -1)
		return
	if(QDELETED(src))
		return
	var/atom/A = src
	addtimer(CALLBACK(A, PROC_REF(vanish_atom), A), duration)

/atom/proc/vanish_atom(atom/A)
	if(!A)
		return
	if(A.conjured)
		visible_message(span_warning("[A] disappears in a puff of smoke!"))
		qdel(A)

/datum/discipline_power/thaumaturgy_path_of_conjuring/proc/summon_item(list/items, duration)
	var/list/display_list = list()
	for(var/typepath in items)
		var/obj/item/I = new typepath()
		display_list[initial(I.name)] = typepath
		qdel(I)

	var/choice = input(owner, "Select an object to summon:", "Object Summoning") as null|anything in display_list
	if(!choice)
		return

	var/typepath = display_list[choice]
	if(!typepath)
		return

	var/obj/item/I = new typepath()
	I.loc = owner.loc
	I.conjured = TRUE
	I.vanish_after(duration)

	if(owner.put_in_hands(I))
		to_chat(owner, span_notice("You conjure a [choice] into your hands."))
	else
		I.forceMove(owner.loc)
		to_chat(owner, span_notice("You conjure a [choice] at your feet."))

/datum/discipline_power/thaumaturgy_path_of_conjuring/proc/summon_living(list/livings, duration)
	var/list/display_list = list()
	for(var/name in livings)
		display_list[name] = livings[name]

	var/choice = input(owner, "Select a creature to summon:", "Creature Summoning") as null|anything in display_list
	if(!choice)
		return

	var/typepath = display_list[choice]
	if(!typepath)
		return

	var/mob/living/L = new typepath()
	L.loc = owner.loc
	L.conjured = TRUE
	L.vanish_after(duration)

	to_chat(owner, span_notice("You conjure a [choice]!"))

/datum/discipline_power/thaumaturgy_path_of_conjuring/summon_the_simple_form
	name = "Summon the Simple Form"
	desc = "Creation of objects limited only by the mind of the thaumaturge"
	level = 1
	vitae_cost = 1

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_conjuring/permanency,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/magic_of_the_smith,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/reverse_conjuration,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/power_over_life
	)

/datum/discipline_power/thaumaturgy_path_of_conjuring/summon_the_simple_form/activate()
	. = ..()
	summon_item(simple_items, 15 SECONDS)

/datum/discipline_power/thaumaturgy_path_of_conjuring/permanency
	name = "Permanency"
	desc = "Creation of objects limited only by the mind of the thaumaturge"
	level = 2
	vitae_cost = 3
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_conjuring/summon_the_simple_form,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/magic_of_the_smith,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/reverse_conjuration,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/power_over_life
	)


/datum/discipline_power/thaumaturgy_path_of_conjuring/permanency/activate()
	. = ..()
	summon_item(simple_items, -1)

/datum/discipline_power/thaumaturgy_path_of_conjuring/magic_of_the_smith
	name = "Magic of the Smith"
	desc = "Creation of objects limited only by the mind of the thaumaturge"
	level = 3
	vitae_cost = 5
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_conjuring/summon_the_simple_form,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/permanency,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/reverse_conjuration,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/power_over_life
	)

/datum/discipline_power/thaumaturgy_path_of_conjuring/magic_of_the_smith/activate()
	. = ..()
	var/list/items_to_summon = normal_items

	if(maxlevel == 5)
		items_to_summon += hard_items

	summon_item(items_to_summon, -1)

/datum/discipline_power/thaumaturgy_path_of_conjuring/reverse_conjuration
	name = "Reverse Conjuration"
	desc = "Creation of objects limited only by the mind of the thaumaturge"
	level = 4
	target_type = TARGET_MOB | TARGET_OBJ
	vitae_cost = 1
	range = 1
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_conjuring/summon_the_simple_form,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/permanency,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/magic_of_the_smith,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/power_over_life
	)

/datum/discipline_power/thaumaturgy_path_of_conjuring/reverse_conjuration/activate(atom/target)
	. = ..()

	if(target.conjured && (istype(target, /obj/item) || istype(target, /mob/living)))
		target.vanish_atom(target)
		to_chat(owner, span_notice("Conjured item has been removed!"))
	else if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		var/list/all_items = list()

		for(var/obj/item/I in H.contents)
			all_items += I
			if(istype(I, /obj/item/storage))
				all_items |= I.contents

		for(var/obj/item/I in all_items)
			if(I && I.conjured)
				I.vanish_atom(I)

		to_chat(owner, span_notice("All [target]'s conjured items have been removed."))

/datum/discipline_power/thaumaturgy_path_of_conjuring/power_over_life
	name = "Power Over Life"
	desc = "Creation of objects limited only by the mind of the thaumaturge"
	level = 5
	vitae_cost = 10
	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_conjuring/summon_the_simple_form,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/permanency,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/magic_of_the_smith,
		/datum/discipline_power/thaumaturgy_path_of_conjuring/reverse_conjuration
	)

/datum/discipline_power/thaumaturgy_path_of_conjuring/power_over_life/activate()
	. = ..()
	summon_living(living, -1)
