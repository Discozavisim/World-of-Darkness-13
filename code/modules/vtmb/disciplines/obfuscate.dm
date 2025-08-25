#define COMBAT_COOLDOWN_LENGTH 45 SECONDS
#define REVEAL_COOLDOWN_LENGTH 15 SECONDS

/datum/discipline/obfuscate
	name = "Obfuscate"
	desc = "Makes you less noticable for living and un-living beings."
	icon_state = "obfuscate"
	power_type = /datum/discipline_power/obfuscate

/datum/discipline_power/obfuscate
	name = "Obfuscate power name"
	desc = "Obfuscate power description"

	activate_sound = 'code/modules/wod13/sounds/obfuscate_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/obfuscate_deactivate.ogg'

	var/static/list/aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_MELEE_SWING,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THREW_MOVABLE,
		COMSIG_MOB_ATTACKING_MELEE,
		COMSIG_MOB_ATTACKED_BY_MELEE,
	)

/datum/discipline_power/obfuscate/proc/on_combat_signal(datum/source)
	SIGNAL_HANDLER

	to_chat(owner, span_danger("Your Obfuscate falls away as you reveal yourself!"))
	try_deactivate(direct = TRUE)

	deltimer(cooldown_timer)
	cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), COMBAT_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

/datum/discipline_power/obfuscate/proc/is_seen_check()
	for (var/mob/living/viewer in oviewers(7, owner))
		//cats cannot stop you from Obfuscating
		if (!istype(viewer, /mob/living/carbon) && !viewer.client)
			continue

		//the corpses are not watching you
		if (HAS_TRAIT(viewer, TRAIT_BLIND) || viewer.stat >= UNCONSCIOUS)
			continue

		to_chat(owner, span_warning("You cannot use [src] while you're being observed!"))
		return FALSE

	return TRUE

//CLOAK OF SHADOWS
/datum/discipline_power/obfuscate/cloak_of_shadows
	name = "Cloak of Shadows"
	desc = "Meld into the shadows and stay unnoticed so long as you draw no attention."

	level = 1
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)



/datum/discipline_power/obfuscate/cloak_of_shadows/pre_activation_checks()
	. = ..()
	return is_seen_check()

/datum/discipline_power/obfuscate/cloak_of_shadows/activate()
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null

	owner.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+level-20
	owner.alpha = 100
	owner.obfuscate_level = level

/datum/discipline_power/obfuscate/cloak_of_shadows/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.invisibility = initial(owner.invisibility)
	owner.alpha = 255

/datum/discipline_power/obfuscate/cloak_of_shadows/proc/handle_move(datum/source, atom/moving_thing, dir)
	SIGNAL_HANDLER

	to_chat(owner, span_danger("Your [src] falls away as you move from your position!"))
	try_deactivate(direct = TRUE)

	deltimer(cooldown_timer)
	cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), REVEAL_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

//UNSEEN PRESENCE
/datum/discipline_power/obfuscate/unseen_presence
	name = "Unseen Presence"
	desc = "Move among the crowds without ever being noticed. Achieve invisibility."

	level = 2
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/unseen_presence/pre_activation_checks()
	. = ..()
	return is_seen_check()

/datum/discipline_power/obfuscate/unseen_presence/activate()
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null

	owner.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+level-20
	owner.alpha = 100
	owner.obfuscate_level = level

/datum/discipline_power/obfuscate/unseen_presence/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.invisibility = initial(owner.invisibility)
	owner.alpha = 255

//remove this when Mask of a Thousand Faces is made tabletop accurate
/datum/discipline_power/obfuscate/unseen_presence/proc/handle_move(datum/source, atom/moving_thing, dir)
	SIGNAL_HANDLER

	if (owner.m_intent != MOVE_INTENT_WALK)
		to_chat(owner, span_danger("Your [src] falls away as you move too quickly!"))
		try_deactivate(direct = TRUE)

		deltimer(cooldown_timer)
		cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), REVEAL_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

//MASK OF A THOUSAND FACES
/datum/discipline_power/obfuscate/mask_of_a_thousand_faces
	name = "Mask of a Thousand Faces"
	desc = "Be noticed, but incorrectly. Hide your identity but nothing else."

	level = 3
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE

	toggled = TRUE

	var/datum/dna/original_dna
	var/original_name
	var/original_skintone
	var/original_hairstyle
	var/original_facialhair
	var/original_haircolor
	var/original_facialhaircolor
	var/original_eyecolor
	var/original_body_mod
	var/original_alt_sprite
	var/original_phonevoicetag
	var/original_alt_sprite_greyscale
	var/original_age
	var/original_gender
	var/original_headshot

	var/datum/dna/impersonating_dna
	var/impersonating_name
	var/impersonating_skintone
	var/impersonating_hairstyle
	var/impersonating_facialhair
	var/impersonating_haircolor
	var/impersonating_facialhaircolor
	var/impersonating_eyecolor
	var/impersonating_body_mod
	var/impersonating_alt_sprite
	var/impresonating_phonevoicetag
	var/impersonating_alt_sprite_greyscale
	var/impersonating_age
	var/impersonating_gender
	var/impersonating_headshot

	var/is_shapeshifted = FALSE
	var/proval = 0

/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/pre_activation_checks()
	. = ..()
	return is_seen_check()

/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/activate()
	. = ..()
	var/choice = alert(owner, "What form do you wish to take?", name, "Yours", "Original","Someone Else's")
//	if(is_shapeshifted)

	if(choice == "Yours")
		deactivate()
		return
	if(choice == "Original")
		make_original()
		shapeshift()
	if(choice == "Someone Else's")
		choose_impersonating()
		shapeshift()

/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/deactivate()
	. = ..()
	shapeshift(to_original = TRUE)

/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/proc/make_original()
	initialize_original()
	var/roll = secret_vampireroll(get_a_intelligence(owner)+get_a_fleshcraft(owner), 6, FALSE)
	var/list/vibori = list()
	switch(roll)
		if(-INFINITY to -1)
			to_chat(owner, span_warning("Твоя плоть противится изменению! Тебя корежит изнутри!"))
			owner.Stun(5 SECONDS)
			owner.do_jitter_animation(10)
		if(1)
			vibori += "Имя"
			vibori += "Причёска"
			vibori += "Лицевая растительность"
			vibori += "Видимый возраст"
		if(2 to 3)
			vibori += "Имя"
			vibori += "Причёска"
			vibori += "Лицевая растительность"
			vibori += "Особенности голоса(voicetag)"
			vibori += "Кожа"
		if(4 to INFINITY)
			vibori += "Имя"
			vibori += "Причёска"
			vibori += "Лицевая растительность"
			vibori += "Особенности голоса(voicetag)"
			vibori += "Кожа"
			vibori += "Цвет глаз"
			vibori += "Телосложение"
	for()
		var/vnesnost = input(owner, "Измени свою внешность", "Затемнение") as null|anything in vibori
		Begin
		if(!vnesnost)
			break
		switch(vnesnost)
			if("Имя")
				var/new_name = input(owner, "Выбери как ты будешь звучать:", "Затемнение")  as text|null
				if(new_name)
					new_name = reject_bad_name(new_name)
					if(new_name)
						impersonating_name = new_name
						goto Begin
			if("Причёска")
				var/hair = input(owner, "Измени свою причёску", "Затемнение") as null|anything in list("Цвет", "Стиль")
				var/new_hairstyle
				switch(hair)
					if("Цвет")
						var/new_hair = input(owner, "Выбери цвет твоих волос:", "Затемнениеe","#"+original_haircolor) as color|null
						if(new_hair)
							impersonating_haircolor = sanitize_hexcolor(new_hair)
							goto Begin
					if("Стиль")
						new_hairstyle = input(owner, "Выбери свой стиль волос:", "Затемнение")  as null|anything in GLOB.hairstyles_list
						if(new_hairstyle)
							impersonating_hairstyle = new_hairstyle
							goto Begin

			if("Лицевая растительность")
				var/new_facial_hairstyle
				var/hair = input(owner, "Измени свою причёску", "Затемнение") as null|anything in list("Цвет", "Стиль")
				switch(hair)
					if("Цвет")
						var/new_facial = input(owner, "Выбери цвет волос:", "Затемнение","#"+original_facialhaircolor) as color|null
						if(new_facial)
							impersonating_facialhaircolor = sanitize_hexcolor(new_facial)
							goto Begin
					if("Стиль")
						new_facial_hairstyle = input(owner, "Выбери стиль волос:", "Затемнение")  as null|anything in GLOB.facial_hairstyles_list
						if(new_facial_hairstyle)
							impersonating_facialhair = new_facial_hairstyle
							goto Begin
			if("Видимый возраст")
				var/new_age = input(owner, "Выбери возраст на который выглядишь:\n([18]-[100])", "Затемнение") as num|null
				if(new_age)
					impersonating_age = max(min( round(text2num(new_age)), 100), 18)
					goto Begin
			if("Особенности голоса(voicetag)")
				var/new_tag = input(owner, "Выбери тональность своего голоса", "Особенности голоса") as num|null
				impresonating_phonevoicetag = length(GLOB.human_list)+max((min(round(text2num(new_tag)), 30)), -30)
				goto Begin

			if("Кожа")
				var/new_s_tone = input(owner, "Выбери тон кожи:", "Затемнение")  as null|anything in GLOB.skin_tones
				if(new_s_tone)
					impersonating_skintone = new_s_tone
					goto Begin

			if("Цвет глаз")
				var/new_eyes = input(owner, "Выбери цвет глаз:", "Затемнение","#"+original_eyecolor) as color|null
				if(new_eyes)
					impersonating_eyecolor = sanitize_hexcolor(new_eyes)
					goto Begin
			if("Телосложени")
				var/telo = input(owner, "Измени своё телосложение", "Затемнение") as null|anything in list("Эндоморф", "Мезоморф", "Эктоморф")
				switch(telo)
					if("Эндоморф")
						impersonating_body_mod = "f"
						goto Begin
					if("Мезоморф")
						impersonating_body_mod = ""
						goto Begin
					if("Эктоморф")
						impersonating_body_mod = "s"
						goto Begin


/datum/discipline_power/obfuscate/mask_of_a_thousand_faces/proc/choose_impersonating()
	initialize_original()
	var/roll = secret_vampireroll(get_a_manipulation(owner)+get_a_performance(owner), 7, FALSE)
	var/list/mob/living/carbon/human/potential_victims = list()
	for(var/mob/living/carbon/human/adding_victim in oviewers(7, owner))
		potential_victims += adding_victim
	if(!length(potential_victims))
		to_chat(owner, span_warning("No one is close enough for you to examine..."))
		return
	var/mob/living/carbon/human/victim = input(owner, "Who do you wish to impersonate?", name) as null|mob in potential_victims
	if(!victim)
		return
	switch(roll)
		if(-INFINITY to 0)
			proval = 1
			return
		if(1)
			impersonating_hairstyle = victim.hairstyle
			impersonating_name = victim.real_name
			impersonating_facialhair = victim.facial_hairstyle
			impersonating_age = victim.age
			impersonating_dna = new
			owner.dna.copy_dna(impersonating_dna)

		if(2 to 3)
			impersonating_dna = new
			owner.dna.copy_dna(impersonating_dna)
			impersonating_hairstyle = victim.hairstyle
			impersonating_name = victim.real_name
			impersonating_facialhair = victim.facial_hairstyle
			impersonating_haircolor = victim.hair_color
			impersonating_facialhaircolor = victim.facial_hair_color
			impersonating_skintone = victim.skin_tone
			impersonating_headshot = victim.headshot_link
			if (victim.clane)
				impersonating_alt_sprite = victim.clane.alt_sprite
				impersonating_alt_sprite_greyscale = victim.clane.alt_sprite_greyscale
		if(4 to INFINITY)
			impersonating_dna = new
			victim.dna.copy_dna(impersonating_dna)
			impersonating_hairstyle = victim.hairstyle
			impersonating_name = victim.real_name
			impersonating_facialhair = victim.facial_hairstyle
			impersonating_haircolor = victim.hair_color
			impersonating_facialhaircolor = victim.facial_hair_color
			impersonating_skintone = victim.skin_tone
			impersonating_eyecolor = victim.eye_color
			impresonating_phonevoicetag = victim.phonevoicetag
			impersonating_body_mod = victim.base_body_mod
			impersonating_gender = victim.gender
			impersonating_headshot = victim.headshot_link
			if (victim.clane)
				impersonating_alt_sprite = victim.clane.alt_sprite
				impersonating_alt_sprite_greyscale = victim.clane.alt_sprite_greyscale

datum/discipline_power/obfuscate/mask_of_a_thousand_faces/proc/initialize_original()
	if(is_shapeshifted)
		return
	if(original_dna && original_body_mod) //// ??
		return

	original_dna = new
	owner.dna.copy_dna(original_dna)
	original_name = owner.real_name
	original_skintone = owner.skin_tone
	original_hairstyle = owner.hairstyle
	original_facialhair = owner.facial_hairstyle
	original_haircolor = owner.hair_color
	original_facialhaircolor = owner.facial_hair_color
	original_eyecolor = owner.eye_color
	original_body_mod = owner.base_body_mod
	original_phonevoicetag = owner.phonevoicetag
	original_alt_sprite = owner.clane?.alt_sprite
	original_alt_sprite_greyscale = owner.clane?.alt_sprite_greyscale
	original_age = owner.age
	original_headshot = owner.headshot_link
	original_gender = owner.gender

	impersonating_hairstyle = owner.hairstyle
	impersonating_name = owner.real_name
	impersonating_facialhair = owner.facial_hairstyle
	impersonating_haircolor = owner.hair_color
	impersonating_facialhaircolor = owner.facial_hair_color
	impersonating_skintone = owner.skin_tone
	impersonating_eyecolor = owner.eye_color
	impresonating_phonevoicetag = owner.phonevoicetag
	impersonating_body_mod = owner.base_body_mod
	impersonating_gender = owner.gender
	impersonating_headshot = owner.headshot_link
	impersonating_alt_sprite = owner.clane.alt_sprite
	impersonating_alt_sprite_greyscale = owner.clane.alt_sprite_greyscale

datum/discipline_power/obfuscate/mask_of_a_thousand_faces/proc/shapeshift(to_original = FALSE)
	// secret_vampireroll
//	if(!impersonating_dna)
//		return
	if(proval)
		to_chat(owner, "У тебя появляются образы в голове! Тебе становится страшно от видений!")
		owner.Stun(10 SECONDS)
		owner.do_jitter_animation(10)
		return

	playsound(get_turf(owner), 'code/modules/wod13/sounds/thousand_faces.ogg', 100, TRUE, -6)

	if(to_original)
		original_dna.transfer_identity(destination = owner, transfer_SE = TRUE, superficial = TRUE)
		if(impersonating_dna)
			QDEL_NULL(impersonating_dna)
		owner.real_name = original_name
		owner.skin_tone = original_skintone
		owner.hairstyle = original_hairstyle
		owner.facial_hairstyle = original_facialhair
		owner.hair_color = original_haircolor
		owner.facial_hair_color = original_facialhaircolor
		owner.eye_color = original_eyecolor
		owner.base_body_mod = original_body_mod
		owner.clane?.alt_sprite = original_alt_sprite
		owner.phonevoicetag = original_phonevoicetag
		owner.clane?.alt_sprite_greyscale = original_alt_sprite_greyscale
		owner.gender = original_gender
		owner.age = original_age
		owner.headshot_link = original_headshot
		is_shapeshifted = FALSE
		owner.stealthy3 = 0
	else
		impersonating_dna.transfer_identity(destination = owner, superficial = TRUE)
		owner.real_name = impersonating_name
		owner.skin_tone = impersonating_skintone
		owner.hairstyle = impersonating_hairstyle
		owner.facial_hairstyle = impersonating_facialhair
		owner.hair_color = impersonating_haircolor
		owner.facial_hair_color = impersonating_facialhaircolor
		owner.eye_color = impersonating_eyecolor
		owner.base_body_mod = impersonating_body_mod
		owner.phonevoicetag = impresonating_phonevoicetag
		owner.clane?.alt_sprite = impersonating_alt_sprite
		owner.clane?.alt_sprite_greyscale = impersonating_alt_sprite_greyscale
		is_shapeshifted = TRUE

		owner.stealthy3 = 1

	owner.update_body()

//VANISH FROM THE MIND'S EYE
/datum/discipline_power/obfuscate/vanish_from_the_minds_eye
	name = "Vanish from the Mind's Eye"
	desc = "Disappear from plain view, and possibly wipe your past presence from recollection."

	level = 4
	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/vanish_from_the_minds_eye/activate()
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	owner.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+level-20
	owner.alpha = 100
	owner.obfuscate_level = level

/datum/discipline_power/obfuscate/vanish_from_the_minds_eye/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	owner.invisibility = initial(owner.invisibility)
	owner.alpha = 255

//CLOAK THE GATHERING
/datum/discipline_power/obfuscate/cloak_the_gathering
	name = "Cloak the Gathering"
	desc = "Hide yourself and others, scheme in peace."

	level = 5
	check_flags = DISC_CHECK_CAPABLE
	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obfuscate/cloak_of_shadows,
		/datum/discipline_power/obfuscate/unseen_presence,
		/datum/discipline_power/obfuscate/vanish_from_the_minds_eye,
		/datum/discipline_power/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/obfuscate/cloak_the_gathering/activate()
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	owner.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+level-20
	owner.alpha = 100
	owner.obfuscate_level = level

/datum/discipline_power/obfuscate/cloak_the_gathering/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	owner.invisibility = initial(owner.invisibility)
	owner.alpha = 255

#undef COMBAT_COOLDOWN_LENGTH
#undef REVEAL_COOLDOWN_LENGTH
