GLOBAL_LIST_EMPTY(vampireroll_numbers)
SUBSYSTEM_DEF(woddices)
	name = "World of Darkness dices"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_VERYLOW
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 10 SECONDS

/datum/controller/subsystem/woddices/fire(resumed = FALSE)
	if(MC_TICK_CHECK)
		return
	for(var/i=0, i < length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)

/proc/create_number_on_mob(mob/Mob, what_color, text)
	var/turf/T = get_turf(Mob)
	if(T)
		var/atom/movable/message_atom = new (T)
		message_atom.density = 0
		message_atom.layer = ABOVE_LIGHTING_LAYER
		message_atom.plane = ABOVE_LIGHTING_PLANE
		message_atom.pixel_y = rand(12, 16)
		message_atom.maptext_width = 96
		message_atom.maptext_height = 16
		message_atom.maptext_x = rand(22, 28)
		message_atom.maptext = MAPTEXT(text)
		message_atom.color = what_color
		animate(message_atom, pixel_y = message_atom.pixel_y+8, time = 20, loop = 1)
		animate(message_atom, pixel_y = message_atom.pixel_y+32, alpha = 0, time = 10)
		spawn(20)
			GLOB.vampireroll_numbers += message_atom

/mob/living
	var/datum/attributes/attributes

/mob/living/Initialize(mapload)
	. = ..()
	attributes = new ()
	attributes.randomize()

/datum/attributes
	var/strength = 1
	var/dexterity = 1
	var/stamina = 1

	var/strength_bonus = 0
	var/dexterity_bonus = 0
	var/stamina_bonus = 0

	var/strength_reagent = 0
	var/dexterity_reagent = 0
	var/stamina_reagent = 0

	var/charisma = 1
	var/manipulation = 1
	var/appearance = 1

	var/charisma_bonus = 0
	var/manipulation_bonus = 0
	var/appearance_bonus = 0

	var/charisma_reagent = 0
	var/manipulation_reagent = 0
	var/appearance_reagent = 0

	var/perception = 1
	var/intelligence = 1
	var/wits = 1

	var/perception_bonus = 0
	var/intelligence_bonus = 0
	var/wits_bonus = 0

	var/perception_reagent = 0
	var/intelligence_reagent = 0
	var/wits_reagent = 0

	var/Alertness = 0
	var/Athletics = 0
	var/Brawl = 0
	var/Empathy = 0
	var/Intimidation = 0
	var/Expression = 0

	var/Crafts = 0
	var/Melee = 0
	var/Firearms = 0
	var/Drive = 0
	var/Security = 0
	var/Fleshcraft = 0
	var/Performance = 0

	var/Finance = 0
	var/Investigation = 0
	var/Medicine = 0
	var/Linguistics = 0
	var/Occult = 0

	var/fortitude_bonus = 0
	var/passive_fortitude = 0
	var/potence_bonus = 0
	var/celerity_bonus = 0
	var/visceratika_bonus = 0
	var/bloodshield_bonus = 0
	var/lasombra_shield = 0
	var/tzimisce_bonus = 0
	var/auspex_buff = 0

	var/diff_curse = 0

/datum/attributes/proc/randomize()
	strength = rand(1, 3)
	dexterity = rand(1, 3)
	stamina = rand(1, 3)

	charisma = rand(1, 3)
	manipulation = rand(1, 3)
	appearance = rand(1, 3)

	perception = rand(1, 3)
	intelligence = rand(1, 3)
	wits = rand(1, 3)

	Alertness = rand(0, 4)
	Athletics = rand(0, 4)
	Brawl = rand(0, 4)
	Empathy = rand(0, 4)
	Intimidation = rand(0, 4)
	Expression = rand(0, 4)

	Crafts = rand(0, 4)
	Melee = rand(0, 4)
	Firearms = rand(0, 4)
	Drive = rand(0, 4)
	Security = rand(0, 4)
	Performance = rand(0, 4)

	Finance = rand(0, 4)
	Investigation = rand(0, 4)
	Medicine = rand(0, 4)
	Linguistics = rand(0, 4)
	Occult = rand(0, 4)

/proc/get_fortitude_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.fortitude_bonus+Living.attributes.passive_fortitude
	else
		return 0

/proc/get_potence_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.potence_bonus
	else
		return 0

/proc/get_celerity_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.celerity_bonus
	else
		return 0

/proc/get_visceratika_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.visceratika_bonus
	else
		return 0

/proc/get_tzimisce_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.tzimisce_bonus
	else
		return 0

/proc/get_bloodshield_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.bloodshield_bonus
	else
		return 0

/proc/get_lasombra_dices(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.lasombra_shield
	else
		return 0

/proc/get_a_alertness(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Alertness
	else
		return 0

/proc/get_a_athletics(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Athletics
	else
		return 0

/proc/get_a_brawl(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Brawl
	else
		return 0

/proc/get_a_empathy(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Empathy
	else
		return 0

/proc/get_a_intimidation(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Intimidation
	else
		return 0

/proc/get_a_expression(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Expression
	else
		return 0

/proc/get_a_crafts(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Crafts
	else
		return 0

/proc/get_a_melee(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Melee
	else
		return 0

/proc/get_a_firearms(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Firearms+Living.attributes.auspex_buff
	else
		return 0

/proc/get_a_drive(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Drive
	else
		return 0

/proc/get_a_security(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Security
	else
		return 0

/proc/get_a_performance(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Performance
	else
		return 0

/proc/get_a_fleshcraft(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Fleshcraft
	else
		return 0

/proc/get_a_finance(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Finance
	else
		return 0

/proc/get_a_investigation(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Investigation+Living.attributes.auspex_buff
	else
		return 0

/proc/get_a_medicine(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Medicine
	else
		return 0

/proc/get_a_linguistics(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Linguistics
	else
		return 0

/proc/get_a_occult(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.Occult
	else
		return 0

/proc/get_a_strength(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.strength+Living.attributes.strength_bonus+Living.attributes.strength_reagent+get_potence_dices(Living)
	else
		return 3

/proc/get_a_dexterity(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.dexterity+Living.attributes.dexterity_bonus+Living.attributes.dexterity_reagent
	else
		return 3

/proc/get_a_stamina(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.stamina+Living.attributes.stamina_bonus+Living.attributes.stamina_reagent
	else
		return 3

/proc/get_a_manipulation(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.manipulation+Living.attributes.manipulation_bonus+Living.attributes.manipulation_reagent
	else
		return 3

/proc/get_a_charisma(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.charisma+Living.attributes.charisma_bonus+Living.attributes.charisma_reagent
	else
		return 3

/proc/get_a_appearance(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.appearance+Living.attributes.appearance_bonus+Living.attributes.appearance_reagent
	else
		return 3

/proc/get_a_perception(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.perception+Living.attributes.perception_bonus+Living.attributes.perception_reagent
	else
		return 3

/proc/get_a_intelligence(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.intelligence+Living.attributes.intelligence_bonus+Living.attributes.intelligence_reagent
	else
		return 3

/proc/get_a_wits(mob/living/Living)
	if(Living.attributes)
		return Living.attributes.wits+Living.attributes.wits_bonus+Living.attributes.wits_reagent
	else
		return 3

/proc/get_a_willpower(mob/living/Living)
	if(ishuman(Living))
		var/mob/living/carbon/human/ohvampire = Living
		if(ohvampire.MyPath)
			return ohvampire.MyPath.willpower
		else if(ohvampire.mind?.dharma)
			return ohvampire.mind.dharma.willpower
		else if(isgarou(Living) || iswerewolf(Living))
			var/mob/living/carbon/C = Living
			switch(C.client.prefs.auspice_level)
				if(1)
					return 7
				if(2)
					return 8
				if(3)
					return 9
		else
			return ceil(ohvampire.humanity/2)
	else
		return 2

/proc/get_dice_image(input, diff)
	var/dat = ""
	var/span_end = ""
	if((input >= diff && input != 1) || input == 10)
		dat += "<span class='nicegreen'>"
		span_end = "</span>"
	if(input == 1)
		dat += "<span class='danger'>"
		span_end = "</span>"
	switch(input)
		if(1)
			dat += "❶"
		if(2)
			dat += "❷"
		if(3)
			dat += "❸"
		if(4)
			dat += "❹"
		if(5)
			dat += "❺"
		if(6)
			dat += "❻"
		if(7)
			dat += "❼"
		if(8)
			dat += "❽"
		if(9)
			dat += "❾"
		if(10)
			dat += "❿"
		else
			dat += "⓿"
	dat += span_end
	return dat


/proc/secret_vampireroll(dices_num = 1, hardness = 1, mob/living/rollperformer, stealthy = FALSE, decap_rolls = TRUE, autosuccesses = 0)
	if(!dices_num)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#646464", "0")
			to_chat(rollperformer, "<b>No dicepool!</b>")
		return 0
	var/clan_difficulty = 0
	if(ishuman(rollperformer))
		var/mob/living/carbon/human/Roller = rollperformer
		if(Roller.willpower_auto)
			autosuccesses += 3
		if(Roller.clane?.name == "Followers of Set")
			var/datum/vampireclane/setite/Setite = Roller.clane
			var/turf/T = get_turf(Roller)
			if(T)
				var/lums = T.get_lumcount()
				if(lums > 0.7)
					if(Setite.last_setite_warning <= world.time)
						Setite.last_setite_warning = world.time + 3 SECONDS
						to_chat(Roller, "<span class='warning'>The light around is making everything difficult...</span>")
					clan_difficulty = 1
	hardness = clamp(hardness+rollperformer.attributes.diff_curse+clan_difficulty, 1, 10)
	var/dices_decap = 0
	if(decap_rolls && !autosuccesses)
		dices_decap = rollperformer.get_health_difficulty()
	dices_num = max(1, dices_num-dices_decap)
	var/wins = 0
	var/brokes = 0
	var/result = ""
	for(var/i in 1 to dices_num)
		if(autosuccesses)
			wins += 1
			result += "<span class='medradio'>⓿</span>"
			autosuccesses = autosuccesses-1
		else
			var/roll = rand(1, 10)
			if(roll == 1)
				brokes += 1
			else if(roll >= hardness || roll == 10)
				wins += 1
			result += get_dice_image(roll, hardness)
	wins = wins-brokes
	if(!stealthy)
		to_chat(rollperformer, result)
	if(wins < 0)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#ff0000", "Botch!")
		return -1
	if(wins == 0)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#646464", "0")
	if(wins == 1)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#dc9f2d", "1")
	if(wins == 2)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#e6de29", "2")
	if(wins == 3)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#7af321", "3")
	if(wins == 4)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#00ff77", "4")
	if(wins == 5)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#00c6ff", "5")
	if(wins == 6)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#0066ff", "6")
	if(wins >= 7)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#b200ff", "7+")
	return wins

/datum/action/aboutme
	name = "About Me"
	desc = "Check assigned role, attributes, known contacts etc."
	button_icon_state = "masquerade"
	check_flags = NONE
	var/mob/living/carbon/human/host

/datum/action/aboutme/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AboutMePanel", name)
		ui.open()

/datum/action/aboutme/ui_host(mob/user)
	return host

/datum/action/aboutme/ui_state(mob/user)
	return GLOB.always_state

/datum/action/aboutme/ui_data(mob/user)
	var/list/data = list()
	if(!host)
		return data
	data["name"] = host.real_name ? host.real_name : "Unknown"
	var/list/objectives = list()
	if(host.mind)
		if(iskindred(host))
			if(host.clane)
				data["affiliation"] = host.clane.name
			else
				data["affiliation"] = "caitiff"
		else if(isgarou(host) || iswerewolf(host))
			data["affiliation"] =  "garou"
		else if(iscathayan(host))
			data["affiliation"] = "kuei-jin"
		else if(isghoul(host))
			data["affiliation"] = "ghoul"
		else if(iszombie(host))
			data["affiliation"] = "zombie"
		else
			data["affiliation"] = "mortal"
		if(host.mind.assigned_role)
			data["role"] = host.mind.assigned_role
		if(host.mind.special_role)
			for(var/datum/antagonist/A in host.mind.antag_datums)
				if(A.objectives && A.objectives.len)
					var/count = 1
					for(var/datum/objective/objective in A.objectives)
						if(objective.check_completion())
							objectives += "Objective #[count]: [objective.explanation_text] Success!"
						else
							objectives += "Objective #[count]: [objective.explanation_text] Fail."
						count++
			data["special_role"] = host.mind.special_role
	var/list/memories = list()
	if(iskindred(host) || isghoul(host))
		if(host.vampire_faction == "Camarilla" || host.vampire_faction == "Anarchs" || host.vampire_faction == "Sabbat" || host.vampire_faction == "Giovanni" || host.vampire_faction == "Triad")
			memories += "I belong to [host.vampire_faction] faction, I shouldn't disobey their rules."
		if(host.generation)
			memories += "I'm from [host.generation] generation."
		var/masquerade_level = " followed the Masquerade Tradition perfectly."
		switch(host.masquerade)
			if(4)
				masquerade_level = " broke the Masquerade rule once."
			if(3)
				masquerade_level = " made a couple of Masquerade breaches."
			if(2)
				masquerade_level = " provoked a moderate Masquerade breach."
			if(1)
				masquerade_level = " almost ruined the Masquerade."
			if(0)
				masquerade_level = "'m danger to the Masquerade and my own kind."
		memories += "Camarilla thinks I[masquerade_level]"
		var/humanity = "I'm out of my mind."
		var/enlight = FALSE
		if(host.clane)
			if(host.clane.enlightenment)
				enlight = TRUE
		if(!enlight)
			switch(host.humanity)
				if(8 to 10)
					humanity = "I'm saintly."
				if(7)
					humanity = "I feel as human as when I lived."
				if(5 to 6)
					humanity = "I'm feeling distant from my humanity."
				if(4)
					humanity = "I don't feel any compassion for the Kine anymore."
				if(2 to 3)
					humanity = "I feel hunger for BLOOD. My humanity is slipping away."
				if(1)
					humanity = "Blood. Feed. Hunger. It gnaws. Must FEED!"
		else
			switch(host.humanity)
				if(8 to 10)
					humanity = "I'm ENLIGHTENED, my BEAST and I are in complete harmony."
				if(7)
					humanity = "I've made great strides in co-existing with my beast."
				if(5 to 6)
					humanity = "I'm starting to learn how to share this unlife with my beast."
				if(4)
					humanity = "I'm still new to my path, but I'm learning."
				if(2 to 3)
					humanity = "I'm a complete novice to my path."
				if(1)
					humanity = "I'm losing control over my beast!"
		memories += humanity
	if(iskindred(host))
		var/datum/phonecontact/clane_leader_contact = GLOB.important_contacts[host.clane.name]
		if (!isnull(clane_leader_contact) && host.real_name != clane_leader_contact.name)
			var/clane_leader_number = isnull(clane_leader_contact.number) ? "Unknown" : clane_leader_contact.number
			memories += "My clane leader is [clane_leader_contact.name]. Their phone number is [clane_leader_number]."
	if(iscathayan(host))
		var/masquerade_level = "is clueless about my presence."
		switch(host.masquerade)
			if(4)
				masquerade_level = "has some thoughts of awareness."
			if(3)
				masquerade_level = "is barely spotting the truth."
			if(2)
				masquerade_level = "is starting to know."
			if(1)
				masquerade_level = "knows me and my true nature."
			if(0)
				masquerade_level = "thinks I'm a monster and is hunting me."
		memories += "West [masquerade_level]"
		var/dharma = "I'm mindless carrion-eater!"
		switch(host.mind.dharma?.level)
			if(1)
				dharma = "I have not proved my worthiness to exist as Kuei-jin..."
			if(2 to 3)
				dharma = "I'm only at the basics of my Dharma."
			if(4 to 5)
				dharma = "I'm so enlighted I can be a guru."
			if(6)
				dharma = "I have mastered the Dharma so far!"

		memories += dharma
		memories += "The [host.mind.dharma?.animated] Chi Energy helps me to stay alive..."
		memories += "My P'o is [host.mind.dharma?.Po]"
		memories += "Yin/Yang[host.max_yin_chi]/[host.max_yang_chi]"
		memories += "Hun/P'o[host.mind.dharma?.Hun]/[host.max_demon_chi]"
	if(iswerewolf(host) || isgarou(host))
		var/masquerade_level = " have followed the rules tonight."
		switch(host.masquerade)
			if(4)
				masquerade_level = " have made a faux pas tonight."
			if(3)
				masquerade_level = " have made a few issues tonight."
			if(2)
				masquerade_level = " have erred tonight."
			if(1)
				masquerade_level = " have acted foolishly and caused an uproar."
			if(0)
				masquerade_level = " should beg our totem for forgiveness."
		memories += "My sect thinks I[masquerade_level]"
		if(host.auspice.tribe.name == "Black Spiral Dancers")
			memories += "Power: [host.honor]"
			memories += "Infamy: [host.glory]"
			memories += "Cunning: [host.wisdom]"
		else
			memories += "Honor: [host.honor]"
			memories += "Glory: [host.glory]"
			memories += "Wisdom: [host.wisdom]"
	if(iszombie(host))
		var/masquerade_level = " have been a perfect tool for my Necromancer."
		switch(host.masquerade)
			if(4)
				masquerade_level = " have let my true nature slip once."
			if(3)
				masquerade_level = " made errors in maintaining my Necromancer's image."
			if(2)
				masquerade_level = " cause great trouble to my masters."
			if(1)
				masquerade_level = " am close to outliving my usefulness."
			if(0)
				masquerade_level = " have become a danger to my Necromancer and their society."
		memories += "In the world of the mundane, I[masquerade_level]"

	var/list/attributes = list()
	attributes += "Strength: [get_a_strength(host)]"
	attributes += "Dexterity: [get_a_dexterity(host)]"
	attributes += "Stamina: [get_a_stamina(host)]"
	attributes += "Charisma: [get_a_charisma(host)]"
	attributes += "Manipulation: [get_a_manipulation(host)]"
	attributes += "Appearance: [get_a_appearance(host)]"
	attributes += "Perception: [get_a_perception(host)]"
	attributes += "Intelligence: [get_a_intelligence(host)]"
	attributes += "Wits: [get_a_wits(host)]"

	var/list/abilities = list()
	abilities += "Alertness: [get_a_alertness(host)]"
	abilities += "Athletics: [get_a_athletics(host)]"
	abilities += "Brawl: [get_a_brawl(host)]"
	abilities += "Empathy: [get_a_empathy(host)]"
	abilities += "Intimidation: [get_a_intimidation(host)]"
	abilities += "Crafts: [get_a_crafts(host)]"
	abilities += "Melee: [get_a_melee(host)]"
	abilities += "Firearms: [get_a_firearms(host)]"
	abilities += "Drive: [get_a_drive(host)]"
	abilities += "Security: [get_a_security(host)]"
	abilities += "Finance: [get_a_finance(host)]"
	abilities += "Investigation: [get_a_investigation(host)]"
	abilities += "Medicine: [get_a_medicine(host)]"
	abilities += "Linguistics: [get_a_linguistics(host)]"
	abilities += "Occult: [get_a_occult(host)]"

	if(host.Myself)
		if(host.Myself.Friend)
			if(host.Myself.Friend.owner)
				memories += "My friend's name is [host.Myself.Friend.owner.true_real_name]."
				if(host.Myself.Friend.phone_number)
					memories += "Their number is [host.Myself.Friend.phone_number]."
				if(host.Myself.Friend.friend_text)
					memories += host.Myself.Friend.friend_text
		if(host.Myself.Enemy)
			if(host.Myself.Enemy.owner)
				memories += "My nemesis is [host.Myself.Enemy.owner.true_real_name]!"
				if(host.Myself.Enemy.enemy_text)
					memories += "[host.Myself.Enemy.enemy_text]"
		if(host.Myself.Lover)
			if(host.Myself.Lover.owner)
				memories += "I'm in love with [host.Myself.Lover.owner.true_real_name]."
				if(host.Myself.Lover.phone_number)
					memories += "Their number is [host.Myself.Lover.phone_number]."
				if(host.Myself.Lover.lover_text)
					memories += "[host.Myself.Lover.lover_text]"
	if(length(host.knowscontacts) > 0)
		memories += "I know some other of my kind in this city. Need to check my phone, there definetely should be:"
		for(var/i in host.knowscontacts)
			memories += "-[i] contact"
	var/list/disciplines = list()
	if(host.hud_used && (iskindred(host) || isghoul(host)))
		for(var/datum/action/discipline/D in host.actions)
			if(D)
				if(D.discipline)
					disciplines += "[D.discipline.name] [D.discipline.level] - [D.discipline.desc]"
	var/obj/keypad/armory/K = find_keypad(/obj/keypad/armory)
	if(K && (host.mind.assigned_role == "Prince" || host.mind.assigned_role == "Sheriff"))
		memories += "The pincode for the armory keypad is: [K.pincode]"
	var/obj/structure/vaultdoor/pincode/bank/bankdoor = find_door_pin(/obj/structure/vaultdoor/pincode/bank)
	if(bankdoor && (host.mind.assigned_role == "Capo"))
		memories += "The pincode for the bank vault is: [bankdoor.pincode]"
	if(bankdoor && (host.mind.assigned_role == "La Squadra"))
		if(prob(50))
			memories += "The pincode for the bank vault is: [bankdoor.pincode]"
		else
			memories += "Unfortunately you don't know the vault code."
	for(var/datum/vtm_bank_account/account in GLOB.bank_account_list)
		if(host.bank_id == account.bank_id)
			memories += "My bank account code is: [account.code]"
			break
	data["info"] = list(
		list(
			"name" = "Memories",
			"tooltip" = "These are your memories. You received them at birth or during your life!",
			"values" = memories
		),
		list("name" = "Objectives", "tooltip" = "Your objectives", "values" = objectives),
		list("name" = "Disciplines", "tooltip" = "Your disciplines", "values" = disciplines),
		list("name" = "Abilities", "tooltip" = "Your abilities", "values" = abilities),
		list("name" = "Attributes", "tooltip" = "Your attributes", "values" = attributes)
	)
	return data

/datum/action/aboutme/ui_act(action, params)
	. = ..()
	if(.)
		return

/datum/action/aboutme/Trigger()
	if(host)
		ui_interact(host)
		return

/*
/datum/morality_path/metamorphoses
	name = "Путь Метаморфозы"
	desc = ""
	vitrues = list()

/datum/morality_path/bloodpath
	name = "Путь Крови"
	desc = ""
	vitrues = list()
*/
