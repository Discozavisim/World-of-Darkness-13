GLOBAL_LIST_EMPTY(global_tentacle_grabs)

/datum/discipline/obtenebration
	name = "Obtenebration"
	desc = "Controls the darkness around you."
	icon_state = "obtenebration"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/obtenebration

/datum/discipline/obtenebration/post_gain()
	. = ..()
	var/datum/action/mysticism/mystic = new()
	owner.mysticism_knowledge = TRUE
	mystic.Grant(owner)
	mystic.level = level
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/mystome)

/datum/discipline_power/obtenebration
	name = "Obtenebration power name"
	desc = "Obtenebration power description"

	effect_sound = 'sound/magic/voidblink.ogg'

//SHADOW PLAY
/datum/discipline_power/obtenebration/shadow_play
	name = "Shadow Play"
	desc = "Manipulate shadows to block visibility."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_TURF | TARGET_MOB | TARGET_OBJ | TARGET_SELF
	range = 7

	violates_masquerade = TRUE

	multi_activate = TRUE
	duration_length = 10 SECONDS
	cooldown_length = 5 SECONDS

	var/list/shadows = list() // A list of all active shadows

	var/datum/action/clear_shadows/cbutton // The button to clear everything

/turf
	var/shadow_count = 0

/atom/movable/shadow_area
	var/list/affected_tiles = list()
	var/list/affected_lamp_decals = list()

/obj/effect/decal/lamplight
	var/shadow_count = 0


/datum/discipline_power/obtenebration/shadow_play/activate(target)
	. = ..()
	var/atom/movable/shadow_area/new_shadow = new(target)
	new_shadow.set_light(discipline.level+2, -10) // Ideally, the shadows would be a special thing impenetrable by anyone but the user, but this works for now
	var/list/tiles = list()
	var/list/lamp_decals = list()
	for(var/turf/T in range(discipline.level * 2, new_shadow))
		tiles += T
		T.shadow_count += 1
		if(T.shadow_count == 1)
			T.lumcount_override = FALSE
	for(var/obj/effect/decal/lamplight/L in range(discipline.level * 2, new_shadow))
		lamp_decals += L
		L.shadow_count += 1
		if(L.shadow_count == 1)
			L.alpha = 0

	new_shadow.affected_tiles += tiles
	new_shadow.affected_lamp_decals += lamp_decals
	shadows += new_shadow
	if(!cbutton) // Grant the button if it doesn't exist
		cbutton = new(src)
		cbutton.Grant(owner)
	addtimer(CALLBACK(src, PROC_REF(remove_shadow), new_shadow), duration_length) // 3 minute timer per shadow

/datum/discipline_power/obtenebration/shadow_play/proc/remove_shadow(atom/movable/shadow_area/old_shadow)
	if(old_shadow && (old_shadow in shadows)) // Check if shadow still exists
		shadows -= old_shadow
		for(var/turf/T in old_shadow.affected_tiles)
			T.shadow_count -= 1
			old_shadow.affected_tiles -= T
			if(T.shadow_count <= 0)
				T.shadow_count = 0
				T.lumcount_override = TRUE
		for(var/obj/effect/decal/lamplight/L in old_shadow.affected_lamp_decals)
			L.shadow_count -= 1
			old_shadow.affected_lamp_decals -= L
			if(L.shadow_count <= 0)
				L.shadow_count = 0
				L.alpha = initial(L.alpha)
		qdel(old_shadow)

	if(!length(shadows) && cbutton) // Remove the button if there are no shadows left
		cbutton.Remove(owner)
		QDEL_NULL(cbutton)

/datum/discipline_power/obtenebration/shadow_play/proc/remove_all_shadows()
	for(var/atom/movable/shadow_area/all_shadows in shadows)
		for(var/turf/T in all_shadows.affected_tiles)
			T.shadow_count = 0
			T.lumcount_override = TRUE
		all_shadows.affected_tiles.Cut()
		all_shadows.affected_lamp_decals.Cut()
		qdel(all_shadows)
	if(cbutton)
		cbutton.Remove(owner)
		QDEL_NULL(cbutton)

//SHROUD OF NIGHT
/datum/discipline_power/obtenebration/shroud_of_night
	name = "Shroud of Night"
	desc = "Turn the shadows into appendages to pull your enemies."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_LYING | DISC_CHECK_IMMOBILE
	target_type = TARGET_MOB
	range = 7

	aggravating = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS

/datum/discipline_power/obtenebration/shroud_of_night/activate(mob/living/target)
	. = ..()
	target.Stun(1 SECONDS)
	var/obj/item/ammo_casing/magic/tentacle/lasombra/casing = new (owner.loc)
	casing.fire_casing(target, owner, null, null, null, ran_zone(), 0,  owner)

//ARMS OF THE ABYSS
/datum/discipline_power/obtenebration/arms_of_the_abyss
	name = "Arms of the Abyss"
	desc = "Use shadows as your arms to harm and grab others from afar."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE

	vitae_cost = 0

	target_type = TARGET_TURF
	range = 7
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS

	var/datum/action/clear_tentacles/tbutton // The button to clear everything

/datum/discipline_power/obtenebration/arms_of_the_abyss/activate(atom/target)
	. = ..()
	var/turf/target_turf = get_turf(target)
	var/dice = get_a_manipulation(owner)+get_a_occult(owner)

	if(target_turf && target_turf.get_lumcount() <= 0.4) // Only works if the area is dark enough. Modify as needed.
		// Remove any existing tentacles first
		for(var/mob/living/simple_animal/hostile/abyss_tentacle/T in world)
			if(T.owner == owner)
				T.release_grabbed_mob()
				qdel(T)
		var/roll = secret_vampireroll(dice, 7, owner)
		var/has_action = FALSE
		for(var/datum/action/A in owner.actions)
			if(istype(A, /datum/action/aggro_mode))
				has_action = TRUE
				break

		// Grant the aggro mode button if it doesn't exist
		if(!has_action)
			var/datum/action/aggro_mode/A = new()
			A.Grant(owner)

		if(!tbutton) // Grant the button if it doesn't exist
			tbutton = new(src)
			tbutton.Grant(owner)

		// Create tentacles based on successes
		for(var/i in 1 to roll)
			// For the first tentacle, use the target turf
			if(i == 1 && !target_turf.is_blocked_turf(exclude_mobs = TRUE))
				new /mob/living/simple_animal/hostile/abyss_tentacle(target_turf, owner)
			else
				// For additional tentacles, find nearby valid turfs
				var/list/open_turfs = list()
				for(var/turf/T in orange(3, target_turf))
					if(!T.is_blocked_turf(exclude_mobs = TRUE) && T.get_lumcount() <= 0.4)
						open_turfs += T
				if(open_turfs.len)
					new /mob/living/simple_animal/hostile/abyss_tentacle(pick(open_turfs), owner)
	else
		to_chat(usr, span_warning("The area is too bright for the shadows to manifest!"))
		return FALSE

/datum/discipline_power/obtenebration/arms_of_the_abyss/proc/remove_all_tentacles()
	for(var/mob/living/simple_animal/hostile/abyss_tentacle/T in world)
		if(T.owner == owner)
			if(!length(T) && tbutton)
				tbutton.Remove(owner)
				QDEL_NULL(tbutton)
			T.release_grabbed_mob()
			qdel(T)

//BLACK METAMORPHOSIS
/datum/discipline_power/obtenebration/black_metamorphosis
	name = "Black Metamorphosis"
	desc = "Fuse with your inner darkness, gaining shadowy armor."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	vitae_cost = 0

	violates_masquerade = TRUE

	grouped_powers = list(
		/datum/discipline_power/obtenebration/tenebrous_form
	)


	toggled = TRUE
	duration_length = 999 SCENES

	var/activating = FALSE
	var/successful = FALSE

/datum/discipline_power/obtenebration/black_metamorphosis/pre_activation_checks()
	. = ..()
	if(activating) // Prevent multi-activation while the do_after is ongoing
		to_chat(owner, span_warning("You are already attempting to activate Black Metamorphosis!"))
		return FALSE
	else if(!activating)
		if(owner.bloodpool >= 2)
			owner.bloodpool -= 2 // Pay the cost here to prevent spending more from multi-activation attempts
		else
			to_chat(owner, span_warning("You do not have enough vitae to activate Black Metamorphosis!"))
			return FALSE

	if(owner.generation >= 10)
		activating = TRUE
		to_chat(owner, span_warning("Your body starts to meld with the shadows..."))
		if(do_after(owner, 2 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE
	else if(owner.generation <= 9)
		activating = TRUE
		to_chat(owner, span_warning("Your body starts to rapidly meld with the shadows..."))
		if(do_after(owner, 1 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE

/datum/discipline_power/obtenebration/black_metamorphosis/activate()
	. = ..()
	activating = FALSE
	var/roll = secret_vampireroll(get_a_manipulation(owner)+owner.MyPath?.courage, 8, owner)
	if(roll >= 3)
		successful = TRUE
		owner.physiology.damage_resistance += 60
		animate(owner, color = "#000000", time = 1 SECONDS, loop = 1)
		to_chat(owner, span_green("You successfully fuse with the shadows!"))
	else if(roll < 0)
		owner.apply_damage(60, BRUTE) // 2 levels of lethal damage on a botch
		to_chat(owner, span_danger("The shadows lash out at you as you fail to fuse with them!"))
		deactivate()
	else if(roll <= 2)
		to_chat(owner, span_warning("You fail to control the shadows!"))
		deactivate()

/datum/discipline_power/obtenebration/black_metamorphosis/deactivate()
	. = ..()
	if(!successful)
		return
	to_chat(owner, span_notice("The shadows fall away from your body."))
	playsound(owner.loc, 'sound/magic/voidblink.ogg', 50, FALSE)
	owner.physiology.damage_resistance -= 60
	animate(owner, color = initial(owner.color), time = 1 SECONDS, loop = 1)

//TENEBROUS FORM
/datum/discipline_power/obtenebration/tenebrous_form
	name = "Tenebrous Form"
	desc = "Become a shadow and move without your physical form."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING

	violates_masquerade = TRUE

	vitae_cost = 0

	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/obtenebration/black_metamorphosis
	)

	duration_length = 999 SCENES
	cooldown_length = 1 TURNS

	var/activating = FALSE
	var/saved_brute_mod = 1
	var/saved_clone_mod = 1
	var/saved_stamina_mod = 1
	var/saved_brain_mod = 1
	var/saved_density

/datum/discipline_power/obtenebration/tenebrous_form/pre_activation_checks()
	. = ..()
	if(activating) // Prevent multi-activation while the do_after is ongoing
		to_chat(owner, span_warning("You are already attempting to activate Tenebrous Form!"))
		return FALSE
	else if(!activating)
		if(owner.bloodpool >= 3)
			owner.bloodpool -= 3 // Pay the cost here to prevent spending more from multi-activation attempts
		else
			to_chat(owner, span_warning("You do not have enough vitae to activate Tenebrous Form!"))
			return FALSE

	// do_after timer based on generation; gen 9 and below can spend more BP per turn, so it activates faster
	if(owner.generation >= 10)
		activating = TRUE
		to_chat(owner, span_warning("Your body slowly starts to turn into an inky blot of shadow..."))
		if(do_after(owner, 3 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE
	else if(owner.generation == 9)
		activating = TRUE
		to_chat(owner, span_warning("Your body starts to turn into an inky blot of shadow..."))
		if(do_after(owner, 2 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE
	else if(owner.generation <= 8)
		activating = TRUE
		to_chat(owner, span_warning("Your body rapidly starts to turn into an inky blot of shadow..."))
		if(do_after(owner, 1 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE

/datum/discipline_power/obtenebration/tenebrous_form/activate()
	. = ..()
	activating = FALSE
	playsound(owner.loc, 'sound/magic/voidblink.ogg', 50, FALSE)
	saved_brute_mod = owner.physiology.brute_mod
	owner.physiology.brute_mod = 0
	saved_clone_mod = owner.physiology.clone_mod
	owner.physiology.clone_mod = 0
	saved_stamina_mod = owner.physiology.stamina_mod
	owner.physiology.stamina_mod = 0
	saved_brain_mod = owner.physiology.brain_mod
	owner.physiology.brain_mod = 0
	animate(owner, color = "#000000", time = 1 SECONDS, loop = 1)

	ADD_TRAIT(owner, TRAIT_STUNIMMUNE, MAGIC)
	ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC)
	ADD_TRAIT(owner, TRAIT_NOBLEED, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_PACIFISM, MAGIC_TRAIT) // Can't physically attack while in this form
	ADD_TRAIT(owner, TRAIT_MOVE_FLYING, MAGIC) // Flying to simulate being unaffected by gravity
	ADD_TRAIT(owner, TRAIT_PASSDOOR, MAGIC) // Trait to phase through doors
	ADD_TRAIT(owner, TRAIT_PASSTABLE, MAGIC) // Trait to phase through tables

	saved_density = owner.density
	owner.density = FALSE

/datum/discipline_power/obtenebration/tenebrous_form/deactivate()
	. = ..()
	to_chat(owner, span_notice("You return to your normal form."))
	playsound(owner.loc, 'sound/magic/voidblink.ogg', 50, FALSE)
	owner.physiology.brute_mod = saved_brute_mod
	owner.physiology.clone_mod = saved_clone_mod
	owner.physiology.stamina_mod = saved_stamina_mod
	owner.physiology.brain_mod = saved_brain_mod
	animate(owner, color = initial(owner.color), time = 1 SECONDS, loop = 1)

	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, MAGIC)
	REMOVE_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC)
	REMOVE_TRAIT(owner, TRAIT_NOBLEED, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_MOVE_FLYING, MAGIC)
	REMOVE_TRAIT(owner, TRAIT_PASSDOOR, MAGIC)
	REMOVE_TRAIT(owner, TRAIT_PASSTABLE, MAGIC)
	owner.density = saved_density


// **************************************************************** ACTIONS ****************************************************************

// Aggro mode control for Arms of the Abyss
/datum/action/aggro_mode
	name = "Tentacle Control"
	desc = "Switches the aggro mode of your Arms of the Abyss"
	icon_icon = 'icons/hud/screen_glass.dmi'
	button_icon_state = "harm"
	var/current_mode = "Aggressive"

/datum/action/aggro_mode/New()
	..()
	button.name = name
	update_icon_state()

/datum/action/aggro_mode/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/user = owner
	if(!isliving(user))
		return
	var/mob/living/Tuser = user
	var/list/options = list(
		"Aggressive" = "Aggressive (grab and damage targets)",
		"Control" = "Control (grab and restrain without damage)",
		"Passive" = "Passive (don't attack or grab)"
	)

	var/select = tgui_input_list(user, "Select tentacle behaviour", "Tentacle Mode", options)
	if(!select || !Tuser)
		return
	current_mode = select
	Tuser.tentacle_aggro_mode = select

	var/tentacles = 0
	for(var/mob/living/simple_animal/hostile/abyss_tentacle/T in world)
		if(T.owner == Tuser)
			T.aggro_mode = select
			tentacles++

	if(tentacles)
		to_chat(Tuser, span_notice("You set your tentacle[tentacles == 1 ? "" : "s"] to [select] mode."))
		update_icon_state()

/datum/action/aggro_mode/proc/update_icon_state()
	if(button)
		button.overlays.Cut()
		button.icon = null
		button.icon_state = ""

	switch(current_mode)
		if("Aggressive")
			button_icon_state = "harm"
		if("Control")
			button_icon_state = "grab"
		if("Passive")
			button_icon_state = "disarm"

	if(button)
		button.icon = icon_icon
		button.icon_state = button_icon_state

// Shadow removal button for Shadow Play
/datum/action/clear_shadows
	name = "Clear Shadows"
	desc = "Clears all currently active Shadow Play shadows"
	icon_icon = 'icons/effects/genetics.dmi'
	button_icon_state = "shadow_portal"
	var/datum/discipline_power/obtenebration/shadow_play/power

/datum/action/clear_shadows/New(Target)
	. = ..()
	power = Target

/datum/action/clear_shadows/Trigger(trigger_flags)
	. = ..()
	if(.)
		power.remove_all_shadows()

// Tentacle removal button for Arms of the Abyss
/datum/action/clear_tentacles
	name = "Clear Tentacles"
	desc = "Clears all currently active Arms of the Abyss tentacles"
	icon_icon = 'icons/hud/actions.dmi'
	button_icon_state = "tentacles"
	var/datum/discipline_power/obtenebration/arms_of_the_abyss/power

/datum/action/clear_tentacles/New(Target)
	. = ..()
	power = Target

/datum/action/clear_tentacles/Trigger(trigger_flags)
	. = ..()
	if(.)
		power.remove_all_tentacles()

/mob/living/simple_animal/hostile/abyss_tentacle
	name = "abyssal tentacle"
	desc = "A shadowy tentacle from the abyss that seeks to grab and crush its prey."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "Goliath_tentacle_wiggle"
	icon_living = "Goliath_tentacle_wiggle"
	icon_dead = "Goliath_tentacle_retract"
	color = rgb(0,0,0)
	layer = BELOW_MOB_LAYER
	anchored = TRUE
	notransform = TRUE
	density = FALSE
	maxHealth = 120
	health = 120
	see_in_dark = 10

	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "crushes"
	attack_verb_simple = "crush"
	attack_sound = 'sound/weapons/punch1.ogg'
	speak_emote = list("writhes")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	del_on_death = TRUE

	vision_range = 7
	aggro_vision_range = 7
	environment_smash = ENVIRONMENT_SMASH_NONE

	var/mob/living/owner
	var/mob/living/grabbed_mob = null
	var/list/recently_released = list()
	var/aggro_mode = "Aggressive"
	var/light_exposure_time = 0
	COOLDOWN_DECLARE(grab_cooldown)
	COOLDOWN_DECLARE(damage_cooldown)

/mob/living/simple_animal/hostile/abyss_tentacle/Initialize(mapload, mob/living/summoner)
	. = ..()
	if(summoner)
		owner = summoner
	if(owner.tentacle_aggro_mode)
		aggro_mode = owner.tentacle_aggro_mode

	COOLDOWN_START(src, grab_cooldown, 1 SECONDS)
	COOLDOWN_START(src, damage_cooldown, 1 SECONDS)
	START_PROCESSING(SSobj, src)

/mob/living/simple_animal/hostile/abyss_tentacle/Destroy()
	release_grabbed_mob()
	STOP_PROCESSING(SSobj, src)
	return ..()

/mob/living/simple_animal/hostile/abyss_tentacle/CanAttack(atom/targ)
	if(!isliving(targ))
		return FALSE

	var/mob/living/L = targ

	if(L == owner)
		return FALSE
	if(istype(L, /mob/living/simple_animal/hostile/abyss_tentacle))
		return FALSE
	if(L.stat == DEAD)
		return FALSE
	if(L == grabbed_mob)
		return FALSE
	if(L in GLOB.global_tentacle_grabs)
		return FALSE
	if(L in recently_released)
		return FALSE
	if(get_dist(src, L) > 1)
		return FALSE

	return ..()

/mob/living/simple_animal/hostile/abyss_tentacle/process(delta_time)
	var/turf/T = get_turf(src)
	if(T.get_lumcount() >= 0.4)
		light_exposure_time += delta_time
		if(light_exposure_time >= 2 SECONDS)
			if(grabbed_mob)
				release_grabbed_mob()
			qdel(src)
			return
	else
		light_exposure_time = 0
	if(aggro_mode == "Passive")
		if(grabbed_mob)
			release_grabbed_mob()
		else
			return

	if(COOLDOWN_FINISHED(src, grab_cooldown) && !grabbed_mob && aggro_mode != "Passive")
		COOLDOWN_START(src, grab_cooldown, 2 SECONDS)

		// Find & grab target
		var/mob/living/target_to_grab
		for(var/mob/living/L in view(2, src))
			if(L == owner || L.stat == DEAD || L == grabbed_mob || (L in recently_released)) // Not owner, dead, grabbed, or recently released
				continue
			if(istype(L, /mob/living/simple_animal/hostile/abyss_tentacle)) // Not another tentacle
				continue
			if(L in GLOB.global_tentacle_grabs) // Not on The List tm
				continue
			target_to_grab = L
			break

		if(target_to_grab)
			grab_mob(target_to_grab)

	// Damage grabbed mob occasionally
	if(aggro_mode == "Aggressive" && COOLDOWN_FINISHED(src, damage_cooldown) && grabbed_mob)
		COOLDOWN_START(src, damage_cooldown, 5 SECONDS)
		grabbed_mob.apply_damage(40, BRUTE)
		to_chat(grabbed_mob, span_danger("The tentacle tightens its grip, crushing you!"))
		playsound(/mob/living/simple_animal/hostile/abyss_tentacle, 'sound/creatures/venus_trap_hurt.ogg', 50, FALSE)

/mob/living/simple_animal/hostile/abyss_tentacle/proc/grab_mob(mob/living/target)
	// More checks
	if(target == owner || istype(target, /mob/living/simple_animal/hostile/abyss_tentacle)) // Not owner, not another tentacle
		return
	if(target in GLOB.global_tentacle_grabs) // Not grabbed by another tentacle
		return
	if(grabbed_mob) // Not already grabbing someone
		return
	if(target.client)
		to_chat(target, span_userdanger("A shadowy tentacle grabs you!"))
	visible_message(span_danger("[src] grabs hold of [target]!"))

	// Grab effects, short stun & drag
	playsound(/mob/living/simple_animal/hostile/abyss_tentacle, 'sound/misc/moist_impact.ogg', 50, FALSE)
	target.Stun(5)
	target.forceMove(get_turf(src))
	target.set_tentacle_grab(src)

	if(aggro_mode == "Control")
		target.mobility_flags &= ~(MOBILITY_STAND | MOBILITY_MOVE)
		target.set_resting(TRUE, TRUE, TRUE)
		to_chat(target, span_userdanger("The tentacle forces you to the ground!"))

	grabbed_mob = target
	GLOB.global_tentacle_grabs += target

	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(on_grabbed_mob_move))

/mob/living/simple_animal/hostile/abyss_tentacle/proc/release_mob(mob/living/target, add_cooldown = TRUE)
	if(target == grabbed_mob)
		grabbed_mob = null
		GLOB.global_tentacle_grabs -= target
		target.Stun(0)
		target.clear_tentacle_grab()

		if(aggro_mode == "Control")
			target.mobility_flags |= (MOBILITY_STAND | MOBILITY_MOVE)
			target.set_resting(FALSE, TRUE, TRUE)

		UnregisterSignal(target, COMSIG_MOVABLE_MOVED)
		to_chat(target, span_notice("The tentacle releases you!"))

		if(add_cooldown)
			recently_released += target
			addtimer(CALLBACK(src, PROC_REF(remove_from_recently_released), target), 10 SECONDS)

/mob/living/simple_animal/hostile/abyss_tentacle/proc/remove_from_recently_released(mob/living/target)
	recently_released -= target

/mob/living/simple_animal/hostile/abyss_tentacle/proc/release_grabbed_mob()
	if(grabbed_mob)
		release_mob(grabbed_mob, FALSE)

/mob/living/simple_animal/hostile/abyss_tentacle/proc/on_grabbed_mob_move(mob/living/source, atom/old_loc, movement_dir, forced)
	SIGNAL_HANDLER
	// If they try to move away, roll to break free
	if(get_dist(source, src) > 0)
		if(world.time >= source.escape_attempt)
			source.escape_attempt = world.time + 5 SECONDS
			var/rollcheck = secret_vampireroll(get_a_strength(source), 6, source)
			if(rollcheck >= 3)
				to_chat(source, span_notice("You break free from the tentacle's grasp!"))
				release_mob(source, TRUE) // Cooldown!
				return

			else
				to_chat(source, span_warning("You struggle against the tentacle but can't break free!"))

		source.visible_message(span_danger("The tentacle pulls [source] back!"))
		source.forceMove(get_turf(src))

/mob/living/simple_animal/hostile/abyss_tentacle/death()
	visible_message(span_danger("[src] retracts back into the shadows!"))
	release_grabbed_mob()
	. = ..()

/mob/living
	var/obj/grabbed_by_tentacle = null
	var/escape_attempt = 0
	var/tentacle_aggro_mode = "Aggressive"

/mob/living/proc/set_tentacle_grab(obj/tentacle)
	grabbed_by_tentacle = tentacle

/mob/living/proc/clear_tentacle_grab()
	grabbed_by_tentacle = null
	escape_attempt = 0

/datum/crafting_recipe/mystome
	name = "Abyss Mysticism Tome"
	time = 10 SECONDS
	reqs = list(/obj/item/paper = 3, /obj/item/drinkable_bloodpack = 1)
	result = /obj/item/mystic_tome
	always_available = FALSE
	category = CAT_MISC

/datum/action/mysticism
	name = "Mysticism"
	desc = "Abyss Mysticism rune drawing."
	button_icon_state = "mysticism"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/drawing = FALSE
	var/level = 1

/datum/action/mysticism/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(drawing)
		return

	var/list/rituals = list()
	for(var/i in subtypesof(/obj/abyssrune))
		var/obj/abyssrune/R = new i(owner)
		if(R.clan_restricted_ritual.len && !(H.clane.type in R.clan_restricted_ritual))
			continue
		if(R.mystlevel <= level)
			rituals[R.name] = list("name" = i, "cost" = R.cost)
		qdel(R)

	var/ritual

	if(istype(H.get_active_held_item(), /obj/item/mystic_tome))
		ritual = tgui_input_list(owner, "Choose rune to draw:", "Mysticism", rituals, null)
	else
		ritual = tgui_input_list(owner, "Choose rune to draw (You need a Mystic Tome to reduce random):", "Mysticism", list("???"))
		if(ritual)
			ritual = pick(rituals)

	if(!ritual)
		return

	var/rtype = rituals[ritual]
	var/rname = rtype["name"]
	var/rcost = rtype["cost"]

	if(H.bloodpool >= rcost)
		drawing = TRUE
		if(do_after(H, 3 SECONDS * max(1, 5 - get_a_occult(H)), H))
			var/result = secret_vampireroll(get_a_intelligence(H)+get_a_occult(H), 6, H)
			if(result >= 3)
				drawing = FALSE
				new rname(H.loc)
				H.bloodpool = max(H.bloodpool - rcost, 0)
				if(H.CheckEyewitness(H, H, 7, FALSE))
					H.AdjustMasquerade(-1)
			else
				to_chat(owner, span_warning("You <b>FAIL</b> at runedrawing!"))
	else
		to_chat(H, span_warning("You need more <b>BLOOD</b> to do that!"))
		drawing = FALSE
		return

	drawing = FALSE

