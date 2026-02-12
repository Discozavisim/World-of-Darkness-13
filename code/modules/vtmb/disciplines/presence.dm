/mob/living
	var/mass_presencer

/datum/discipline/presence
	name = "Presence"
	desc = "Makes targets in radius more vulnerable to damages."
	icon_state = "presence"
	power_type = /datum/discipline_power/presence

/datum/discipline_power/presence
	name = "Presence power name"
	desc = "Presence power description"

	activate_sound = 'code/modules/wod13/sounds/presence_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/presence_deactivate.ogg'

/datum/discipline_power/presence/activate(mob/living/carbon/human/target)
	. = ..()
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			target.mind.dharma?.roll_po(owner, target)

/datum/discipline_power/presence/awe
	name = "Awe"
	desc = "Make those around you admire and want to be closer to you."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	range = 7
	duration_length = 15 SECONDS
	cooldown_length = 15 SECONDS

	var/list/affected_mobs = list()
	var/list/owner_auras = list()
	var/list/target_auras = list()


/datum/discipline_power/presence/awe/activate()
	. = ..()

	if(owner.client)
		for(var/mob/living/T in owner_auras)
			owner.client.images -= owner_auras[T]
	owner_auras.Cut()

	for(var/mob/living/T in target_auras)
		if(T.client)
			T.client.images -= target_auras[T]
	target_auras.Cut()

	affected_mobs.Cut()

	if((owner.wear_mask && (owner.wear_mask.flags_inv & HIDEFACE) || (owner.head && (owner.head.flags_inv & HIDEFACE))))
		to_chat(owner, span_warning("Твое лицо скрыто - ты никого не заворажил."))
		deactivate()
		return

	for(var/mob/living/target in view(range, owner))
		if(target == owner)
			continue
		if(target.mass_presencer)
			continue
		var/success_chance = secret_vampireroll(get_a_charisma(owner)+get_a_performance(owner), 7, owner, TRUE)
		if(success_chance >= 3)
			affected_mobs += target

	if(!affected_mobs.len)
		to_chat(owner, span_warning("Тебе не удаётся ни на кого произвести впечатление."))
		deactivate()
		return

	for(var/mob/living/target in affected_mobs)
		if(isnpc(target))
			var/mob/living/carbon/human/npc/npc_target = target
			if(npc_target.danger_source == owner)
				npc_target.danger_source = null
		target.mass_presencer = owner

		if(owner.client)
			var/image/Io = image(icon = 'code/modules/wod13/icons.dmi', icon_state = "presence_2", layer = ABOVE_MOB_LAYER, loc = target)
			owner.client.images |= Io
			owner_auras[target] = Io

		if(target.client)
			var/image/It = image(icon = 'code/modules/wod13/icons.dmi', icon_state = "presence", layer = ABOVE_MOB_LAYER, loc = owner)
			target.client.images |= It
			target_auras[target] = It

			var/text_sent = pick(
				"Ты невольно обращаешь своё внимание на [owner.name].",
				"Твой взгляд вдруг сам собой задерживается на [owner.name].",
				"Среди окружающих [owner.name] начинает притягивать твоё внимание.",
				"Тебе сложно не обращать внимания на [owner.name].",
				"[owner.name] внезапно будто бы становится центром твоего внимания.")
			to_chat(target, span_userlove(text_sent))
			target.presence_text(text_sent)

			if(iscarbon(target))
				var/mob/living/carbon/C = target
				if(C.has_trauma_type(/datum/brain_trauma/magic/presence_awe, TRAUMA_RESILIENCE_ABSOLUTE))
					C.cure_trauma_type(/datum/brain_trauma/magic/presence_awe, TRAUMA_RESILIENCE_ABSOLUTE)
				C.gain_trauma(new /datum/brain_trauma/magic/presence_awe(owner), TRAUMA_RESILIENCE_ABSOLUTE)


/datum/discipline_power/presence/awe/deactivate()
	. = ..()

	if(owner.client)
		for(var/mob/living/T in owner_auras)
			owner.client.images -= owner_auras[T]
	owner_auras.Cut()

	for(var/mob/living/T in target_auras)
		if(T.client)
			T.client.images -= target_auras[T]
	target_auras.Cut()

	for(var/mob/living/target in affected_mobs)
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			if(C.has_trauma_type(/datum/brain_trauma/magic/presence_awe, TRAUMA_RESILIENCE_ABSOLUTE))
				var/obj/item/organ/brain/B = C.getorganslot(ORGAN_SLOT_BRAIN)
				for(var/datum/brain_trauma/magic/presence_awe/T in B.get_traumas_type(/datum/brain_trauma/magic/presence_awe, TRAUMA_RESILIENCE_ABSOLUTE))
					if(T.trauma_caster == owner)
						C.cure_trauma_type(T, TRAUMA_RESILIENCE_ABSOLUTE)

		target.mass_presencer = null

	affected_mobs.Cut()

/atom/movable/screen/presence_text
	icon = null
	icon_state = ""
	name = ""
	screen_loc = "5,5"
	layer = HUD_LAYER+0.02
	plane = HUD_PLANE
	alpha = 0

/mob/living/proc/presence_text(text_to_send, var/color="#FF1493", var/shadow="#ff6dbc")
	if(!mind)
		return
	if(!client)
		return
	if(!text_to_send)
		return
	if(client.presence_text)
		client.screen -= client.presence_text
		qdel(client.presence_text)
		client.presence_text = null

	var/atom/movable/screen/presence_text/T = new()
	client.screen += T
	T.maptext = {"<span style='vertical-align:top; text-align:center;
				color: [color]; font-size: 150%; font-style: italic; font-weight: bold;
				text-shadow: 0px 0px 6px [shadow], 0 0 12px [shadow];
				font-family: "Blackmoor LET", "Pterra";'>[text_to_send]</span>"}
	T.maptext_width = 205
	T.maptext_height = 209
	T.maptext_x = 12
	T.maptext_y = 64
	client.presence_text = T
	playsound_local(src, 'sound/effects/presence_awe.ogg', 100, FALSE)
	animate(T, alpha = 255, time = 10, easing = EASE_IN)
	addtimer(CALLBACK(src, PROC_REF(clear_presence_text), T), 35)

/mob/living/proc/clear_presence_text(atom/movable/screen/A)
	if(!A)
		return
	if(!client)
		return
	animate(A, alpha = 0, time = 10, easing = EASE_OUT)
	sleep(11)
	if(client)
		if(client.screen && A)
			client.screen -= A
			qdel(A)

/mob/living/carbon/human/proc/walk_to_caster(mob/living/step_to)
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_to(src, step_to, 0)
		face_atom(step_to)

//DREAD GAZE
/datum/discipline_power/presence/dread_gaze
	name = "Dread Gaze"
	desc = "Incite fear in others through only your words and gaze."

	level = 2

	check_flags = DISC_CHECK_CAPABLE
	range = 7

	cooldown_length = 15 SECONDS
	duration_length = 15 SECONDS
	var/list/affected_mobs = list()
	var/list/owner_auras = list()
	var/list/target_auras = list()

/datum/discipline_power/presence/dread_gaze/activate()
	. = ..()

	if(owner.client)
		for(var/mob/living/T in owner_auras)
			owner.client.images -= owner_auras[T]
	owner_auras.Cut()

	for(var/mob/living/T in target_auras)
		if(T.client)
			T.client.images -= target_auras[T]
	target_auras.Cut()

	affected_mobs.Cut()

	for(var/mob/living/target in view(range, owner))
		if(target == owner)
			continue
		if(target.mass_presencer)
			continue
		var/consience = 0
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			consience = human_target.MyPath?.consience
		var/success_chance = secret_vampireroll(get_a_charisma(owner)+get_a_intimidation(owner), get_a_wits(target)+consience, owner, TRUE)
		if(success_chance >= 3)
			affected_mobs += target

	if(!affected_mobs.len)
		to_chat(owner, span_warning("Тебе не удаётся ни кого запугать."))
		deactivate()
		return

	for(var/mob/living/target in affected_mobs)
		target.emote(("scream"))
		target.blur_eyes(7.5)
		target.do_jitter_animation(15 SECONDS)
		if(isnpc(target))
			var/mob/living/carbon/human/npc/npc_target = target
			if(npc_target.danger_source)
				npc_target.danger_source = null
		target.mass_presencer = owner

		var/datum/cb = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster), owner)
		for(var/i in 1 to 30)
			addtimer(cb, (i - 1) * target.total_multiplicative_slowdown())

		if(owner.client)
			var/image/Io = image(icon = 'code/modules/wod13/icons.dmi', icon_state = "presence_2", layer = ABOVE_MOB_LAYER, loc = target)
			owner.client.images |= Io
			owner_auras[target] = Io

		if(target.client)
			var/image/It = image(icon = 'code/modules/wod13/icons.dmi', icon_state = "presence", layer = ABOVE_MOB_LAYER, loc = owner)
			target.client.images |= It
			target_auras[target] = It
			target.overlay_fullscreen("fear", /atom/movable/screen/fullscreen/fear, 1)

		var/name_to_use = owner.name

		if((owner.wear_mask && (owner.wear_mask.flags_inv & HIDEFACE) || (owner.head && (owner.head.flags_inv & HIDEFACE))))
			name_to_use = "незнакомца"

		var/text_sent = pick(
			"Ужас из-за [name_to_use] срывает тебя с места!",
			"Страх из-за [name_to_use] лишает тебя воли!",
			"Одного присутствия [name_to_use] хватает, чтобы ты дрогнул!",
			"От одного взгляда [name_to_use] ты срываешься в бег!",
			"Паника из-за [name_to_use] становится невыносимой!")
		to_chat(target, span_cult(text_sent))
		target.presence_text(text_sent, color="#bf2020", shadow="#c14c4c")

/datum/discipline_power/presence/dread_gaze/deactivate()
	. = ..()

	if(owner.client)
		for(var/mob/living/T in owner_auras)
			owner.client.images -= owner_auras[T]
	owner_auras.Cut()

	for(var/mob/living/T in target_auras)
		if(T.client)
			T.client.images -= target_auras[T]
			T.clear_fullscreen("fear")
	target_auras.Cut()

	for(var/mob/living/target in affected_mobs)
		target.mass_presencer = null

	affected_mobs.Cut()

/datum/discipline_power/presence/proc/presence_end(mob/living/target, mob/living/carbon/human/caster, initial_fights_anyway)
	var/mob/living/carbon/human/npc/N = target
	if(N && N.presence_master == caster)
		// End presence effect
		N.presence_master = null
		N.add_movespeed_modifier(/datum/movespeed_modifier/npc)
		N.presence_follow = FALSE
		N.remove_overlay(MUTATIONS_LAYER)
		N.presence_enemies = list()
		N.danger_source = null
		caster.puppets -= N
		N.fights_anyway = initial_fights_anyway
		if(!length(caster.puppets))
			for(var/datum/action/presence_stay/VI in caster.actions)
				if(VI)
					VI.Remove(caster)
			for(var/datum/action/presence_deaggro/VI in caster.actions)
				if(VI)
					VI.Remove(caster)

//ENTRANCEMENT
/datum/discipline_power/presence/entrancement
	name = "Entrancement"
	desc = "Manipulate minds by bending emotions to your will."

	level = 3

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/entrancement/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/entrancement/activate(mob/living/carbon/human/target)
	. = ..()
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)


	if(istype(target, /mob/living/carbon/human/npc) && owner.puppets.len < get_a_charisma(owner)+get_a_empathy(owner))
		var/mob/living/carbon/human/npc/N = target
		if(!N.presence_master)
			if(!length(owner.puppets))
				var/datum/action/presence_stay/E1 = new()
				E1.Grant(owner)
				var/datum/action/presence_deaggro/E2 = new()
				E2.Grant(owner)

			N.presence_master = owner

			N.presence_follow = TRUE
			N.remove_movespeed_modifier(/datum/movespeed_modifier/npc)
			owner.puppets |= N
			var/initial_fights_anyway = N.fights_anyway
			N.fights_anyway = TRUE
			owner.say("Come with me...")

			addtimer(CALLBACK(src, PROC_REF(presence_end), target, owner, initial_fights_anyway), 50 SECONDS * mypower)
	else
		var/obj/item/I1 = target.get_active_held_item()
		var/obj/item/I2 = target.get_inactive_held_item()
		to_chat(target, "<span class='userlove'><b>PLEASE ME</b></span>")
		owner.say("PLEASE ME!!")
		target.face_atom(owner)
		target.do_jitter_animation(3 SECONDS)
		target.Immobilize(1 SECONDS)
		target.drop_all_held_items()
		if(I1)
			I1.throw_at(get_turf(owner), 3, 1, target)
		if(I2)
			I2.throw_at(get_turf(owner), 3, 1, target)

/datum/discipline_power/presence/entrancement/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//SUMMON
/datum/discipline_power/presence/summon
	name = "Summon"
	desc = "Call anyone you've ever met to be by your side."

	level = 4

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/summon/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/summon/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	to_chat(target, "<span class='userlove'><b>FEAR ME</b></span>")
	owner.say("FEAR ME!!")
	var/datum/cb = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster), owner)
	for(var/i in 1 to 30)
		addtimer(cb, (i - 1) * target.total_multiplicative_slowdown())
	target.emote("scream")
	target.do_jitter_animation(3 SECONDS)

/datum/discipline_power/presence/summon/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

/mob/living/carbon/human/proc/step_away_caster(mob/living/step_from)
	walk(src, 0)
	if(!CheckFrenzyMove())
		set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		step_away(src, step_from, 99)

//MAJESTY
/datum/discipline_power/presence/majesty
	name = "Majesty"
	desc = "Become so grand that others find it nearly impossible to disobey or harm you."

	level = 5

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 5 SECONDS

/datum/discipline_power/presence/majesty/pre_activation_checks(mob/living/target)
	var/mypower = secret_vampireroll(max(get_a_charisma(owner), get_a_appearance(owner))+get_a_empathy(owner), get_a_willpower(target), owner)
	if(mypower < 3)
		to_chat(owner, "<span class='warning'>You fail at sway!</span>")
		owner.emote("stare")
		if(mypower == -1)
			owner.Stun(3 SECONDS)
			owner.do_jitter_animation(10)
		return FALSE

	return TRUE

/datum/discipline_power/presence/majesty/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
	presence_overlay.pixel_z = 1
	target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	to_chat(target, "<span class='userlove'><b>UNDRESS YOURSELF</b></span>")
	owner.say("UNDRESS YOURSELF!!")
	target.Immobilize(1 SECONDS)
	for(var/obj/item/clothing/W in target.contents)
		target.dropItemToGround(W, TRUE)

/datum/discipline_power/presence/majesty/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

/mob/living/carbon/human/npc/proc/handle_presence_movement()
	if(!presence_master || stat >= DEAD)
		return
	if(presence_enemies.len)
		var/dist = 100
		var/mob/enemy = null
		for(var/mob/i in presence_enemies)
			if(get_dist(presence_master,i) < dist && i.stat < 2)
				dist = get_dist(presence_master,i)
				enemy = i
		danger_source = enemy

	if(!presence_follow && !danger_source)
		walktarget = null
	if(presence_follow)
		if(presence_master.z == z && get_dist(src, presence_master) > 3)
			walktarget = presence_master
		else
			walktarget = null
	else
		face_atom(presence_master)

/* ACTIONS */

/datum/action/presence_stay
	name = "Stay/Follow (Presence)"
	desc = "Tell your Presence-thralled NPC to stay put or follow."
	button_icon_state = "wait"
	var/cool_down = 0
	var/following = TRUE
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/presence_stay/Trigger()
	. = ..()
	if(ishuman(owner))
		if(cool_down + 10 >= world.time)
			return
		cool_down = world.time
		var/mob/living/carbon/human/H = owner
			// flip “following” on or off
		following = !following
		if(following)
			H.say("Follow me")
			to_chat(H, "You call your thralls to follow you.")
			for(var/mob/living/carbon/human/npc/HPC in H.puppets)
				if(HPC)
					if(HPC.stat == 0 && !HPC.key && !HPC.IsSleeping() && !HPC.IsUnconscious() && !HPC.IsParalyzed() && !HPC.IsKnockdown() && !HPC.IsStun() && !HAS_TRAIT(HPC, TRAIT_RESTRAINED) && !HPC.pulledby)
						HPC.forceMove(get_turf(H))
		else
			H.say("Stay here")
			to_chat(H, "You command your thralls to remain here.")
			// For each Presence’d NPC you control, apply the new setting
		for(var/mob/living/carbon/human/npc/N in GLOB.npc_list)
			if(N.presence_master == H)
				N.presence_follow = following

/datum/action/presence_deaggro
	name = "Loose Aggression (Presence)"
	desc = "Command to stop your Presence-thralled NPC any aggressive moves."
	button_icon_state = "deaggro"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/cool_down = 0

/datum/action/presence_deaggro/Trigger()
	. = ..()
	if(ishuman(owner))
		if(cool_down+10 >= world.time)
			return
		cool_down = world.time
		var/mob/living/carbon/human/H = owner
		H.say("Stop it!")
		to_chat(H, "You order your thralls to stop attacking.")
		for(var/mob/living/carbon/human/npc/N in H.puppets)
			N.presence_enemies = list()
			N.danger_source = null
