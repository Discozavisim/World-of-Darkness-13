/mob/living/carbon/human/proc/add_bite_animation()
	remove_overlay(BITE_LAYER)
	var/mutable_appearance/bite_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "bite", -BITE_LAYER)
	overlays_standing[BITE_LAYER] = bite_overlay
	apply_overlay(BITE_LAYER)
	spawn(15)
		if(src)
			remove_overlay(BITE_LAYER)

/proc/get_needed_difference_between_numbers(var/number1, var/number2)
	if(number1 > number2)
		return number1 - number2
	else if(number1 < number2)
		return number2 - number1
	else
		return 1

/mob/living/carbon/human/proc/drinksomeblood(var/mob/living/carbon/human/user, var/mob/living/target)
	last_drinkblood_use = world.time

	if(client)
		client.images -= suckbar
	qdel(suckbar)
	suckbar_loc = target
	suckbar = image('code/modules/wod13/bloodcounter.dmi', suckbar_loc, "[round(14*(target.bloodpool/target.maxbloodpool))]", HUD_LAYER)
	suckbar.pixel_z = 40
	suckbar.plane = ABOVE_HUD_PLANE
	suckbar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA

	if(client)
		client.images += suckbar

	if(iskindred(target) || iscathayan(target) || isgarou(target) || iswerewolf(target))
		var/mob/living/carbon/human/carbon = target

		var/selfcontrol = 3

		if(carbon.MyPath)
			selfcontrol = carbon.MyPath.selfcontrol

		var/modifikator = secret_vampireroll(selfcontrol, 8, carbon, TRUE)

		if(modifikator >= 3)
			target.visible_message("<span class='danger'>[user]'s misses [carbon]!</span>", \
				"<span class='danger'>You avoid [user]'s kiss!</span>", "<span class='hear'>You hear a slurp!</span>", COMBAT_MESSAGE_RANGE, user)
			to_chat(user, "<span class='warning'>[carbon] shakes you off!</span>")
			log_combat(user, carbon, "attempted to kiss")
			last_drinkblood_use += 50
			if(client)
				client.images -= suckbar
				qdel(suckbar)
			if(carbon.pulledby)
				carbon.pulledby.stop_pulling()
			if(carbon.IsStun())
				carbon.SetStun(0)
			return

	var/sound/heartbeat = sound('code/modules/wod13/sounds/drinkblood2.ogg', repeat = TRUE)
	if(HAS_TRAIT(src, TRAIT_BLOODY_SUCKER))
		src.emote("moan")
		Immobilize(30, TRUE)
	playsound_local(src, heartbeat, 75, 0, channel = CHANNEL_BLOOD, use_reverb = FALSE)
	if(isnpc(target))
		var/mob/living/carbon/human/npc/NPC = target
		NPC.danger_source = null
//		NPC.last_attacker = src


	target.Stun(3 SECONDS)


	if(target.bloodpool <= 1 && target.maxbloodpool > 1)
		to_chat(src, "<span class='warning'>You feel small amount of <b>BLOOD</b> in your victim.</span>")
		if(iskindred(target) && iskindred(src) && !src.in_frenzy)
			if(!user.know_diablerie)
				to_chat(src, "Высосан... досуха.")
				if(client)
					client.images -= suckbar
				qdel(suckbar)
				return
			if(!target.client)
				to_chat(src, "<span class='warning'>Тебе нужна душа в твоей жертве для этого...</span>")
				return
			message_admins("[ADMIN_LOOKUPFLW(src)] is attempting to Diablerize [ADMIN_LOOKUPFLW(target)]")
			log_attack("[key_name(src)] is attempting to Diablerize [key_name(target)].")
			if(target.key)
				if(!GLOB.canon_event)
					to_chat(src, "<span class='warning'>Не каноничное событие!</span>")
					return
				to_chat(src, "<span class='userdanger'><b>ТЫ ПЫТАЕШЬСЯ ДИАБЛЕРИЗИРОВАТЬ СВОЮ ЖЕРТВУ!!!</b></span>")
			else
				to_chat(src, "<span class='warning'>Тебе нужна душа в твоей жертвеs для этого...</span>")
				return

	if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
		if(CheckEyewitness(src, src, 7, FALSE))
			AdjustMasquerade(-1)
	if(do_after(src, 30, target = target, timed_action_flags = NONE, progress = FALSE))
		if(!iscarbon(target))
			if(istype(target, /mob/living/simple_animal/pet/rat))
				if(MyPath)
					MyPath.trigger_morality("ratdrink")
			else
				if(MyPath)
					MyPath.trigger_morality("animaldrink")
		else
			switch(target.bloodquality)
				if(BLOOD_QUALITY_HIGH)
					if(MyPath)
						MyPath.trigger_morality("gooddrink")
				if(BLOOD_QUALITY_LOW)
					if(MyPath)
						MyPath.trigger_morality("baddrink")
				if(BLOOD_QUALITY_NORMAL)
					if(MyPath)
						MyPath.trigger_morality("firstfeed")
		target.bloodpool = max(0, target.bloodpool-1)
		suckbar.icon_state = "[round(14*(target.bloodpool/target.maxbloodpool))]"
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			drunked_of |= "[H.dna.real_name]"
			if(!iskindred(target))
				H.blood_volume = max(H.blood_volume-50, 150)
			if(iscathayan(src))
				if(target.yang_chi > 0 || target.yin_chi > 0)
					if(target.yang_chi > target.yin_chi)
						target.yang_chi = target.yang_chi-1
						yang_chi = min(yang_chi+1, max_yang_chi)
						to_chat(src, "<span class='engradio'>Some <b>Yang</b> Chi energy enters you...</span>")
					else
						target.yin_chi = target.yin_chi-1
						yin_chi = min(yin_chi+1, max_yin_chi)
						to_chat(src, "<span class='medradio'>Some <b>Yin</b> Chi energy enters you...</span>")
					COOLDOWN_START(target, chi_restore, 30 SECONDS)
					update_chi_hud()
				else
					to_chat(src, "<span class='warning'>The <b>BLOOD</b> feels tasteless...</span>")
			if(H.reagents)
				if(length(H.reagents.reagent_list))
					H.reagents.trans_to(src, min(10, H.reagents.total_volume), transfered_by = target, methods = VAMPIRE)
		if(clane)
			if(clane.name == "Giovanni")
				target.adjustBruteLoss(20, TRUE)
			if(clane.name == "Ventrue" && target.bloodquality < BLOOD_QUALITY_NORMAL)	//Ventrue can suck on normal people, but not homeless people and animals. BLOOD_QUALITY_LOV - 1, BLOOD_QUALITY_NORMAL - 2, BLOOD_QUALITY_HIGH - 3. Blue blood gives +1 to suction
				to_chat(src, "<span class='warning'>You are too privileged to drink that awful <b>BLOOD</b>. Go get something better.</span>")
				visible_message("<span class='danger'>[src] throws up!</span>", "<span class='userdanger'>You throw up!</span>")
				playsound(get_turf(src), 'code/modules/wod13/sounds/vomit.ogg', 75, TRUE)
				if(isturf(loc))
					add_splatter_floor(loc)
				stop_sound_channel(CHANNEL_BLOOD)
				if(client)
					client.images -= suckbar
				qdel(suckbar)
				return
		if(iskindred(target))
			to_chat(src, "<span class='userlove'>[target]'s blood tastes HEAVENLY...</span>")
			adjustBruteLoss(-25, TRUE)
			adjustFireLoss(-10, TRUE)
		else
			to_chat(src, "<span class='warning'>You sip some <b>BLOOD</b> from your victim. It feels good.</span>")
		bloodpool = min(maxbloodpool, bloodpool+1*max(1, target.bloodquality-1))
		adjustBruteLoss(-10, TRUE)
		adjustFireLoss(-5, TRUE)
		update_damage_overlays()
		update_health_hud()
		update_blood_hud()
		if(target.bloodpool <= 0)
			if(ishuman(target))
				var/mob/living/carbon/human/K = target
				if(grab_state >= GRAB_KILL && (iskindred(target) && iskindred(src)))
					var/datum/preferences/P = GLOB.preferences_datums[ckey(key)]
					var/datum/preferences/P2 = GLOB.preferences_datums[ckey(target.key)]
					var/uspeh = 0
					var/modifikator_diab = 0
					var/L
					if(alert("Ты ДЕЙСТВИТЕЛЬНО хочешь высосать душу?",,"Да","Нет")=="Да")
						user.Immobilize(80 SECONDS, TRUE)
						attributes.stamina_bonus = -2
						ADD_TRAIT(K, BEING_DIABLERIE, TRAIT_GENERIC)
				//	if(diablerist || P.generation > P2.generation+2)
						if(diablerist)
							modifikator_diab = 1
						for(L = 0, L<7, L++)
							if(do_mob(src, src, 10 SECONDS))
								var/diablerie = secret_vampireroll(get_a_strength(user), 9+modifikator_diab, user)
								MyPath.trigger_morality("diablerie")
								K.MyPath.trigger_morality("diablerie_jertva")
								if(diablerie <= 0)
									uspeh -= 1
									to_chat(user, "<span class='warning'>Душа [target] сопротивляется с новой силой, ты чувствуешь, как слабеешь...</span>")
								else
									uspeh += diablerie
									to_chat(user, "<span class='warning'>Ты чувствуешь, как душа [target] слабеет...</span>")
							else
								to_chat(user, "<span class='warning'><b> ДУША УСКОЛЬЗНУЛА С ТВОИХ УСТ!!! </b></span>")
								REMOVE_TRAIT(K, BEING_DIABLERIE, TRAIT_GENERIC)
								return
						if(L == 7)
							switch(uspeh)
								if(-INFINITY to 6)
									K.MyPath.trigger_morality("diablerie_jertva_uspeh")
									to_chat(src, "<span class='userdanger'><b>ДУША [K] ПЕРЕХВАТИЛА ТВОЁ ТЕЛО.</b></span>")
									message_admins("[ADMIN_LOOKUPFLW(src)] tried to Diablerize [ADMIN_LOOKUPFLW(target)] and was overtaken.")
									log_attack("[key_name(src)] tried to Diablerize [key_name(target)] and was overtaken.")
									death()
									P2.add_experience(50)
									if(P)
										P.reset_character()
										P.reason_of_death = "Failed the Diablerie ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."

								/*	if(P2)
										var/list/discplinesP = P.discipline_types - P2.discipline_types
										P2.discipline_types += discplinesP
										var/ZV1 = length(discplinesP)
											for(ZV1, ZV1>0, ZV1--)
												P.discipline_levels += 0
												*/
								if(7 to INFINITY)
									MyPath.trigger_morality("diablerie_success")
									user.attributes.stamina_bonus = 0
									AdjustMasquerade(-1)
									message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(target)]")
									log_attack("[key_name(src)] successfully Diablerized [key_name(target)].")
									adjustBruteLoss(-80, TRUE)
									adjustFireLoss(-80, TRUE)
									K.death()
									rollfrenzy()
									var/modifikator_disc = 0
									if(length(P.discipline_types) > 3)
										modifikator_disc = 8
									if(key)
										diablerist = 1
										if(P)
											P.diablerist = 1
											P.generation_bonus = generation-target.generation
											generation = target.generation
											P.add_experience(75)
											var/list/disciplinesPP = P2.discipline_types - P.discipline_types
											var/new_discipline = input(user, "Select your new Discipline", "Discipline Selection") as null|anything in disciplinesPP
											if(prob(15-modifikator_disc))
												if(new_discipline)
													P.discipline_types += new_discipline
													P.discipline_levels += 0
									if(K.client)
										var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
										trauma.friend.key = K.key
									if(P2)
										P2.reset_character()
										P2.reason_of_death =  "Diablerized by [true_real_name ? true_real_name : real_name] ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
					if(client)
						client.images -= suckbar
					qdel(suckbar)
					return
				else
					K.blood_volume = 0
			if(ishuman(target) && !iskindred(target))
				if(target.stat != DEAD)
					if(isnpc(target))
						var/mob/living/carbon/human/npc/Npc = target
						Npc.last_attacker = null
						killed_count = killed_count+1
						if(killed_count >= 5)
//							GLOB.fuckers |= src
							SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_loss.ogg', 0, 0, 75))
							to_chat(src, "<span class='userdanger'><b>POLICE ASSAULT IN PROGRESS</b></span>")
					SEND_SOUND(src, sound('code/modules/wod13/sounds/feed_failed.ogg', 0, 0, 75))
					to_chat(src, "<span class='warning'>This sad sacrifice for your own pleasure affects something deep in your mind.</span>")
					AdjustMasquerade(-1)
					if(MyPath)
						MyPath.trigger_morality("drying")
					else
						AdjustHumanity(-1, 0)
					target.death()
			if(!ishuman(target))
				if(target.stat != DEAD)
					target.death()
			stop_sound_channel(CHANNEL_BLOOD)
			last_drinkblood_use = 0
			if(client)
				client.images -= suckbar
			qdel(suckbar)
			return
		if(grab_state >= GRAB_PASSIVE)

			stop_sound_channel(CHANNEL_BLOOD)
			user.drinksomeblood(user, target)
	else
		last_drinkblood_use += 10
		if(client)
			client.images -= suckbar
		qdel(suckbar)
		stop_sound_channel(CHANNEL_BLOOD)
		if(!iskindred(target) || !iscathayan(target))
			target.SetSleeping(50)
