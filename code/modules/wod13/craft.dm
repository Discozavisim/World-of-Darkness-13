
/////////////////WEAPONS|ОРУЖИЕ/////////////////////////////

/datum/crafting_recipe/stake
	name = "Stake"
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5)
	tools = list(TOOL_OSTROE)
	result = /obj/item/vampire_stake
	always_available = TRUE
	category = CAT_WEAPON

/datum/crafting_recipe/stake_metal
	name = "Armatura Stake"
	time = 50
	reqs = list(/obj/item/stack/rods = 1)
	tools = list(TOOL_OSTROE)
	result = /obj/item/vampire_stake/metal
	always_available = TRUE
	category = CAT_WEAPON

/datum/crafting_recipe/molotov
	name = "Molotov Cocktail"
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 1, /obj/item/reagent_containers/food/drinks/beer/vampire = 1, /obj/item/gas_can = 1)
	result = /obj/item/molotov
	always_available = TRUE
	category = CAT_WEAPON

/////////////////TZIMISCE|ЦИМИСХИ/////////////////////////////

/datum/crafting_recipe/tzi_trench
	name = "Leather-Bone Trenchcoat (Armor)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 50, /obj/item/spine = 1)
	result = /obj/item/clothing/suit/vampire/trench/tzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_med
	name = "Medical Hand (Healing)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 35, /obj/item/bodypart/r_arm = 1, /obj/item/organ/heart = 1, /obj/item/organ/tongue = 1)
	result = /obj/item/organ/cyberimp/arm/medibeam
	always_available = FALSE
	category = CAT_TZIMISCE


/datum/crafting_recipe/tzi_heart
	name = "Second Heart (Antistun)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 25, /obj/item/organ/heart = 1)
	result = /obj/item/organ/cyberimp/brain/anti_stun/tzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_eyes
	name = "Better Eyes (Nightvision)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 15, /obj/item/organ/eyes = 1)
	result = /obj/item/organ/eyes/night_vision/nightmare
	always_available = FALSE
	category = CAT_TZIMISCE
/*
/datum/crafting_recipe/tzi_stealth
	name = "Stealth Skin (Invisibility)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/vampire_stake = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/dnainjector/chameleonmut
	always_available = FALSE
	category = CAT_TZIMISCE
*/
/datum/crafting_recipe/tzi_koldun
	name = "Koldun Sorcery (Firebreath)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/vampire_stake = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/dnainjector/koldun
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_implant
	name = "Implanting Flesh Device"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/melee/vampirearms/knife = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/autosurgeon/organ
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_floor
	name = "Gut Floor"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 1, /obj/item/guts = 1)
	result = /obj/effect/decal/gut_floor
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_wall
	name = "Flesh Wall"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 2)
	result = /obj/structure/fleshwall
	always_available = FALSE
	category = CAT_TZIMISCE
