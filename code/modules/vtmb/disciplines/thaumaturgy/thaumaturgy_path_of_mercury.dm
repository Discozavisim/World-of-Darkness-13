/datum/discipline/thaumaturgy_path_of_mercury
	name = "Thaumaturgy: Path of Mercury"
	desc = "An ancient path developed to enable instant travel."
	icon_state = "thaumaturgy_path_of_mercury"
	learnable_by_clans = list(/datum/vampireclane/tremere)
	power_type = /datum/discipline_power/thaumaturgy_path_of_mercury

/datum/discipline/thaumaturgy_path_of_mercury/post_gain()
	. = ..()
	owner.faction |= "Tremere"
	ADD_TRAIT(owner, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/arctome)

/datum/discipline_power/thaumaturgy_path_of_mercury
	name = "Path of Mercury power name"
	desc = "Path of Mercury power description"

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	aggravating = FALSE
	hostile = FALSE
	violates_masquerade = TRUE

	cooldown_length = 3 TURNS

	var/success_roll

/datum/discipline_power/thaumaturgy_path_of_mercury/pre_activation_checks(atom/target)
	. = ..()
	success_roll = secret_vampireroll(get_a_willpower(owner) + get_a_occult(owner), level + 3, owner)
	if(success_roll < 0)
		to_chat(owner, span_userdanger("Магия выходит из-под контроля! Вас отбрасывает!"))
		owner.Knockdown(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	if(success_roll == 0)
		to_chat(owner, span_notice("Ваша магия угасает!"))
		return FALSE
	return TRUE

/datum/discipline_power/thaumaturgy_path_of_mercury/proc/is_valid_teleport_turf(turf/T)
	if(!T)
		return FALSE
	if(!istype(T, /turf/open/floor))
		return FALSE
	if(T.density)
		return FALSE
	for(var/obj/O in T)
		if(O.density && !O.CanAllowThrough(owner, T))
			return FALSE
	return TRUE

/datum/discipline_power/thaumaturgy_path_of_mercury/proc/do_teleport(atom/target)
	var/turf/target_turf = get_turf(target)
	if(!is_valid_teleport_turf(target_turf))
		to_chat(owner, span_warning("Вы не можете туда переместиться!"))
		return FALSE

	playsound(get_turf(owner), 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
	new /obj/effect/temp_visual/dir_setting/cult/phase(get_turf(owner), owner.dir)
	owner.forceMove(target_turf)
	new /obj/effect/temp_visual/dir_setting/cult/phase/out(get_turf(owner), owner.dir)
	playsound(target_turf, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
	to_chat(owner, span_notice("Пространство сжимается вокруг вас, и вы оказываетесь в другом месте."))
	return TRUE

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_tread
	name = "Hermes' Tread"
	desc = "Мгновенно переместиться на короткую дистанцию."

	level = 1
	target_type = TARGET_TURF | TARGET_OBJ | TARGET_MOB
	range = 3
	cooldown_length = 5 SECONDS

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_mercury/five_league_stride,
		/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage,
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness,
		/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage
	)

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_tread/activate(atom/target)
	. = ..()
	var/turf/T = get_turf(target)
	if(!(T in view(range, owner)))
		to_chat(owner, span_warning("Вы не видите это место!"))
		return
	do_teleport(target)


/datum/discipline_power/thaumaturgy_path_of_mercury/five_league_stride
	name = "Five-League Stride"
	desc = "Переместиться на значительную дистанцию в мгновение ока."

	level = 2
	target_type = TARGET_TURF | TARGET_OBJ | TARGET_MOB
	range = 7
	cooldown_length = 8 SECONDS

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_tread,
		/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage,
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness,
		/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage
	)

/datum/discipline_power/thaumaturgy_path_of_mercury/five_league_stride/activate(atom/target)
	. = ..()
	var/turf/T = get_turf(target)
	if(!(T in view(range, owner)))
		to_chat(owner, span_warning("Вы не видите это место!"))
		return
	do_teleport(target)

/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage
	name = "Astral Passage"
	desc = "Сосредоточиться и переместиться на большую дистанцию."

	level = 3
	target_type = NONE
	cooldown_length = 10 SECONDS
	cooldown_override = TRUE

	var/zoom_radius = 5
	var/zoom_offset = 6
	var/tp_range = 19
	var/is_zooming = FALSE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_tread,
		/datum/discipline_power/thaumaturgy_path_of_mercury/five_league_stride,
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness,
		/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage
	)

/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage/activate()
	. = ..()
	if(!owner.client)
		return
	is_zooming = TRUE
	to_chat(owner, span_notice("Вы сосредотачиваетесь, расширяя своё восприятие..."))
	owner.client.view_size.zoomOut(zoom_radius, zoom_offset, owner.dir)
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_rotate))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move_cancel))
	RegisterSignal(owner, COMSIG_MOB_CLICKON, PROC_REF(on_zoom_click))

/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage/proc/on_rotate(atom/thing, old_dir, new_dir)
	SIGNAL_HANDLER
	if(ismob(thing))
		var/mob/M = thing
		if(M.client)
			M.client.view_size.zoomOut(zoom_radius, zoom_offset, new_dir)

/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage/proc/on_move_cancel()
	SIGNAL_HANDLER
	cleanup_zoom()
	to_chat(owner, span_warning("Вы сдвинулись — концентрация потеряна!"))

/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage/proc/on_zoom_click(mob/source, atom/target, click_parameters)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(click_parameters)
	if(modifiers["right"])
		cleanup_zoom()
		to_chat(owner, span_notice("Вы отменяете телепортацию."))
		return COMSIG_MOB_CANCEL_CLICKON

	spawn()
		var/turf/target_turf = get_turf(target)
		if(!target_turf)
			cleanup_zoom()
			return
		if(get_dist(owner, target_turf) > tp_range)
			to_chat(owner, span_warning("Слишком далеко!"))
			return
		if(!is_valid_teleport_turf(target_turf))
			to_chat(owner, span_warning("Вы не можете туда переместиться!"))
			return
		cleanup_zoom()
		if(do_teleport(target_turf))
			do_cooldown(TRUE)

	return COMSIG_MOB_CANCEL_CLICKON

/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage/proc/cleanup_zoom()
	if(!is_zooming)
		return
	is_zooming = FALSE
	UnregisterSignal(owner, COMSIG_ATOM_DIR_CHANGE)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(owner, COMSIG_MOB_CLICKON)
	if(owner.client)
		owner.client.view_size.zoomIn()

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness
	name = "Hermes' Fleetness"
	desc = "Сосредоточиться и переместиться на еще более дальнюю дистанцию."

	level = 4
	target_type = NONE
	cooldown_length = 15 SECONDS
	cooldown_override = TRUE

	var/zoom_radius = 14
	var/zoom_offset = 14
	var/tp_range = 36
	var/is_zooming = FALSE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_tread,
		/datum/discipline_power/thaumaturgy_path_of_mercury/five_league_stride,
		/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage,
		/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage
	)

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness/activate()
	. = ..()
	if(!owner.client)
		return
	is_zooming = TRUE
	to_chat(owner, span_notice("Вы сосредотачиваетесь, расширяя своё восприятие..."))
	owner.client.view_size.zoomOut(zoom_radius, zoom_offset, owner.dir)
	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_rotate))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move_cancel))
	RegisterSignal(owner, COMSIG_MOB_CLICKON, PROC_REF(on_zoom_click))

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness/proc/on_rotate(atom/thing, old_dir, new_dir)
	SIGNAL_HANDLER
	if(ismob(thing))
		var/mob/M = thing
		if(M.client)
			M.client.view_size.zoomOut(zoom_radius, zoom_offset, new_dir)

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness/proc/on_move_cancel()
	SIGNAL_HANDLER
	cleanup_zoom()
	to_chat(owner, span_warning("Вы сдвинулись — концентрация потеряна!"))

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness/proc/on_zoom_click(mob/source, atom/target, click_parameters)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(click_parameters)
	if(modifiers["right"])
		cleanup_zoom()
		to_chat(owner, span_notice("Вы отменяете телепортацию."))
		return COMSIG_MOB_CANCEL_CLICKON

	spawn()
		var/turf/target_turf = get_turf(target)
		if(!target_turf)
			cleanup_zoom()
			return
		if(get_dist(owner, target_turf) > tp_range)
			to_chat(owner, span_warning("Слишком далеко!"))
			return
		if(!is_valid_teleport_turf(target_turf))
			to_chat(owner, span_warning("Вы не можете туда переместиться!"))
			return
		cleanup_zoom()
		if(do_teleport(target_turf))
			do_cooldown(TRUE)

	return COMSIG_MOB_CANCEL_CLICKON

/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness/proc/cleanup_zoom()
	if(!is_zooming)
		return
	is_zooming = FALSE
	UnregisterSignal(owner, COMSIG_ATOM_DIR_CHANGE)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(owner, COMSIG_MOB_CLICKON)
	if(owner.client)
		owner.client.view_size.zoomIn()

/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage
	name = "Secured Passage"
	desc = "Телепортироваться в любую известную локацию города."

	level = 5
	target_type = NONE
	vitae_cost = 3
	cooldown_length = 30 SECONDS

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_tread,
		/datum/discipline_power/thaumaturgy_path_of_mercury/five_league_stride,
		/datum/discipline_power/thaumaturgy_path_of_mercury/astral_passage,
		/datum/discipline_power/thaumaturgy_path_of_mercury/hermes_fleetness
	)

/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage/pre_activation_checks(atom/target)
	success_roll = secret_vampireroll(get_a_willpower(owner) + get_a_occult(owner), level + 3, owner)
	if(success_roll < 0)
		to_chat(owner, span_userdanger("Магия выходит из-под контроля! Вас уносит в неизвестное место!"))
		owner.do_jitter_animation(10)
		var/turf/botch_destination = find_botch_destination()
		if(botch_destination)
			playsound(get_turf(owner), 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
			new /obj/effect/temp_visual/dir_setting/cult/phase(get_turf(owner), owner.dir)
			owner.forceMove(botch_destination)
			new /obj/effect/temp_visual/dir_setting/cult/phase/out(get_turf(owner), owner.dir)
			playsound(botch_destination, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
		owner.Knockdown(5 SECONDS)
		return FALSE
	if(success_roll == 0)
		to_chat(owner, span_notice("Ваша магия угасает!"))
		return FALSE
	return TRUE

/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage/proc/find_botch_destination()
	var/list/all_options = list()

	var/list/area_locs = list()
	for(var/V in GLOB.sortedAreas)
		var/area/AR = V
		if(!istype(AR, /area/vtm))
			continue
		if(AR.area_flags & NOTELEPORT)
			continue
		if(!AR.contents.len)
			continue
		if(area_locs[AR.name])
			continue
		var/turf/picked = AR.contents[1]
		if(picked && is_station_level(picked.z))
			area_locs[AR.name] = AR
	if(length(area_locs))
		var/area/random_area = area_locs[pick(area_locs)]
		for(var/turf/T in get_area_turfs(random_area.type))
			if(!T.density && istype(T, /turf/open/floor))
				all_options += T
				break

	for(var/turf/T in get_area_turfs(/area/vtm/interior/backrooms))
		if(!T.density && istype(T, /turf/open/floor))
			all_options += T
			break

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H == owner)
			continue
		if(H.stat >= DEAD)
			continue
		var/turf/T = get_turf(H)
		if(T)
			all_options += T

	if(!length(all_options))
		return null
	return pick(all_options)

/datum/discipline_power/thaumaturgy_path_of_mercury/secured_passage/activate()
	. = ..()

	var/list/mercury_locs = list()
	for(var/V in GLOB.sortedAreas)
		var/area/AR = V
		if(!istype(AR, /area/vtm))
			continue
		if(AR.area_flags & NOTELEPORT)
			continue
		if(istype(AR, /area/vtm/interior/backrooms))
			continue
		if(!AR.contents.len)
			continue
		if(mercury_locs[AR.name])
			continue
		var/turf/picked = AR.contents[1]
		if(picked && is_station_level(picked.z))
			mercury_locs[AR.name] = AR

	sortTim(mercury_locs, GLOBAL_PROC_REF(cmp_text_asc))

	if(!length(mercury_locs))
		to_chat(owner, span_warning("Вы не чувствуете мест, куда можно переместиться..."))
		return

	var/choice = input(owner, "Выберите локацию для телепортации:", "Secured Passage") as null|anything in mercury_locs
	if(!choice)
		return
	if(owner.stat >= HARD_CRIT)
		return

	var/area/target_area = mercury_locs[choice]
	var/list/possible_turfs = list()
	for(var/turf/T in get_area_turfs(target_area.type))
		if(!istype(T, /turf/open/floor))
			continue
		if(T.density)
			continue
		var/clear = TRUE
		for(var/obj/O in T)
			if(O.density && !O.CanAllowThrough(owner, T))
				clear = FALSE
				break
		if(clear)
			possible_turfs += T

	if(!length(possible_turfs))
		to_chat(owner, span_warning("Не найдено безопасного места в этой локации!"))
		return

	var/turf/destination = pick(possible_turfs)
	playsound(get_turf(owner), 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
	new /obj/effect/temp_visual/dir_setting/cult/phase(get_turf(owner), owner.dir)
	owner.forceMove(destination)
	new /obj/effect/temp_visual/dir_setting/cult/phase/out(get_turf(owner), owner.dir)
	playsound(destination, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
	to_chat(owner, span_notice("Магия крови переносит вас через город в [choice]."))