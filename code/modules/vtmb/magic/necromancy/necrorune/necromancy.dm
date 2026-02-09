/obj/necrorune
	name = "Necromancy Rune"
	desc = "Death is only the beginning."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "rune1"
	color = rgb(10,128,20)
	anchored = TRUE
	var/word = "THURI'LLAH 'NHT"
	var/activator_bonus = 0
	var/activated = FALSE
	var/mob/living/last_activator
	var/necrolevel = 1
	var/list/sacrifices = list()
	var/list/clan_restricted_ritual = list()
	var/cost = 2

/obj/necrorune/proc/complete()
	return

/obj/necrorune/attack_hand(mob/user)
	if(activated)
		return

	var/mob/living/L = user
	if(!HAS_TRAIT(L, TRAIT_NECROMANCY_KNOWLEDGE))
		return

	L.say(word)
	L.Immobilize(30)
	last_activator = user

	animate(src, color = rgb(72, 230, 106), time = 10)


	if(sacrifices.len > 0)
		var/list/found_items = list()
		for(var/obj/item/I in get_turf(src))
			for(var/item_type in sacrifices)
				if(istype(I, item_type))
					if(istype(I, /obj/item/reagent_containers/blood))
						var/obj/item/reagent_containers/blood/bloodpack = I
						if(bloodpack.reagents && bloodpack.reagents.total_volume > 0)
							found_items += I
							break
					else
						found_items += I
						break
		if(found_items.len == sacrifices.len)
			for(var/obj/item/I in found_items)
				if(I)
					qdel(I)
			complete()
		else
			to_chat(user, "You lack the necessary sacrifices to complete the ritual. Found [found_items.len], required [sacrifices.len].")
	else
		complete()

/obj/necrorune/AltClick(mob/user)
	..()
	qdel(src)

/datum/crafting_recipe/necrotome
	name = "Necromantic Ritualism Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/ectoplasm = 1)
	result = /obj/item/necromancy_tome
	always_available = FALSE
	category = CAT_MISC

/obj/item/necromancy_tome
	name = "necromancy tome"
	desc = "An old tome bound in peculiar leather."
	icon_state = "necrobook"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	is_magic = TRUE
	var/list/rituals = list()

/obj/item/necromancy_tome/Initialize(mapload)
	. = ..()
	for(var/i in subtypesof(/obj/necrorune))
		if(i)
			var/obj/necrorune/R = new i(src)
			rituals |= R

/obj/item/necromancy_tome/attack_self(mob/user)
	. = ..()
	for(var/obj/necrorune/R in rituals)
		var/list/required_items = list()
		for(var/item_type in R.sacrifices)
			var/obj/item/I = new item_type(src)
			required_items += I.name
			qdel(I)
		var/required_list
		if(required_items.len == 1)
			required_list = required_items[1]
		else
			for(var/item_name in required_items)
				required_list += (required_list == "" ? item_name : ", [item_name]")
		to_chat(user, "[R.necrolevel] [R.name] - [R.desc] Requirements: [length(required_list) ? required_list : "None"].")
