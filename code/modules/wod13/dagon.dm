/obj/item/dagon
	name = "Dagon"
	desc = "Wand. Has different gradations of strength"
	icon_state = "wiredrod"
	var/dagon_power = 400
/obj/item/dagon/two
	dagon_power = 500
/obj/item/dagon/three
	dagon_power = 600
/obj/item/dagon/fourth
	dagon_power = 700
/obj/item/dagon/five
	dagon_power = 800
/obj/item/dagon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		victim.apply_damage(dagon_power, BURN,)

/mob/living/simple_animal/hostile/bear/wod13
	name = "bear"
	desc = "IS THAT A FUCKING BEAR-"
	icon = 'code/modules/wod13/64x64.dmi'
	emote_hear = list("roars.")
	emote_see = list("shakes its head.", "stomps.")
	butcher_results = list(/obj/item/food/meat/slab = 7)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes"
	response_disarm_simple = "gently push"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"


	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 8
	maxbloodpool = 8
	del_on_death = 1
	maxHealth = 500
	health = 500
	cached_multiplicative_slowdown = 2

	bloodpool = 1
	maxbloodpool = 1
	maxHealth = 850
	health = 850
	see_in_dark = 7


	melee_damage_lower = 35
	melee_damage_upper = 40


/mob/living/simple_animal/pet/cat/floppa
	name = "Karakal"
	desc = "Cat with big ears-"
	icon = 'code/modules/wod13/48x48.dmi'
	icon_state = "floppa"
	icon_living = "floppa"
	icon_dead = "floppa_dead"
	speak = list("Meow!", "Esp!", "Purr!", "HSSSSS")
	speak_emote = list("purrs", "meows")
	emote_hear = list("meows.", "mews.")
	emote_see = list("shakes its head.", "shivers.")
	butcher_results = list(/obj/item/food/meat/slab = 7)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes"
	response_disarm_simple = "gently push"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	see_in_dark = 7


	maxHealth = 250
	health = 250

	bloodquality = BLOOD_QUALITY_LOW
	melee_damage_lower = 15
	melee_damage_upper = 30

/mob/living/simple_animal/pet/cat/floppa/Initialize(mapload)
	. = ..()
	var/matrix/ntransform = matrix(transform)
	ntransform.Scale(0.5, 0.5)
	animate(src, transform = ntransform, time = 0,5)


/mob/living/simple_animal/pet/horse
	name = "Horse"
	desc = "This is my horse my horse is amasing!"
	icon = 'code/modules/wod13/64x64.dmi'
	icon_state = "horse"
	icon_living = "horse"
	icon_dead = "horse_dead"
	icon_buckle = "horse_buckle"
	speak = list(, "Igo-go!", "Purr!", "HSSSSS")
	emote_see = list("shakes its head.", "shivers.")
	butcher_results = list(/obj/item/food/meat/slab = 7)
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes"
	response_disarm_simple = "gently push"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	speed = -0.55
	maxHealth = 250
	health = 250
	can_buckle = TRUE
	var/vampiric = 0
	see_in_dark = 4

	bloodquality = BLOOD_QUALITY_LOW
	melee_damage_lower = 10
	melee_damage_upper = 20

/mob/living/simple_animal/pet/horse/Initialize(mapload)
	. = ..()
	if(vampiric)
		AddElement(/datum/element/ridable, /datum/component/riding/creature/horse/vamp)
	else
		AddElement(/datum/element/ridable, /datum/component/riding/creature/horse)


/mob/living/simple_animal/pet/crow
	name = "Crow"
	desc = "Crow will come to you!"
	icon = 'code/modules/wod13/animals32x32.dmi'
	icon_state = "crow_fly"
	icon_living = "crow_fly"
	icon_dead = "crow_dead"
	speak = list(, "KHAAAR!!", "Khar.", "KHAR!!")
	emote_see = list("shakes its head.", "shivers.")
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "gently pushes"
	response_disarm_simple = "gently push"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	speed = 1.5
	see_in_dark = 4

	is_flying_animal = TRUE



	bloodquality = BLOOD_QUALITY_LOW
	melee_damage_lower = 5
	melee_damage_upper = 10

///////// CROW FLY ANIMATION //////////

/datum/movespeed_modifier/fly
	multiplicative_slowdown = -1.2

/datum/action/I_belive_I_can_Fly
	name = "Fly Up"
	desc = "Fly to the upper level."
	button_icon_state = "fly"

/datum/action/I_belive_I_can_Fly/Trigger()
	var/mob/living/simple_animal/pet/crow/C = owner
	var/prejnii = C.movement_type
	if(C.icon_state == "crow")
		C.icon_state = "crow_fly"
		C.is_flying_animal = TRUE
		ADD_TRAIT(src, TRAIT_MOVE_FLYING, ELEMENT_TRAIT)
		C.movement_type = FLYING
		C.add_movespeed_modifier(/datum/movespeed_modifier/fly)
		owner.up()

	else if(C.icon_state == "crow_fly")
		C.icon_state = "crow"
		C.is_flying_animal = FALSE
		REMOVE_TRAIT(src, TRAIT_MOVE_FLYING, ELEMENT_TRAIT)
		C.movement_type = prejnii
		C.remove_movespeed_modifier(/datum/movespeed_modifier/fly)
		owner.down()


/mob/living/simple_animal/pet/cat/vampiretzi
	name = "cat?"
	icon = 'code/modules/wod13/mobs.dmi'
	bloodpool = 5
	maxbloodpool = 5
	mob_size = MOB_SIZE_SMALL
	icon_state = "cattzi"
	icon_living = "cattzi"
	icon_dead = "cattzi_dead"
	see_in_dark = 8


