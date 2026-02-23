#define BRUSH_CLIP "GD"
#define WRUNG_HAND "DG"
#define RESTRAIN_COMBO "GG"
#define HANDCUFFS_COMBO "HGHG"
#define CONSECUTIVE_COMBO "HD"
#define FOOTBOARD "DH"
#define LAYING "DDDD"
#define CHOKE "HHH"

/datum/martial_art/police_jiu
	name = "Police Martial Arts"
	id = MARTIALART_PJ
	help_verb = /mob/living/proc/PJ_help
	block_chance = 75
	smashes_tables = TRUE
	max_streak_length = 6
	var/old_grab_state = null
	var/restraining = FALSE
	display_combos = TRUE

/datum/martial_art/police_jiu/reset_streak(mob/living/new_target)
	. = ..()
	restraining = FALSE

/datum/martial_art/police_jiu/proc/check_streak(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(findtext(streak,BRUSH_CLIP))
		streak = ""
		Brush(A,D)
		return TRUE
	if(findtext(streak,WRUNG_HAND))
		Wrung(A,D)
	if(findtext(streak,RESTRAIN_COMBO))
		streak = ""
		Restrain(A,D)
		return TRUE
	if(findtext(streak,HANDCUFFS_COMBO))
		streak = ""
		Handfuff(A,D)
		return TRUE
	if(findtext(streak,CONSECUTIVE_COMBO))
		Consecutive(A,D)
	if(findtext(streak,FOOTBOARD))
		streak = ""
		Footboard(A,D)
		return TRUE
	if(findtext(streak,LAYING))
		streak = ""
		Laying(A,D)
		return TRUE
	if(findtext(streak,CHOKE))
		streak = ""
		Choke(A,D)
		return TRUE
	return FALSE

/datum/martial_art/police_jiu/proc/Brush(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	D.visible_message("<span class='danger'>[A] brushed [D]'s hand!</span>", \
					"<span class='userdanger'>You're hand brushed by [A]!</span>", "<span class='hear'>You hear a sickening sound of clicking from hand!</span>", null, A)
	to_chat(A, "<span class='danger'>You brushed [D]'s hand!</span>")
	playsound(get_turf(A), 'sound/weapons/slam.ogg', 50, TRUE, -1)
	D.apply_damage(15, BRUTE)
	if(ishuman(D) || iswerewolf(D) || isghoul(D))
		D.Paralyze(10)
		D.adjustStaminaLoss(55)
	if(D.body_position == STANDING_UP)
		D.toggle_resting()
	log_combat(A, D, "brushed clip (Police_Jiu)")
	return TRUE

/datum/martial_art/police_jiu/proc/Wrung(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	D.visible_message("<span class='danger'>[A] wrung [D]'s hand!</span>", \
					"<span class='userdanger'>You're hand wrung by [A]!</span>", "<span class='hear'>You hear a sickening sound of clicking from hand!</span>", null, A)
	to_chat(A, "<span class='danger'>You wrung [D]'s hand!</span>")
	playsound(get_turf(A), 'sound/weapons/slam.ogg', 50, TRUE, -1)
	D.adjustStaminaLoss(20)
	D.Paralyze(20)
	log_combat(A, D, "wrung hand (Police_Jiu)")
	return TRUE

/datum/martial_art/police_jiu/proc/Choke(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat || !D.IsParalyzed())
		D.visible_message("<span class='danger'>[A] sweeps and chockes [D]!</span>", \
						"<span class='userdanger'>You're chocked by [A]!</span>", "<span class='hear'>You hear muffled moan!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You chocke [D]!</span>")
		playsound(get_turf(A), 'sound/weapons/cqchit1.ogg', 50, TRUE, -1)
		D.adjustOxyLoss(10)
		D.adjustStaminaLoss(30)
		D.losebreath += 2
		D.Knockdown(25)
		log_combat(A, D, "choked (Police_Jiu)")
	if(!(D.body_position == STANDING_UP))
		log_combat(A, D, "chocked (leg on neck)(Police_Jiu)")
		D.visible_message("<span class='danger'>[A] clamps [D]'s throat with his knee [D.p_them()]!</span>", \
						"<span class='userdanger'>You're throat unconscious by [A]'s knee!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You clamp [D]'s throat, choking [D.p_them()] out!</span>")
		playsound(get_turf(A), 'sound/weapons/genhit1.ogg', 50, TRUE, -1)
		if(ishuman(D) || iswerewolf(D) || isghoul(D))
			D.adjustOxyLoss(15)
			D.losebreath += 3
			D.Knockdown(15)
	return TRUE

/datum/martial_art/police_jiu/proc/Handfuff(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	for(var/obj/item/restraints/handcuffs/H in D.held_items)
		to_chat(A, "<span class='warning'>[D] is already handcuffed!</span>")
		return FALSE
	for(var/obj/item/restraints/handcuffs/H in A.contents)
		H.apply_cuffs(D, A)
		D.adjustStaminaLoss(60)
		log_combat(A, D, "Handcuffed (Police_Jiu)")
	return TRUE

/datum/martial_art/police_jiu/proc/Restrain(mob/living/A, mob/living/D)
	if(restraining)
		return
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		log_combat(A, D, "restrained (Police_Jiu)")
		D.visible_message("<span class='warning'>[A] locks [D] into a restraining position!</span>", \
						"<span class='userdanger'>You're locked into a restraining position by [A]!</span>", "<span class='hear'>You hear shuffling and a muffled groan!</span>", null, A)
		to_chat(A, "<span class='danger'>You lock [D] into a restraining position!</span>")
		D.adjustStaminaLoss(20)
		D.Stun(65)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE) 
		restraining = TRUE
		addtimer(VARSET_CALLBACK(src, restraining, FALSE), 50, TIMER_UNIQUE)
	return TRUE

/datum/martial_art/police_jiu/proc/Consecutive(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		log_combat(A, D, "consecutive Police jiu'd (Police_Jiu)")
		D.visible_message("<span class='danger'>[A] strikes [D]'s abdomen, neck and back consecutively</span>", \
						"<span class='userdanger'>Your abdomen, neck and back are struck consecutively by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You strike [D]'s abdomen, neck and back consecutively!</span>")
		playsound(get_turf(D), 'sound/weapons/cqchit2.ogg', 50, TRUE, -1)
		var/obj/item/I = D.get_active_held_item()
		if(I && D.temporarilyRemoveItemFromInventory(I))
			A.put_in_hands(I)
		D.adjustStaminaLoss(35)
		D.apply_damage(25, A.get_attack_type())
	return TRUE

/datum/martial_art/police_jiu/proc/Footboard(mob/living/A, mob/living/D)
	var/obj/item/bodypart/affecting = D.get_bodypart(BODY_ZONE_CHEST)
	D.visible_message("<span class='warning'>[A] punches liver [D]!</span>", \
					"<span class='userdanger'>Your liver blowed by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
	to_chat(A, "<span class='danger'>You liver punch[D]!</span>")
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	D.Knockdown(80)
	log_combat(A, D, "punched liver(Police_Jiu)")
	D.adjustStaminaLoss(25)
	sleep(5)
	D.adjustStaminaLoss(9)
	sleep(5)
	D.adjustStaminaLoss(8)
	sleep(5)
	D.adjustStaminaLoss(7)
	sleep(5)
	D.adjustStaminaLoss(6)
	sleep(5)
	D.adjustStaminaLoss(5)
	sleep(5)
	D.adjustStaminaLoss(4)
	sleep(5)
	D.adjustStaminaLoss(3)
	sleep(5)
	D.adjustStaminaLoss(2)
	sleep(5)
	D.adjustStaminaLoss(1)
	return TRUE

/datum/martial_art/police_jiu/proc/Laying(mob/living/A, mob/living/D)
	D.visible_message("<span class='danger'>[A] pins [D] into the ground!</span>", \
					"<span class='userdanger'>You're pinned into the ground by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You pin [D] into the ground!</span>")
	playsound(get_turf(A), 'sound/weapons/cqchit2.ogg', 50, TRUE, -1)
	D.adjustStaminaLoss(25)
	D.Paralyze(20)
	D.Stun(125)
	if(D.body_position == STANDING_UP)
		D.toggle_resting()
	log_combat(A, D, "pinned (Police_Jiu)")
	return TRUE


/datum/martial_art/police_jiu/grab_act(mob/living/A, mob/living/D)
	if(A.a_intent == INTENT_GRAB && A!=D && can_use(A)) // A!=D prevents grabbing yourself
		add_to_streak("G",D)
		if(check_streak(A,D))
			return FALSE
			return TRUE
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE) //Instant agressive grab if on grab intent
			log_combat(A, D, "grabbed", addition="aggressively")
			D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
		else
			add_to_streak("G",D)
		return TRUE
	else
		return FALSE

/datum/martial_art/police_jiu/harm_act(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "attacked (Police Jiu)")
	A.do_attack_animation(D)
	var/picked_hit_type = pick("Police Jiu", "Big Boss")
	var/bonus_damage = 5
	if(D.body_position == LYING_DOWN)
		bonus_damage += 5
		picked_hit_type = "stomp"
	D.apply_damage(bonus_damage, BRUTE)
	if(picked_hit_type == "kick" || picked_hit_type == "stomp")
		playsound(get_turf(D), 'sound/weapons/cqchit2.ogg', 50, TRUE, -1)
	else
		playsound(get_turf(D), 'sound/weapons/cqchit1.ogg', 50, TRUE, -1)
	D.visible_message("<span class='danger'>[A] [picked_hit_type]ed [D]!</span>", \
					"<span class='userdanger'>You're [picked_hit_type]ed by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You [picked_hit_type] [D]!</span>")
	log_combat(A, D, "[picked_hit_type]s (Police Jiu)")
	if(A.resting && !D.stat && !D.IsParalyzed())
		D.visible_message("<span class='danger'>[A] leg sweeps [D]!</span>", \
						"<span class='userdanger'>Your legs are sweeped by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You leg sweep [D]!</span>")
		playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
		D.apply_damage(5, BRUTE)
		D.Paralyze(30)
		log_combat(A, D, "sweeped (Police Jiu)")
	return TRUE

/datum/martial_art/police_jiu/disarm_act(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("D",D)
	var/obj/item/I = null
	if(check_streak(A,D))
		return TRUE
	if(prob(rand(10, 100)))
		if(!D.stat || !D.IsParalyzed() || !restraining)
			I = D.get_active_held_item()
			D.visible_message("<span class='danger'>[A] tries to tackle [D] to the ground!</span>", \
							"<span class='userdanger'>[A] Shoves you to the ground!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You tackle [D].</span>")
			playsound(get_turf(D), 'sound/weapons/cqchit1.ogg', 50, TRUE, -1)
			if(I && D.temporarilyRemoveItemFromInventory(I))
				A.put_in_hands(I)
			D.Jitter(10)
			D.adjustStaminaLoss(15)
			D.Knockdown(15)
	else
		D.visible_message("<span class='danger'>[A] fails to disarm [D]!</span>", \
						"<span class='userdanger'>You're nearly disarmed by [A]!</span>", "<span class='hear'>You hear a swoosh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='warning'>You fail to disarm [D]!</span>")
		playsound(D, 'sound/weapons/cqchit1.ogg', 25, TRUE, -1)
		D.adjustStaminaLoss(10)
	log_combat(A, D, "disarmed (Police Jiu)", "[I ? " grabbing \the [I]" : ""]")
	if(restraining && A.pulling == D)
		log_combat(A, D, "knocked out (Chokehold)(Police Jiu)")
		D.visible_message("<span class='danger'>[A] puts [D] into a chokehold!</span>", \
						"<span class='userdanger'>You're put into a chokehold by [A]!</span>", "<span class='hear'>You hear shuffling and a muffled groan!</span>", null, A)
		to_chat(A, "<span class='danger'>You put [D] into a chokehold!</span>")

		if(ishuman(D) || iswerewolf(D) || isghoul(D))
			D.SetSleeping(400)
		restraining = FALSE
		if(A.grab_state < GRAB_NECK && !HAS_TRAIT(A, TRAIT_PACIFISM))
			A.setGrabState(GRAB_NECK)
	else
		restraining = FALSE
		return FALSE
	return TRUE

/mob/living/proc/PJ_help()
	set name = "Remember The Basics"
	set desc = "You try to remember some of the basics of Police Martial Art."
	set category = "Police"
	to_chat(usr, "<b><i>You try to remember some of the basics of your Martial Arts.</i></b>")

	var/list/result = get_martial_info()
	to_chat(usr, result.Join("\n"))

	to_chat(usr, "<b><i>In addition, by having your throw mode on when being attacked, you enter an active defense mode where you have a chance to block and sometimes even counter attacks done to you.</i></b>")




/atom/proc/get_martial_info()
	. = list("<span class='info'>*---------*\nThis is <EM>Police Jitsu</EM>!")

	. += "<span class='notice'>Brush clip</span>: Grab Disarm. A brush clip with which you can put criminal on the ground.</span>"
	. += "<span class='notice'>Wrung Hand</span>: Disarm Grab. Quickly disarms criminal.</span>"
	. += "<span class='notice'>Restrain</span>: Grab Grab. Locks opponents into a restraining position, disarm to knock them out with a chokehold.</span>"
	. += "<span class='notice'>Handcuffs combo</span>: Harm Grab Harm Grab. Put the criminal in handcuffs using an effective technique.</span>"
	. += "<span class='notice'>Consecutive</span>: Harm Disarm. Mainly offensive move, huge damage and mid stamina damage.</span>"
	. += "<span class='notice'>Liver Punch</span>: Disarm Harm. Punch criminal's liver making them weaker over time.</span>"
	. += "<span class='notice'>Laying</span>: Disarm Disarm Disarm Disarm. Pin the criminal on the ground without any consequences.</span>"
	. += "<span class='notice'>Choke</span>: Harm Harm Harm. Chocke your opponent. Or choke with your knee if he's lying down(more effective).</span>"

#undef BRUSH_CLIP
#undef WRUNG_HAND
#undef RESTRAIN_COMBO
#undef HANDCUFFS_COMBO
#undef CONSECUTIVE_COMBO
#undef FOOTBOARD
#undef LAYING
#undef CHOKE
