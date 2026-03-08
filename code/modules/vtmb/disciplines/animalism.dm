/obj/effect/spectral_wolf
	name = "Spectral Wolf"
	desc = "Bites enemies in other dimensions."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "wolf"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
/*
/obj/effect/proc_holder/spell/targeted/shapeshift/animalism
	name = "Animalism Form"
	desc = "Take on the shape a rat."
	charge_max = 50
	cooldown_min = 50
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/pet/rat

		if(5)
			var/datum/warform/Warform = new
			Warform.transform(/mob/living/simple_animal/hostile/rat_beastform, owner, FALSE)
*/

/datum/discipline/animalism
	name = "Animalism"
	desc = "Summons spectral animals over your targets. Violates Masquerade."
	icon_state = "animalism"
	power_type = /datum/discipline_power/animalism

/datum/discipline_power/animalism
	name = "Animalism power name"
	desc = "Animalism power description"

	effect_sound = 'code/modules/wod13/sounds/wolves.ogg'

//SUMMON RAT
/datum/discipline_power/animalism/summon_rat
	name = "Skittering Critters"
	desc = "Summons rats to follow you and gnaw on your enemies."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 1
	violates_masquerade = FALSE

	cooldown_length = 8 SECONDS

/datum/discipline_power/animalism/summon_rat/activate()
	. = ..()
	var/limit = get_a_charisma(owner)+get_a_empathy(owner)
	if(length(owner.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/beast = pick(owner.beastmaster)
		beast.death()
	if(!length(owner.beastmaster))
		var/datum/action/beastmaster_stay/stay = new()
		stay.Grant(owner)
		var/datum/action/beastmaster_deaggro/deaggro = new()
		deaggro.Grant(owner)

	var/mob/living/simple_animal/hostile/beastmaster/rat/rat = new(get_turf(owner))
	rat.my_creator = owner
	owner.beastmaster |= rat
	rat.beastmaster = owner

/datum/discipline_power/animalism/beckoning
	name = "Beckoning"
	desc = "A call that mystically summons animals of the chosen species."

	check_flags = DISC_CHECK_CAPABLE

	level = 2
	violates_masquerade = TRUE

	cooldown_length = 15 SECONDS

/datum/discipline_power/animalism/beckoning/activate()
	. = ..()
	var/roll = secret_vampireroll(get_a_charisma(owner)+get_a_alertness(owner), 6, owner)
	if(roll == -1)
		return
	var/limit = get_a_charisma(owner)+get_a_empathy(owner)
	var/count = clamp(roll, 1, 5)
	var/mob_type
	var/sound_file
	if(length(owner.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/beast = pick(owner.beastmaster)
		beast.death()
	if(!length(owner.beastmaster))
		var/datum/action/beastmaster_stay/stay = new()
		stay.Grant(owner)
		var/datum/action/beastmaster_deaggro/deaggro = new()
		deaggro.Grant(owner)
	var/area/A = get_area(owner)
	if(istype(A, /area/vtm/forest))
		switch(rand(1, 100))
			if(1 to 90)
				mob_type = /mob/living/simple_animal/hostile/beastmaster/wolf
				sound_file = 'code/modules/wod13/sounds/animalism/wolf_howl.ogg'
				owner.emote("howl")
			if(91 to 100)
				mob_type = /mob/living/simple_animal/hostile/beastmaster/bear
				sound_file = 'code/modules/wod13/sounds/animalism/bear_growl.ogg'
				owner.emote("growl")
	else if(istype(A, /area/vtm/sewer))
		switch(rand(1, 100))
			if(1 to 75)
				mob_type = /mob/living/simple_animal/hostile/beastmaster/rat
				sound_file = 'code/modules/wod13/sounds/animalism/rat_squeak.ogg'
				owner.emote("squeak")
			if(76 to 100)
				mob_type = /mob/living/simple_animal/hostile/beastmaster/rat/flying
				sound_file = 'code/modules/wod13/sounds/animalism/rat_squeak.ogg'
				owner.emote("squeak")
	else
		switch(rand(1, 100))
			if(1 to 50)
				mob_type = /mob/living/simple_animal/hostile/beastmaster/rat
				sound_file = 'code/modules/wod13/sounds/animalism/rat_squeak.ogg'
				owner.emote("squeak")
			if(51 to 75)
				mob_type = /mob/living/simple_animal/hostile/beastmaster
				sound_file = 'code/modules/wod13/sounds/animalism/dog_bark.ogg'
				owner.emote("bark")
			if(76 to 100)
				mob_type = /mob/living/simple_animal/hostile/beastmaster/cat
				sound_file = 'code/modules/wod13/sounds/animalism/cat_meow.ogg'
				owner.emote("meow")
	var/obj/effect/temp_visual/animalism_summon/animal = new /obj/effect/temp_visual/animalism_summon(owner.loc, "summoning")
	QDEL_IN(animal, 35)
	for(var/i = 1, i <= count, i++)
		var/mob/living/simple_animal/hostile/beastmaster/beast = new mob_type(get_turf(owner))
		beast.my_creator = owner
		owner.beastmaster |= beast
		beast.beastmaster = owner
	playsound(owner.loc, sound_file, 75, TRUE)
//SUMMON WOLF
/*
/obj/effect/spectral_wolf
	name = "Spectral Wolf"
	desc = "Bites enemies in other dimensions."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "wolf"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
*/

/datum/discipline_power/animalism/summon_wolf
	name = "Spectral Wolf"
	desc = "Summons a phantasmal wolf to attack the target."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 3
	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS

/datum/discipline_power/animalism/summon_wolf/activate()
	. = ..()
	var/limit = get_a_charisma(owner)+get_a_empathy(owner)
	if(length(owner.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/beast = pick(owner.beastmaster)
		beast.death()
	if(!length(owner.beastmaster))
		var/datum/action/beastmaster_stay/stay = new()
		stay.Grant(owner)
		var/datum/action/beastmaster_deaggro/deaggro = new()
		deaggro.Grant(owner)

	var/mob/living/simple_animal/hostile/beastmaster/dog = new(get_turf(owner))
	dog.my_creator = owner
	owner.beastmaster |= dog
	dog.beastmaster = owner

//SUMMON BAT
/datum/discipline_power/animalism/summon_bat
	name = "Subsume the Spirit"
	desc = "Take control of a beast."

	target_type = TARGET_LIVING
	range = 7
	check_flags = DISC_CHECK_CAPABLE

	level = 4

	cooldown_length = 15 SECONDS

/datum/discipline_power/animalism/summon_bat/activate(mob/living/simple_animal/hostile/beastmaster/target)
	. = ..()
	if(!istype(target, /mob/living/simple_animal/hostile/beastmaster))
		to_chat(owner, span_warning("Над этим существом нельзя взять контроль."))
		return POWER_CANCEL_ACTIVATION
	var/roll = secret_vampireroll(get_a_manipulation(owner)+get_a_performance(owner), 8, owner)
	if(roll < 1)
		to_chat(owner, span_warning("Не удалось взять зверя под контроль!"))
		return POWER_CANCEL_ACTIVATION
	target.animalism_controller = owner
	target.ckey = owner.client.ckey
	target.client.init_verbs()
	addtimer(CALLBACK(src, PROC_REF(give_end_action), target), 1)
	log_game("[key_name(owner)] захватил контроль над зверем [target].")

/datum/discipline_power/animalism/summon_bat/proc/give_end_action(mob/living/simple_animal/hostile/beastmaster/target)
	if(target.client)
		var/datum/action/end_animal/leave = new()
		leave.Grant(target)
		to_chat(target, span_notice("Теперь ты контролируешь зверя. Используй 'Выход из формы' чтобы вернуться в тело."))

/datum/action/end_animal
	name = "Выход из формы"
	desc = "Возвращение в исходное тело."
	button_icon_state = "bloodcrawler"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/end_animal/Trigger()
	. = ..()
	if(!istype(usr, /mob/living/simple_animal/hostile/beastmaster))
		return
	var/mob/living/simple_animal/hostile/beastmaster/animal = usr
	var/mob/living/carbon/human/initial = animal.animalism_controller
	var/dam_percentage = animal.health / animal.maxHealth
	var/percent_carbon = initial.maxHealth * dam_percentage
	var/blago_damage = clamp(initial.maxHealth - percent_carbon, 0, 100)
	initial.apply_damage(blago_damage, BRUTE, forced = TRUE, wound_bonus = CANT_WOUND)
	animal.animalism_controller = null
	initial.ckey = animal.client.ckey
	initial.client.init_verbs()
	log_game("[key_name(initial)] покинул тело зверя и вернулся обратно.")
	qdel(src)

//RAT SHAPESHIFT
/obj/effect/proc_holder/spell/targeted/shapeshift/animalism
	name = "Animalism Form"
	desc = "Take on the shape a rat."
	charge_max = 5 SECONDS
	cooldown_min = 5 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/pet/rat

/datum/discipline_power/animalism/rat_shapeshift
	name = "Skitter"
	desc = "Become one of the rats that crawl beneath the city."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS
	duration_length = 20 SECONDS


/datum/discipline_power/animalism/rat_shapeshift/activate()
	. = ..()
	var/datum/warform/Warform = new
	Warform.transform(/mob/living/simple_animal/hostile/rat_beastform, owner, FALSE)

/*
/datum/discipline_power/animalism/rat_shapeshift/deactivate()
	. = ..()

	if(owner.stat != DEAD)
		shapeshift.Restore(shapeshift.myshape)
		owner.Stun(1.5 SECONDS)
*/
