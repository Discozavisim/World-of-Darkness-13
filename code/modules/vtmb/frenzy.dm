//Here's things for future madness

//add_client_colour(/datum/client_colour/glass_colour/red)
//remove_client_colour(/datum/client_colour/glass_colour/red)
/client/Click(object,location,control,params)
	if(isatom(object))
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			if(H.in_frenzy)
				return
		if(iswerewolf(mob))
			var/mob/living/carbon/werewolf/W = mob
			if(W.in_frenzy)
				return
	..()

/mob/living/carbon/proc/rollfrenzy()
	if(client)
		if(isgarou(src) || iswerewolf(src))
			to_chat(src, "I'm full of <span class='danger'><b>ANGER</b></span>, and I'm about to flare up in <span class='danger'><b>RAGE</b></span>. Rolling...")
		else if(iskindred(src))
			to_chat(src, "I need <span class='danger'><b>BLOOD</b></span>. The <span class='danger'><b>BEAST</b></span> is calling. Rolling...")
		else if(iscathayan(src))
			to_chat(src, "My <span class='danger'><b>P'o</b></span> is awakening. Rolling...")
		else
			to_chat(src, "I'm too <span class='danger'><b>AFRAID</b></span> to continue doing this. Rolling...")
		SEND_SOUND(src, sound('code/modules/wod13/sounds/bloodneed.ogg', 0, 0, 50))
		var/check
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.MyPath)
				check = secret_vampireroll(H.MyPath.consience+H.MyPath.selfcontrol, 10-H.humanity, H, TRUE, FALSE)
				switch(check)
					if(-1)
						enter_frenzymod()
						if(iskindred(src))
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200*H.clane.frenzymod)
						else
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200)
						frenzy_hardness = 1
						to_chat(src, "<span class='comradio'><b>CONSIENCE</b></span>+<span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Botch</span>")
					if(0 to 2)
						enter_frenzymod()
						if(iskindred(src))
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100*H.clane.frenzymod)
						else
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100)
						frenzy_hardness = 1
						to_chat(src, "<span class='comradio'><b>CONSIENCE</b></span>+<span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span>")
					if(3 to INFINITY)
						frenzy_hardness = min(10, frenzy_hardness+1)
						to_chat(src, "<span class='comradio'><b>CONSIENCE</b></span>+<span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>[check] Successes</span>")
			else
				if(iscathayan(src))
					check = vampireroll(max(1, mind.dharma.Hun), min(10, (mind.dharma.level*2)-max_demon_chi), src)
				else
					check = vampireroll(max(1, round(humanity/2)), min(frenzy_chance_boost, frenzy_hardness), src)
				switch(check)
					if(DICE_FAILURE)
						enter_frenzymod()
						if(iskindred(src))
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100*H.clane.frenzymod)
						else
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100)
						frenzy_hardness = 1
					if(DICE_CRIT_FAILURE)
						enter_frenzymod()
						if(iskindred(src))
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200*H.clane.frenzymod)
						else
							addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200)
						frenzy_hardness = 1
					if(DICE_CRIT_WIN)
						frenzy_hardness = max(1, frenzy_hardness-1)
					else
						frenzy_hardness = min(10, frenzy_hardness+1)
		else
			check = vampireroll(max(1, round(humanity/2)), min(frenzy_chance_boost, frenzy_hardness), src)
			switch(check)
				if(DICE_FAILURE)
					enter_frenzymod()
					addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100)
					frenzy_hardness = 1
				if(DICE_CRIT_FAILURE)
					enter_frenzymod()
					addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200)
					frenzy_hardness = 1
				if(DICE_CRIT_WIN)
					frenzy_hardness = max(1, frenzy_hardness-1)
				else
					frenzy_hardness = min(10, frenzy_hardness+1)

/mob/living/carbon/proc/rollrotshreck()
	if(!iskindred(src))
		return
	if(client)
		var/mob/living/carbon/human/H
		if(ishuman(src))
			H = src

		to_chat(src, "There is <span class='danger'><b>FIRE</b></span> around me. The <span class='danger'><b>BEAST</b></span> is calling. Rolling...")

		SEND_SOUND(src, sound('code/modules/wod13/sounds/bloodneed.ogg', 0, 0, 50))
		var/check
		if(H.MyPath)
			check = secret_vampireroll(H.MyPath.courage+H.MyPath.selfcontrol, 10-H.humanity, H, TRUE, FALSE)
			switch(check)
				if(-1)
					enter_frenzymod()
					if(iskindred(src))
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200*H.clane.frenzymod)
					else
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200)
					frenzy_hardness = 1
					to_chat(src, "<span class='sciradio'><b>COURAGE</b></span>+<span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Botch</span>")
				if(0 to 2)
					enter_frenzymod()
					if(iskindred(src))
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100*H.clane.frenzymod)
					else
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100)
					frenzy_hardness = 1
					to_chat(src, "<span class='sciradio'><b>COURAGE</b></span>+<span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span>")
				if(3 to INFINITY)
					frenzy_hardness = min(10, frenzy_hardness+1)
					to_chat(src, "<span class='sciradio'><b>COURAGE</b></span>+<span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>[check] Successes</span>")
		else
			check = vampireroll(max(1, round(humanity/2)), min(frenzy_chance_boost, frenzy_hardness), src)
			switch(check)
				if(DICE_FAILURE)
					enter_frenzymod()
					if(iskindred(src))
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100*H.clane.frenzymod)
					else
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 100)
					frenzy_hardness = 1
				if(DICE_CRIT_FAILURE)
					enter_frenzymod()
					if(iskindred(src))
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200*H.clane.frenzymod)
					else
						addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 200)
					frenzy_hardness = 1
				if(DICE_CRIT_WIN)
					frenzy_hardness = max(1, frenzy_hardness-1)
				else
					frenzy_hardness = min(10, frenzy_hardness+1)

/mob/living/carbon/proc/enter_frenzymod()
	if(in_frenzy)
		return
	SEND_SOUND(src, sound('code/modules/wod13/sounds/frenzy.ogg', 0, 0, 50))
	in_frenzy = TRUE
	add_client_colour(/datum/client_colour/glass_colour/red)
	demon_chi = 0
	if(iswerewolf(src) || isgarou(src))
		adjust_rage(-10, src, TRUE)
	GLOB.frenzy_list += src

/mob/living/carbon/proc/exit_frenzymod()
	if(!in_frenzy)
		return
	in_frenzy = FALSE
	mind?.dharma?.Po_combat = FALSE
	remove_client_colour(/datum/client_colour/glass_colour/red)
	GLOB.frenzy_list -= src

/mob/living/carbon/proc/CheckFrenzyMove()
	if(stat >= SOFT_CRIT)
		return TRUE
	if(IsSleeping())
		return TRUE
	if(IsUnconscious())
		return TRUE
	if(IsParalyzed())
		return TRUE
	if(IsKnockdown())
		return TRUE
	if(IsStun())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE

/mob/living/carbon/proc/frenzystep()
	if(!isturf(loc) || CheckFrenzyMove())
		return
	if(m_intent == MOVE_INTENT_WALK)
		toggle_move_intent(src)
	set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))

	var/atom/fear
	for(var/obj/effect/fire/F in GLOB.fires_list)
		if(F)
			if(get_dist(src, F) < 7 && F.z == src.z)
				if(get_dist(src, F) < 6)
					fear = F
				if(get_dist(src, F) < 5)
					fear = F
				if(get_dist(src, F) < 4)
					fear = F
				if(get_dist(src, F) < 3)
					fear = F
				if(get_dist(src, F) < 2)
					fear = F
				if(get_dist(src, F) < 1)
					fear = F

//	if(!fear && !frenzy_target)
//		return

	if(iskindred(src))
		if(fear)
			step_away(src,fear,99)
			if(prob(25))
				emote("scream")
		else
			var/mob/living/carbon/human/H = src
			if(get_dist(frenzy_target, src) <= 1)
				if(isliving(frenzy_target))
					var/mob/living/L = frenzy_target
					if(L.bloodpool && L.stat != DEAD && last_drinkblood_use+95 <= world.time)
						L.grabbedby(src)
						if(ishuman(L))

							var/mob/living/carbon/human/user = H
							var/mob/living/carbon/human/target = L

							var/add_hard = 0

							var/mob/living/carbon/human/carbon = target
							var/obj/item/bodypart/affecting = carbon.get_bodypart(user.zone_selected)
							var/list/items = carbon.clothingonpart(affecting)
							if(items.len > 0)
								add_hard = 1
							if(carbon.checkarmor(affecting, LETHAL) || carbon.checkarmor(affecting, BASHING) || carbon.checkarmor(affecting, AGGRAVATED))
								add_hard = 2

							var/modifikator = secret_vampireroll(get_a_strength(user)+get_a_brawl(user), 6+add_hard, user)

							if(modifikator == -1)
								target.visible_message("<span class='danger'>[user]'s misses [target]!</span>", \
									"<span class='danger'>You avoid [user]'s bite!</span>", "<span class='hear'>You hear a crunch!</span>", COMBAT_MESSAGE_RANGE, user)
								to_chat(user, "<span class='warning'>Your fangs miss [target]!</span>")
								log_combat(user, target, "attempted to bite")
								last_drinkblood_use += 50
								return
							else if(modifikator == 0)
								target.visible_message("<span class='danger'>[user]'s misses [target]!</span>", \
									"<span class='danger'>You avoid [user]'s bite!</span>", "<span class='hear'>You hear a crunch!</span>", COMBAT_MESSAGE_RANGE, user)
								to_chat(user, "<span class='warning'>Your fangs miss [target]!</span>")
								log_combat(user, target, "attempted to bite")
								last_drinkblood_use += 10
								return

							L.emote("scream")
							var/mob/living/carbon/human/BT = L
							BT.add_bite_animation()
						if(CheckEyewitness(L, src, 7, FALSE))
							H.AdjustMasquerade(-1)
						playsound(src, 'code/modules/wod13/sounds/drinkblood1.ogg', 50, TRUE)
						L.visible_message("<span class='warning'><b>[src] bites [L]'s neck!</b></span>", "<span class='warning'><b>[src] bites your neck!</b></span>")
						face_atom(L)
						H.drinksomeblood(H, L)
			else
				step_to(src,frenzy_target,0)
				face_atom(frenzy_target)
	else
		if(get_dist(frenzy_target, src) <= 1)
			if(isliving(frenzy_target))
				var/mob/living/L = frenzy_target
				if(L.stat != DEAD)
					a_intent = INTENT_HARM
					if(last_rage_hit+5 < world.time)
						last_rage_hit = world.time
						UnarmedAttack(L)
		else
			step_to(src,frenzy_target,0)
			face_atom(frenzy_target)

/mob/living/carbon/proc/get_frenzy_targets()
	var/list/targets = list()
	if(iskindred(src))
		for(var/mob/living/L in oviewers(7, src))
			if(L.bloodpool && L.stat != DEAD)
				targets += L
				if(L == frenzy_target)
					return L
	else
		for(var/mob/living/L in oviewers(7, src))
			if(L.stat != DEAD)
				targets += L
				if(L == frenzy_target)
					return L
	if(length(targets) > 0)
		return pick(targets)
	else
		return null

/mob/living/carbon/proc/handle_automated_frenzy()
	for(var/mob/living/carbon/human/npc/NPC in viewers(5, src))
		NPC.Aggro(src)
	if(isturf(loc))
		frenzy_target = get_frenzy_targets()
		if(frenzy_target)
			var/datum/cb = CALLBACK(src, PROC_REF(frenzystep))
			var/reqsteps = SSfrenzypool.wait/total_multiplicative_slowdown()
			for(var/i in 1 to reqsteps)
				addtimer(cb, (i - 1)*total_multiplicative_slowdown())
		else
			if(!CheckFrenzyMove())
				if(isturf(loc))
					var/turf/T = get_step(loc, pick(NORTH, SOUTH, WEST, EAST))
					face_atom(T)
					Move(T)

/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	. = ..()
