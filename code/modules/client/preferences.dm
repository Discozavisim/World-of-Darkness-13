GLOBAL_LIST_EMPTY(preferences_datums)

/datum/preferences
	var/client/parent
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 20

	//non-preference stuff
	var/muted = 0
	var/last_ip
	var/last_id

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/ooccolor = "#c43b23"
	var/asaycolor = "#ff4500"			//This won't change the color for current admins, only incoming ones.
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds

	//Antag preferences
	var/list/be_special = list()		//Special role selection
	var/tmp/old_be_special = 0			//Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.

	var/UI_style = null
	var/buttons_locked = FALSE
	var/hotkeys = TRUE

	///Runechat preference. If true, certain messages will be displayed on the map, not ust on the chat area. Boolean.
	var/chat_on_map = TRUE
	///Limit preference on the size of the message. Requires chat_on_map to have effect.
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	///Whether non-mob messages will be displayed, such as machine vendor announcements. Requires chat_on_map to have effect. Boolean.
	var/see_chat_non_mob = TRUE
	///Whether emotes will be displayed on runechat. Requires chat_on_map to have effect. Boolean.
	var/see_rc_emotes = TRUE
	//Клан вампиров
	var/datum/vampireclane/clane = new /datum/vampireclane/brujah()
	// Custom Keybindings
	var/list/key_bindings = list()

	var/list/equipped_gear = list()
	var/show_loadout = TRUE
	var/gear_tab = "General"
	var/loadout_dots_max = 0
	var/loadout_dots = 0
	var/loadout_slots = 0
	var/loadout_slots_max = 0

	var/tgui_fancy = TRUE
	var/tgui_lock = FALSE
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/preferred_map = null
	var/pda_style = MONO
	var/pda_color = "#808000"

	var/uses_glasses_colour = 0

	//character preferences
	var/slot_randomized					//keeps track of round-to-round randomization of the character slot, prevents overwriting
	var/slotlocked = 0
	var/real_name						//our character's name
	var/gender = MALE					//gender of character (well duh)
	var/age = 30						//age of character
	var/total_age = 30
	var/blood_type = "A+"
	var/underwear = "Nude"				//underwear type
	var/underwear_color = "000"			//underwear color
	var/undershirt = "Nude"				//undershirt type
	var/socks = "Nude"					//socks type
	var/backpack = DBACKPACK				//backpack type
	var/jumpsuit_style = PREF_SUIT		//suit/skirt
	var/hairstyle = "Bald"				//Hair type
	var/hair_color = "000"				//Hair color
	var/facial_hairstyle = "Shaved"	//Face hair type
	var/facial_hair_color = "000"		//Facial hair color
	var/skin_tone = "caucasian1"		//Skin color
	var/eye_color = "000"				//Eye color
	var/datum/species/pref_species = new /datum/species/human()	//Mutant race
	var/list/features = list("mcolor" = "FFF", "ethcolor" = "9c3030", "tail_lizard" = "Smooth", "tail_human" = "None", "snout" = "Round", "horns" = "None", "ears" = "None", "wings" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None", "legs" = "Normal Legs", "moth_wings" = "Plain", "moth_antennae" = "Plain", "moth_markings" = "None")
	var/list/randomise = list(RANDOM_UNDERWEAR = TRUE, RANDOM_UNDERWEAR_COLOR = TRUE, RANDOM_UNDERSHIRT = TRUE, RANDOM_SOCKS = TRUE, RANDOM_BACKPACK = TRUE, RANDOM_JUMPSUIT_STYLE = TRUE, RANDOM_HAIRSTYLE = TRUE, RANDOM_HAIR_COLOR = TRUE, RANDOM_FACIAL_HAIRSTYLE = TRUE, RANDOM_FACIAL_HAIR_COLOR = TRUE, RANDOM_SKIN_TONE = TRUE, RANDOM_EYE_COLOR = TRUE)
	var/phobia = "spiders"

	var/list/custom_names = list()
	var/preferred_ai_core_display = "Blue"
	var/prefered_security_department = SEC_DEPT_RANDOM

	//Quirk list
	var/list/all_quirks = list()

	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

		// Want randomjob if preferences already filled - Donkie
	var/joblessrole = BERANDOMJOB  //defaults to 1 for fewer assistants

	// 0 = character settings, 1 = game preferences
	var/current_tab = 0

	var/unlock_content = 0

	var/list/ignoring = list()

	var/clientfps = 60

	var/parallax

	var/ambientocclusion = TRUE
	///Should we automatically fit the viewport?
	var/auto_fit_viewport = FALSE
	///Should we be in the widescreen mode set by the config?
	var/widescreenpref = TRUE
	///Old discipline icons
	var/old_discipline = FALSE
	///What size should pixels be displayed as? 0 is strech to fit
	var/pixel_size = 0
	///What scaling method should we use? Distort means nearest neighbor
	var/scaling_method = SCALING_METHOD_DISTORT
	var/uplink_spawn_loc = UPLINK_PDA
	///The playtime_reward_cloak variable can be set to TRUE from the prefs menu only once the user has gained over 5K playtime hours. If true, it allows the user to get a cool looking roundstart cloak.
	var/playtime_reward_cloak = FALSE

	var/list/exp = list()
	var/list/menuoptions

	var/action_buttons_screen_locs = list()

	///This var stores the amount of points the owner will get for making it out alive.
	var/hardcore_survival_score = 0

	///Someone thought we were nice! We get a little heart in OOC until we join the server past the below time (we can keep it until the end of the round otherwise)
	var/hearted
	///If we have a hearted commendations, we honor it every time the player loads preferences until this time has been passed
	var/hearted_until
	/// Agendered spessmen can choose whether to have a male or female bodytype
	var/body_type
	var/body_model = 2
	/// If we have persistent scars enabled
	var/persistent_scars = TRUE
	///If we want to broadcast deadchat connect/disconnect messages
	var/broadcast_login_logout = TRUE

	//Generation
	var/generation = 13
	var/generation_bonus = 0

	// Diablerie
	var/know_diablerie = 0

	//Renown
	var/renownrank = 0
	var/honor = 0
	var/glory = 0
	var/wisdom = 0

	//Masquerade
	var/masquerade = 5

	var/enlightenment = FALSE
	var/humanity = 7

	//Legacy
	var/exper = 1440
	var/exper_plus = 0

	var/discipline1level = 1
	var/discipline2level = 1
	var/discipline3level = 1
	var/discipline4level = 1

	var/discipline1type
	var/discipline2type
	var/discipline3type
	var/discipline4type

	//Character sheet stats
	var/true_experience = 50
	var/trufaith_level = 0 // 0-3, bought with experience in Character List (20/30/40)
	var/torpor_count = 0

	//linked lists determining known Disciplines and their known ranks
	///Datum types of the Disciplines this character knows.
	var/list/discipline_types = list()
	///Ranks of the Disciplines this character knows, corresponding to discipline_types.
	var/list/discipline_levels = list()

	//Skills
	var/lockpicking = 0
	var/athletics = 0

	var/info_known = INFO_KNOWN_UNKNOWN

	var/friend = FALSE
	var/enemy = FALSE
	var/lover = FALSE

	var/ambitious = FALSE
	var/flavor_text
	var/headshot
	var/headshot_link
	var/friend_text
	var/enemy_text
	var/lover_text

	var/diablerist = 0

	var/reason_of_death = "None"

	var/archetype = /datum/archetype/average

	var/breed = BREED_HOMID
	var/datum/garou_tribe/tribe = new /datum/garou_tribe/wendigo()
	var/datum/auspice/auspice = new /datum/auspice/ahroun()
	var/werewolf_color = "black"
	var/werewolf_scar = 0
	var/werewolf_hair = 0
	var/werewolf_hair_color = "#000000"
	var/werewolf_eye_color = "#FFFFFF"
	var/werewolf_apparel

	var/werewolf_name
	var/auspice_level = 1

	var/clane_accessory

	var/dharma_type = /datum/dharma
	var/dharma_level = 1
	var/po_type = "Rebel"
	var/po = 5
	var/hun = 5
	var/yang = 5
	var/yin = 5
	var/list/chi_types = list()
	var/list/chi_levels = list()

	var/list/priorities = list("Physical" = 1, "Social" = 2, "Mental" = 3)
	var/list/languages = list()
	var/list/loadout = list()

	var/Strength = 1
	var/Dexterity = 1
	var/Stamina = 1
	var/Manipulation = 1
	var/Charisma = 1
	var/Appearance = 1
	var/Perception = 1
	var/Intelligence = 1
	var/Wits = 1

/////TALENTS
	var/Alertness = 0
	var/Athletics = 0
	var/Brawl = 0
	var/Empathy = 0
	var/Intimidation = 0
	var/Expression = 0

////// SKILLS
	var/Crafts = 0
	var/Melee = 0
	var/Firearms = 0
	var/Drive = 0
	var/Security = 0
	var/Fleshcraft = 0
	var/Performance = 0

//// KNOWELEDGE
	var/Finance = 0
	var/Investigation = 0
	var/Medicine = 0
	var/Linguistics = 0
	var/Occult = 0

	var/consience = 4
	var/selfcontrol = 3
	var/courage = 3

	var/main_physical_attribute = "Strength"
	var/main_social_attribute = "Charisma"
	var/main_mental_attribute = "Perception"

	var/secondary_physical_attribute = "Dexterity"
	var/secondary_social_attribute = "Manipulation"
	var/secondary_mental_attribute = "Intelligence"

	var/old_enough_to_get_exp = FALSE

/datum/preferences/proc/add_experience(amount)
	true_experience = clamp(true_experience + amount, 0, 1000)

/datum/preferences/proc/reset_stats(attributes_only = FALSE)
	Strength = 1
	Dexterity = 1
	Stamina = 1
	Manipulation = 1
	Charisma = 1
	Appearance = 1
	Perception = 1
	Intelligence = 1
	Wits = 1
	if(!attributes_only)
		Alertness = 0
		Athletics = 0
		Brawl = 0
		Empathy = 0
		Intimidation = 0
		Expression = 0
		Crafts = 0
		Melee = 0
		Firearms = 0
		Drive = 0
		Security = 0
		Fleshcraft = 0
		Finance = 0
		Investigation = 0
		Medicine = 0
		Linguistics = 0
		Occult = 0

/datum/preferences/proc/reset_character()
	slotlocked = 0
	diablerist = 0
	know_diablerie = 0
	torpor_count = 0
	generation_bonus = 0
	reset_stats()
	languages = list()
	info_known = INFO_KNOWN_UNKNOWN
	masquerade = initial(masquerade)
	generation = initial(generation)
	dharma_level = initial(dharma_level)
	hun = initial(hun)
	po = initial(po)
	yin = initial(yin)
	yang = initial(yang)
	chi_types = list()
	chi_levels = list()
	renownrank = initial(renownrank)
	auspice_level = initial(auspice_level)
	honor = initial(honor)
	glory = initial(glory)
	wisdom = initial(wisdom)
	qdel(clane)
	clane = new /datum/vampireclane/brujah()
	discipline_types = list()
	discipline_levels = list()
	for (var/i in 1 to clane.clane_disciplines.len)
		discipline_types += clane.clane_disciplines[i]
		discipline_levels += 1
	humanity = clane.start_humanity
	enlightenment = clane.enlightenment
	equipped_gear = list()
	random_species()
	random_character()
	body_model = rand(1, 3)
	true_experience = 50
	trufaith_level = 0
	real_name = random_unique_name(gender)
	save_character()

/proc/reset_shit(mob/M)
	if(M.key)
		var/datum/preferences/P = GLOB.preferences_datums[ckey(M.key)]
		if(P)
			P.reset_character()

/datum/preferences/New(client/C)
	parent = C

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
//			unlock_content = C.IsByondMember()
//			if(unlock_content)
//				max_save_slots = 8
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			return
	//we couldn't load character data so just randomize the character appearance + name
	random_species()
	random_character()		//let's create a random character then - rather than a fat, bald and naked man.
	reset_character()
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C?.set_macros()
//	pref_species = new /datum/species/kindred()
	real_name = pref_species.random_name(gender,1)
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 4

/proc/make_font_cool(text)
	if(text)
		var/coolfont = "<font face='Percolator'>[text]</font>"
		return coolfont

/proc/RankName(rank, tribe)
	if(tribe != "Corax")
		switch(rank)
			if(0)
				return "Cub"
			if(1)
				return "Cliath"
			if(2)
				return "Fostern"
			if(3)
				return "Adren"
			if(4)
				return "Athro"
			if(5)
				return "Elder"
			if(6)
				return "Legend"
	else
		switch(rank)
			if(0)
				return "Fledgling"
			if(1)
				return "Oviculum"
			if(2)
				return "Neocornix"
			if(3)
				return "Ales"
			if(4)
				return "Volucris"
			if(5)
				return "Corvus"
			if(6)
				return "Grey Eminence"

/proc/RankDesc(rank, tribe)
	if(tribe != "Corax")
		switch(rank)
			if(0)
				return "You are not known to other Garou. Why?"
			if(1)
				return "You have completed your rite of passage as a Cliath."
			if(2)
				return "Fosterns have challenged for their rank and become proven members of Garou society."
			if(3)
				return "With proven work, wit, and function, Adren are higher echelons of Garou society, better known for control."
			if(4)
				return "A disciplined lieutenant and trusted Garou to your peers, you have respect and renown within the city as an Athro."
			if(5)
				return "One of the renowned names of the region, you are known as outstanding in California to some degree, worthy of the title of Elder."
			if(6)
				return "You're a Legendary NPC."
	else
		switch(rank)
			if(0)
				return "You are barely known to other Corax, and sit on the lower branches during Parliament"
			if(1)
				return "Other Corax have indulged in your secrets, and consider you Oviculum."
			if(2)
				return "You usually get to speak before the afternoon, and have shared remarkable intel several times, making you Neocornix ."
			if(3)
				return "You are witty, knowledgeable and have started making your mark accross the state, earning you the title of Ales"
			if(4)
				return "Not only do you posess juicy info over the state's big players, but you've gotten into dangerous scraps and came out in (mostly) one piece. \nOther Corax respectfully refer to you as Volucris"
			if(5)
				return "You sit on the highest branches of the tree whenever a Parliament's ongoing. You have shared devastating secrets with the rest of the Corax, and have shaped the fate of this region. \n You have the influence and prestige that makes the rest of your kind quiet down and listen, earning you the illustrious title of Corvus."
			if(6)
				return "Though you are officially still Corvus, your name is known worldwide, and your words can make or break nations, you should ideally be an NPC"

/datum/preferences/proc/ShowChoices(mob/user)
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE

	show_loadout = (current_tab == 5) ? show_loadout : FALSE
	update_preview_icon(show_loadout)
//	update_preview_icon()
	var/list/dat = list("<center>")

	if(istype(user, /mob/dead/new_player))
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=0' [current_tab == 0 ? "class='linkOn'" : ""]>[make_font_cool("CHARACTER SETTINGS")]</a>"
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=1' [current_tab == 1 ? "class='linkOn'" : ""]>[make_font_cool("CHARACTER LIST")]</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=2' [current_tab == 2 ? "class='linkOn'" : ""]>[make_font_cool("GAME PREFERENCES")]</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=3' [current_tab == 3 ? "class='linkOn'" : ""]>[make_font_cool("OOC PREFERENCES")]</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=4' [current_tab == 4 ? "class='linkOn'" : ""]>[make_font_cool("CUSTOM KEYBINDINGS")]</a>"
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=5' [current_tab == 5 ? "class='linkOn'" : ""]>[make_font_cool("LOADOUT")]</a>"

	if(!path)
		dat += "<div class='notice'>Please create an account to save your preferences</div>"

	dat += "</center>"

	dat += "<HR>"

	switch(current_tab)
		if (0) // Character Settings#
			Character_Settings(user, dat)
		if(1)
			Character_List(user, dat)
		if (2) // Game Preferences
			Game_Preferences(user, dat)
		if(3) //OOC Preferences
			OOC_Preferences(user, dat)
		if(4) // Custom keybindings
			custom_keybindings(user, dat)
		if(5)  //LOADOUT
			Loadout(user, dat)


	dat += "<hr><center>"

	if(slotlocked)
		dat += "Your character is saved. You can't change name and appearance, but your progress will be saved.<br>"
	if(!IsGuestKey(user.key) && !slotlocked)
		dat += "<a href='byond://?_src_=prefs;preference=load'>Undo</a> "
		dat += "<a href='byond://?_src_=prefs;preference=save'>Save Character</a> "
//	dat += "<a href='byond://?_src_=prefs;preference=save_pref'>Save Preferences</a> "

	if(istype(user, /mob/dead/new_player))
		dat += "<a href='byond://?_src_=prefs;preference=reset_all'>Reset Setup</a>"
	dat += "</center>"

	winshow(user, "preferences_window", TRUE)
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>[make_font_cool("CHARACTER")]</div>", 640, 770)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "preferences_window", src)

//A proc that creates the score circles based on attribute and the additional bonus for the attribute
//
/datum/preferences/proc/build_attribute_score(attribute, max_number, price, variable_name, freepoints)
	var/dat = ""
	for(var/a in 1 to attribute)
		dat += "•"
	var/leftover_circles = max_number - attribute //5 is the default number of blank circles
	for(var/c in 1 to leftover_circles)
		dat += "o"
	var/real_price = attribute ? (attribute*price) : price //In case we have an attribute of 0, we don't multiply by 0
	if(attribute < max_number)
		if(leftover_circles)
			if(freepoints > 0)
				dat += "<a href='byond://?_src_=prefs;preference=[variable_name];task=input'>Increase (free)</a>"
			else if(true_experience >= real_price)
				dat += "<a href='byond://?_src_=prefs;preference=[variable_name];task=input'>Increase ([real_price])</a>"
	dat += "<br>"
	return dat

/datum/preferences/proc/get_freebie_points(categor)
	var/physical_priorities = 0
	var/social_priorities = 0
	var/mental_priorities = 0
	for(var/i in priorities)
		if(i == "Physical")
			switch(priorities[i])
				if(1)
					physical_priorities = 7
				if(2)
					physical_priorities = 5
				if(3)
					physical_priorities = 3
		if(i == "Social")
			switch(priorities[i])
				if(1)
					social_priorities = 7
				if(2)
					social_priorities = 5
				if(3)
					social_priorities = 3
		if(i == "Mental")
			switch(priorities[i])
				if(1)
					mental_priorities = 7
				if(2)
					mental_priorities = 5
				if(3)
					mental_priorities = 3

	var/used_physical = max(0, Strength - 1) + max(0, Dexterity - 1) + max(0, Stamina - 1)
	var/used_social = max(0, Charisma - 1) + max(0, Manipulation - 1) + max(0, Appearance - 1)
	var/used_mental = max(0, Perception - 1) + max(0, Intelligence - 1) + max(0, Wits - 1)

	physical_priorities = max(0, physical_priorities - used_physical)
	social_priorities = max(0, social_priorities - used_social)
	mental_priorities = max(0, mental_priorities - used_mental)

	switch(categor)
		if("Physical")
			return physical_priorities
		if("Social")
			return social_priorities
		if("Mental")
			return mental_priorities
	return 0

/datum/preferences/proc/get_gen_attribute_limit(attribute)
	var/level

	if(pref_species.name == "Vampire")
		level = generation - generation_bonus
	else if(pref_species.name == "Werewolf")
		level = auspice_level
	else if(pref_species.name == "Kuei-Jin")
		level = dharma_level
	else
		level = 13

	if(pref_species.name == "Vampire")
		switch(level)
			if(9)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 6
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 4
				else
					return 3
			if(8)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 7
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 5
				else
					return 3
			if(7)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 8
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 6
				else
					return 4
			if(6)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 9
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 7
				else
					return 5
		if(level > 9)
			if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
				return 5
			else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
				return 4
			else
				return 3
		if(level < 6)
			if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
				return 10
			else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
				return 8
			else
				return 6

	if(pref_species.name == "Kuei-Jin")
		switch(level)
			if(1)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 5
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 4
				else
					return 3
			if(2)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 6
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 4
				else
					return 3
			if(3)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 7
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 5
				else
					return 3
			if(4)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 8
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 6
				else
					return 4
			if(5)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 9
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 7
				else
					return 5
			if(6)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 10
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 8
				else
					return 6

	if(pref_species.name == "Werewolf")
		switch(level)
			if(1)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 5
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 4
				else
					return 3
			if(2)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 6
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 4
				else
					return 3
			if(3)
				if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
					return 7
				else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
					return 5
				else
					return 3

	if(attribute == main_physical_attribute || attribute == main_social_attribute || attribute == main_mental_attribute)
		return 5
	else if(attribute == secondary_physical_attribute || attribute == secondary_social_attribute || attribute == secondary_mental_attribute)
		return 4
	else
		return 3


#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/SetChoices(mob/user, limit = 17, list/splitJobs = list("Chief Engineer"), widthPerColumn = 295, height = 620)
	if(!SSjob)
		return

	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/width = widthPerColumn

	var/HTML = "<center>"
	if(SSjob.occupations.len <= 0)
		HTML += "The job SSticker is not yet finished creating jobs, please try again later"
		HTML += "<center><a href='byond://?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.

	else
		HTML += "<b>Choose occupation chances</b><br>"
		HTML += "<div align='center'>Left-click to raise an occupation preference, right-click to lower it.<br></div>"
		HTML += "<center><a href='byond://?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='byond://?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob

		var/bypass = FALSE
		if (check_rights_for(user.client, R_ADMIN))
			bypass = TRUE

		for(var/datum/job/job in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))

			index += 1
			if((index >= limit) || (job.title in splitJobs))
				width += widthPerColumn
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			HTML += "<tr bgcolor='[job.selection_color]'><td width='60%' align='right'>"
			var/rank = job.title
			lastJob = job
			if(is_banned_from(user.ckey, rank))
				HTML += "<font color=red>[rank]</font></td><td><a href='byond://?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			//<font color=red>text</font> (Zamenil potomu chto slishkom rezhet glaza
			if(required_playtime_remaining && !bypass)
				HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \]</font></td></tr>"
				continue
			if(!job.player_old_enough(user.client) && !bypass)
				var/available_in_days = job.available_in_days(user.client)
				HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
				continue
			if((generation-generation_bonus > job.minimal_generation) && !bypass)
				HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[FROM [job.minimal_generation] GENERATION AND OLDER\]</font></td></tr>"
				continue
			if((generation < job.max_generation) && !bypass)
				HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[FROM [job.max_generation] GENERATION AND YOUNGER\]</font></td></tr>"
				continue
			if((masquerade < job.minimal_masquerade) && !bypass)
				HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[job.minimal_masquerade] MASQUERADE POINTS REQUIRED\]</font></td></tr>"
				continue
			if(!job.allowed_species.Find(pref_species.name) && !bypass)
				HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[pref_species.name] RESTRICTED\]</font></td></tr>"
				continue
			if(pref_species.name == "Vampire")
				if(clane)
					var/alloww = FALSE
					for(var/i in job.allowed_bloodlines)
						if(i == clane.name)
							alloww = TRUE
					if(!alloww && !bypass)
						HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[clane.name] RESTRICTED\]</font></td></tr>"
						continue
			if(pref_species.name == "Werewolf")
				if(tribe)
					var/alloww = FALSE
					if(job.allowed_tribes.len)
						for(var/i in job.allowed_tribes)
							if(i == tribe.name)
								alloww = TRUE
					else
						alloww = TRUE

					if(!alloww && !bypass)
						HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[tribe.name] RESTRICTED\]</font></td></tr>"
						continue
				if(auspice)
					var/alloww = FALSE
					for(var/i in job.allowed_auspice)
						if(i == auspice.name)
							alloww = TRUE
					if(!alloww && !bypass)
						HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[auspice.name] RESTRICTED\]</font></td></tr>"
						continue
				var/renownlowed = TRUE
				if(job.minimal_renownrank)
					if((renownrank < job.minimal_renownrank) && !bypass)
						renownlowed = FALSE
				if(!renownlowed && !bypass)
					HTML += "<font color=#290204>[rank]</font></td><td><font color=#290204> \[[job.minimal_renownrank] RENOWN RANK REQUIRED\]</font></td></tr>"
					continue
			if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
				HTML += "<font color=orange>[rank]</font></td><td></td></tr>"
				continue
			if((rank in GLOB.leader_positions) || (rank == "AI"))//Bold head jobs
				HTML += "<b><span class='dark'>[rank]</span></b>"
			else
				HTML += "<span class='dark'>[rank]</span>"

			HTML += "</td><td width='40%'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='byond://?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

			if(rank == SSjob.overflow_role)//Overflow is special
				if(job_preferences[SSjob.overflow_role] == JP_LOW)
					HTML += "<font color=green>Yes</font>"
				else
					HTML += "<font color=red>No</font>"
				HTML += "</a></td></tr>"
				continue

			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"

		for(var/i = 1, i < (limit - index), i += 1) // Finish the column so it is even
			HTML += "<tr bgcolor='[lastJob.selection_color]'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"

		HTML += "</td'></tr></table>"
		HTML += "</center></table>"

		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
		if(joblessrole == BERANDOMJOB)
			message = "Get random job if preferences unavailable"
		else if(joblessrole == RETURNTOLOBBY)
			message = "Return to lobby if preferences unavailable"
		HTML += "<center><br><a href='byond://?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		HTML += "<center><a href='byond://?_src_=prefs;preference=job;task=reset'>Reset Preferences</a></center>"

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Occupation Preferences</div>", width, height)
	popup.set_window_options("can_close=0")
	popup.set_content(HTML)
	popup.open(FALSE)

/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences[j] == JP_HIGH)
				job_preferences[j] = JP_MEDIUM
				//technically break here

	job_preferences[job.title] = level
	return TRUE

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		user << browse(null, "window=mob_occupation")
		ShowChoices(user)
		return

	if (!isnum(desiredLvl))
		to_chat(user, "<span class='danger'>UpdateJobPreference - desired level was not a number. Please notify coders!</span>")
		ShowChoices(user)
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	if(role == SSjob.overflow_role)
		if(job_preferences[job.title] == JP_LOW)
			jpval = null
		else
			jpval = JP_LOW

	SetJobPreferenceLevel(job, jpval)
	SetChoices(user)

	return 1


/datum/preferences/proc/ResetJobs()
	job_preferences = list()

/datum/preferences/proc/SetQuirks(mob/user)
	if(!SSquirks)
		to_chat(user, "<span class='danger'>The quirk subsystem is still initializing! Try again in a minute.</span>")
		return

	if(slotlocked)
		return

	var/list/dat = list()
	if(!SSquirks.quirks.len)
		dat += "The quirk subsystem hasn't finished initializing, please hold..."
		dat += "<center><a href='byond://?_src_=prefs;preference=trait;task=close'>Done</a></center><br>"
	else
		dat += "<center><b>Choose quirk setup</b></center><br>"
		dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>\
		Quirks are applied at roundstart and cannot normally be removed.</div>"
		dat += "<center><a href='byond://?_src_=prefs;preference=trait;task=close'>Done</a></center>"
		dat += "<hr>"
		dat += "<center><b>Current quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]</center>"
		dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\
		<b>Quirk balance remaining:</b> [GetQuirkBalance()]</center><br>"
		for(var/V in SSquirks.quirks)
			var/datum/quirk/T = SSquirks.quirks[V]
			var/quirk_name = initial(T.name)
			var/has_quirk
			var/quirk_cost = initial(T.value) * -1
			var/lock_reason = "This trait is unavailable."
			var/quirk_conflict = FALSE
			for(var/_V in all_quirks)
				if(_V == quirk_name)
					has_quirk = TRUE
			if(initial(T.mood_quirk) && CONFIG_GET(flag/disable_human_mood))
				lock_reason = "Mood is disabled."
				quirk_conflict = TRUE
			if(has_quirk)
				if(quirk_conflict)
					all_quirks -= quirk_name
					has_quirk = FALSE
				else
					quirk_cost *= -1 //invert it back, since we'd be regaining this amount
			if(quirk_cost > 0)
				quirk_cost = "+[quirk_cost]"
			var/font_color = "#AAAAFF"
			if(initial(T.value) != 0)
				font_color = initial(T.value) > 0 ? "#AAFFAA" : "#FFAAAA"

			if(!initial(T.mood_quirk))
				var/datum/quirk/Q = new T()

				if(length(Q.allowed_species))
					var/species_restricted = TRUE
					for(var/i in Q.allowed_species)
						if(i == pref_species.name)
							species_restricted = FALSE
					if(species_restricted)
						lock_reason = "[pref_species.name] restricted."
						quirk_conflict = TRUE
				if(Q.allowed_clans.len && "Kindred" == pref_species.name)
					var/clan_restricted = TRUE
					for(var/i in Q.allowed_clans)
						if(i == clane.name)
							clan_restricted = FALSE
					if(clan_restricted)
						lock_reason = "[clane.name] restricted."
						quirk_conflict = TRUE
				if(Q.allowed_tribes.len && "Werewolf" == pref_species.name)
					var/tribe_restricted = TRUE
					for(var/i in Q.allowed_tribes)
						if(i == tribe.name)
							tribe_restricted = FALSE
					if(tribe_restricted)
						lock_reason = "[tribe.name] restricted."
						quirk_conflict = TRUE
				qdel(Q)

			if(quirk_conflict && lock_reason != "Mood is disabled.")
				dat += "<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)] \
				<font color='red'><b>LOCKED: [lock_reason]</b></font><br>"
			else if(lock_reason != "Mood is disabled.")
				if(has_quirk)
					dat += "<a href='byond://?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<b><font color='[font_color]'>[quirk_name]</font></b> - [initial(T.desc)]<br>"
				else
					dat += "<a href='byond://?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
					<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)]<br>"
		dat += "<br><center><a href='byond://?_src_=prefs;preference=trait;task=reset'>Reset Quirks</a></center>"

	var/datum/browser/popup = new(user, "mob_occupation", "<div align='center'>Quirk Preferences</div>", 900, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/GetQuirkBalance()
	var/bal = 0
	if(pref_species.name == "Human")
		bal = 3
	for(var/V in all_quirks)
		var/datum/quirk/T = SSquirks.quirks[V]
		bal -= initial(T.value)
	return bal

/datum/preferences/proc/GetPositiveQuirkCount()
	. = 0
	for(var/q in all_quirks)
		if(SSquirks.quirk_points[q] > 0)
			.++

/datum/preferences/proc/validate_quirks()
	if(GetQuirkBalance() < 0)
		all_quirks = list()

/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(istype(user.client.mob, /mob/dead/observer/avatar))
		to_chat(user, "<span class='notice'>You can't modify preferences while auspex ghosted!</span>")
		return
	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details?.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, "<span class='danger'>You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]</span>")
			return

	switch(href_list["preference"])
		if("job")
			switch(href_list["task"])
				if("close")
					user << browse(null, "window=mob_occupation")
					ShowChoices(user)
				if("reset")
					ResetJobs()
					SetChoices(user)
				if("random")
					switch(joblessrole)
						if(RETURNTOLOBBY)
							if(is_banned_from(user.ckey, SSjob.overflow_role))
								joblessrole = BERANDOMJOB
							else
								joblessrole = BEOVERFLOW
						if(BEOVERFLOW)
							joblessrole = BERANDOMJOB
						if(BERANDOMJOB)
							joblessrole = RETURNTOLOBBY
					SetChoices(user)
				if("setJobLevel")
					UpdateJobPreference(user, href_list["text"], text2num(href_list["level"]))
				else
					SetChoices(user)
			return TRUE

		if("trait")
			switch(href_list["task"])
				if("close")
					user << browse(null, "window=mob_occupation")
					ShowChoices(user)
				if("update")
					var/quirk = href_list["trait"]
					if(!SSquirks.quirks[quirk])
						return
					for(var/V in SSquirks.quirk_blacklist) //V is a list
						var/list/L = V
						if(!(quirk in L))
							continue
						for(var/Q in all_quirks)
							if((Q in L) && !(Q == quirk)) //two quirks have lined up in the list of the list of quirks that conflict with each other, so return (see quirks.dm for more details)
								to_chat(user, "<span class='danger'>[quirk] is incompatible with [Q].</span>")
								return
					var/value = SSquirks.quirk_points[quirk]
					var/balance = GetQuirkBalance()
					if(quirk in all_quirks)
						if(balance + value < 0)
							to_chat(user, "<span class='warning'>Refunding this would cause you to go below your balance!</span>")
							return
						all_quirks -= quirk
					else
						var/is_positive_quirk = SSquirks.quirk_points[quirk] > 0
						if(is_positive_quirk && GetPositiveQuirkCount() >= MAX_QUIRKS)
							to_chat(user, "<span class='warning'>You can't have more than [MAX_QUIRKS] positive quirks!</span>")
							return
						if(balance - value < 0)
							to_chat(user, "<span class='warning'>You don't have enough balance to gain this quirk!</span>")
							return
						all_quirks += quirk
					SetQuirks(user)
				if("reset")
					all_quirks = list()
					SetQuirks(user)
				else
					SetQuirks(user)
			return TRUE

		if("loadout")
			process_loadout_links(user, href_list)

	switch(href_list["task"])
		if("random")
			if(slotlocked)
				return
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
				if("age")
					age = rand(AGE_MIN, AGE_MAX)
				if("total_age")
					var/max_age = 0
					if(pref_species.name == "Vampire")
						max_age = 1000
					if(pref_species.name == "Ghoul")
						max_age = 500
					total_age = rand(age, age+max_age)
				if("hair")
					hair_color = random_short_color()
				if("hairstyle")
					if(clane.no_hair)
						hairstyle = "Bald"
					else if(clane.haircuts)
						hairstyle = pick(clane.haircuts)
					else
						hairstyle = random_hairstyle(gender)
				if("facial")
					facial_hair_color = random_short_color()
				if("facial_hairstyle")
					if(clane.no_hair)
						facial_hairstyle = "Shaved"
					if(clane.no_facial)
						facial_hairstyle = "Shaved"
					else
						facial_hairstyle = random_facial_hairstyle(gender)
				if("underwear")
					underwear = random_underwear(gender)
				if("underwear_color")
					underwear_color = random_short_color()
				if("undershirt")
					undershirt = random_undershirt(gender)
				if("socks")
					socks = random_socks()
				if(BODY_ZONE_PRECISE_EYES)
					eye_color = random_eye_color()
				if("s_tone")
					skin_tone = random_skin_tone()
//				if("species")
//					random_species()
				if("bag")
					backpack = pick(GLOB.backpacklist)
				if("suit")
					jumpsuit_style = pick(GLOB.jumpsuitlist)
				if("all")
					random_character(gender)

		if("input")
			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])


			switch(href_list["preference"])
				if("ghostform")
					if(unlock_content)
						var/new_form = input(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",null) as null|anything in GLOB.ghost_forms
						if(new_form)
							ghost_form = new_form
				if("ghostorbit")
					if(unlock_content)
						var/new_orbit = input(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND", null) as null|anything in GLOB.ghost_orbits
						if(new_orbit)
							ghost_orbit = new_orbit

				if("ghostaccs")
					var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
					switch(new_ghost_accs)
						if(GHOST_ACCS_FULL_NAME)
							ghost_accs = GHOST_ACCS_FULL
						if(GHOST_ACCS_DIR_NAME)
							ghost_accs = GHOST_ACCS_DIR
						if(GHOST_ACCS_NONE_NAME)
							ghost_accs = GHOST_ACCS_NONE

				if("ghostothers")
					var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
					switch(new_ghost_others)
						if(GHOST_OTHERS_THEIR_SETTING_NAME)
							ghost_others = GHOST_OTHERS_THEIR_SETTING
						if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
							ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
						if(GHOST_OTHERS_SIMPLE_NAME)
							ghost_others = GHOST_OTHERS_SIMPLE

				if("werewolf_name")
					if(slotlocked || (!pref_species.id == "garou"))
						return

					var/new_name = input(user, "Choose your character's werewolf name:", "Character Preference")  as text|null
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							werewolf_name = new_name
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and . It must not contain any words restricted by IC chat and name filters.</font>")
				if("name")
					if(slotlocked)
						return

					var/new_name = input(user, "Choose your character's name:", "Character Preference")  as text|null
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							real_name = new_name
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and . It must not contain any words restricted by IC chat and name filters.</font>")

				if("age")
					if(slotlocked)
						return

					var/new_age = input(user, "Choose your character's biological age:\n([AGE_MIN]-[AGE_MAX])", "Character Preference") as num|null
					if(new_age)
						age = max(min( round(text2num(new_age)), AGE_MAX),AGE_MIN)
						if (age > total_age)
							total_age = age
						update_preview_icon()

				if("total_age")
					if(slotlocked)
						return

					var/new_age = input(user, "Choose your character's actual age:\n([age]-[age+1000])", "Character Preference") as num|null
					if(new_age)
						total_age = max(min(round(text2num(new_age)), age+1000), age)
						if (total_age < age)
							age = total_age
						update_preview_icon()

				if("blood_type")
					if(slotlocked)
						return
					var/list/blood_types = list("A+", "A-", "B+", "B-", "O+", "O-")
					var/bloods = input(user, "Choose your character's blood type:", "Character Preference")  as null|anything in blood_types
					if(bloods)
						blood_type = bloods

				if("info_choose")
					var/new_info_known = input(user, "Choose who knows your character:", "Fame")  as null|anything in list(INFO_KNOWN_UNKNOWN,INFO_KNOWN_CLAN_ONLY,INFO_KNOWN_FACTION,INFO_KNOWN_PUBLIC)
					if(new_info_known)
						info_known = new_info_known

				if("hair")
					if(slotlocked)
						return

					var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
					if(new_hair)
						hair_color = sanitize_hexcolor(new_hair)

				if("hairstyle")
					if(slotlocked)
						return

					if(clane.no_hair)
						hairstyle = "Bald"
					else
						var/new_hairstyle
						if(clane.haircuts)
							new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in clane.haircuts
						else
							if(gender == MALE)
								new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_male_list
							else if(gender == FEMALE)
								new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_female_list
							else
								new_hairstyle = input(user, "Choose your character's hairstyle:", "Character Preference")  as null|anything in GLOB.hairstyles_list
						if(new_hairstyle)
							hairstyle = new_hairstyle

				if("next_hairstyle")
					if(slotlocked)
						return

					if(clane.no_hair)
						hairstyle = "Bald"
					else if(clane.haircuts)
						hairstyle = next_list_item(hairstyle, clane.haircuts)
					else
						if (gender == MALE)
							hairstyle = next_list_item(hairstyle, GLOB.hairstyles_male_list)
						else if(gender == FEMALE)
							hairstyle = next_list_item(hairstyle, GLOB.hairstyles_female_list)
						else
							hairstyle = next_list_item(hairstyle, GLOB.hairstyles_list)

				if("previous_hairstyle")
					if(slotlocked)
						return

					if(clane.no_hair)
						hairstyle = "Bald"
					else if(clane.haircuts)
						hairstyle = previous_list_item(hairstyle, clane.haircuts)
					else
						if (gender == MALE)
							hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_male_list)
						else if(gender == FEMALE)
							hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_female_list)
						else
							hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_list)

				if("facial")
					if(slotlocked)
						return

					var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
					if(new_facial)
						facial_hair_color = sanitize_hexcolor(new_facial)

				if("facial_hairstyle")
					if(slotlocked)
						return

					if(clane.no_facial)
						facial_hairstyle = "Shaved"
					else
						var/new_facial_hairstyle
						if(gender == MALE)
							new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_male_list
						else if(gender == FEMALE)
							new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_female_list
						else
							new_facial_hairstyle = input(user, "Choose your character's facial-hairstyle:", "Character Preference")  as null|anything in GLOB.facial_hairstyles_list
						if(new_facial_hairstyle)
							facial_hairstyle = new_facial_hairstyle

				if("next_facehairstyle")
					if(slotlocked)
						return

					if(clane.no_facial)
						facial_hairstyle = "Shaved"
					else
						if (gender == MALE)
							facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
						else if(gender == FEMALE)
							facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
						else
							facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("previous_facehairstyle")
					if(slotlocked)
						return

					if(clane.no_facial)
						facial_hairstyle = "Shaved"
					else
						if (gender == MALE)
							facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_male_list)
						else if (gender == FEMALE)
							facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_female_list)
						else
							facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

				if("underwear")
					var/new_underwear
					if(gender == MALE)
						new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_m
					else if(gender == FEMALE)
						new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_f
					else
						new_underwear = input(user, "Choose your character's underwear:", "Character Preference")  as null|anything in GLOB.underwear_list
					if(new_underwear)
						underwear = new_underwear

				if("underwear_color")
					var/new_underwear_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+underwear_color) as color|null
					if(new_underwear_color)
						underwear_color = sanitize_hexcolor(new_underwear_color)

				if("undershirt")
					var/new_undershirt
					if(gender == MALE)
						new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_m
					else if(gender == FEMALE)
						new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_f
					else
						new_undershirt = input(user, "Choose your character's undershirt:", "Character Preference") as null|anything in GLOB.undershirt_list
					if(new_undershirt)
						undershirt = new_undershirt

				if("socks")
					var/new_socks
					new_socks = input(user, "Choose your character's socks:", "Character Preference") as null|anything in GLOB.socks_list
					if(new_socks)
						socks = new_socks

				if("eyes")
					if(slotlocked)
						return

					var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+eye_color) as color|null
					if(new_eyes)
						eye_color = sanitize_hexcolor(new_eyes)

				if("newdiscipline")
					if((true_experience < 10) || !(pref_species.id == "kindred"))
						return

					var/list/possible_new_disciplines = subtypesof(/datum/discipline) - discipline_types - /datum/discipline/bloodheal
					var/list/discipline_names = list()

					for (var/discipline_type in possible_new_disciplines)
						var/datum/discipline/discipline = new discipline_type

						if (discipline.clan_restricted && !(discipline.learnable_by_clans.len))
							qdel(discipline)
							continue

						if (discipline.learnable_by_clans.len && !(clane.type in discipline.learnable_by_clans))
							qdel(discipline)
							continue

						if (!discipline.clan_restricted && !discipline.learnable_by_clans.len && clane.name != "Caitiff")
							qdel(discipline)
							continue

						discipline_names[discipline.name] = discipline_type
						qdel(discipline)

					if(!discipline_names.len)
						return

					var/new_discipline = input(user, "Select your new Discipline", "Discipline Selection") as null|anything in discipline_names
					if(new_discipline)
						var/selected_discipline = discipline_names[new_discipline]
						discipline_types += selected_discipline
						discipline_levels += 1
						true_experience -= 10

				if("newghouldiscipline")
					if((true_experience < 10) || !(pref_species.id == "ghoul"))
						return

					// [ChillRaccoon] - hot-patched shit for specify which disces should be able to be taken
					var/list/possible_new_disciplines = list(/datum/discipline/obfuscate, /datum/discipline/auspex, /datum/discipline/celerity, /datum/discipline/fortitude, /datum/discipline/potence, /datum/discipline/dementation) - discipline_types - /datum/discipline/bloodheal //subtypesof(/datum/discipline) - discipline_types

					var/new_discipline = input(user, "Select your new Discipline", "Discipline Selection") as null|anything in possible_new_disciplines
					if(new_discipline)
						discipline_types += new_discipline
						discipline_levels += 1
						true_experience -= 10

				if("newchidiscipline")
					if((true_experience < 10) || !(pref_species.id == "kuei-jin"))
						return

					var/list/possible_new_disciplines = subtypesof(/datum/chi_discipline) - discipline_types
					var/how_much_usual_chi = 0
					var/how_much_usual_demon = 0
					var/how_much_usual = 0
					for(var/i in discipline_types)
						if(i)
							var/datum/chi_discipline/C = i
							if(initial(C.discipline_type) == "Shintai")
								how_much_usual += 1
							if(initial(C.discipline_type) == "Demon")
								how_much_usual_demon += 1
							if(initial(C.discipline_type) == "Chi")
								how_much_usual_chi += 1
					for(var/i in possible_new_disciplines)
						if(i)
							var/datum/chi_discipline/C = i
							if(initial(C.discipline_type) == "Shintai")
								if(how_much_usual >= 5)
									possible_new_disciplines -= i
							if(initial(C.discipline_type) == "Demon")
								if(how_much_usual_demon >= 2)
									possible_new_disciplines -= i
							if(initial(C.discipline_type) == "Chi")
								if(how_much_usual_chi >= 2)
									possible_new_disciplines -= i
					var/new_discipline = input(user, "Select your new Discipline", "Discipline Selection") as null|anything in possible_new_disciplines
					if(new_discipline)
						discipline_types += new_discipline
						discipline_levels += 1
						true_experience -= 10

				if("werewolf_color")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					var/list/colors = list("black", "gray", "red", "white", "ginger", "brown")
					var/result = input(user, "Select fur color:", "Appearance Selection") as null|anything in colors
					if(result)
						werewolf_color = result

				if("werewolf_scar")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					if(tribe == "Glass Walkers")
						if(werewolf_scar == 9)
							werewolf_scar = 0
						else
							werewolf_scar = min(9, werewolf_scar+1)
					else
						if(werewolf_scar == 7)
							werewolf_scar = 0
						else
							werewolf_scar = min(7, werewolf_scar+1)

				if("werewolf_hair")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					if(werewolf_hair == 4)
						werewolf_hair = 0
					else
						werewolf_hair = min(4, werewolf_hair+1)

				if("werewolf_hair_color")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					var/new_hair = input(user, "Select hair color:", "Appearance Selection",werewolf_hair_color) as color|null
					if(new_hair)
						werewolf_hair_color = sanitize_ooccolor(new_hair)

				if("werewolf_eye_color")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					var/new_eye = input(user, "Select eye color:", "Appearance Selection",werewolf_eye_color) as color|null
					if(new_eye)
						werewolf_eye_color = sanitize_ooccolor(new_eye)

				if("auspice")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					if(src.tribe.name == "Corax")
						auspice = /datum/auspice/theurge
						return
					else
						var/list/auspice_choices = list()
						for(var/i in GLOB.auspices_list)
							var/a = GLOB.auspices_list[i]
							var/datum/auspice/V = new a
							auspice_choices[V.name] += GLOB.auspices_list[i]
							qdel(V)
						var/result = tgui_input_list(user, "Select an Auspice", "Auspice Selection", auspice_choices)
						if(result)
							var/newtype = GLOB.auspices_list[result]
							var/datum/auspice/Auspic = new newtype()
							auspice = Auspic

				if("clane_acc")
					if(pref_species.id != "kindred")	//Due to a lot of people being locked to furries
						return

					if(!length(clane.accessories))
						clane_accessory = null
						return
					var/result = input(user, "Select a mark", "Marks") as null|anything in clane.accessories
					if(result)
						clane_accessory = result

				if("clane")
					if(slotlocked || !(pref_species.id == "kindred"))
						return

					if (alert("Are you sure you want to change your Clan? This will reset your Disciplines.", "Confirmation", "Yes", "No") != "Yes")
						return

					var/list/available_clans = list()
					for(var/i in GLOB.clanes_list)
						var/a = GLOB.clanes_list[i]
						var/datum/vampireclane/V = new a
						if (V.whitelisted)
							if (SSwhitelists.is_whitelisted(user.ckey, V.name))
								available_clans[V.name] += GLOB.clanes_list
						else
							available_clans[V.name] += GLOB.clanes_list[i]
						qdel(V)
					var/result = input(user, "Select a clane", "Clane Selection") as null|anything in available_clans
					if(result)
						var/newtype = GLOB.clanes_list[result]
						clane = new newtype()
						discipline_types = list()
						discipline_levels = list()
						if(result == "Caitiff")
							generation = 13
							for (var/i = clane.clane_disciplines.len; i < 3; i++)
								if (slotlocked)
									break
								var/list/possible_new_disciplines = subtypesof(/datum/discipline) - clane.clane_disciplines - /datum/discipline/bloodheal
								for (var/discipline_type in possible_new_disciplines)
									var/datum/discipline/discipline = new discipline_type
									if (discipline.clan_restricted)
										possible_new_disciplines -= discipline_type
									if (discipline.learnable_by_clans.len && !(clane.type in discipline.learnable_by_clans))
										possible_new_disciplines -= discipline_type
									qdel(discipline)
								var/new_discipline = input(user, "Select a Discipline", "Discipline Selection") as null|anything in possible_new_disciplines
								if (new_discipline)
									clane.clane_disciplines += new_discipline
									discipline_types += new_discipline
									discipline_levels += 1
									true_experience -= 10
						else //Separate this fucking shit, otherwise we can encounter with some trouble. This is a bug. [ChillRaccoon]
							for (var/i in 1 to clane.clane_disciplines.len)
								discipline_types += clane.clane_disciplines[i]
								discipline_levels += 1
						humanity = clane.start_humanity
						enlightenment = clane.enlightenment
						if(clane.no_hair)
							hairstyle = "Bald"
						if(clane.no_facial)
							facial_hairstyle = "Shaved"
						if(length(clane.accessories))
							if("none" in clane.accessories)
								clane_accessory = "none"
							else
								clane_accessory = pick(clane.accessories)
				if("auspice_level")
					var/cost = max(10, auspice_level * 10)
					if ((true_experience < cost) || (auspice_level >= 3))
						return

					true_experience -= cost
					auspice_level = max(1, auspice_level + 1)

				if("priorities")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/new_priorities = input(user, "Select a Discipline", "Discipline Selection") as null|anything in list("Physical, Social, Mental", "Physical, Mental, Social", "Social, Physical, Mental", "Social, Mental, Physical", "Mental, Social, Physical", "Mental, Physical, Social")
					if(new_priorities)
						switch(new_priorities)
							if("Physical, Social, Mental")
								priorities = list("Physical" = 1, "Social" = 2, "Mental" = 3)
							if("Physical, Mental, Social")
								priorities = list("Physical" = 1, "Mental" = 2, "Social" = 3)
							if("Social, Physical, Mental")
								priorities = list("Social" = 1, "Physical" = 2, "Mental" = 3)
							if("Social, Mental, Physical")
								priorities = list("Social" = 1, "Mental" = 2, "Physical" = 3)
							if("Mental, Social, Physical")
								priorities = list("Mental" = 1, "Social" = 2, "Physical" = 3)
							if("Mental, Physical, Social")
								priorities = list("Mental" = 1, "Physical" = 2, "Social" = 3)
						reset_stats(TRUE)

				if("main_physical")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/physical_attributes = list("Strength", "Dexterity", "Stamina")
					physical_attributes -= secondary_physical_attribute
					var/new_main_physical = tgui_input_list(user, "Select a Main Physical Attribute", "Attribute Selection", physical_attributes)
					if(new_main_physical)
						main_physical_attribute = new_main_physical
						verify_attributes()

				if("secondary_physical")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/physical_attributes = list("Strength", "Dexterity", "Stamina")
					physical_attributes -= main_physical_attribute
					var/new_secondary_physical = tgui_input_list(user, "Select a Secondary Physical Attribute", "Attribute Selection", physical_attributes)
					if(new_secondary_physical)
						secondary_physical_attribute = new_secondary_physical
						verify_attributes()

				if("main_social")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/social_attributes = list("Charisma", "Manipulation", "Appearance")
					social_attributes -= secondary_social_attribute
					var/new_main_social = tgui_input_list(user, "Select a Main Social Attribute", "Attribute Selection", social_attributes)
					if(new_main_social)
						main_social_attribute = new_main_social
						verify_attributes()

				if("secondary_social")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/social_attributes = list("Charisma", "Manipulation", "Appearance")
					social_attributes -= secondary_social_attribute
					var/new_secondary_social = tgui_input_list(user, "Select a Secondary Social Attribute", "Attribute Selection", social_attributes)
					if(new_secondary_social)
						secondary_social_attribute = new_secondary_social
						verify_attributes()

				if("main_mental")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/mental_attributes = list("Perception", "Intelligence", "Wits")
					mental_attributes -= secondary_mental_attribute
					var/new_main_mental = tgui_input_list(user, "Select a Main Mental Attribute", "Attribute Selection", mental_attributes)
					if(new_main_mental)
						main_mental_attribute = new_main_mental
						verify_attributes()

				if("secondary_mental")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change your Priorities? This will reset your Attributes.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/mental_attributes = list("Perception", "Intelligence", "Wits")
					mental_attributes -= main_mental_attribute
					var/new_secondary_mental = tgui_input_list(user, "Select a Secondary Mental Attribute", "Attribute Selection", mental_attributes)
					if(new_secondary_mental)
						secondary_mental_attribute = new_secondary_mental
						verify_attributes()

				if("strength")
					if(handle_upgrade(Strength, Strength * 5, get_gen_attribute_limit("Strength"), "Physical"))
						Strength++

				if("dexterity")
					if(handle_upgrade(Dexterity, Dexterity * 5, get_gen_attribute_limit("Dexterity"), "Physical"))
						Dexterity++

				if("stamina")
					if(handle_upgrade(Stamina, Stamina * 5, get_gen_attribute_limit("Stamina"), "Physical"))
						Stamina++

				if("charisma")
					if(handle_upgrade(Charisma, Charisma * 5, get_gen_attribute_limit("Charisma"), "Social"))
						Charisma++

				if("manipulation")
					if(handle_upgrade(Manipulation, Manipulation * 5, get_gen_attribute_limit("Manipulation"), "Social"))
						Manipulation++

				if("appearance")
					if(handle_upgrade(Appearance, Appearance * 5, get_gen_attribute_limit("Appearance"), "Social"))
						Appearance++

				if("perception")
					if(handle_upgrade(Perception, Perception * 5, get_gen_attribute_limit("Perception"), "Mental"))
						Perception++

				if("intelligence")
					if(handle_upgrade(Intelligence, Intelligence * 5, get_gen_attribute_limit("Intelligence"), "Mental"))
						Intelligence++

				if("wits")
					if(handle_upgrade(Wits, Wits * 5, get_gen_attribute_limit("Wits"), "Mental"))
						Wits++

				if("alertness")
					if(handle_upgrade(Alertness, Alertness * 3, 5))
						Alertness++

				if("athletics")
					if(handle_upgrade(Athletics, Athletics * 3, 5))
						Athletics++

				if("brawl")
					if(handle_upgrade(Brawl, Brawl * 3, 5))
						Brawl++

				if("empathy")
					if(handle_upgrade(Empathy, Empathy * 3, 5))
						Empathy++

				if("intimidation")
					if(handle_upgrade(Intimidation, Intimidation * 3, 5))
						Intimidation++

				if("expression")
					if(handle_upgrade(Expression, Expression * 3, 5))
						Expression++

				if("crafts")
					if(handle_upgrade(Crafts, Crafts * 3, 5))
						Crafts++

				if("melee")
					if(handle_upgrade(Melee, Melee * 3, 5))
						Melee++

				if("firearms")
					if(handle_upgrade(Firearms, Firearms * 3, 5))
						Firearms++

				if("drive")
					if(handle_upgrade(Drive, Drive * 3, 5))
						Drive++

				if("security")
					if(handle_upgrade(Security, Security * 3, 5))
						Security++

				if("performance")
					if(handle_upgrade(Performance, Performance * 3, 5))
						Performance++

				if("fleshcraft")
					if(handle_upgrade(Fleshcraft, Fleshcraft * 3, 5))
						Fleshcraft++

				if("finance")
					if(handle_upgrade(Finance, Finance * 3, 5))
						Finance++

				if("investigation")
					if(handle_upgrade(Investigation, Investigation * 3, 5))
						Investigation++

				if("medicine")
					if(handle_upgrade(Medicine, Medicine * 3, 5))
						Medicine++

				if("linguistics")
					if(handle_upgrade(Linguistics, Linguistics * 3, 5))
						Linguistics++

				if("occult")
					if(handle_upgrade(Occult, Occult * 3, 5))
						Occult++

				if("tribe")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					var/list/available_tribes = list()
					for(var/i in GLOB.tribes_list)
						var/a = GLOB.tribes_list[i]
						var/datum/garou_tribe/G = new a
						available_tribes[G.name] += GLOB.tribes_list[i]
						qdel(G)
					var/new_tribe = tgui_input_list(user, "Choose your Tribe:", "Tribe", sort_list(available_tribes))
					if(new_tribe)
						var/newtype = GLOB.tribes_list[new_tribe]
						new_tribe = new newtype()
						tribe = new_tribe
						if(tribe.name == "Corax")
							ADD_TRAIT(user, TRAIT_CORAX, tribe) //This might be redundant considering we also add this trait in auspice.dm
							// Convert Lupus to Corvid, and default Metis to Corvid since Corax don't have them
							if(breed == BREED_LUPUS || breed == BREED_METIS)
								breed = BREED_CORVID
							auspice = /datum/auspice/theurge // we do not want player to have a choice in the auspice, Corax being theurges is already silly enough
						else
							if(breed == BREED_CORVID)
								breed = BREED_LUPUS
							if(HAS_TRAIT(user, TRAIT_CORAX))
								REMOVE_TRAIT(user, TRAIT_CORAX, tribe)
				if("breed")
					if(slotlocked || !(pref_species.id == "garou"))
						return

					var/available_breeds = list(BREED_HOMID, BREED_METIS, BREED_LUPUS)
					// Alternative breed choices for the Corax
					if(istype(tribe, /datum/garou_tribe/corax))
						available_breeds = list(BREED_HOMID, BREED_CORVID)

					var/new_breed = tgui_input_list(user, "Choose your Breed:", "Breed", sort_list(available_breeds))
					if(new_breed)
						breed = new_breed
/*
				if("archetype")
					if(slotlocked)
						return

					if (alert("Are you sure you want to change Archetype? This will reset your attributes.", "Confirmation", "Yes", "No") != "Yes")
						return

					var/list/archetypes = list()
					for(var/i in subtypesof(/datum/archetype))
						archetypes += i
					var/result = input(user, "Select an archetype", "Attributes Selection") as null|anything in archetypes
					if(result)
						archetype = result
						var/datum/archetype/archetip = new archetype()
						physique = archetip.start_physique
						dexterity = archetip.start_dexterity
						mentality = archetip.start_mentality
						social = archetip.start_social
						blood = archetip.start_blood
						lockpicking = archetip.start_lockpicking
						athletics = archetip.start_athletics
*/
				if("discipline")
					if(pref_species.id == "kindred")
						var/i = text2num(href_list["upgradediscipline"])

						var/discipline_type = discipline_types[i]
						var/datum/discipline/discipline = new discipline_type
						var/discipline_level = discipline_levels[i]
						var/cost = discipline_level * 7

						if (discipline_level <= 0)
							cost = 10
						else if (clane.name == "Caitiff")
							cost = discipline_level * 6
						else if (clane.clane_disciplines.Find(discipline_types[i]))
							cost = discipline_level * 5
						else if (discipline.learnable_by_clans.Find(clane.type))
							cost = discipline_level * 6

						if ((true_experience < cost) || (discipline_level >= 5))
							return

						true_experience -= cost
						discipline_levels[i] = min(5, max(1, discipline_levels[i] + 1))

					if(pref_species.id == "kuei-jin")
						var/a = text2num(href_list["upgradechidiscipline"])

						var/discipline_level = discipline_levels[a]
						var/cost = discipline_level * 6
						if (discipline_level <= 0)
							cost = 10

						if ((true_experience < cost) || (discipline_level >= 5))
							return

						true_experience -= cost
						discipline_levels[a] = min(5, max(1, discipline_levels[a] + 1))

				if("path")
					var/cost = max(2, humanity * 2)
					if ((true_experience < cost) || (humanity >= 10) || !(pref_species.id == "kindred"))
						return

					true_experience -= cost
					humanity = max(1, humanity + 1)

				if("pathof")
					if (slotlocked || !(pref_species.id == "kindred"))
						return

					enlightenment = !enlightenment

				if("renownrank")
					if(slotlocked)
						return

					var/new_renown = tgui_input_number(user, "Select your Renown Rank (0-3):", "Character Preference", renownrank, 3, 0)
					if(new_renown)
						renownrank = clamp(new_renown, 0, 3)

				if("renownglory")
					if(slotlocked)
						return

					var/new_glory = tgui_input_number(user, "Select your Glory (0-10):", "Character Preference", glory, 10, 0)
					if(new_glory)
						glory = clamp(new_glory, 0, 10)
				if("renownhonor")
					if(slotlocked)
						return

					var/new_honor = tgui_input_number(user, "Select your Honor (0-10):", "Character Preference", honor, 10, 0)
					if(new_honor)
						honor = clamp(new_honor, 0, 10)
				if("renownwisdom")
					if(slotlocked)
						return

					var/new_wisdom = tgui_input_number(user, "Select your Wisdom (0-10):", "Character Preference", wisdom, 10, 0)
					if(new_wisdom)
						wisdom = clamp(new_wisdom, 0, 10)

				if("languages_reset")
					languages = list()

				if("languages")
					if(length(languages) >= Linguistics)
						return

					var/list/languages_possible_base = list(
					/datum/language/espanol,
					/datum/language/mandarin,
					/datum/language/beachbum,
					/datum/language/russian,
					/datum/language/italian,
					/datum/language/latin,
					/datum/language/hebrew,
					/datum/language/french,
					/datum/language/arabic,
					/datum/language/german,
					/datum/language/hebrew,
					/datum/language/japanese,
					/datum/language/cantonese,
					/datum/language/greek
					)
					var/list/available = languages_possible_base - languages

					var/result = input(user, "Learn Language", "Language") as null|anything in available
					if(result)
						languages += result

				if("consience")
					if (alert("Are you sure you want to change your Virtues? This will reset your Humanity.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/result = input(user, "Adjust Consience (1 to [min(5, 9-(selfcontrol+courage))])", "Consience") as null|num
					result = clamp(result, 1, min(5, 10-(selfcontrol+courage)))
					consience = result
					humanity = consience+selfcontrol

				if("selfcontrol")
					if (alert("Are you sure you want to change your Virtues? This will reset your Humanity.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/result = input(user, "Adjust Self-Control (1 to [min(5, 9-(consience+courage))])", "Self-Control") as null|num
					result = clamp(result, 1, min(5, 10-(consience+courage)))
					selfcontrol = result
					humanity = consience+selfcontrol

				if("courage")
					if (alert("Are you sure you want to change your Virtues? This will reset your Humanity.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/result = input(user, "Adjust Courage (1 to [min(5, 9-(consience+selfcontrol))])", "Courage") as null|num
					result = clamp(result, 1, min(5, 10-(consience+selfcontrol)))
					courage = result
					humanity = consience+selfcontrol

				if("dharmarise")
					if ((true_experience < 20) || (dharma_level >= 6) || !(pref_species.id == "kuei-jin"))
						return

					true_experience -= 20
					dharma_level = clamp(dharma_level + 1, 1, 6)
					yin = min(10, yin += 1)
					yang = min(10, yang += 1)
					if (dharma_level >= 6)
						hun += 1
						po += 1

				if("trufaith_buy")
					if(pref_species.name != "Human" && pref_species.id != "kindred")
						return
					if(!SSwhitelists.is_whitelisted(user?.client?.ckey, "trufaith", real_name))
						return
					var/cost = 0
					if(trufaith_level == 0)
						cost = 20
					else if(trufaith_level == 1)
						cost = 30
					else if(trufaith_level == 2)
						cost = 40
					else
						return
					if(true_experience < cost)
						return
					true_experience -= cost
					trufaith_level = min(3, trufaith_level + 1)

				/*
				if("torpor_restore")
					if(torpor_count != 0 && true_experience >= 3*(14-generation))
						torpor_count = 0
						true_experience = true_experience-(3*(14-generation))
				*/


				if("dharmatype")
					if(slotlocked)
						return
					if (alert("Are you sure you want to change Dharma? This will reset path-specific stats.", "Confirmation", "Yes", "No") != "Yes")
						return
					var/list/dharmas = list()
					for(var/i in subtypesof(/datum/dharma))
						var/datum/dharma/dharma = i
						dharmas += initial(dharma.name)
					var/result = input(user, "Select Dharma", "Dharma") as null|anything in dharmas
					if(result)
						for(var/i in subtypesof(/datum/dharma))
							var/datum/dharma/dharma = i
							if(initial(dharma.name) == result)
								dharma_type = i
								dharma_level = initial(dharma_level)
								hun = initial(hun)
								po = initial(po)
								yin = initial(yin)
								yang = initial(yang)
						verify_attributes()

				if("potype")
					if(slotlocked)
						return
					var/list/pos = list("Rebel", "Legalist", "Demon", "Monkey", "Fool")
					var/result = input(user, "Select P'o", "P'o") as null|anything in pos
					if(result)
						po_type = result

				if("chibalance")
					var/max_limit = min(dharma_level * 4, 20)
					var/sett = input(user, "Enter the maximum of Yin your character has:", "Yin/Yang") as num|null
					if(sett)
						sett = max(1, min(sett, max_limit-1))
						yin = sett
						yang = max_limit-sett

				if("demonbalance")
					var/max_limit = dharma_level*2
					var/sett = input(user, "Enter the maximum of Hun your character has:", "Hun/P'o") as num|null
					if(sett)
						sett = max(1, min(sett, max_limit-1))
						hun = sett
						po = max_limit-sett

				if("generation")
					if((clane?.name == "Caitiff") || slotlocked)
						return

					var/new_gen = input(user, "Select your generation (LOWER GENERATION MEANS LESS JOB SLOTS):", "Character Preference") as num|null
					if(new_gen)
						generation = clamp(new_gen, 7, 13)
						generation_bonus = 0
						diablerist = FALSE
						verify_attributes()

				if("friend_text")
					var/new_text = input(user, "What a Friend knows about me:", "Character Preference") as text|null
					if(new_text)
						friend_text = trim(copytext_char(sanitize(new_text), 1, 512))
				if("enemy_text")
					var/new_text = input(user, "What an Enemy knows about me:", "Character Preference") as text|null
					if(new_text)
						enemy_text = trim(copytext_char(sanitize(new_text), 1, 512))
				if("lover_text")
					var/new_text = input(user, "What a Lover knows about me:", "Character Preference") as text|null
					if(new_text)
						lover_text = trim(copytext_char(sanitize(new_text), 1, 512))

				if("flavor_text")
					var/new_flavor = input(user, "Choose your character's flavor text:", "Character Preference") as text|null
					if(new_flavor)
						if(length(new_flavor) > 3 * 512)
							to_chat(user, "Слишком большой...")
						else
							flavor_text = trim(copytext_char(sanitize(new_flavor), 1, 512))

				if("change_appearance")
					if((true_experience < 3) || !slotlocked)
						return

					slotlocked = FALSE
					true_experience -= 3

				if("species")
					if(slotlocked)
						return

					if (alert("Are you sure you want to change species? This will reset species-specific stats and attributes.", "Confirmation", "Yes", "No") != "Yes")
						return

					var/list/choose_species = list()
					for (var/key in GLOB.selectable_races)
						var/newtype = GLOB.species_list[key]
						var/datum/species/selecting_species = new newtype
						if (!selecting_species.selectable)
							qdel(selecting_species)
							continue
						if (selecting_species.whitelisted)
							if (!SSwhitelists.is_whitelisted(parent.ckey, key))
								qdel(selecting_species)
								continue
						choose_species += key
						qdel(selecting_species)

					var/result = input(user, "Select a species", "Species Selection") as null|anything in choose_species
					if(result)
						var/newtype = GLOB.species_list[result]
						pref_species = new newtype()
						discipline_types = list()
						discipline_levels = list()
						if(pref_species.id == "kindred")
							qdel(clane)
							clane = new /datum/vampireclane/brujah()
							for (var/i in 1 to clane.clane_disciplines.len)
								discipline_types += clane.clane_disciplines[i]
								discipline_levels += 1
						//Now that we changed our species, we must verify that the mutant colour is still allowed.
						var/temp_hsv = RGBtoHSV(features["mcolor"])
						if(features["mcolor"] == "#000" || (!(MUTCOLORS_PARTSONLY in pref_species.species_traits) && ReadHSV(temp_hsv)[3] < ReadHSV("#7F7F7F")[3]))
							features["mcolor"] = pref_species.default_color
						if(randomise[RANDOM_NAME])
							real_name = pref_species.random_name(gender)
						all_quirks = list()
						SetQuirks(user)
						reset_attributes()

				if("mutant_color")
					if(slotlocked)
						return

					var/new_mutantcolor = input(user, "Choose your character's alien/mutant color:", "Character Preference","#"+features["mcolor"]) as color|null
					if(new_mutantcolor)
						var/temp_hsv = RGBtoHSV(new_mutantcolor)
						if(new_mutantcolor == "#000000")
							features["mcolor"] = pref_species.default_color
						else if((MUTCOLORS_PARTSONLY in pref_species.species_traits) || ReadHSV(temp_hsv)[3] >= ReadHSV("#7F7F7F")[3]) // mutantcolors must be bright, but only if they affect the skin
							features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
						else
							to_chat(user, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")

				if("color_ethereal")
					var/new_etherealcolor = input(user, "Choose your ethereal color", "Character Preference") as null|anything in GLOB.color_list_ethereal
					if(new_etherealcolor)
						features["ethcolor"] = GLOB.color_list_ethereal[new_etherealcolor]


				if("tail_lizard")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_lizard
					if(new_tail)
						features["tail_lizard"] = new_tail

				if("tail_human")
					var/new_tail
					new_tail = input(user, "Choose your character's tail:", "Character Preference") as null|anything in GLOB.tails_list_human
					if(new_tail)
						features["tail_human"] = new_tail

				if("snout")
					var/new_snout
					new_snout = input(user, "Choose your character's snout:", "Character Preference") as null|anything in GLOB.snouts_list
					if(new_snout)
						features["snout"] = new_snout

				if("horns")
					var/new_horns
					new_horns = input(user, "Choose your character's horns:", "Character Preference") as null|anything in GLOB.horns_list
					if(new_horns)
						features["horns"] = new_horns

				if("ears")
					var/new_ears
					new_ears = input(user, "Choose your character's ears:", "Character Preference") as null|anything in GLOB.ears_list
					if(new_ears)
						features["ears"] = new_ears

				if("wings")
					var/new_wings
					new_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.r_wings_list
					if(new_wings)
						features["wings"] = new_wings

				if("frills")
					var/new_frills
					new_frills = input(user, "Choose your character's frills:", "Character Preference") as null|anything in GLOB.frills_list
					if(new_frills)
						features["frills"] = new_frills

				if("spines")
					var/new_spines
					new_spines = input(user, "Choose your character's spines:", "Character Preference") as null|anything in GLOB.spines_list
					if(new_spines)
						features["spines"] = new_spines

				if("body_markings")
					var/new_body_markings
					new_body_markings = input(user, "Choose your character's body markings:", "Character Preference") as null|anything in GLOB.body_markings_list
					if(new_body_markings)
						features["body_markings"] = new_body_markings

				if("legs")
					var/new_legs
					new_legs = input(user, "Choose your character's legs:", "Character Preference") as null|anything in GLOB.legs_list
					if(new_legs)
						features["legs"] = new_legs

				if("moth_wings")
					var/new_moth_wings
					new_moth_wings = input(user, "Choose your character's wings:", "Character Preference") as null|anything in GLOB.moth_wings_list
					if(new_moth_wings)
						features["moth_wings"] = new_moth_wings

				if("moth_antennae")
					var/new_moth_antennae
					new_moth_antennae = input(user, "Choose your character's antennae:", "Character Preference") as null|anything in GLOB.moth_antennae_list
					if(new_moth_antennae)
						features["moth_antennae"] = new_moth_antennae

				if("moth_markings")
					var/new_moth_markings
					new_moth_markings = input(user, "Choose your character's markings:", "Character Preference") as null|anything in GLOB.moth_markings_list
					if(new_moth_markings)
						features["moth_markings"] = new_moth_markings

				if("s_tone")
					if(slotlocked)
						return

					var/new_s_tone = input(user, "Choose your character's skin-tone:", "Character Preference")  as null|anything in GLOB.skin_tones
					if(new_s_tone)
						skin_tone = new_s_tone

				if("ooccolor")
					var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
					if(new_ooccolor)
						ooccolor = sanitize_ooccolor(new_ooccolor)

				if("asaycolor")
					var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference",asaycolor) as color|null
					if(new_asaycolor)
						asaycolor = sanitize_ooccolor(new_asaycolor)

				if("bag")
					var/new_backpack = input(user, "Choose your character's style of bag:", "Character Preference")  as null|anything in GLOB.backpacklist
					if(new_backpack)
						backpack = new_backpack

				if("suit")
					if(jumpsuit_style == PREF_SUIT)
						jumpsuit_style = PREF_SKIRT
					else
						jumpsuit_style = PREF_SUIT

				if("uplink_loc")
					var/new_loc = input(user, "Choose your character's traitor uplink spawn location:", "Character Preference") as null|anything in GLOB.uplink_spawn_loc_list
					if(new_loc)
						uplink_spawn_loc = new_loc

				if("playtime_reward_cloak")
					if (user.client.get_exp_living(TRUE) >= PLAYTIME_VETERAN)
						playtime_reward_cloak = !playtime_reward_cloak

				if("ai_core_icon")
					var/ai_core_icon = input(user, "Choose your preferred AI core display screen:", "AI Core Display Screen Selection") as null|anything in GLOB.ai_core_display_screens - "Portrait"
					if(ai_core_icon)
						preferred_ai_core_display = ai_core_icon

				if("sec_dept")
					var/department = input(user, "Choose your preferred security department:", "Security Departments") as null|anything in GLOB.security_depts_prefs
					if(department)
						prefered_security_department = department

				if ("preferred_map")
					var/maplist = list()
					var/default = "Default"
					if (config.defaultmap)
						default += " ([config.defaultmap.map_name])"
					for (var/M in config.maplist)
						var/datum/map_config/VM = config.maplist[M]
						if(!VM.votable)
							continue
						var/friendlyname = "[VM.map_name] "
						if (VM.voteweight <= 0)
							friendlyname += " (disabled)"
						maplist[friendlyname] = VM.map_name
					maplist[default] = null
					var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in sortList(maplist)
					if (pickedmap)
						preferred_map = maplist[pickedmap]

				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps.\n-1 means recommended value (currently:[RECOMMENDED_FPS])\n0 means world fps (currently:[world.fps])", "Character Preference", clientfps)  as null|num
					if (!isnull(desiredfps))
						clientfps = sanitize_integer(desiredfps, -1, 1000, clientfps)
						parent.fps = (clientfps < 0) ? RECOMMENDED_FPS : clientfps
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
					if(pickedui)
						UI_style = pickedui
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
				if("pda_style")
					var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
					if(pickedPDAStyle)
						pda_style = pickedPDAStyle
				if("pda_color")
					var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
					if(pickedPDAColor)
						pda_color = pickedPDAColor

				if("phobia")
					var/phobiaType = input(user, "What are you scared of?", "Character Preference", phobia) as null|anything in SStraumas.phobia_types
					if(phobiaType)
						phobia = phobiaType

				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)

		else
			switch(href_list["preference"])
				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC
				if("gender")
					if(slotlocked)
						return

					var/list/friendlyGenders = list("Male" = "male", "Female" = "female")
					var/pickedGender = input(user, "Choose your gender.", "Character Preference", gender) as null|anything in friendlyGenders
					if(pickedGender && friendlyGenders[pickedGender] != gender)
						gender = friendlyGenders[pickedGender]
						underwear = random_underwear(gender)
						undershirt = random_undershirt(gender)
						socks = random_socks()
						facial_hairstyle = random_facial_hairstyle(gender)
						hairstyle = random_hairstyle(gender)
				if("body_type")
					if(slotlocked)
						return

					if(body_type == MALE)
						body_type = FEMALE
					else
						body_type = MALE
				if("body_model")
					if(slotlocked)
						return

					if(body_model == 1)
						body_model = 2
					else if(body_model == 2)
						body_model = 3
					else if(body_model == 3)
						body_model = 1
				if("hotkeys")
					hotkeys = !hotkeys
					if(hotkeys)
						winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_ENABLED]")
					else
						winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_DISABLED]")

				if("keybindings_capture")
					var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
					var/old_key = href_list["old_key"]
					CaptureKeybinding(user, kb, old_key)
					return

				if("keybindings_set")
					var/kb_name = href_list["keybinding"]
					if(!kb_name)
						user << browse(null, "window=capturekeypress")
						ShowChoices(user)
						return

					var/clear_key = text2num(href_list["clear_key"])
					var/old_key = href_list["old_key"]
					if(clear_key)
						if(key_bindings[old_key])
							key_bindings[old_key] -= kb_name
							LAZYADD(key_bindings["Unbound"], kb_name)
							if(!length(key_bindings[old_key]))
								key_bindings -= old_key
						user << browse(null, "window=capturekeypress")
						user.client.set_macros()
						save_preferences()
						ShowChoices(user)
						return

					var/new_key = uppertext(href_list["key"])
					var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
					var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
					var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
					var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
					// var/key_code = text2num(href_list["key_code"])

					if(GLOB._kbMap[new_key])
						new_key = GLOB._kbMap[new_key]

					var/full_key
					switch(new_key)
						if("Alt")
							full_key = "[new_key][CtrlMod][ShiftMod]"
						if("Ctrl")
							full_key = "[AltMod][new_key][ShiftMod]"
						if("Shift")
							full_key = "[AltMod][CtrlMod][new_key]"
						else
							full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
					if(kb_name in key_bindings[full_key]) //We pressed the same key combination that was already bound here, so let's remove to re-add and re-sort.
						key_bindings[full_key] -= kb_name
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					key_bindings[full_key] += list(kb_name)
					key_bindings[full_key] = sortList(key_bindings[full_key])

					user << browse(null, "window=capturekeypress")
					user.client.set_macros()
					save_preferences()

				if("keybindings_reset")
					var/choice = tgui_alert(user, "Would you prefer 'hotkey' or 'classic' defaults?", "Setup keybindings", list("Hotkey", "Classic", "Cancel"))
					if(choice == "Cancel")
						ShowChoices(user)
						return
					hotkeys = (choice == "Hotkey")
					key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
					user.client.set_macros()

				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("see_rc_emotes")
					see_rc_emotes = !see_rc_emotes

				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("winflash")
					windowflashing = !windowflashing

				//here lies the badmins
				if("hear_adminhelps")
					user.client.toggleadminhelpsound()
				if("hear_prayers")
					user.client.toggle_prayer_sound()
				if("announce_login")
					user.client.toggleannouncelogin()
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_dead_chat")
					user.client.deadchat()
				if("toggle_radio_chatter")
					user.client.toggle_hear_radio()
				if("toggle_prayers")
					user.client.toggleprayers()
				if("toggle_deadmin_always")
					toggles ^= DEADMIN_ALWAYS
				if("toggle_deadmin_antag")
					toggles ^= DEADMIN_ANTAGONIST
				if("toggle_deadmin_head")
					toggles ^= DEADMIN_POSITION_HEAD
				if("toggle_deadmin_security")
					toggles ^= DEADMIN_POSITION_SECURITY
				if("toggle_deadmin_silicon")
					toggles ^= DEADMIN_POSITION_SILICON
				if("toggle_ignore_cult_ghost")
					toggles ^= ADMIN_IGNORE_CULT_GHOST


				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("toggle_random")
					if(slotlocked)
						return
					var/random_type = href_list["random_type"]
					if(randomise[random_type])
						randomise -= random_type
					else
						randomise[random_type] = TRUE

				if("friend")
					friend = !friend

				if("enemy")
					enemy = !enemy

				if("lover")
					lover = !lover

				if("ambitious")
					ambitious = !ambitious

				if("persistent_scars")
					persistent_scars = !persistent_scars

				if("clear_scars")
					var/path = "data/player_saves/[user.ckey[1]]/[user.ckey]/scars.sav"
					fdel(path)
					to_chat(user, "<span class='notice'>All scar slots cleared.</span>")

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("endofround_sounds")
					toggles ^= SOUND_ENDOFROUND

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")

					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("ghost_laws")
					chat_toggles ^= CHAT_GHOSTLAWS

				if("hear_login_logout")
					chat_toggles ^= CHAT_LOGIN_LOGOUT

				if("broadcast_login_logout")
					broadcast_login_logout = !broadcast_login_logout

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("parallaxup")
					parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("parallaxdown")
					parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
					if (parent && parent.mob && parent.mob.hud_used)
						parent.mob.hud_used.update_parallax_pref(parent.mob)

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent?.screen && parent.screen.len)
						var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in parent.screen
						PM.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("old_discipline")
					old_discipline = !old_discipline

				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.view_size.setDefault(getScreenSize(widescreenpref))

				if("pixel_size")
					switch(pixel_size)
						if(PIXEL_SCALING_AUTO)
							pixel_size = PIXEL_SCALING_1X
						if(PIXEL_SCALING_1X)
							pixel_size = PIXEL_SCALING_1_2X
						if(PIXEL_SCALING_1_2X)
							pixel_size = PIXEL_SCALING_2X
						if(PIXEL_SCALING_2X)
							pixel_size = PIXEL_SCALING_3X
						if(PIXEL_SCALING_3X)
							pixel_size = PIXEL_SCALING_AUTO
					user.client.view_size.apply() //Let's winset() it so it actually works

				if("scaling_method")
					switch(scaling_method)
						if(SCALING_METHOD_NORMAL)
							scaling_method = SCALING_METHOD_DISTORT
						if(SCALING_METHOD_DISTORT)
							scaling_method = SCALING_METHOD_BLUR
						if(SCALING_METHOD_BLUR)
							scaling_method = SCALING_METHOD_NORMAL
					user.client.view_size.setZoomMode()

				if("save")
					if(alert("Are you finished with your setup?",,"Yes","No")=="Yes")
						slotlocked = 1
						save_preferences()
						save_character()

				if("load")
					load_preferences()
					load_character()

				if("reset_all")
					if (alert("Are you sure you want to reset your character?", "Confirmation", "Yes", "No") != "Yes")
						return
					reset_character()

				if("changeslot")
					if(!load_character(text2num(href_list["num"])))
						reset_character()

				if("tab")
					if (href_list["tab"])
						current_tab = text2num(href_list["tab"])
						if(current_tab == 5)
							show_loadout = TRUE

				if("clear_heart")
					hearted = FALSE
					hearted_until = null
					to_chat(user, "<span class='notice'>OOC Commendation Heart disabled</span>")
					save_preferences()

	save_preferences()
	save_character()
	ShowChoices(user)
	return TRUE

/datum/preferences/proc/handle_upgrade(number, cost, numlimit, catgr)
	if(cost <= 0)
		if(!catgr)
			cost = 3
	if (((true_experience < cost) && !get_freebie_points(catgr)) || (number >= numlimit))
		return FALSE
	if(!get_freebie_points(catgr))
		true_experience -= cost
	return TRUE

/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE, is_latejoiner = TRUE, loadout = FALSE)

	hardcore_survival_score = 0 //Set to 0 to prevent you getting points from last another time.

	if((randomise[RANDOM_SPECIES] || randomise[RANDOM_HARDCORE]) && !character_setup)

		random_species()

	if((randomise[RANDOM_BODY] || (randomise[RANDOM_BODY_ANTAG] && antagonist) || randomise[RANDOM_HARDCORE]) && !character_setup)
		slot_randomized = TRUE
		random_character(gender, antagonist)

	if((randomise[RANDOM_NAME] || (randomise[RANDOM_NAME_ANTAG] && antagonist) || randomise[RANDOM_HARDCORE]) && !character_setup)
		slot_randomized = TRUE
		real_name = pref_species.random_name(gender)

	if(randomise[RANDOM_HARDCORE] && parent.mob.mind && !character_setup)
		if(can_be_random_hardcore())
			hardcore_random_setup(character, antagonist, is_latejoiner)

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == "human"))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name
	character.true_real_name = real_name
	character.name = character.real_name
	character.diablerist = diablerist
	character.know_diablerie = know_diablerie

	character.attributes.strength = min(get_gen_attribute_limit("Strength"), Strength)
	character.attributes.dexterity = min(get_gen_attribute_limit("Dexterity"), Dexterity)
	character.attributes.stamina = min(get_gen_attribute_limit("Stamina"), Stamina)

	character.attributes.charisma = min(get_gen_attribute_limit("Charisma"), Charisma)
	character.attributes.manipulation = min(get_gen_attribute_limit("Manipulation"), Manipulation)
	character.attributes.appearance = min(get_gen_attribute_limit("Appearance"), Appearance)

	character.attributes.perception = min(get_gen_attribute_limit("Perception"), Perception)
	character.attributes.intelligence = min(get_gen_attribute_limit("Intelligence"), Intelligence)
	character.attributes.wits = min(get_gen_attribute_limit("Wits"), Wits)

	character.attributes.Alertness = Alertness
	character.attributes.Athletics = Athletics
	character.attributes.Brawl = Brawl
	character.attributes.Empathy = Empathy
	character.attributes.Intimidation = Intimidation
	character.attributes.Expression = Expression

	character.attributes.Crafts = Crafts
	character.attributes.Melee = Melee
	character.attributes.Firearms = Firearms
	character.attributes.Drive = Drive
	character.attributes.Security = Security
	character.attributes.Fleshcraft = Fleshcraft

	character.attributes.Finance = Finance
	character.attributes.Investigation = Investigation
	character.attributes.Medicine = Medicine
	character.attributes.Linguistics = Linguistics
	character.attributes.Occult = Occult

/*
	character.physique = physique
	character.dexterity = dexterity
	character.social = social
	character.mentality = mentality
	character.blood = blood
	character.lockpicking = lockpicking
	character.athletics = athletics
	character.info_known = info_known
*/
	if(pref_species.name == "Vampire")
		var/datum/vampireclane/CLN = new clane.type()
		character.clane = CLN
		character.clane.current_accessory = clane_accessory
		character.maxbloodpool = get_gen_bloodpool(generation-generation_bonus)
		character.bloodpool = rand(2, character.maxbloodpool)
		character.generation = generation-generation_bonus
		character.max_yin_chi = character.maxbloodpool
		character.yin_chi = character.max_yin_chi
		character.clane.enlightenment = FALSE
		character.MyPath = new /datum/morality_path/humanity()
		character.MyPath.dot = humanity
		character.MyPath.willpower = selfcontrol + courage
		character.MyPath.owner = character
		character.MyPath.consience = consience
		character.MyPath.selfcontrol = selfcontrol
		character.MyPath.courage = courage
	else
		character.clane = null
		character.generation = 13
		character.bloodpool = character.maxbloodpool
		if(pref_species.name == "Kuei-Jin")
			character.yang_chi = yang
			character.max_yang_chi = yang
			character.yin_chi = yin
			character.max_yin_chi = yin
			character.max_demon_chi = po
		else
			character.yang_chi = 3
			character.max_yang_chi = 3
			character.yin_chi = 2
			character.max_yin_chi = 2

	if(pref_species.name == "Werewolf")
		switch(tribe.name)
			if("Wendigo", "Corax")
				character.yin_chi = 1
				character.max_yin_chi = 1
				character.yang_chi = 5 + (auspice_level * 2)
				character.max_yang_chi = 5 + (auspice_level * 2)
			if("Glass Walkers","Bone Gnawers")
				character.yin_chi = 1 + auspice_level
				character.max_yin_chi = 1 + auspice_level
				character.yang_chi = 5 + auspice_level
				character.max_yang_chi = 5 + auspice_level
			if("Black Spiral Dancers","Ghost Council")
				character.yin_chi = 1 + auspice_level * 2
				character.max_yin_chi = 1 + auspice_level * 2
				character.yang_chi = 5
				character.max_yang_chi = 5
		character.honor = honor
		character.wisdom = wisdom
		character.glory = glory
		character.renownrank = renownrank
	character.humanity = humanity
	character.masquerade = masquerade
	if(!character_setup)
		if(character in GLOB.masquerade_breakers_list)
			if(character.masquerade > 4)
				GLOB.masquerade_breakers_list -= character
		else if(character.masquerade < 5)
			GLOB.masquerade_breakers_list += character

	character.flavor_text = sanitize_text(flavor_text)
	if (features["headshot_link"])
		character.headshot_link += (features["headshot_link"])
	character.gender = gender
	character.age = age
	character.chronological_age = total_age
	if(gender == MALE || gender == FEMALE)
		character.body_type = gender
	else
		character.body_type = body_type

	switch(body_model)
		if(1)
			character.base_body_mod = "s"
		if(2)
			character.base_body_mod = ""
		if(3)
			character.base_body_mod = "f"

	character.eye_color = eye_color
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
		organ_eyes.old_eye_color = eye_color
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color

	if(pref_species.name == "Vampire")
		if(!character.original_skin_tone)
			character.original_skin_tone = skin_tone
		if(clane.alt_sprite && !clane.alt_sprite_greyscale)
			character.skin_tone = "albino"
		else
			character.skin_tone = get_vamp_skin_color(skin_tone)
	else
		character.skin_tone = skin_tone

	character.hairstyle = hairstyle
	if(character.age < 16)
		facial_hairstyle = "Shaved"
		character.facial_hairstyle = facial_hairstyle
	else
		character.facial_hairstyle = facial_hairstyle
	character.underwear = underwear
	character.underwear_color = underwear_color
	character.undershirt = undershirt
	character.socks = socks

	character.backpack = backpack

	character.jumpsuit_style = jumpsuit_style

	if(loadout)
		for(var/gear_name in equipped_gear)
			var/datum/gear/gear = SSloadout.gear_datums[gear_name]
			if(gear?.slot)
				character.equip_to_slot_or_del(gear.spawn_item(character, character), gear.slot)

	var/datum/species/chosen_species
	chosen_species = pref_species.type

	character.dna.blood_type = blood_type
	character.dna.features = features.Copy()
	character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE)
	character.dna.real_name = character.real_name
	if(character.clane)
		character.clane.on_gain(character)

	if(pref_species.name == "Werewolf")
		var/datum/auspice/CLN = new auspice.type()
		character.auspice = CLN
		character.auspice.level = auspice_level
		character.auspice.tribe = tribe
		character.auspice.on_gain(character)
		character.auspice.set_breed(breed, character)
		if(character.transformator?.crinos_form && character.transformator?.lupus_form && !HAS_TRAIT(character, TRAIT_CORAX))
			var/mob/living/carbon/werewolf/crinos/crinos = character.transformator.crinos_form?.resolve()
			var/mob/living/carbon/werewolf/lupus/lupus = character.transformator.lupus_form?.resolve()

			if(!crinos)
				character.transformator.crinos_form = null
				CRASH("[key_name(character)]'s crinos_form weakref contained no crinos mob!")
			if(!lupus)
				character.transformator.lupus_form = null
				CRASH("[key_name(character)]'s lupus_form weakref contained no lupus mob!")

			crinos.sprite_color = werewolf_color
			crinos.sprite_scar = werewolf_scar
			crinos.sprite_hair = werewolf_hair
			crinos.sprite_hair_color = werewolf_hair_color
			crinos.sprite_eye_color = werewolf_eye_color
			lupus.sprite_color = werewolf_color
			lupus.sprite_eye_color = werewolf_eye_color

			if(werewolf_name)
				crinos.name = werewolf_name
				lupus.name = werewolf_name
			else
				crinos.name = real_name
				lupus.name = real_name

			if(!crinos.attributes)
				crinos.attributes = new /datum/attributes()
			if(!lupus.attributes)
				lupus.attributes = new /datum/attributes()

			crinos.attributes.strength = character.attributes.strength+4
			crinos.attributes.dexterity = character.attributes.dexterity+1
			crinos.attributes.stamina = character.attributes.stamina+3
			crinos.attributes.charisma = character.attributes.charisma
			crinos.attributes.manipulation = character.attributes.manipulation-3
			crinos.attributes.appearance = character.attributes.appearance
			crinos.attributes.perception = character.attributes.perception
			crinos.attributes.intelligence = character.attributes.intelligence
			crinos.attributes.wits = character.attributes.wits

			crinos.attributes.Alertness = character.attributes.Alertness
			crinos.attributes.Athletics = character.attributes.Athletics
			crinos.attributes.Brawl = character.attributes.Brawl
			crinos.attributes.Empathy = character.attributes.Empathy
			crinos.attributes.Intimidation = character.attributes.Intimidation
			crinos.attributes.Crafts = character.attributes.Crafts
			crinos.attributes.Melee = character.attributes.Melee
			crinos.attributes.Firearms = character.attributes.Firearms
			crinos.attributes.Drive = character.attributes.Drive
			crinos.attributes.Security = character.attributes.Security
			crinos.attributes.Finance = character.attributes.strength
			crinos.attributes.Investigation = character.attributes.Investigation
			crinos.attributes.Medicine = character.attributes.Medicine
			crinos.attributes.Linguistics = character.attributes.Linguistics
			crinos.attributes.Occult = character.attributes.Occult
			crinos.attributes.Performance = character.attributes.Performance
			crinos.attributes.Fleshcraft = character.attributes.Fleshcraft
			crinos.attributes.Expression = character.attributes.Expression

			lupus.attributes.strength = character.attributes.strength+1
			lupus.attributes.dexterity = character.attributes.dexterity+2
			lupus.attributes.stamina = character.attributes.stamina+2
			lupus.attributes.charisma = character.attributes.charisma
			lupus.attributes.manipulation = character.attributes.manipulation-3
			lupus.attributes.appearance = character.attributes.appearance
			lupus.attributes.perception = character.attributes.perception
			lupus.attributes.intelligence = character.attributes.intelligence
			lupus.attributes.wits = character.attributes.wits

			lupus.attributes.Alertness = character.attributes.Alertness
			lupus.attributes.Athletics = character.attributes.Athletics
			lupus.attributes.Brawl = character.attributes.Brawl
			lupus.attributes.Empathy = character.attributes.Empathy
			lupus.attributes.Intimidation = character.attributes.Intimidation
			lupus.attributes.Crafts = character.attributes.Crafts
			lupus.attributes.Melee = character.attributes.Melee
			lupus.attributes.Firearms = character.attributes.Firearms
			lupus.attributes.Drive = character.attributes.Drive
			lupus.attributes.Security = character.attributes.Security
			lupus.attributes.Finance = character.attributes.strength
			lupus.attributes.Investigation = character.attributes.Investigation
			lupus.attributes.Medicine = character.attributes.Medicine
			lupus.attributes.Linguistics = character.attributes.Linguistics
			lupus.attributes.Occult = character.attributes.Occult
			lupus.attributes.Performance = character.attributes.Performance
			lupus.attributes.Fleshcraft = character.attributes.Fleshcraft
			lupus.attributes.Expression = character.attributes.Expression

		else if(HAS_TRAIT(character, TRAIT_CORAX) /*character.transformator?.corax_form && character.transformator?.corvid_form*/) // if we have the Corax tribe, use the Corax forms instead..
			var/mob/living/carbon/werewolf/corax/corax_crinos/cor_crinos = character.transformator.corax_form?.resolve()
			var/mob/living/carbon/werewolf/lupus/corvid/corvid = character.transformator.corvid_form?.resolve()

			if(!cor_crinos)
				character.transformator.corax_form = null
				CRASH("[key_name(character)]'s corax_form weakref contained no corax crinos mob!")
			if(!corvid)
				character.transformator.corvid_form = null
				CRASH("[key_name(character)]'s corvid_form weakref contained no corvid mob!")

			cor_crinos.sprite_color = werewolf_color
			//cor_crinos.icon_state = werewolf_color // gotta use Icon state for this one apparently
			cor_crinos.sprite_scar = werewolf_scar
			cor_crinos.sprite_hair = werewolf_hair
			cor_crinos.sprite_hair_color = werewolf_hair_color
			cor_crinos.sprite_eye_color = werewolf_eye_color
			corvid.sprite_color = werewolf_color
			corvid.sprite_eye_color = werewolf_eye_color

			if(werewolf_name)
				cor_crinos.name = werewolf_name
				corvid.name = werewolf_name
			else
				cor_crinos.name = real_name
				corvid.name = real_name

			if(!cor_crinos.attributes)
				cor_crinos.attributes = new /datum/attributes()
			if(!corvid.attributes)
				corvid.attributes = new /datum/attributes()

			cor_crinos.attributes.strength = character.attributes.strength+1
			cor_crinos.attributes.dexterity = character.attributes.dexterity+1
			cor_crinos.attributes.stamina = character.attributes.stamina+1
			cor_crinos.attributes.charisma = character.attributes.charisma
			cor_crinos.attributes.manipulation = character.attributes.manipulation-2
			cor_crinos.attributes.appearance = character.attributes.appearance-1
			cor_crinos.attributes.perception = character.attributes.perception
			cor_crinos.attributes.intelligence = character.attributes.intelligence
			cor_crinos.attributes.wits = character.attributes.wits

			cor_crinos.attributes.Alertness = character.attributes.Alertness
			cor_crinos.attributes.Athletics = character.attributes.Athletics
			cor_crinos.attributes.Brawl = character.attributes.Brawl
			cor_crinos.attributes.Empathy = character.attributes.Empathy
			cor_crinos.attributes.Intimidation = character.attributes.Intimidation
			cor_crinos.attributes.Crafts = character.attributes.Crafts
			cor_crinos.attributes.Melee = character.attributes.Melee
			cor_crinos.attributes.Firearms = character.attributes.Firearms
			cor_crinos.attributes.Drive = character.attributes.Drive
			cor_crinos.attributes.Security = character.attributes.Security
			cor_crinos.attributes.Finance = character.attributes.strength
			cor_crinos.attributes.Investigation = character.attributes.Investigation
			cor_crinos.attributes.Medicine = character.attributes.Medicine
			cor_crinos.attributes.Linguistics = character.attributes.Linguistics
			cor_crinos.attributes.Occult = character.attributes.Occult
			cor_crinos.attributes.Performance = character.attributes.Performance+3
			cor_crinos.attributes.Fleshcraft = character.attributes.Fleshcraft
			cor_crinos.attributes.Expression = character.attributes.Expression

			corvid.attributes.strength = character.attributes.strength-1
			corvid.attributes.dexterity = character.attributes.dexterity+1
			corvid.attributes.stamina = character.attributes.stamina
			corvid.attributes.charisma = character.attributes.charisma
			corvid.attributes.manipulation = character.attributes.manipulation-3
			corvid.attributes.appearance = character.attributes.appearance
			corvid.attributes.perception = character.attributes.perception
			corvid.attributes.intelligence = character.attributes.intelligence
			corvid.attributes.wits = character.attributes.wits

			corvid.attributes.Alertness = character.attributes.Alertness
			corvid.attributes.Athletics = character.attributes.Athletics
			corvid.attributes.Brawl = character.attributes.Brawl
			corvid.attributes.Empathy = character.attributes.Empathy
			corvid.attributes.Intimidation = character.attributes.Intimidation
			corvid.attributes.Crafts = character.attributes.Crafts
			corvid.attributes.Melee = character.attributes.Melee
			corvid.attributes.Firearms = character.attributes.Firearms
			corvid.attributes.Drive = character.attributes.Drive
			corvid.attributes.Security = character.attributes.Security
			corvid.attributes.Finance = character.attributes.strength
			corvid.attributes.Investigation = character.attributes.Investigation
			corvid.attributes.Medicine = character.attributes.Medicine
			corvid.attributes.Linguistics = character.attributes.Linguistics
			corvid.attributes.Occult = character.attributes.Occult
			corvid.attributes.Performance = character.attributes.Performance+3
			corvid.attributes.Fleshcraft = character.attributes.Fleshcraft
			corvid.attributes.Expression = character.attributes.Expression


	if(pref_species.mutant_bodyparts["tail_lizard"])
		character.dna.species.mutant_bodyparts["tail_lizard"] = pref_species.mutant_bodyparts["tail_lizard"]
	if(pref_species.mutant_bodyparts["spines"])
		character.dna.species.mutant_bodyparts["spines"] = pref_species.mutant_bodyparts["spines"]

	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts()
	if(!character_setup)
//		if(pref_species.name == "Werewolf")
//			character.transformator.fast_trans_gender(character, character.base_breed)
		character.roundstart_vampire = TRUE
		if(character.age < 16)
			if(!character.ischildren)
				character.ischildren = TRUE
				character.AddElement(/datum/element/children, COMSIG_PARENT_PREQDELETED, src)
		parent << browse(null, "window=preferences_window")
		parent << browse(null, "window=preferences_browser")

/datum/preferences/proc/can_be_random_hardcore()
	if(parent.mob.mind.assigned_role in GLOB.command_positions) //No command staff
		return FALSE
	for(var/A in parent.mob.mind.antag_datums)
		var/datum/antagonist/antag
		if(antag.get_team()) //No team antags
			return FALSE
	return TRUE

/datum/preferences/proc/get_default_name(name_id)
	switch(name_id)
		if("human")
			return random_unique_name()
		if("ai")
			return pick(GLOB.ai_names)
		if("cyborg")
			return DEFAULT_CYBORG_NAME
		if("clown")
			return pick(GLOB.clown_names)
		if("mime")
			return pick(GLOB.mime_names)
		if("religion")
			return DEFAULT_RELIGION
		if("deity")
			return DEFAULT_DEITY
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Choose your character's [namedata["qdesc"]]:","Character Preference") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name,namedata["allow_numbers"])
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, [namedata["allow_numbers"] ? "0-9, " : ""]-, ' and . It must not contain any words restricted by IC chat and name filters.</font>")
			return
		else
			custom_names[name_id] = sanitized_name

/datum/preferences/proc/RenownRequirements()
	var/gloryy = "Glory"
	var/honorr = "Honor"
	var/wisdomm = "Wisdom"
	var/stringtoreturn
	if(tribe.name == "Black Spiral Dancers")
		gloryy = "Infamy"
		honorr = "Power"
		wisdomm = "Cunning"
	switch(auspice.name)
		if("Ahroun")
			switch(renownrank)
				if(0)
					stringtoreturn = "2 [gloryy], 1 [honorr]"
					return stringtoreturn

				if(1)
					stringtoreturn = "4 [gloryy], 1 [honorr], 1 [wisdomm]"
					return stringtoreturn

				if(2)
					stringtoreturn = "6 [gloryy], 3 [honorr], 1 [wisdomm]"
					return stringtoreturn

				if(3)
					stringtoreturn = "9 [gloryy], 4 [honorr], 2 [wisdomm]"
					return stringtoreturn

				if(4)
					stringtoreturn = "10 [gloryy], 9 [honorr], 4 [wisdomm]"
					return stringtoreturn


		if("Galliard")
			switch(renownrank)
				if(0)
					stringtoreturn = "2 [gloryy], 1 [wisdomm]"
					return stringtoreturn

				if(1)
					stringtoreturn = "4 [gloryy], 2 [wisdomm]"
					return stringtoreturn

				if(2)
					stringtoreturn = "4 [gloryy], 2[honorr], 4 [wisdomm]"
					return stringtoreturn

				if(3)
					stringtoreturn = "7 [gloryy], 2 [honorr], 6 [wisdomm]"
					return stringtoreturn

				if(4)
					stringtoreturn = "9 [gloryy], 5 [honorr], 9 [wisdomm]"
					return stringtoreturn


		if("Philodox")
			switch(renownrank)
				if(0)
					stringtoreturn = "3 [honorr]"
					return stringtoreturn

				if(1)
					stringtoreturn = "1 [gloryy], 4 [honorr], 1 [wisdomm]"
					return stringtoreturn

				if(2)
					stringtoreturn = "2 [gloryy], 6 [honorr], 2 [wisdomm]"
					return stringtoreturn

				if(3)
					stringtoreturn = "3 [gloryy], 8 [honorr], 4 [wisdomm]"
					return stringtoreturn

				if(4)
					stringtoreturn = "4 [gloryy], 10 [honorr], 9 [wisdomm]"
					return stringtoreturn


		if("Theurge")
			switch(renownrank)
				if(0)
					stringtoreturn = "3 [wisdomm]"
					return stringtoreturn

				if(1)
					stringtoreturn = "1 [gloryy], 5 [wisdomm]"
					return stringtoreturn

				if(2)
					stringtoreturn = "2 [gloryy], 1 [honorr], 7 [wisdomm]"
					return stringtoreturn

				if(3)
					stringtoreturn = "4 [gloryy], 2 [honorr], 9 [wisdomm]"
					return stringtoreturn

				if(4)
					stringtoreturn = "4 [gloryy], 9 [honorr], 10 [wisdomm]"
					return stringtoreturn


		if("Ragabash")
			switch(renownrank)
				if(0)
					stringtoreturn = "3 Total"
					return stringtoreturn

				if(1)
					stringtoreturn = "7 Total"
					return stringtoreturn

				if(2)
					stringtoreturn = "13 Total"
					return stringtoreturn

				if(3)
					stringtoreturn = "19 Total"
					return stringtoreturn

				if(4)
					stringtoreturn = "25 Total"
					return stringtoreturn

/datum/preferences/proc/AuspiceRankUp()
	switch(auspice.name)
		if("Ahroun")
			switch(renownrank)
				if(0)
					if(glory >= 2 && honor >= 1) return TRUE
				if(1)
					if(glory >= 4 && honor >= 1 && wisdom >= 1) return TRUE
				if(2)
					if(glory >= 6 && honor >= 3 && wisdom >= 1) return TRUE
				if(3)
					if(glory >= 9 && honor >= 4 && wisdom >= 2) return TRUE
				if(4)
					if(glory >= 10 && honor >= 9 && wisdom >= 4) return TRUE

		if("Galliard")
			switch(renownrank)
				if(0)
					if(glory >= 2 && wisdom >= 1) return TRUE
				if(1)
					if(glory >= 4 && wisdom >= 2) return TRUE
				if(2)
					if(glory >= 4 && honor >= 2 && wisdom >= 4) return TRUE
				if(3)
					if(glory >= 7 && honor >= 2 && wisdom >= 6) return TRUE
				if(4)
					if(glory >= 9 && honor >= 5 && wisdom >= 9) return TRUE

		if("Philodox")
			switch(renownrank)
				if(0)
					if(honor >= 3) return TRUE
				if(1)
					if(glory >= 1 && honor >= 4 && wisdom >= 1) return TRUE
				if(2)
					if(glory >= 2 && honor >= 6 && wisdom >= 2) return TRUE
				if(3)
					if(glory >= 3 && honor >= 8 && wisdom >= 4) return TRUE
				if(4)
					if(glory >= 4 && honor >= 10 && wisdom >= 9) return TRUE

		if("Theurge")
			switch(renownrank)
				if(0)
					if(wisdom >= 3) return TRUE
				if(1)
					if(glory >= 1 && wisdom >= 5) return TRUE
				if(2)
					if(glory >= 2 && honor >= 1 && wisdom >= 7) return TRUE
				if(3)
					if(glory >= 4 && honor >= 2 && wisdom >= 9) return TRUE
				if(4)
					if(glory >= 4 && honor >= 9 && wisdom >= 10) return TRUE

		if("Ragabash")
			switch(renownrank)
				if(0)
					if((glory+honor+wisdom) >= 3) return TRUE
				if(1)
					if((glory+honor+wisdom) >= 7) return TRUE
				if(2)
					if((glory+honor+wisdom) >= 13) return TRUE
				if(3)
					if((glory+honor+wisdom) >= 19) return TRUE
				if(4)
					if((glory+honor+wisdom) >= 25) return TRUE

	return FALSE

/datum/preferences/proc/verify_attributes()
	Strength = min(Strength, get_gen_attribute_limit("Strength"))
	Dexterity = min(Dexterity, get_gen_attribute_limit("Dexterity"))
	Stamina = min(Stamina, get_gen_attribute_limit("Stamina"))

	Charisma = min(Charisma, get_gen_attribute_limit("Charisma"))
	Manipulation = min(Manipulation, get_gen_attribute_limit("Manipulation"))
	Appearance = min(Appearance, get_gen_attribute_limit("Appearance"))

	Perception = min(Perception, get_gen_attribute_limit("Perception"))
	Intelligence = min(Intelligence, get_gen_attribute_limit("Intelligence"))
	Wits = min(Wits, get_gen_attribute_limit("Wits"))

/datum/preferences/proc/reset_attributes()
	Strength = 1
	Dexterity = 1
	Stamina = 1

	Charisma = 1
	Manipulation = 1
	Appearance = 1

	Perception = 1
	Intelligence = 1
	Wits = 1

	Alertness = 0
	Athletics = 0
	Brawl = 0
	Empathy = 0
	Intimidation = 0
	Expression = 0

	Crafts = 0
	Melee = 0
	Firearms = 0
	Drive = 0
	Security = 0

	Finance = 0
	Investigation = 0
	Medicine = 0
	Linguistics = 0
	Occult = 0
