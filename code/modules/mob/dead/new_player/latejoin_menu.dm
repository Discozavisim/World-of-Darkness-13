GLOBAL_DATUM_INIT(latejoin_menu, /datum/latejoin_menu, new)

/datum/latejoin_menu/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LatejoinMenu", "Latejoin Menu")
		ui.open()

/datum/latejoin_menu/ui_data(mob/user)
	var/list/data = list(
		"round_duration" = DisplayTimeText(world.time - SSticker.round_start_time),
		"departments" = list(),
	)
	if(!istype(user, /mob/dead/new_player))
		return data
	var/mob/dead/new_player/owner = user

	for(var/datum/job/prioritized_job in SSjob.prioritized_jobs)
		if(prioritized_job.current_positions >= prioritized_job.total_positions)
			SSjob.prioritized_jobs -= prioritized_job

	for(var/category in GLOB.position_categories)
		var/category_info = GLOB.position_categories[category]
		var/jobs_in_category = list()
		var/open_slots = 0
		for(var/job in category_info["jobs"])
			var/datum/job/job_datum = SSjob.name_occupations[job]
			if(!job_datum)
				continue
			var/job_list = list(
				"command" = (job in GLOB.leader_positions),
				"prioritized" = (job_datum in SSjob.prioritized_jobs),
				"used_slots" = job_datum.current_positions,
				"open_slots" = job_datum.total_positions < 0 ? "∞" : job_datum.total_positions
			)
			if(job_datum.v_duty)
				job_list["description"] = job_datum.v_duty
			else if(job_datum.duty)
				job_list["description"] = job_datum.duty

			var/is_job_unavailable = owner.IsJobUnavailable(job_datum.title, TRUE)
			if(is_job_unavailable != JOB_AVAILABLE)
				job_list["unavailable_reason"] = get_job_unavailable_error_message(is_job_unavailable)

			if(job_datum.total_positions < 0)
				open_slots = "∞"
			if(open_slots != "∞" && job_datum.total_positions - job_datum.current_positions > 0)
				open_slots += job_datum.total_positions - job_datum.current_positions

			jobs_in_category += list("[job_datum.title]" = job_list)
		data["departments"] += list(
			"[category]" = list(
				"color" = category_info["color"],
				"jobs" = jobs_in_category,
				"open_slots" = open_slots
			))
	return data

/datum/latejoin_menu/ui_state(mob/user)
	return GLOB.new_player_state

/datum/latejoin_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/dead/new_player/player = ui.user
	if(!player)
		return FALSE
	switch(action)
		if("select_job")
			if(player.client.prefs.invalid_disciplines_block() && player.client.prefs.blocked_slot != TRUE)
				player.client.prefs.blocked_slot = TRUE
				to_chat(usr, span_boldwarning("Слот заблокирован так как у персонажа обнаружено слишком много дисциплин. Напишите в ахелп для их удаления."))
				to_chat(usr, span_boldwarning("Кол-во разрешенных изучаемых дисциплин (Learnable_by_clans) - 2. Кол-во разрешенных обычных дисциплин - 1."))
				to_chat(usr, span_boldwarning("Так-же слот может быть заблокирован если у персонажа имеется клановая дисциплина другого клана."))
			if(!SSticker?.IsRoundInProgress())
				to_chat(player, "<span class='danger'>The round is either not ready, or has already finished...</span>")
				return TRUE

			var/name_wrong = FALSE
			for(var/i in GLOB.fucking_joined)
				if(i == player.client.prefs.real_name)
					name_wrong = TRUE
			if(name_wrong)
				to_chat(player, "<span class='danger'>You already used this character in round!</span>")
				return TRUE

			if(!GLOB.enter_allowed)
				to_chat(player, "<span class='notice'>There is an administrative lock on entering the game!</span>")
				return TRUE

			if(SSticker.queued_players.len && !(ckey(player.key) in GLOB.admin_datums))
				var/relevant_cap
				var/hpc = CONFIG_GET(number/hard_popcap)
				var/epc = CONFIG_GET(number/extreme_popcap)
				if(hpc && epc)
					relevant_cap = min(hpc, epc)
				else
					relevant_cap = max(hpc, epc)
				if((living_player_count() >= relevant_cap) || (player != SSticker.queued_players[1]))
					to_chat(player, "<span class='warning'>Server is full.</span>")
					return TRUE

			player.AttemptLateSpawn(params["job"])
			return TRUE

/datum/latejoin_menu/proc/get_job_unavailable_error_message(retval, jobtitle)
	switch(retval)
		if(JOB_AVAILABLE)
			return "[jobtitle] is available."
		if(JOB_UNAVAILABLE_GENERIC)
			return "[jobtitle] is unavailable."
		if(JOB_UNAVAILABLE_BANNED)
			return "You are currently banned from [jobtitle]."
		if(JOB_UNAVAILABLE_PLAYTIME)
			return "You do not have enough relevant playtime for [jobtitle]."
		if(JOB_UNAVAILABLE_ACCOUNTAGE)
			return "Your account is not old enough for [jobtitle]."
		if(JOB_UNAVAILABLE_SLOTFULL)
			return "[jobtitle] is already filled to capacity."
		if(JOB_UNAVAILABLE_GENERATION)
			return "Your generation is too young for [jobtitle]."
		if(JOB_UNAVAILABLE_RANK)
			return "Your renown rank is too low for [jobtitle]."
		if(JOB_UNAVAILABLE_SPECIES)
			return "Your species cannot be [jobtitle]."
		if(JOB_UNAVAILABLE_SPECIES_LIMITED)
			return "Your species has a limit on how many can be [jobtitle]."
		if(JOB_BLOCKED_SLOT)
			return "Слот заблокирован."
	return "Error: Unknown job availability."
