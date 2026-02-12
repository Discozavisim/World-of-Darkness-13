
/////////////////WEAPONS|ОРУЖИЕ/////////////////////////////

/datum/crafting_recipe/stake
	name = "Stake"
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5)
	tools = list(TOOL_KNIFE)
	result = /obj/item/vampire_stake
	always_available = TRUE
	category = CAT_WEAPON

/datum/crafting_recipe/stake_metal
	name = "Armatura Stake"
	time = 50
	reqs = list(/obj/item/stack/rods = 1)
	tools = list(TOOL_KNIFE)
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

/datum/crafting_recipe/tzi_unicorn
	name = "Unicorn (Decoration)"
	time = 50
	reqs = list(/obj/item/organ/penis = 1)
	result = /obj/item/organ/penicorn
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_biter
	name = "Biting Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 2, /obj/item/bodypart/r_arm = 2, /obj/item/bodypart/l_arm = 2, /obj/item/spine = 1)
	result = /mob/living/simple_animal/hostile/biter
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_fister
	name = "Punching Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 5, /obj/item/bodypart/r_arm = 1, /obj/item/bodypart/l_arm = 1, /obj/item/spine = 1, /obj/item/guts = 1)
	result = /mob/living/simple_animal/hostile/fister
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_tanker
	name = "Fat Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/bodypart/r_arm = 1, /obj/item/bodypart/l_arm = 1, /obj/item/bodypart/r_leg = 1, /obj/item/bodypart/l_leg = 1, /obj/item/spine = 1, /obj/item/guts = 2)
	result = /mob/living/simple_animal/hostile/tanker
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzicreature
	name = "Wretched Creature"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/organ/brain = 1, /obj/item/organ/lungs = 1)
	result = /obj/item/toy/plush/tzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/axetzi
	name = "Living Axe"
	time = 50
	reqs = list(/obj/item/organ/eyes = 1, /obj/item/spine = 2, /obj/item/stack/human_flesh = 40)
	result = /obj/item/melee/vampirearms/fireaxe/axetzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/cattzi
	name = "flesh cat"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 20, /obj/item/guts = 1, /obj/item/spine = 1, /obj/item/toy/plush/tzi = 1)
	result = /mob/living/simple_animal/pet/cat/vampiretzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_blade
	name = "Bone Blade"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 25, /obj/item/guts = 1, /obj/item/spine = 1)
	result = /obj/item/organ/cyberimp/arm/tzimisce
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_venom
	name = "Nematocyst Whip"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 15, /obj/item/guts = 1, /obj/item/organ/stomach = 1, /obj/item/organ/liver = 1)
	result = /obj/item/organ/cyberimp/arm/tzimisce/venom
	always_available = FALSE
	category = CAT_TZIMISCE

//////////////////////////////// BLOODPACKS || ПАКЕТИКИ ////////////////////////////////////////

/datum/crafting_recipe/methpack
	name = "Сделать метамфетаминовый пакетик"
	time = 25
	reqs = list(/obj/item/reagent_containers/food/drinks/meth = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/methpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/morphpack
	name = "Сделать морфиновый пакетик"
	time = 25
	reqs = list(/datum/reagent/medicine/morphine = 15, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/morphpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/cokepack
	name = "Сделать кокаиновый пакетик"
	time = 25
	reqs = list(/obj/item/reagent_containers/food/drinks/meth/cocaine = 1, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/cokepack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/heroinpack
	name = "Сделать героиновый пакетик"
	time = 25
	reqs = list(/datum/reagent/drug/heroin = 15, /obj/item/drinkable_bloodpack/full = 1)
	result = /obj/item/reagent_containers/drug/cokepack/heroinpack
	always_available = TRUE
	category = CAT_DRUGS
