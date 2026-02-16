/obj/item/melee/touch_attack/vicissitude_touch
	name = "\improper flesh touch"
	desc = "Play twister with your friends."
	catchphrase = null
	on_use_sound = 'code/modules/wod13/sounds/vicissitude.ogg'
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "vicissitude"
	inhand_icon_state = "zapper"

/obj/item/melee/touch_attack/vicissitude_touch/Click()
	src.Destroy()

/obj/item/melee/touch_attack/vicissitude_touch/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.stat >= HARD_CRIT)
			if(istype(target, /mob/living/carbon/human/npc))
				var/mob/living/carbon/human/npc/NPC = target
				NPC.last_attacker = null
			if(!iskindred(target) && !isgarou(target) && !iscathayan(target))	//Who tf wrote this with || lmao
				if(H.stat != DEAD)
					H.death()
				var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
				var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
				var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
				var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
				var/obj/item/bodypart/CH = H.get_bodypart(BODY_ZONE_CHEST)
				var/obj/item/bodypart/HE = H.get_bodypart(BODY_ZONE_HEAD)
				if(B1)
					B1.drop_limb()
				if(B2)
					B2.drop_limb()
				if(B3)
					B3.drop_limb()
				if(B4)
					B4.drop_limb()
				if(CH)
					CH.dismember()
				if(HE)
					HE.dismember()
				new /obj/item/stack/human_flesh/fifty(target.loc)
				new /obj/item/guts(target.loc)
				new /obj/item/spine(target.loc)
				qdel(target)
		else
			H.emote("scream")
			H.apply_damage(30, BRUTE, BODY_ZONE_CHEST)
			H.apply_damage(10, CLONE)
			if(prob(5))
				var/obj/item/bodypart/B = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
				if(B)
					B.drop_limb()
	else if(isliving(target))
		var/mob/living/Twister = target
		Twister.Stun(20)
		Twister.apply_damage(30, BRUTE)
		Twister.apply_damage(10, CLONE)
		Twister.visible_message("<span class='danger'>[target]'s skin writhes like worms, twisting and contorting!</span>", "<span class='userdanger'>Your flesh twists unnaturally!</span>")

/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as Tzimisce art of flesh and bone shaping. Violates Masquerade."
	icon_state = "vicissitude"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/vicissitude

/datum/discipline/vicissitude/post_gain()
	. = ..()
	owner.faction |= "Tzimisce"

/datum/discipline_power/vicissitude
	name = "Vicissitude power name"
	desc = "Vicissitude power description"

	activate_sound = 'code/modules/wod13/sounds/vicissitude.ogg'

//MALLEABLE VISAGE
/datum/discipline_power/vicissitude/malleable_visage
	name = "Malleable Visage"
	desc = "Change your features to mimic those of a victim."

	level = 1
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND | DISC_CHECK_SEE | DISC_CHECK_LYING

	violates_masquerade = TRUE

	cooldown_length = 10 SECONDS

	//why is this necessary why isn't transfer_identity working please fix this
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

	var/original_isdwarf
	var/original_istower

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

	var/impersonating_clane
	var/impersonating_faction
	var/impersonating_job
	var/impersonating_info

	var/impersonating_isdwarf
	var/impersonating_istower

	var/is_shapeshifted = FALSE

/datum/discipline_power/vicissitude/malleable_visage/activate()
	. = ..()
	var/choice = alert(owner, "What form do you wish to take?", name, "Yours", "New Appearance","Someone Else's")
//	if(is_shapeshifted)

	if(choice == "Yours")
		shapeshift(to_original = TRUE)
		return
	if(choice == "New Appearance")
		make_original()
		return
	if(choice == "Someone Else's")
		choose_impersonating()
		return

/*
/datum/discipline_power/vicissitude/malleable_visage/deactivate()
	. = ..()
	shapeshift(to_original = TRUE)
*/

/datum/discipline_power/vicissitude/malleable_visage/proc/make_original()
	initialize_original()
	var/roll = secret_vampireroll(get_a_intelligence(owner)+get_a_fleshcraft(owner), 6, owner)
	var/list/vibori = list()
	switch(roll)
		if(-INFINITY to -1)
			to_chat(owner, span_warning("Твоя плоть противится изменению! Тебя корежит изнутри!"))
			owner.Stun(5 SECONDS)
			owner.do_jitter_animation(10)
			return
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
			vibori += "Пол"
	for()

		var/vnesnost = input(owner, "Измени свою внешность", "Изменчивость") as null|anything in vibori
		if(!vnesnost)
			break
		switch(vnesnost)
			if("Имя")
				var/new_name = input(owner, "Измени свои основные черты лица:", "Изменчивость")  as text|null
				if(new_name)
					new_name = reject_bad_name(new_name)
					if(new_name)
						impersonating_name = new_name
				continue
			if("Причёска")
				var/hair = input(owner, "Измени свою причёску", "Изменчивость") as null|anything in list("Цвет", "Стиль")
				var/new_hairstyle
				switch(hair)
					if("Цвет")
						var/new_hair = input(owner, "Измени цвет своих волос:", "Изменчивость","#"+original_haircolor) as color|null
						if(new_hair)
							impersonating_haircolor = sanitize_hexcolor(new_hair)
						continue
					if("Стиль")
						new_hairstyle = input(owner, "Измени стиль:", "Изменчивость")  as null|anything in GLOB.hairstyles_list
						if(new_hairstyle)
							impersonating_hairstyle = new_hairstyle
						continue

			if("Лицевая растительность")
				var/new_facial_hairstyle
				var/hair = input(owner, "Измени свою причёску", "Изменчивость") as null|anything in list("Цвет", "Стиль")
				switch(hair)
					if("Цвет")
						var/new_facial = input(owner, "Измени цвет волос:", "Изменчивость","#"+original_facialhaircolor) as color|null
						if(new_facial)
							impersonating_facialhaircolor = sanitize_hexcolor(new_facial)
						continue
					if("Стиль")
						new_facial_hairstyle = input(owner, "Измени стиль:", "Изменчивость")  as null|anything in GLOB.facial_hairstyles_list
						if(new_facial_hairstyle)
							impersonating_facialhair = new_facial_hairstyle
						continue
			if("Видимый возраст")
				var/new_age = input(owner, "Измени свой видимый возраст:\n([18]-[100])", "Изменчивость") as num|null
				if(new_age)
					impersonating_age = max(min( round(text2num(new_age)), 100), 18)
				continue
			if("Особенности голоса(voicetag)")
				var/new_tag = input(owner, "Выбери тональность своего голоса", "Особенности голоса") as num|null
				if(new_tag)
					impresonating_phonevoicetag = length(GLOB.human_list)+max((min(round(text2num(new_tag)), 30)), -30)
				continue

			if("Кожа")
				var/new_s_tone = input(owner, "Выбери цвет твоей кожи:", "Изменчивость")  as null|anything in GLOB.skin_tones
				if(new_s_tone)
					impersonating_skintone = new_s_tone
				continue

			if("Цвет глаз")
				var/new_eyes = input(owner, "Измени цвет своих глаз:", "Изменчивость","#"+original_eyecolor) as color|null
				if(new_eyes)
					impersonating_eyecolor = sanitize_hexcolor(new_eyes)
				continue
			if("Телосложени")
				var/telo = input(owner, "Измени своё телосложение", "Изменчивость") as null|anything in list("Эндоморф", "Мезоморф", "Эктоморф")

				switch(telo)
					if("Эндоморф")
						impersonating_body_mod = "f"
						continue
					if("Мезоморф")
						impersonating_body_mod = ""
						continue
					if("Эктоморф")
						impersonating_body_mod = "s"
						continue
			if("Пол")
				var/gender_bender = input(owner, "Измени свой пол", "Изменчивость") as null|anything in list("Мужской", "Женский")
				switch(gender_bender)
					if("Мужской")
						impersonating_gender = MALE
						continue
					if("Женский")
						impersonating_gender = FEMALE
						continue
				if(!gender_bender)
					continue

	shapeshift()

/datum/discipline_power/vicissitude/malleable_visage/proc/choose_impersonating()
	initialize_original()
	var/roll = secret_vampireroll(get_a_perception(owner)+get_a_fleshcraft(owner), 8, owner)
	var/list/mob/living/carbon/human/potential_victims = list()
	for(var/mob/living/carbon/human/adding_victim in oviewers(7, owner))
		potential_victims += adding_victim
	if(!length(potential_victims))
		to_chat(owner, span_warning("No one is close enough for you to examine..."))
		return
	var/mob/living/carbon/human/victim = input(owner, "Who do you wish to impersonate?", name) as null|mob in potential_victims
	if(!victim)
		return
	for(var/i=0, i<roll, i++)
		if(roll <=  0)
			owner.Stun(5 SECONDS)
			owner.do_jitter_animation(10)
			to_chat(owner, span_warning("Твоя плоть противится изменению! Тебя корежит изнутри!"))
			break
		switch(i)
			if(1)
				impersonating_hairstyle = victim.hairstyle
				impersonating_name = victim.real_name
				impersonating_facialhair = victim.facial_hairstyle
				impersonating_age = victim.age
				impersonating_dna = new
				owner.dna.copy_dna(impersonating_dna)
				impersonating_headshot = victim.headshot_link

				impersonating_clane = victim.clane
				impersonating_faction = victim.vampire_faction
				impersonating_job = victim.job
				impersonating_info = victim.info_known

				impersonating_isdwarf = victim.isdwarfy
				impersonating_istower = victim.istower
			if(2 to 3)
				impersonating_haircolor = victim.hair_color
				impersonating_facialhaircolor = victim.facial_hair_color
				impersonating_skintone = victim.skin_tone
				if (victim.clane)
					impersonating_alt_sprite = victim.clane.alt_sprite
					impersonating_alt_sprite_greyscale = victim.clane.alt_sprite_greyscale
			if(4 to INFINITY)
				impersonating_eyecolor = victim.eye_color
				impresonating_phonevoicetag = victim.phonevoicetag
				impersonating_body_mod = victim.base_body_mod
				impersonating_gender = victim.gender

	shapeshift()

/datum/discipline_power/vicissitude/malleable_visage/proc/initialize_original()
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

	original_isdwarf = owner.isdwarfy
	original_istower = owner.istower

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

	impersonating_clane = null
	impersonating_faction = null
	impersonating_job = null
	impersonating_info = null

	impersonating_isdwarf = owner.isdwarfy
	impersonating_istower = owner.istower

/datum/discipline_power/vicissitude/malleable_visage/proc/shapeshift(to_original = FALSE, instant = FALSE)
	var/fleshcrafting = get_a_fleshcraft(owner)
	// secret_vampireroll
//	if(!impersonating_dna)
//		return
	if(!instant)
		var/time_delay = 10 SECONDS
		if(original_body_mod != impersonating_body_mod)
			time_delay += 5 SECONDS
		if(original_alt_sprite != impersonating_alt_sprite)
			time_delay += 10 SECONDS
		if(fleshcrafting)
			time_delay -= 3*fleshcrafting SECONDS
		if(time_delay > 0)
			to_chat(owner, span_notice("You begin molding your appearance... This will take [DisplayTimeText(time_delay)]."))

			if (!do_after(owner, time_delay))
				return

	owner.Stun(1 SECONDS)
	owner.do_jitter_animation(10)
	playsound(get_turf(owner), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)

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
		owner.switch_masquerade(owner)

		if(owner.isdwarfy)
			owner.RemoveElement(/datum/element/dwarfism)
		if(owner.istower)
			owner.RemoveElement(/datum/element/giantism)
		owner.isdwarfy = original_isdwarf
		owner.istower = original_istower
		if(owner.isdwarfy)
			owner.AddElement(/datum/element/dwarfism)
		if(owner.istower)
			owner.AddElement(/datum/element/giantism)
	else
		//Nosferatu, Cappadocians, Gargoyles, Kiasyd, etc. will revert instead of being indefinitely without their curse
		if(original_alt_sprite)
			addtimer(CALLBACK(src, PROC_REF(revert_to_cursed_form)), 5 MINUTES)
		if(impersonating_dna)
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
		owner.gender = impersonating_gender
		owner.age = impersonating_age
		owner.headshot_link = impersonating_headshot
		is_shapeshifted = TRUE
		owner.switch_masquerade(owner)

		if(owner.isdwarfy)
			owner.RemoveElement(/datum/element/dwarfism)
		if(owner.istower)
			owner.RemoveElement(/datum/element/giantism)
		owner.isdwarfy = impersonating_isdwarf
		owner.istower = impersonating_istower
		if(owner.isdwarfy)
			owner.AddElement(/datum/element/dwarfism)
		if(owner.istower)
			owner.AddElement(/datum/element/giantism)

	owner.update_body()

/datum/discipline_power/vicissitude/malleable_visage/proc/revert_to_cursed_form()
	if(!original_alt_sprite)
		return
	if(!is_shapeshifted)
		return
	if(!owner.clane)
		return

	owner.base_body_mod = original_body_mod
	owner.clane.alt_sprite = original_alt_sprite
	owner.clane.alt_sprite_greyscale = original_alt_sprite_greyscale

	to_chat(owner, span_warning("Your cursed appearance reasserts itself!"))

//FLESHCRAFTING
/datum/discipline_power/vicissitude/fleshcrafting
	name = "Fleshcrafting"
	desc = "Mold your victim's flesh and soft tissue to your desire."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
//	target_type = TARGET_MOB
	range = 1

	effect_sound = 'code/modules/wod13/sounds/vicissitude.ogg'
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS
//	grouped_powers = list(/datum/discipline_power/vicissitude/bonecrafting)

/datum/discipline_power/vicissitude/fleshcrafting/activate(mob/living/target)
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_active_hand(new /obj/item/melee/touch_attack/vicissitude_touch(owner))

/datum/discipline_power/vicissitude/fleshcrafting/post_gain()
	. = ..()
	var/obj/item/organ/cyberimp/arm/surgery/vicissitude/surgery_implant = new()
	surgery_implant.Insert(owner)

	if(!owner.mind)
		return
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_wall)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_stool)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_floor)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_unicorn)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_eyes)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_implant)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_venom)

//BONECRAFTING
/datum/discipline_power/vicissitude/bonecrafting
	name = "Bonecrafting"
	desc = "Mold your victim's flesh and soft tissue to your desire."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	target_type = TARGET_MOB
	range = 1

	effect_sound = 'code/modules/wod13/sounds/vicissitude.ogg'
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS
//	grouped_powers = list(/datum/discipline_power/vicissitude/fleshcrafting)

/datum/discipline_power/vicissitude/bonecrafting/activate(mob/living/target)
	. = ..()
	if(target.stat >= HARD_CRIT)
		if(target.stat != DEAD)
			target.death()
		var/obj/item/bodypart/r_arm/r_arm = target.get_bodypart(BODY_ZONE_R_ARM)
		var/obj/item/bodypart/l_arm/l_arm = target.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/r_leg/r_leg = target.get_bodypart(BODY_ZONE_R_LEG)
		var/obj/item/bodypart/l_leg/l_leg = target.get_bodypart(BODY_ZONE_L_LEG)
		if(r_arm)
			r_arm.drop_limb()
		if(l_arm)
			l_arm.drop_limb()
		if(r_leg)
			r_leg.drop_limb()
		if(l_leg)
			l_leg.drop_limb()
		new /obj/item/stack/human_flesh/ten(target.loc)
		new /obj/item/guts(target.loc)
		new /obj/item/spine(target.loc)
		qdel(target)
	else
		target.emote("scream")
		target.apply_damage(60, BRUTE, BODY_ZONE_CHEST)

/datum/discipline_power/vicissitude/bonecrafting/post_gain()
	. = ..()
	var/datum/action/basic_vicissitude/vicissitude_upgrade = new()
	vicissitude_upgrade.Grant(owner)

	if(!owner.mind)
		return
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_trench)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_biter)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_fister)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_tanker)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/cattzi)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/axetzi)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_blade)


/datum/action/basic_vicissitude
	name = "Vicissitude Upgrade"
	desc = "Upgrade your body..."
	button_icon_state = "basic"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/list/selected_upgrade = list()
	var/mutable_appearance/upgrade_overlay
	var/mutable_appearance/hands2_overlay
	var/original_skin_tone
	var/original_hairstyle
	var/original_body_mod
	var/list/basic = list("Skin armor", "Centipede legs", "Second pair of arms", "Leather wings")

/datum/action/basic_vicissitude/Trigger()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.generation <= 7)
		var/stareishii = input(owner, "Что ты хочешь сделать?", "Изменчивость") as null|anything in list("Убрать", "Нарастатить")
		switch(stareishii)
			if("Нарастатить")
				give_upgrade()
			if("Убрать")
				remove_upgrade()
	else
		if(length(selected_upgrade) > 0 )
			remove_upgrade()
		else
			give_upgrade()

	owner.update_body()

/datum/action/basic_vicissitude/proc/give_upgrade()
	var/mob/living/carbon/human/user = owner
	var/upgrade = input(owner, "Choose basic upgrade:", "Vicissitude Upgrades") as null|anything in basic
	if(!upgrade)
		return
	to_chat(user, span_notice("You begin molding your flesh and bone into a stronger form..."))
	if(!do_after(user, 10 SECONDS))
		return
//	if(selected_upgrade && owner.generation > 7)
	if(length(selected_upgrade) >= 4)
		return
	selected_upgrade += upgrade
	ADD_TRAIT(user, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
	switch(upgrade)
		if("Skin armor")
			user.unique_body_sprite = "tziarmor"
			original_skin_tone = user.skin_tone
			user.skin_tone = "albino"
			original_hairstyle = user.hairstyle
			user.hairstyle = "Bald"
			original_body_mod = user.base_body_mod
			user.base_body_mod = ""
			user.physiology.armor.melee += 20
			user.physiology.armor.bullet += 20
			user.attributes.tzimisce_bonus = 2
		if("Centipede legs")
			user.remove_overlay(PROTEAN_LAYER)
			upgrade_overlay = mutable_appearance('code/modules/wod13/64x64.dmi', "centipede", -PROTEAN_LAYER)
			upgrade_overlay.pixel_z = -16
			upgrade_overlay.pixel_w = -16
			user.overlays_standing[PROTEAN_LAYER] = upgrade_overlay
			user.apply_overlay(PROTEAN_LAYER)
			user.add_movespeed_modifier(/datum/movespeed_modifier/centipede)
			basic -= "Centipede legs"
		if("Second pair of arms")
			var/limbs = user.held_items.len
			user.change_number_of_hands(limbs + 2)
			user.remove_overlay(PROTEAN_LAYER)
			hands2_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "2hands", -PROTEAN_LAYER)
			hands2_overlay.color = "#[skintone2hex(user.skin_tone)]"
			user.overlays_standing[PROTEAN_LAYER] = hands2_overlay
			user.apply_overlay(PROTEAN_LAYER)
		if("Leather wings")
			user.dna.species.GiveSpeciesFlight(user)

	user.do_jitter_animation(10)
	playsound(get_turf(user), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)

/datum/action/basic_vicissitude/proc/remove_upgrade()
	var/razmer = length(selected_upgrade)
	var/mob/living/carbon/human/user = owner
	for(razmer, razmer>0, razmer--)
	//	var/upgrade = selected_upgrade[razmer]
		var/upgrade = input(owner, "What exactly you want to remove?", "Vicissitude Remove") as null|anything in selected_upgrade
		if(!upgrade)
			return

		to_chat(user, span_notice("You begin surgically removing your enhancements..."))
		if(!do_after(user, 10 SECONDS))
			return
		REMOVE_TRAIT(user, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
		switch(upgrade)
			if("Skin armor")
				user.unique_body_sprite = null
				user.skin_tone = original_skin_tone
				user.hairstyle = original_hairstyle
				user.base_body_mod = original_body_mod
				user.physiology.armor.melee -= 20
				user.physiology.armor.bullet -= 20
				selected_upgrade -= upgrade
			if("Centipede legs")
				user.remove_overlay(PROTEAN_LAYER)
				QDEL_NULL(upgrade_overlay)
				user.remove_movespeed_modifier(/datum/movespeed_modifier/centipede)
				selected_upgrade -= upgrade
				basic += "Centipede legs"
			if("Second pair of arms")
				var/limbs = user.held_items.len
				user.change_number_of_hands(limbs - 2)
				user.remove_overlay(PROTEAN_LAYER)
				QDEL_NULL(hands2_overlay)
				selected_upgrade -= upgrade
			if("Leather wings")
				user.dna.species.RemoveSpeciesFlight(user)
				selected_upgrade -= upgrade

	user.do_jitter_animation(10)
	playsound(get_turf(user), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)

	selected_upgrade = list()

//HORRID FORM
/datum/discipline_power/vicissitude/horrid_form
	name = "Horrid Form"
	desc = "Shift your flesh and bone into that of a hideous monster."

	level = 4
	vitae_cost = 2
	violates_masquerade = TRUE
	var/possible_shape = list(/mob/living/simple_animal/hostile/tzimisce_beast, \
	/mob/living/simple_animal/hostile/tzimisce_beast/mouth)
	var/shapeshift_type = null

/datum/discipline_power/vicissitude/horrid_form/pre_activation_checks(mob/living/target)
	if(!shapeshift_type)
		var/list/animal_list = list()
		var/list/display_shapes = list()
		for(var/path in possible_shape)
			var/mob/living/simple_animal/animal = path
			animal_list[initial(animal.name)] = path
			var/image/animal_image = image(icon = initial(animal.icon), icon_state = initial(animal.icon_state))
			display_shapes += list(initial(animal.name) = animal_image)
		sortList(display_shapes)
		var/new_shapeshift_type = show_radial_menu(owner, owner, display_shapes, custom_check = CALLBACK(src, PROC_REF(check_menu), owner), radius = 38, require_near = TRUE)
		if(!new_shapeshift_type)
			return FALSE
		shapeshift_type = new_shapeshift_type
		shapeshift_type = animal_list[shapeshift_type]
	return TRUE


/datum/discipline_power/vicissitude/horrid_form/activate()
	. = ..()
	var/datum/warform/Warform = new
	Warform.transform(shapeshift_type, owner, TRUE)

/datum/discipline_power/vicissitude/horrid_form/post_gain()
	. = ..()
	if(!owner.mind)
		return
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_heart)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_med)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzicreature)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_venom)


//BLOODFORM
/datum/discipline_power/vicissitude/bloodform
	name = "Bloodform"
	desc = "Liquefy into a shifting mass of sentient Vitae."

	level = 5

	violates_masquerade = TRUE

	var/datum/warform/Warform

/datum/discipline_power/vicissitude/bloodform/activate()
	. = ..()
	Warform = new
	Warform.transform(/mob/living/simple_animal/hostile/bloodcrawler, owner, TRUE, 0)

/obj/item/organ/cyberimp/arm/surgery/vicissitude
	icon_state = "toolkit_implant_vic"
	contents = newlist(/obj/item/retractor/augment/vicissitude, /obj/item/hemostat/augment/vicissitude, /obj/item/cautery/augment/vicissitude, /obj/item/surgicaldrill/augment/vicissitude, /obj/item/scalpel/augment/vicissitude, /obj/item/circular_saw/augment/vicissitude, /obj/item/surgical_drapes/vicissitude)
	implant_sound = 'code/modules/wod13/sounds/Tzim_Organ.ogg'


/obj/item/retractor/augment/vicissitude
	name = "retracting appendage"
	desc = "A pair of prehensile pincers."
	icon_state = "retractor_vic"
	inhand_icon_state = "clamps_vic"
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/hemostat/augment/vicissitude
	name = "hemostatic pincers"
	desc = "A pair of thin appendages that were once fingers, secreting a hemostatic fluid from the tips."
	icon_state = "hemostat_vic"
	inhand_icon_state = "clamps_vic"
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/cautery/augment/vicissitude
	name = "chemical cautery"
	desc = "A specialized organ drooling a chemical package that releases an extreme amount of heat, very quickly."
	icon_state = "cautery_vic"
	inhand_icon_state = "cautery_vic"
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/surgicaldrill/augment/vicissitude
	name = "surgical fang"
	desc = "A spiral fang that bores into the flesh with reckless glee."
	icon_state = "drill_vic"
	hitsound = 'sound/effects/wounds/blood2.ogg'
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/scalpel/augment/vicissitude
	name = "scalpel claw"
	desc = "An altered nail, adjusted to make fine incisions."
	icon_state = "scalpel_vic"
	inhand_icon_state = "scalpel_vic"
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/circular_saw/augment/vicissitude
	name = "circular jaw"
	desc = "A spinning disc of teeth, screaming, as it bites through the flesh."
	icon_state = "saw_vic"
	inhand_icon_state = "saw_vic"
	hitsound = 'sound/effects/wounds/blood2.ogg'
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/surgical_drapes/vicissitude
	name = "skin drape"
	desc = "A stretch of skin, sweating out antibiotics and disinfectants, to provide a sterile-ish environment to work in."
	icon_state = "surgical_drapes_vic"
	inhand_icon_state = "drapes_vic"
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	masquerade_violating = TRUE

/obj/item/organ/cyberimp/arm/tzimisce
	name = "armblade implant"
	desc = "A concealed serrated bone blade."
	icon = 'code/modules/wod13/weapons.dmi'
	icon_state = "armblade"
	zone = BODY_ZONE_L_ARM
	contents = newlist(/obj/item/melee/vampirearms/tzimisce)
	implant_sound = 'code/modules/wod13/sounds/Tzim_Organ.ogg'

/obj/item/organ/cyberimp/arm/tzimisce/venom
	name = "nematocyst whip implant"
	desc = "A concealed venomous whip."
	icon = 'code/modules/wod13/48x32weapons.dmi'
	icon_state = "zhalo"
	contents = newlist(/obj/item/melee/vampirearms/tzimisce/venom)

/obj/item/melee/vampirearms/tzimisce
	name = "armblade"
	desc = "A monstrous weapon, made out of sharpened bone."
	icon = 'code/modules/wod13/weapons.dmi'
	icon_state = "armblade"
	force = 35
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 40
	armour_penetration = 40
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	wound_bonus = 5
	bare_wound_bonus = 25
	resistance_flags = FIRE_PROOF
	masquerade_violating = TRUE

/obj/item/melee/vampirearms/tzimisce/venom
	name = "nematocyst whip"
	desc = "An elongated tendril covered with stinging cells."
	icon = 'code/modules/wod13/48x32weapons.dmi'
	icon_state = "zhalo"
	damtype = TOX
	force = 20
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 10
	armour_penetration = 10
	sharpness = SHARP_NONE
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	wound_bonus = 0
	bare_wound_bonus = 0
	resistance_flags = FIRE_PROOF
	masquerade_violating = TRUE

