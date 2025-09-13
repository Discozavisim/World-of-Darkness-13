/datum/werewolf_holder/transformation
	var/datum/weakref/human_form
	var/datum/weakref/crinos_form
	var/datum/weakref/lupus_form

	var/transformating = FALSE
	var/given_quirks = FALSE

/datum/werewolf_holder/transformation/New()
	var/mob/living/carbon/werewolf/crinos/crinos = new()
	crinos_form = WEAKREF(crinos)
	crinos = crinos_form.resolve()
	crinos?.transformator = src

	var/mob/living/carbon/werewolf/lupus/lupus = new()
	lupus_form = WEAKREF(lupus)
	lupus = lupus_form.resolve()
	lupus?.transformator = src

	crinos?.moveToNullspace()
	lupus?.moveToNullspace()

/datum/werewolf_holder/transformation/Destroy()
	human_form = null
	crinos_form = null
	lupus_form = null

	return ..()

/datum/werewolf_holder/transformation/proc/transfer_damage(mob/living/carbon/first, mob/living/carbon/second)
	second.masquerade = first.masquerade
	var/percentage = (100/first.maxHealth)*second.maxHealth
	second.adjustBruteLoss(round((first.getBruteLoss()/100)*percentage)-second.getBruteLoss())
	second.adjustFireLoss(round((first.getFireLoss()/100)*percentage)-second.getFireLoss())
	second.adjustToxLoss(round((first.getToxLoss()/100)*percentage)-second.getToxLoss())
	second.adjustCloneLoss(round((first.getCloneLoss()/100)*percentage)-second.getCloneLoss())

/datum/werewolf_holder/transformation/proc/trans_gender(mob/living/carbon/trans, form)
	if(trans.stat == DEAD)
		return
	if(transformating)
		to_chat(trans, span_boldwarning("You're already transforming!"))
		return
	if(!given_quirks)
		given_quirks = TRUE
		if(HAS_TRAIT(trans, TRAIT_DANCER))
			var/datum/action/dance/DA = new()
			DA.Grant(lupus_form)
			var/datum/action/dance/NE = new()
			NE.Grant(crinos_form)
	var/matrix/ntransform = matrix(trans.transform) //aka transform.Copy()
	if(trans.auspice.rage == 0 && form != trans.auspice.base_breed)
		to_chat(trans, "Not enough rage to transform into anything but [trans.auspice.base_breed].")
		return
	if(trans.in_frenzy)
		to_chat(trans, "You can't transform while in frenzy.")
		return
	trans.inspired = FALSE
	if(ishuman(trans))
		var/datum/species/garou/G = trans.dna.species
		var/mob/living/carbon/human/H = trans
		if(G.glabro)
			H.remove_overlay(PROTEAN_LAYER)
			H.attributes.strength_bonus -= 2
			H.attributes.stamina_bonus -= 2
			H.attributes.dexterity_bonus -= 2
			var/matrix/M = matrix()
			M.Scale(1)
			H.transform = M
			G.glabro = FALSE
			H.update_icons()
	var/datum/language_holder/garou_lang = trans.get_language_holder()
	if(!garou_lang)
		trans.language_holder = trans.initial_language_holder
		garou_lang = trans.language_holder
	switch(form)
		if("Lupus")
			for(var/spoken_language in garou_lang.spoken_languages)
				garou_lang.remove_language(spoken_language, FALSE, TRUE)
			garou_lang.grant_language(/datum/language/primal_tongue, TRUE, TRUE)
			garou_lang.grant_language(/datum/language/garou_tongue, TRUE, TRUE)
			if(iscrinos(trans))
				ntransform.Scale(0.75, 0.75)
			if(ishuman(trans))
				ntransform.Scale(1, 0.75)
		if("Crinos")
			for(var/spoken_language in garou_lang.spoken_languages)
				garou_lang.remove_language(spoken_language, FALSE, TRUE)
			garou_lang.grant_language(/datum/language/primal_tongue, TRUE, TRUE)
			garou_lang.grant_language(/datum/language/garou_tongue, TRUE, TRUE)
			if(islupus(trans))
				var/mob/living/carbon/werewolf/lupus/lupor = trans
				if(lupor.hispo)
					ntransform.Scale(0.95, 1.25)
				else
					ntransform.Scale(1, 1.75)
			if(ishuman(trans))
				ntransform.Scale(1.25, 1.5)
		if("Homid")
			for(var/spoken_language in garou_lang.understood_languages)
				garou_lang.grant_language(spoken_language, TRUE, TRUE)
			garou_lang.remove_language(/datum/language/primal_tongue, FALSE, TRUE)
			if(iscrinos(trans))
				ntransform.Scale(0.75, 0.75)
			if(islupus(trans))
				ntransform.Scale(1, 1.5)
	switch(form)
		if("Lupus")
			if(islupus(trans))
				transformating = FALSE
				return
			if(!lupus_form)
				return
			var/mob/living/carbon/werewolf/lupus/lupus = lupus_form.resolve()
			if(!lupus)
				lupus_form = null
				return

			transformating = TRUE

			animate(trans, transform = ntransform, color = "#000000", time = 30)
			playsound(get_turf(trans), 'code/modules/wod13/sounds/transform.ogg', 50, FALSE)

			for(var/mob/living/simple_animal/hostile/beastmaster/B in trans.beastmaster)
				if(B)
					qdel(B)

			addtimer(CALLBACK(src, PROC_REF(transform_lupus), trans, lupus), 30 DECISECONDS)
		if("Crinos")
			if(iscrinos(trans))
				transformating = FALSE
				return
			if(!crinos_form)
				return
			var/mob/living/carbon/werewolf/crinos/crinos = crinos_form.resolve()
			if(!crinos)
				crinos_form = null
				return

			transformating = TRUE

			animate(trans, transform = ntransform, color = "#000000", time = 30)
			playsound(get_turf(trans), 'code/modules/wod13/sounds/transform.ogg', 50, FALSE)
			for(var/mob/living/simple_animal/hostile/beastmaster/B in trans.beastmaster)
				if(B)
					qdel(B)

			addtimer(CALLBACK(src, PROC_REF(transform_crinos), trans, crinos), 30 DECISECONDS)
		if("Homid")
			if(ishuman(trans))
				transformating = FALSE
				return
			if(!human_form)
				return
			var/mob/living/carbon/human/homid = human_form.resolve()
			if(!homid)
				human_form = null
				return

			transformating = TRUE

			animate(trans, transform = ntransform, color = "#000000", time = 30)
			playsound(get_turf(trans), 'code/modules/wod13/sounds/transform.ogg', 50, FALSE)
			for(var/mob/living/simple_animal/hostile/beastmaster/B in trans.beastmaster)
				if(B)
					qdel(B)

			addtimer(CALLBACK(src, PROC_REF(transform_homid), trans, homid), 30 DECISECONDS)

/datum/werewolf_holder/transformation/proc/transform_lupus(mob/living/carbon/trans, mob/living/carbon/werewolf/lupus/lupus)
	PRIVATE_PROC(TRUE)

	if(trans.stat == DEAD || !trans.client) // [ChillRaccoon] - preventing non-player transform issues
		animate(trans, transform = null, color = "#FFFFFF")
		return
	var/items = trans.get_contents()
	for(var/obj/item/item_worn in items)
		if(item_worn)
			if(!ismob(item_worn.loc))
				continue
			trans.dropItemToGround(item_worn, TRUE)
	var/turf/current_loc = get_turf(trans)
	lupus.color = "#000000"
	lupus.forceMove(current_loc)
	animate(lupus, color = "#FFFFFF", time = 10)
	lupus.key = trans.key
	trans.moveToNullspace()
	lupus.bloodpool = trans.bloodpool
	lupus.masquerade = trans.masquerade
	lupus.nutrition = trans.nutrition
	if(trans.auspice.tribe.name == "Black Spiral Dancers" || HAS_TRAIT(trans, TRAIT_WYRMTAINTED))
		lupus.wyrm_tainted = 1
	lupus.mind = trans.mind
	lupus.update_blood_hud()
	transfer_damage(trans, lupus)
	lupus.add_movespeed_modifier(/datum/movespeed_modifier/lupusform)
	transformating = FALSE
	animate(trans, transform = null, color = "#FFFFFF", time = 1)
	lupus.update_icons()
	if(lupus.hispo)
		lupus.remove_movespeed_modifier(/datum/movespeed_modifier/lupusform)
		lupus.add_movespeed_modifier(/datum/movespeed_modifier/crinosform)

/datum/werewolf_holder/transformation/proc/transform_crinos(mob/living/carbon/trans, mob/living/carbon/werewolf/crinos/crinos)
	PRIVATE_PROC(TRUE)

	if(trans.stat == DEAD)
		animate(trans, transform = null, color = "#FFFFFF")
		return
	var/items = trans.get_contents()
	for(var/obj/item/item_worn in items)
		if(item_worn)
			if(!ismob(item_worn.loc))
				continue
			trans.dropItemToGround(item_worn, TRUE)
	var/turf/current_loc = get_turf(trans)
	crinos.color = "#000000"
	crinos.forceMove(current_loc)
	animate(crinos, color = "#FFFFFF", time = 10)
	crinos.key = trans.key
	trans.moveToNullspace()
	crinos.bloodpool = trans.bloodpool
	crinos.masquerade = trans.masquerade
	crinos.nutrition = trans.nutrition
	if(trans.auspice.tribe.name == "Black Spiral Dancers" || HAS_TRAIT(trans, TRAIT_WYRMTAINTED))
		crinos.wyrm_tainted = 1
	crinos.mind = trans.mind
	crinos.update_blood_hud()
	transfer_damage(trans, crinos)
	crinos.add_movespeed_modifier(/datum/movespeed_modifier/crinosform)
	transformating = FALSE
	animate(trans, transform = null, color = "#FFFFFF", time = 1)
	crinos.update_icons()
	crinos.mind.current = crinos

/datum/werewolf_holder/transformation/proc/transform_homid(mob/living/carbon/trans, mob/living/carbon/human/homid)
	PRIVATE_PROC(TRUE)

	if(trans.stat == DEAD || !trans.client) // [ChillRaccoon] - preventing non-player transform issues
		animate(trans, transform = null, color = "#FFFFFF")
		return
	var/items = trans.get_contents()
	for(var/obj/item/item_worn in items)
		if(item_worn)
			if(!ismob(item_worn.loc))
				continue
			trans.dropItemToGround(item_worn, TRUE)
	var/turf/current_loc = get_turf(trans)
	homid.color = "#000000"
	homid.forceMove(current_loc)
	animate(homid, color = "#FFFFFF", time = 10)
	homid.key = trans.key
	trans.moveToNullspace()
	homid.bloodpool = trans.bloodpool
	homid.masquerade = trans.masquerade
	homid.nutrition = trans.nutrition
	homid.mind = trans.mind
	homid.update_blood_hud()
	transfer_damage(trans, homid)
	homid.remove_movespeed_modifier(/datum/movespeed_modifier/crinosform)
	homid.remove_movespeed_modifier(/datum/movespeed_modifier/lupusform)
	transformating = FALSE
	animate(trans, transform = null, color = "#FFFFFF", time = 1)
	homid.update_body()
	homid.mind.current = homid

/mob/living/carbon/human
	var/datum/warform/warform

/mob/living/simple_animal
	var/datum/warform/warform
	var/mob/living/carbon/human/my_creator

/datum/warform
	var/mob/living/carbon/human/humanform
	var/mob/living/simple_animal/warform
	var/obj/effect/proc_holder/spell/targeted/shapeshift/Shapeshift
	var/datum/language_holder/lange

/datum/warform/proc/transform(animal_atom, mob/living/carbon/human/owner, masquerady = TRUE, time)
//	var/matrix/ntransform = matrix()
//	if(animal_atom.mob_size == )
//		ntransform.Scale(1.25, 1.5)
//	animate(owner, transform = ntransform, color = "#9d0e0eff", time = 10)
	if(time == null)
		time = 2 TURNS
	to_chat(owner, "Ты начинаешь превращаться...")
	spawn(time)
		owner.drop_all_held_items()
		humanform = owner
		lange = new ()
		lange.owner = humanform
		lange.copy_languages(humanform.mind?.language_holder)
		Shapeshift = new (owner)
		Shapeshift.invocation_type = "none"
		Shapeshift.shapeshift_type = animal_atom
		var/mob/living/simple_animal/H = Shapeshift.Shapeshift(humanform)
		warform = H
		warform.bloodpool = humanform.bloodpool
		warform.maxbloodpool = humanform.maxbloodpool
		warform.generation = humanform.generation

		var/datum/action/end_warform/R = new
		R.Grant(H)
		owner.warform = src
		warform.warform = src

//	warform.attributes = humanform.attributes
		if(animal_atom == /mob/living/simple_animal/hostile/tzimisce_beast)
			warform.attributes.strength_bonus = 3
			warform.attributes.dexterity_bonus = 3
			warform.attributes.stamina_bonus = 3

//	warform.mind?.language_holder = new ()
//	warform.mind?.language_holder.copy_languages(lange)
		if(masquerady)
			warform.my_creator = owner

/datum/warform/proc/end()
//	var/matrix/ntransform = matrix()
//	ntransform.Scale(0.75, 0.5)
	Shapeshift.Restore(Shapeshift.myshape)
	for(var/datum/action/end_warform/W in humanform.actions)
		if(W)
			W.Remove(humanform)
	humanform.mind?.language_holder = lange
	qdel(Shapeshift)
	qdel(src)

/datum/action/end_warform
	name = "Exit Warform"
	desc = "Exit your current warform."
	button_icon_state = "bloodcrawler"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS


/datum/action/end_warform/Trigger()
	. = ..()
	if(isanimal(owner))
		var/mob/living/simple_animal/Lviv = owner
		Lviv.warform.warform.attributes.strength_bonus = 0
		Lviv.warform.warform.attributes.dexterity_bonus = 0
		Lviv.warform.warform.attributes.stamina_bonus = 0
		Lviv.warform.humanform.bloodpool = Lviv.bloodpool
		Lviv.warform.warform.warform.end()
