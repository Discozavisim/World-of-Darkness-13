/datum/action/chi_discipline
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS
	button_icon = 'code/modules/wod13/UI/kuei_jin.dmi' //This is the file for the BACKGROUND icon
	background_icon_state = "discipline" //And this is the state for the background icon

	icon_icon = 'code/modules/wod13/UI/kuei_jin.dmi' //This is the file for the ACTION icon
	button_icon_state = "discipline" //And this is the state for the action icon
	vampiric = TRUE
	var/level_icon_state = "1" //And this is the state for the action icon
	var/datum/chi_discipline/discipline
	var/active_check = FALSE

/datum/action/chi_discipline/Trigger()
	if(discipline && isliving(owner))
		var/mob/living/owning = owner
		if(discipline.ranged)
			if(!active_check)
				active_check = TRUE
				if(owning.chi_ranged)
					owning.chi_ranged.Trigger()
				owning.chi_ranged = src
				if(button)
					button.color = "#970000"
			else
				active_check = FALSE
				owning.chi_ranged = null
				button.color = "#ffffff"
		else
			if(discipline)
				if(discipline.check_activated(owner, owner))
					discipline.activate(owner, owner)
	. = ..()

/datum/action/chi_discipline/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	button_icon = 'code/modules/wod13/UI/kuei_jin.dmi'
	icon_icon = 'code/modules/wod13/UI/kuei_jin.dmi'
	if(icon_icon && button_icon_state && ((current_button.button_icon_state != button_icon_state) || force))
		current_button.cut_overlays(TRUE)
		if(discipline)
			current_button.name = discipline.name
			current_button.desc = discipline.desc
			current_button.add_overlay(mutable_appearance(icon_icon, "[discipline.icon_state]"))
			current_button.button_icon_state = "[discipline.icon_state]"
			current_button.add_overlay(mutable_appearance(icon_icon, "[discipline.level_casting]"))
		else
			current_button.add_overlay(mutable_appearance(icon_icon, button_icon_state))
			current_button.button_icon_state = button_icon_state

/datum/action/chi_discipline/proc/switch_level()
	SEND_SOUND(owner, sound('code/modules/wod13/sounds/highlight.ogg', 0, 0, 50))
	if(discipline)
		if(discipline.level_casting < discipline.level)
			discipline.level_casting = discipline.level_casting+1
			if(button)
				ApplyIcon(button, TRUE)
			return
		else
			discipline.level_casting = 1
			if(button)
				ApplyIcon(button, TRUE)
			return

/mob/living/Click()
	if(isliving(usr) && usr != src)
		var/mob/living/L = usr
		if(L.chi_ranged)
			L.chi_ranged.active_check = FALSE
			if(L.chi_ranged.button)
				animate(L.chi_ranged.button, color = "#ffffff", time = 10, loop = 1)
			if(L.chi_ranged.discipline.check_activated(src, usr))
				L.chi_ranged.discipline.activate(src, usr)
			L.chi_ranged = null
	. = ..()

//			if(DISCP)
//				if(DISCP.active)
//					DISCP.range_activate(src, SH)
//					SH.face_atom(src)
//					return

/atom/movable/screen/movable/action_button/Click(location,control,params)
	if(istype(linked_action, /datum/action/chi_discipline))
		var/list/modifiers = params2list(params)
		if(LAZYACCESS(modifiers, "right"))
			var/datum/action/chi_discipline/D = linked_action
			D.switch_level()
			return
	. = ..()

/datum/chi_discipline
	///Name of this Discipline.
	var/name = "Chi Discipline"
	///Text description of this Discipline.
	var/desc = "Discipline with powers such as..."
	///Icon for this Discipline as in disciplines.dmi
	var/icon_state
	///Cost in yin points of activating this Discipline.
	var/cost_yin = 0
	///Cost in yang points of activating this Discipline.
	var/cost_yang = 0
	///Cost in demon points of activating this Discipline.
	var/cost_demon = 0
	//Is ranged?
	var/ranged = FALSE
	///Duration and cooldown of the Discipline.
	var/delay = 0.5 SECONDS
	///Whether this Discipline causes a Masquerade breach when used in front of mortals.
	var/violates_masquerade = FALSE
	///What rank, or how many dots the caster has in this Discipline.
	var/level = 1
	///The sound that plays when any power of this Discipline is activated.
	var/activate_sound = 'code/modules/wod13/sounds/chi_use.ogg'

	var/dead_restricted
	///What rank of this Discipline is currently being casted.
	var/level_casting = 1

	var/discipline_type = "Shintai"		//Either "Shintai", "Chi" or "Demon" arts
	COOLDOWN_DECLARE(activate)

/datum/chi_discipline/proc/post_gain(mob/living/carbon/human/user)
	return

/datum/chi_discipline/proc/check_activated(mob/living/target, mob/living/carbon/human/caster)
	SHOULD_CALL_PARENT(TRUE)

	if(caster.stat >= HARD_CRIT || caster.IsSleeping() || caster.IsUnconscious() || caster.IsParalyzed() || caster.IsStun() || HAS_TRAIT(caster, TRAIT_RESTRAINED))
		return FALSE

	if(!COOLDOWN_FINISHED(src, activate))
		to_chat(caster, "<span class='warning'>Wait [DisplayTimeText(COOLDOWN_TIMELEFT(src, activate))] before you can use [src] again!</span>")
		return FALSE

	if(caster.yin_chi < cost_yin)
		SEND_SOUND(caster, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
		to_chat(caster, "<span class='warning'>You don't have enough <b>Yin Chi</b> to use [src].</span>")
		return FALSE

	if(caster.yang_chi < cost_yang)
		SEND_SOUND(caster, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
		to_chat(caster, "<span class='warning'>You don't have enough <b>Yang Chi</b> to use [src].</span>")
		return FALSE

	if(caster.demon_chi < cost_demon)
		SEND_SOUND(caster, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
		to_chat(caster, "<span class='warning'>You don't have enough <b>Demon Chi</b> to use [src].</span>")
		return FALSE

	if(HAS_TRAIT(caster, TRAIT_PACIFISM))
		return FALSE

	if(target.stat == DEAD && dead_restricted)
		return FALSE

	if(target.resistant_to_disciplines)
		to_chat(caster, "<span class='danger'>[target] resists your powers!</span>")
		return FALSE

	return TRUE

/datum/chi_discipline/proc/activate(mob/living/target, mob/living/carbon/human/caster)
	SHOULD_CALL_PARENT(TRUE)

	if(!target)
		return
	if(!caster)
		return

	COOLDOWN_START(src, activate, delay)

	caster.yin_chi = max(0, caster.yin_chi - cost_yin)
	caster.yang_chi = max(0, caster.yang_chi - cost_yang)
	caster.demon_chi = max(0, caster.demon_chi - cost_demon)
	caster.update_chi_hud()

	if(ranged)
		if(isnpc(target))
			var/mob/living/carbon/human/npc/NPC = target
			NPC.Aggro(caster, TRUE)

	if(activate_sound)
		caster.playsound_local(caster, activate_sound, 50, FALSE)

	if(violates_masquerade)
		if(caster.CheckEyewitness(target, caster, 7, TRUE))
			caster.AdjustMasquerade(-1)

	to_chat(caster, "<span class='notice'>You activate [src][(ranged && target) ? " on [target]" : ""].</span>")
	log_attack("[key_name(caster)] casted level [src.level_casting] of the Discipline [src.name][target == caster ? "." : " on [key_name(target)]"]")
