/datum/chi_discipline/kiai
	name = "Kiai"
	desc = "Manipulate reality by voice."
	icon_state = "kiai"
	ranged = TRUE
	delay = 12 SECONDS
	cost_demon = 1
	activate_sound = 'code/modules/wod13/sounds/kiai_activate.ogg'
	discipline_type = "Demon"

/mob/living/carbon/human/proc/combat_to_caster()
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_to(src,caster,0)
		face_atom(caster)
		a_intent = INTENT_HARM
		drop_all_held_items()
		UnarmedAttack(caster)

/datum/chi_discipline/kiai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/sound_gender = 'code/modules/wod13/sounds/kiai_male.ogg'
	switch(caster.gender)
		if(MALE)
			sound_gender = 'code/modules/wod13/sounds/kiai_male.ogg'
		if(FEMALE)
			sound_gender = 'code/modules/wod13/sounds/kiai_female.ogg'
	caster.emote("scream")
	playsound(caster.loc, sound_gender, 100, FALSE)
	var/mypower = secret_vampireroll(max(get_a_strength(caster), get_a_manipulation(caster))+get_a_intimidation(caster), get_a_willpower(target), caster)
	if(mypower < 1)
		to_chat(caster, "<span class='warning'>You fail at screaming!</span>")
		if(mypower == -1)
			caster.Stun(3 SECONDS)
			caster.do_jitter_animation(10)
		return
	switch(level_casting)
		if(1)
			target.emote(pick("shiver", "pale"))
			target.Stun(2 SECONDS)
		if(2)
			target.emote("stare")
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				var/datum/cb = CALLBACK(human_target, TYPE_PROC_REF(/mob/living/carbon/human, combat_to_caster))
				for(var/i in 1 to 20)
					addtimer(cb, (i - 1) * 1.5 SECONDS)
		if(3)
			target.emote("scream")
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				var/datum/cb = CALLBACK(human_target, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster))
				for(var/i in 1 to 20)
					addtimer(cb, (i - 1) * 1.5 SECONDS)
		if(4)
			if(prob(25))
				target.resist_fire()
			new /datum/hallucination/fire(target, TRUE)
		if(5)
			if(prob(25))
				target.resist_fire()
			new /datum/hallucination/fire(target, TRUE)
			for(var/mob/living/hallucinating_mob in (oviewers(5, target) - caster))
				if(prob(20))
					hallucinating_mob.resist_fire()
				new /datum/hallucination/fire(hallucinating_mob, TRUE)
