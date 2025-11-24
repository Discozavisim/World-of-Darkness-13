/mob/dead/new_player
	var/ready = 0
	var/late_ready = FALSE
	var/spawning = 0//Referenced when you want to delete the new_player later on in the code.

	flags_1 = NONE

	invisibility = INVISIBILITY_ABSTRACT

	density = FALSE
	stat = DEAD
	hud_possible = list()

	var/mob/living/new_character	//for instant transfer once the round is set up

	//Used to make sure someone doesn't get spammed with messages if they're ineligible for roles
	var/ineligible_for_roles = FALSE

	var/client_ref

/mob/dead/new_player/Initialize(mapload)
	if(client && SSticker.state == GAME_STATE_STARTUP)
		var/atom/movable/screen/splash/S = new(client, TRUE, TRUE)
		S.Fade(TRUE)

	if(length(GLOB.newplayer_start))
		forceMove(pick(GLOB.newplayer_start))
	else
		forceMove(locate(1,1,1))

	ComponentInitialize()

	. = ..()

	GLOB.new_player_list += src

/mob/dead/new_player/Destroy()
	GLOB.new_player_list -= src
	return ..()

/mob/dead/new_player/prepare_huds()
	return

/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!client)
		return

	if(client.interviewee)
		return FALSE

	if(href_list["lobby_init"])
		GLOB.lobby_screen.update(client)
		return TRUE
	if(href_list["show_preferences"])
		client.prefs.ShowChoices(src)
		return TRUE
	if(href_list["ready"])
		if(usr.client.prefs.invalid_disciplines_block() && usr.client.prefs.blocked_slot != TRUE)
			usr.client.prefs.blocked_slot = TRUE
			to_chat(usr, span_boldwarning("Слот заблокирован так как у персонажа обнаружено слишком много дисциплин. Напишите в ахелп для их удаления."))
			to_chat(usr, span_boldwarning("Кол-во разрешенных изучаемых дисциплин (Learnable_by_clans) - 2. Кол-во разрешенных обычных дисциплин - 1."))
			to_chat(usr, span_boldwarning("Так-же слот может быть заблокирован если у персонажа имеется клановая дисциплина другого клана."))
		SSbad_guys_party.candidates -= src
		late_ready = FALSE
		ready = !ready
		GLOB.lobby_screen.update(client)
		return TRUE
	if(href_list["late_party"])
		if(usr.client.prefs.invalid_disciplines_block() && usr.client.prefs.blocked_slot != TRUE)
			usr.client.prefs.blocked_slot = TRUE
			to_chat(usr, span_boldwarning("Слот заблокирован так как у персонажа обнаружено слишком много дисциплин. Напишите в ахелп для их удаления."))
			to_chat(usr, span_boldwarning("Кол-во разрешенных изучаемых дисциплин (Learnable_by_clans) - 2. Кол-во разрешенных обычных дисциплин - 1."))
			to_chat(usr, span_boldwarning("Так-же слот может быть заблокирован если у персонажа имеется клановая дисциплина другого клана."))
		if (!can_respawn())
			to_chat(src, "<span class='boldwarning'>You cannot respawn yet.</span>")
			return
		ready = PLAYER_NOT_READY
		if(late_ready)
			late_ready = FALSE
			SSbad_guys_party.candidates -= src
		else
			late_ready = TRUE
			SSbad_guys_party.candidates += src
		GLOB.lobby_screen.update(client)
		return TRUE
	if(href_list["observe"])
		if(SSticker.current_state != GAME_STATE_PLAYING)
			return FALSE
		make_me_an_observer()
		return TRUE
	if(href_list["late_join"])
		if(usr.client.prefs.invalid_disciplines_block()) && usr.client.prefs.blocked_slot != TRUE
			usr.client.prefs.blocked_slot = TRUE
			to_chat(usr, span_boldwarning("Слот заблокирован так как у персонажа обнаружено слишком много дисциплин. Напишите в ахелп для их удаления."))
			to_chat(usr, span_boldwarning("Кол-во разрешенных изучаемых дисциплин (Learnable_by_clans) - 2. Кол-во разрешенных обычных дисциплин - 1."))
			to_chat(usr, span_boldwarning("Так-же слот может быть заблокирован если у персонажа имеется клановая дисциплина другого клана."))
		if (!can_respawn())
			to_chat(usr, "<span class='boldwarning'>You cannot respawn yet.</span>")
			return FALSE
		SSbad_guys_party.candidates -= src
		late_ready = FALSE
		if(!SSticker?.IsRoundInProgress())
			to_chat(usr, "<span class='boldwarning'>The round is either not ready, or has already finished...</span>")
			return FALSE

		if(href_list["late_join"] == "override")
			LateChoices()
			return FALSE

		//Determines Relevent Population Cap
		var/relevant_cap
		var/hpc = CONFIG_GET(number/hard_popcap)
		var/epc = CONFIG_GET(number/extreme_popcap)
		if(hpc && epc)
			relevant_cap = min(hpc, epc)
		else
			relevant_cap = max(hpc, epc)

		if(SSticker.queued_players.len || (relevant_cap && living_player_count() >= relevant_cap && !(ckey(key) in GLOB.admin_datums)))
			to_chat(usr, "<span class='danger'>[CONFIG_GET(string/hard_popcap_message)]</span>")

			var/queue_position = SSticker.queued_players.Find(usr)
			if(queue_position == 1)
				to_chat(usr, "<span class='notice'>You are next in line to join the game. You will be notified when a slot opens up.</span>")
			else if(queue_position)
				to_chat(usr, "<span class='notice'>There are [queue_position-1] players in front of you in the queue to join the game.</span>")
			else
				SSticker.queued_players += usr
				to_chat(usr, "<span class='notice'>You have been added to the queue to join the game. Your position in queue is [SSticker.queued_players.len].</span>")
			return FALSE
		LateChoices()
		return TRUE
	if(href_list["manifest"])
		ViewManifest()
		return TRUE

//When you cop out of the round (NB: this HAS A SLEEP FOR PLAYER INPUT IN IT)
/mob/dead/new_player/proc/make_me_an_observer()
	if(QDELETED(src) || !src.client)
		ready = PLAYER_NOT_READY
		return FALSE

	var/this_is_like_playing_right = tgui_alert(src, "Are you sure you wish to observe? You will not be able to play this round!", "Player Setup", list("Yes","No"))

	if(QDELETED(src) || !src.client || this_is_like_playing_right != "Yes")
		ready = PLAYER_NOT_READY
		GLOB.lobby_screen.show(client)
		return FALSE

	var/mob/dead/observer/observer = new()
	spawning = TRUE

	observer.started_as_observer = TRUE
	close_spawn_windows()
	var/obj/effect/landmark/observer_start/O = locate(/obj/effect/landmark/observer_start) in GLOB.landmarks_list
	to_chat(src, "<span class='notice'>Now teleporting.</span>")
	if (O)
		observer.forceMove(O.loc)
	else
		to_chat(src, "<span class='notice'>Teleporting failed. Ahelp an admin please</span>")
		stack_trace("There's no freaking observer landmark available on this map or you're making observers before the map is initialised")
	observer.key = key
	observer.client = client
	observer.set_ghost_appearance()
	if(observer.client && observer.client.prefs)
		observer.real_name = observer.client.prefs.real_name
		observer.name = observer.real_name
		observer.client.init_verbs()
	observer.update_icon()
	observer.stop_sound_channel(CHANNEL_LOBBYMUSIC)
	deadchat_broadcast(" has observed.", "<b>[observer.real_name]</b>", follow_target = observer, turf_target = get_turf(observer), message_type = DEADCHAT_DEATHRATTLE)
	QDEL_NULL(mind)
	qdel(src)
	return TRUE

/mob/dead/new_player/proc/IsJobUnavailable(rank, latejoin = FALSE)
	var/bypass = FALSE
	if (check_rights_for(client, R_ADMIN))
		bypass = TRUE
	var/datum/job/job = SSjob.GetJob(rank)
	if(!job)
		return JOB_UNAVAILABLE_GENERIC
	if((job.current_positions >= job.total_positions) && (job.total_positions != -1))
		return JOB_UNAVAILABLE_SLOTFULL
	if(is_banned_from(ckey, rank))
		return JOB_UNAVAILABLE_BANNED
	if(QDELETED(src))
		return JOB_UNAVAILABLE_GENERIC
	if(!job.player_old_enough(client) && !bypass)
		return JOB_UNAVAILABLE_ACCOUNTAGE
	if(job.required_playtime_remaining(client) && !bypass)
		return JOB_UNAVAILABLE_PLAYTIME
	if(latejoin && !job.special_check_latejoin(client))
		return JOB_UNAVAILABLE_GENERIC
	if((client.prefs.generation-client.prefs.generation_bonus > job.minimal_generation) && !bypass)
		return JOB_UNAVAILABLE_GENERATION
	if((client.prefs.generation < job.max_generation) && !bypass)
		return JOB_UNAVAILABLE_GENERATION
	if(!job.scale_with_pop() && !bypass)
		return JOB_UNAVAILABLE_GENERIC
	if (job.title == "Citizen")
		return JOB_AVAILABLE
	if((client.prefs.masquerade < job.minimal_masquerade) && !bypass)
		return JOB_UNAVAILABLE_MASQUERADE
	if(!job.allowed_species.Find(client.prefs.pref_species.name) && !bypass)
		return JOB_UNAVAILABLE_SPECIES
	if ((job.species_slots[client.prefs.pref_species.name] == 0) && !bypass)
		return JOB_UNAVAILABLE_SPECIES_LIMITED
	if((client.prefs.pref_species.name == "Vampire") && !bypass)
		if(client.prefs.clane)
			for(var/i in job.allowed_bloodlines)
				if(i == client.prefs.clane.name)
					return JOB_AVAILABLE
			return JOB_UNAVAILABLE_CLAN
	if((client.prefs.pref_species.name == "Werewolf") && !bypass)

		if(client.prefs.tribe && !bypass)
			if(job.allowed_tribes.len)
				if(!job.allowed_tribes.Find(client.prefs.tribe.name))
					return JOB_UNAVAILABLE_RANK

		if(job.minimal_renownrank && !bypass)
			if(client.prefs.renownrank < job.minimal_renownrank)
				return JOB_UNAVAILABLE_RANK
	if(client.prefs.blocked_slot)
		return JOB_BLOCKED_SLOT
	return JOB_AVAILABLE

/mob/dead/new_player/proc/AttemptLateSpawn(rank)
	var/error = IsJobUnavailable(rank)
	if(error != JOB_AVAILABLE)
		return FALSE

	if(SSticker.late_join_disabled)
		alert(src, "An administrator has disabled late join spawning.")
		return FALSE

//	if(SSmasquerade.total_level <= 250)
//		alert(src, "Global Masquerade level is too low!")
//		return FALSE

	var/arrivals_docked = TRUE
	if(SSshuttle.arrivals)
		close_spawn_windows()	//In case we get held up
		if(SSshuttle.arrivals.damaged && CONFIG_GET(flag/arrivals_shuttle_require_safe_latejoin))
			src << alert("The arrivals shuttle is currently malfunctioning! You cannot join.")
			return FALSE

		if(CONFIG_GET(flag/arrivals_shuttle_require_undocked))
			SSshuttle.arrivals.RequireUndocked(src)
		arrivals_docked = SSshuttle.arrivals.mode != SHUTTLE_CALL

	//Remove the player from the join queue if he was in one and reset the timer
	SSticker.queued_players -= src
	SSticker.queue_delay = 4

	SSjob.AssignRole(src, rank, 1)

	var/mob/living/character = create_character(TRUE)	//creates the human and transfers vars and mind
	var/equip = SSjob.EquipRank(character, rank, TRUE)
	if(isliving(equip))	//Borgs get borged in the equip, so we need to make sure we handle the new mob.
		character = equip

	var/datum/job/job = SSjob.GetJob(rank)

	if(job && !job.override_latejoin_spawn(character))
		SSjob.SendToLateJoin(character)
		if(!arrivals_docked)
			var/atom/movable/screen/splash/Spl = new(character.client, TRUE)
			Spl.Fade(TRUE)
//			character.playsound_local(get_turf(character), 'sound/voice/ApproachingTG.ogg', 25)

		character.update_parallax_teleport()

	SSticker.minds += character.mind
	character.client.init_verbs() // init verbs for the late join
	var/mob/living/carbon/human/humanc
	if(ishuman(character))
		humanc = character	//Let's retypecast the var to be human,

	if(humanc)	//These procs all expect humans
		GLOB.data_core.manifest_inject(humanc)
		if(SSshuttle.arrivals)
			SSshuttle.arrivals.QueueAnnounce(humanc, rank)
		else
			AnnounceArrival(humanc, rank)
		AddEmploymentContract(humanc)
		if(GLOB.highlander)
			to_chat(humanc, "<span class='userdanger'><i>THERE CAN BE ONLY ONE!!!</i></span>")
			humanc.make_scottish()

		humanc.increment_scar_slot()
		humanc.load_persistent_scars()

		if(GLOB.summon_guns_triggered)
			give_guns(humanc)
		if(GLOB.summon_magic_triggered)
			give_magic(humanc)
		if(GLOB.curse_of_madness_triggered)
			give_madness(humanc, GLOB.curse_of_madness_triggered)

		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CREWMEMBER_JOINED, humanc, rank)

	GLOB.joined_player_list += character.ckey

	if(CONFIG_GET(flag/allow_latejoin_antagonists) && humanc)	//Borgs aren't allowed to be antags. Will need to be tweaked if we get true latejoin ais.
		if(SSshuttle.emergency)
			switch(SSshuttle.emergency.mode)
				if(SHUTTLE_RECALL, SHUTTLE_IDLE)
					SSticker.mode.make_antag_chance(humanc)
				if(SHUTTLE_CALL)
					if(SSshuttle.emergency.timeLeft(1) > initial(SSshuttle.emergencyCallTime)*0.5)
						SSticker.mode.make_antag_chance(humanc)

	if(humanc && CONFIG_GET(flag/roundstart_traits))
		SSquirks.AssignQuirks(humanc, humanc.client, TRUE)

	log_manifest(character.mind.key,character.mind,character,latejoin = TRUE)

/mob/dead/new_player/proc/AddEmploymentContract(mob/living/carbon/human/employee)
	//TODO:  figure out a way to exclude wizards/nukeops/demons from this.
	for(var/C in GLOB.employmentCabinets)
		var/obj/structure/filingcabinet/employment/employmentCabinet = C
		if(!employmentCabinet.virgin)
			employmentCabinet.addFile(employee)


/mob/dead/new_player/proc/LateChoices()
	GLOB.latejoin_menu.ui_interact(src)

/mob/dead/new_player/proc/create_character(transfer_after)
	spawning = 1
	close_spawn_windows()

	var/mob/living/carbon/human/H = new(loc)

	var/frn = CONFIG_GET(flag/force_random_names)
	var/admin_anon_names = SSticker.anonymousnames
	if(!frn)
		frn = is_banned_from(ckey, "Appearance")
		if(QDELETED(src))
			return
	if(frn)
		client.prefs.random_character()
		client.prefs.real_name = client.prefs.pref_species.random_name(gender,1)

	var/is_antag
	if(mind in GLOB.pre_setup_antags)
		is_antag = TRUE

	client.prefs.copy_to(H, antagonist = is_antag, is_latejoiner = transfer_after)

	if(admin_anon_names)//overrides random name because it achieves the same effect and is an admin enabled event tool
		randomize_human(H)
		H.fully_replace_character_name(null, SSticker.anonymousnames.anonymous_name(H))

	H.dna.update_dna_identity()
	if(mind)
		if(transfer_after)
			mind.late_joiner = TRUE
		mind.active = FALSE					//we wish to transfer the key manually
		mind.original_character_slot_index = client.prefs.default_slot
		mind.transfer_to(H)					//won't transfer key since the mind is not active
		mind.original_character = H

	H.name = real_name
	client.init_verbs()
	. = H
	new_character = .
	if(transfer_after)
		transfer_character()
//	if(client.prefs.archtype)
//		H.__archetype = new client.prefs.archtype
/mob/dead/new_player/proc/transfer_character()
	. = new_character
	if(.)
		new_character.key = key		//Manually transfer the key to log them in,
		new_character.stop_sound_channel(CHANNEL_LOBBYMUSIC)
		if(ishuman(new_character))
			var/mob/living/carbon/human/H = new_character
			if(H.client)
				H.true_real_name = H.client.prefs.real_name
				for(var/i in H.client.prefs.languages)
					H.grant_language(i)
				if(H.age < 16)
					H.add_quirk(/datum/quirk/freerunning)
					H.add_quirk(/datum/quirk/light_step)
					H.add_quirk(/datum/quirk/skittish)
					H.add_quirk(/datum/quirk/pushover)
				H.create_disciplines()
				if(H.client.prefs.ambitious)
					if(H.mind)
						H.mind.add_antag_datum(/datum/antagonist/ambitious)
				if(iscathayan(H))
					if(H.mind)
						H.mind.dharma = new H.client.prefs.dharma_type()
						H.mind.dharma.level = H.client.prefs.dharma_level
						H.mind.dharma.willpower = H.client.prefs.dharma_level
						H.mind.dharma.Po = H.client.prefs.po_type
						H.mind.dharma.Hun = H.client.prefs.hun
						H.mind.dharma.on_gain(H)
//						H.mind.dharma.initial_skin_color = H.skin_tone
				GLOB.fucking_joined |= H.client.prefs.real_name
				var/datum/relationship/R = new ()
				H.Myself = R
				R.owner = H
				R.need_friend = H.client.prefs.friend
				R.need_enemy = H.client.prefs.enemy
				R.need_lover = H.client.prefs.lover
				R.friend_text = H.client.prefs.friend_text
				R.enemy_text = H.client.prefs.enemy_text
				R.lover_text = H.client.prefs.lover_text
				R.publish()
				/*
				if(H.hud_used?.static_noise)
					H.hud_used.static_noise.alpha = 255
					SEND_SOUND(H, sound('code/modules/wod13/sounds/whitt.ogg', 0, 0, 50))
					spawn(3 SECONDS)
						H.hud_used.static_noise.alpha = 6
				*/
				if(H.hud_used?.ui_announcement)
					var/matrix/M = matrix()
					M.Scale(2, 2)
					H.hud_used.ui_announcement.transform = M
					H.hud_used.ui_announcement.maptext_width = 96
					H.hud_used.ui_announcement.maptext_height = 32
					H.hud_used.ui_announcement.maptext_x = -16
					H.hud_used.ui_announcement.maptext_y = 32
					H.hud_used.ui_announcement.maptext = MAPTEXT("[SSmapping.config.map_name], [SScity_time.timeofnight]")
					H.hud_used.ui_announcement.color = "#000000"
					animate(H.hud_used.ui_announcement, color = "#ffffff", time = 5, loop = 1)
					spawn(5 SECONDS)
						H.hud_used.ui_announcement.color = "#ffffff"
						animate(H.hud_used.ui_announcement, color = "#000000", alpha = 0, time = 2 SECONDS, loop = 1)
		new_character = null
		qdel(src)

/mob/dead/new_player/proc/ViewManifest()
	if(!client)
		return
	if(world.time < client.crew_manifest_delay)
		return
	client.crew_manifest_delay = world.time + (1 SECONDS)
	GLOB.manifest.ui_interact(src)

/mob/dead/new_player/Move()
	return 0


/mob/dead/new_player/proc/close_spawn_windows()

	src << browse(null, "window=latechoices") //closes late choices window
	src << browse(null, "window=playersetup") //closes the player setup window
	src << browse(null, "window=preferences") //closes job selection
	src << browse(null, "window=mob_occupation")
	src << browse(null, "window=latechoices") //closes late job selection

// Used to make sure that a player has a valid job preference setup, used to knock players out of eligibility for anything if their prefs don't make sense.
// A "valid job preference setup" in this situation means at least having one job set to low, or not having "return to lobby" enabled
// Prevents "antag rolling" by setting antag prefs on, all jobs to never, and "return to lobby if preferences not available"
// Doing so would previously allow you to roll for antag, then send you back to lobby if you didn't get an antag role
// This also does some admin notification and logging as well, as well as some extra logic to make sure things don't go wrong
/mob/dead/new_player/proc/check_preferences()
	if(!client)
		return FALSE //Not sure how this would get run without the mob having a client, but let's just be safe.
	if(client.prefs.joblessrole != RETURNTOLOBBY)
		return TRUE
	// If they have antags enabled, they're potentially doing this on purpose instead of by accident. Notify admins if so.
	var/has_antags = FALSE
	if(client.prefs.be_special.len > 0)
		has_antags = TRUE
	if(client.prefs.job_preferences.len == 0)
		if(!ineligible_for_roles)
			to_chat(src, "<span class='danger'>You have no jobs enabled, along with return to lobby if job is unavailable. This makes you ineligible for any round start role, please update your job preferences.</span>")
		ineligible_for_roles = TRUE
		ready = PLAYER_NOT_READY
		if(has_antags)
			log_admin("[src.ckey] just got booted back to lobby with no jobs, but antags enabled.")
			message_admins("[src.ckey] just got booted back to lobby with no jobs enabled, but antag rolling enabled. Likely antag rolling abuse.")

		return FALSE //This is the only case someone should actually be completely blocked from antag rolling as well
	return TRUE

/**
 * Prepares a client for the interview system, and provides them with a new interview
 *
 * This proc will both prepare the user by removing all verbs from them, as well as
 * giving them the interview form and forcing it to appear.
 */
/mob/dead/new_player/proc/register_for_interview()
	// First we detain them by removing all the verbs they have on client
	for (var/v in client.verbs)
		var/procpath/verb_path = v
		remove_verb(client, verb_path)

	// Then remove those on their mob as well
	for (var/v in verbs)
		var/procpath/verb_path = v
		remove_verb(src, verb_path)

	// Then we create the interview form and show it to the client
	var/datum/interview/I = GLOB.interviews.interview_for_client(client)
	if (I)
		I.ui_interact(src)

	// Add verb for re-opening the interview panel, and re-init the verbs for the stat panel
	add_verb(src, /mob/dead/new_player/proc/open_interview)
