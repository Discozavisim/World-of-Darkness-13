/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/protean

/datum/discipline_power/protean
	name = "Protean power name"
	desc = "Protean power description"

	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/protean_deactivate.ogg'

//EYES OF THE BEAST
/datum/discipline_power/protean/eyes_of_the_beast
	name = "Eyes of the Beast"
	desc = "Let your eyes be a gateway to your Beast. Gain its eyes."

	level = 1

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS


/datum/discipline_power/protean/eyes_of_the_beast/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.add_client_colour(/datum/client_colour/glass_colour/red)

/datum/discipline_power/protean/eyes_of_the_beast/deactivate()
	. = ..()
	for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
		qdel(G)
	owner.remove_client_colour(/datum/client_colour/glass_colour/red)

//FERAL CLAWS
/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15

/datum/discipline_power/protean/feral_claws
	name = "Feral Claws"
	desc = "Become a predator and grow hideous talons."

	level = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS


/datum/discipline_power/protean/feral_claws/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel(owner))
	owner.add_client_colour(/datum/client_colour/glass_colour/red)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/protean2)

/datum/discipline_power/protean/feral_claws/deactivate()
	. = ..()
	for(var/obj/item/melee/vampirearms/knife/gangrel/G in owner.contents)
		qdel(G)
	owner.remove_client_colour(/datum/client_colour/glass_colour/red)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)

//EARTH MELD
/datum/discipline_power/protean/earth_meld
	name = "Earth Meld"
	desc = "Hide yourself in the earth itself."

	level = 3

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

/datum/discipline_power/protean/earth_meld/pre_activation_checks(mob/living/target)
	var/t = get_turf(owner)
	if(!istype(t, /turf/open/floor/plating/vampgrass) && !istype(t,/turf/open/floor/plating/vampdirt) && !istype(t,/turf/open/floor/plating/rough/cave) && !istype(t, /turf/open/floor/plating/vampbeach))
		to_chat(owner, "Здесь слишком плотно... Нужна открытая земля!")
		return FALSE
	return TRUE

/datum/discipline_power/protean/earth_meld/activate()
	. = ..()
	to_chat(owner, "<span class='warning'>Земля, родная земля... Здесь прохладно и безопасно... Чтобы из неё выйти тебе придеться хорошенечко начать сопротивляться!</span>")
	var/obj/structure/bury_pit/burial_pit = new (get_turf(owner))
	burial_pit.icon_state = "pit1"
	burial_pit.alpha = 50
	burial_pit.name = "Earth Meld"
	burial_pit.supernatural = TRUE
	burial_pit.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+4
	owner.forceMove(burial_pit)

/datum/discipline_power/protean/shape_of_the_beast
	name = "Shape of the Beast"
	desc = "Assume the form of an animal and retain your power."

	level = 4

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE
	violates_masquerade = TRUE
	var/shapeshift_type = null

	var/possible_shapes = list(
		/mob/living/simple_animal/hostile/bear/wod13/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/cat/vampire, \
		/mob/living/simple_animal/pet/horse/vampire, \
		/mob/living/simple_animal/pet/crow/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	)
	var/fly_shape = list(
		/mob/living/simple_animal/pet/crow/vampire, \
		/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire, \
	)
	var/non_gangrel_shapes = list(
		/mob/living/simple_animal/hostile/beastmaster/rat/flying, \
		/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	)

	var/is_gangrel = FALSE
	cancelable = TRUE
	cooldown_length = 20 SECONDS


/datum/discipline_power/protean/shape_of_the_beast/pre_activation_checks(mob/living/target)
	if(owner.clane.name == "Gangrel")
		is_gangrel = TRUE
	if(!shapeshift_type)
		var/list/animal_list = list()
		var/list/display_animals = list()
		if(!is_gangrel)
			for(var/path in non_gangrel_shapes)
				var/mob/living/simple_animal/animal = path
				animal_list[initial(animal.name)] = path
				var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
				display_animals += list(initial(animal.name) = animal_image)
		else
			for(var/path in possible_shapes)
				var/mob/living/simple_animal/animal = path
				animal_list[initial(animal.name)] = path
				var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
				display_animals += list(initial(animal.name) = animal_image)
		sortList(display_animals)
		var/new_shapeshift_type = show_radial_menu(owner, owner, display_animals, custom_check = CALLBACK(src, PROC_REF(check_menu), owner), radius = 38, require_near = TRUE)
		if(!new_shapeshift_type)
			return FALSE
	//	if(is_gangrel)
	//		shapeshift_type = list(new_shapeshift_type, )
		shapeshift_type = new_shapeshift_type
		shapeshift_type = animal_list[shapeshift_type]
	return TRUE

/datum/discipline_power/protean/shape_of_the_beast/activate()
	. = ..()
	var/datum/warform/Warform = new
	Warform.transform(shapeshift_type, owner, TRUE)


/mob/living/simple_animal/hostile/smokecrawler/mist
	name = "Mist"
	desc = "Levitating Spritz of Water."
	speed = -1
	alpha = 20
	color = "#0920eeff"
	damage_coeff = list(BRUTE = 0, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	a_intent = INTENT_HELP
//	density = FALSE
	is_flying_animal = 1
	movement_type = FLYING

/mob/living/simple_animal/hostile/smokecrawler/mist/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_MOVE_FLYING, ELEMENT_TRAIT)

/mob/living/simple_animal/hostile/smokecrawler/mist/Move(NewLoc, direct)
	. = ..()
	var/obj/structure/vampdoor/V = locate() in NewLoc
	var/obj/machinery/door/poddoor/shutters/S = locate() in NewLoc
	if(V)
		if(!V.magic_lock)
			forceMove(get_turf(V))
	if(S)
		forceMove(get_turf(S))

//MIST FORM
/datum/discipline_power/protean/mist_form
	name = "Mist Form"
	desc = "Dissipate your body and move as mist."

	level = 5
	vitae_cost = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	cooldown_length = 20 SECONDS

/datum/discipline_power/protean/mist_form/activate()
	. = ..()
	var/datum/warform/Warform = new
	Warform.transform(/mob/living/simple_animal/hostile/smokecrawler/mist, owner, TRUE)

///// FORMS for Shape of The Beast

/mob/living/simple_animal/hostile/beastmaster/shapeshift //Only used for Shapeshifting
	speed = -0.50
	maxHealth = 200
	health = 200
	harm_intent_damage = 20
	melee_damage_lower = 24
	melee_damage_upper = 42
	melee_damage_type = CLONE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)



/mob/living/simple_animal/hostile/beastmaster/shapeshift/wolf
	name = "Black Wolf"
	desc = "Howling and Snarling."
	icon = 'code/modules/wod13/werewolf_lupus.dmi'
	icon_state = "black"
	icon_living = "black"
	icon_dead = "black_rest"

/mob/living/simple_animal/hostile/bear/wod13/vampire
	bloodquality = BLOOD_QUALITY_HIGH
	melee_damage_type = CLONE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire
	melee_damage_type = CLONE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)
	movement_type = FLYING

/mob/living/simple_animal/hostile/beastmaster/rat/flying/vampire/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_MOVE_FLYING, ELEMENT_TRAIT)

/mob/living/simple_animal/pet/cat/floppa/vampire
	bloodquality = BLOOD_QUALITY_HIGH
	melee_damage_type = CLONE
	AIStatus = AI_OFF
	maxHealth = 300
	health = 300
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/hostile/beastmaster/shapeshift/cat/vampire
	name = "Big cat"
	bloodquality = BLOOD_QUALITY_HIGH
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "cat2"
	melee_damage_type = CLONE
	AIStatus = AI_OFF
	maxHealth = 300
	health = 300
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)


/mob/living/simple_animal/hostile/beastmaster/shapeshift/cat/vampire/Initialize()
	. = ..()
	var/matrix/ntransform = matrix()
	ntransform.Scale(1.25, 1.5)
	animate(src, transform = ntransform, time = 0,5)

/mob/living/simple_animal/hostile/beastmaster/rat/vampire
	bloodquality = BLOOD_QUALITY_HIGH
	melee_damage_type = CLONE
	AIStatus = AI_OFF
	maxHealth = 300
	health = 300
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/hostile/beastmaster/rat/vampire/Initialize()
	. = ..()
	var/matrix/ntransform = matrix()
	ntransform.Scale(1.25, 1.5)
	animate(src, transform = ntransform, time = 0,5)

/mob/living/simple_animal/pet/horse/vampire
	bloodquality = BLOOD_QUALITY_HIGH
	vampiric = 1
	AIStatus = AI_OFF
	melee_damage_type = CLONE
	maxHealth = 300
	health = 300
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/pet/crow/vampire
	bloodquality = BLOOD_QUALITY_HIGH
	is_flying_animal = FALSE
	melee_damage_type = CLONE
	AIStatus = AI_OFF
	maxHealth = 300
	health = 300
	icon_state = "crow"
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 0)

/mob/living/simple_animal/pet/crow/vampire/Initialize()
	. = ..()
	var/datum/action/I_belive_I_can_Fly/FU = new()
	FU.Grant(src)
