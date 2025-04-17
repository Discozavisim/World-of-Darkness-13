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
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
		var/atom/a = pick(GLOB.vampireroll_numbers)
		if(a)
			GLOB.vampireroll_numbers -= a
			qdel(a)
	if(length(GLOB.vampireroll_numbers))
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

/mob/living/Initialize()
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

	var/Crafts = 0
	var/Melee = 0
	var/Firearms = 0
	var/Drive = 0
	var/Security = 0

	var/Finance = 0
	var/Investigation = 0
	var/Medicine = 0
	var/Linguistics = 0
	var/Occult = 0

	var/fortitude_bonus = 0
	var/passive_fortitude = 0
	var/potence_bonus = 0
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

	Crafts = rand(0, 4)
	Melee = rand(0, 4)
	Firearms = rand(0, 4)
	Drive = rand(0, 4)
	Security = rand(0, 4)

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


/proc/secret_vampireroll(var/dices_num = 1, var/hardness = 1, var/mob/living/rollperformer, var/stealthy = FALSE, var/decap_rolls = TRUE)
	if(!dices_num)
		if(!stealthy)
			create_number_on_mob(rollperformer, "#646464", "0")
			to_chat(rollperformer, "<b>No dicepool!</b>")
		return 0
	var/clan_difficulty = 0
	var/autosuccesses = 0
	if(ishuman(rollperformer))
		var/mob/living/carbon/human/Roller = rollperformer
		if(Roller.willpower_auto)
			autosuccesses = 3
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

/datum/action/aboutme/Trigger()
	if(host)
		var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909; color: white;
			}


			</style>
			"}
		dat += "<center><h2>Memories</h2><BR></center>"
		dat += "[icon2html(getFlatIcon(host), host)]I am "
		if(host.real_name)
			dat += "[host.real_name],"
		if(!host.real_name)
			dat += "Unknown,"

		if(host.mind)

			if(iskindred(host))
				if(host.clane)
					dat += " the [host.clane.name]"
				else
					dat += " the caitiff"
			else if(isgarou(host) || iswerewolf(host))
				dat += " the garou"
			else if(iscathayan(host))
				dat += " the kuei-jin"
			else if(isghoul(host))
				dat += " the ghoul"
			else
				dat += " the mortal"

			if(host.mind.assigned_role)
				if(host.mind.special_role)
					dat += ", carrying the [host.mind.assigned_role] (<font color=red>[host.mind.special_role]</font>) role."
				else
					dat += ", carrying the [host.mind.assigned_role] role."
			if(!host.mind.assigned_role)
				dat += "."
			dat += "<BR>"
			if(host.mind.enslaved_to)
				dat += "My Regnant is [host.mind.enslaved_to], I should obey their wants.<BR>"
		if(host.mind.special_role)
			for(var/datum/antagonist/A in host.mind.antag_datums)
				if(A.objectives)
					dat += "[printobjectives(A.objectives)]<BR>"
		if(iskindred(host) || isghoul(host))
			if(host.vampire_faction == "Camarilla" || host.vampire_faction == "Anarchs" || host.vampire_faction == "Sabbat" || host.vampire_faction == "Giovanni" || host.vampire_faction == "Triad")
				dat += "I belong to [host.vampire_faction] faction, I shouldn't disobey their rules.<BR>"
			if(host.generation)
				dat += "I'm from [host.generation] generation.<BR>"
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
			dat += "Camarilla thinks I[masquerade_level]<BR>"
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
						humanity = "I feel hunger for <b>BLOOD</b>. My humanity is slipping away."
					if(1)
						humanity = "Blood. Feed. Hunger. It gnaws. Must <b>FEED!</b>"

			else
				switch(host.humanity)
					if(8 to 10)
						humanity = "I'm <b>ENLIGHTENED</b>, my <b>BEAST</b> and I are in complete harmony."
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

			dat += "[humanity]<BR>"

		if(iskindred(host))
			if(host.clane.name == "Brujah")
				if(GLOB.brujahname != "")
					if(host.real_name != GLOB.brujahname)
						dat += " My primogen is: [GLOB.brujahname].<BR>"
			if(host.clane.name == "Malkavian")
				if(GLOB.malkavianname != "")
					if(host.real_name != GLOB.malkavianname)
						dat += " My primogen is: [GLOB.malkavianname].<BR>"
			if(host.clane.name == "Nosferatu")
				if(GLOB.nosferatuname != "")
					if(host.real_name != GLOB.nosferatuname)
						dat += " My primogen is: [GLOB.nosferatuname].<BR>"
			if(host.clane.name == "Toreador")
				if(GLOB.toreadorname != "")
					if(host.real_name != GLOB.toreadorname)
						dat += " My primogen is: [GLOB.toreadorname].<BR>"
			if(host.clane.name == "Ventrue")
				if(GLOB.ventruename != "")
					if(host.real_name != GLOB.ventruename)
						dat += " My primogen is: [GLOB.ventruename].<BR>"
		if(iscathayan(host))
			var/masquerade_level = " is clueless about my presence."
			switch(host.masquerade)
				if(4)
					masquerade_level = " has some thoughts of awareness."
				if(3)
					masquerade_level = " is barely spotting the truth."
				if(2)
					masquerade_level = " is starting to know."
				if(1)
					masquerade_level = " knows me and my true nature."
				if(0)
					masquerade_level = " thinks I'm a monster and is hunting me."
			dat += "West[masquerade_level]<BR>"
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

			dat += "[dharma]<BR>"

			dat += "The <b>[host.mind.dharma?.animated]</b> Chi Energy helps me to stay alive...<BR>"
			dat += "My P'o is [host.mind.dharma?.Po]<BR>"
			dat += "<b>Yin/Yang</b>[host.max_yin_chi]/[host.max_yang_chi]<BR>"
			dat += "<b>Hun/P'o</b>[host.mind.dharma?.Hun]/[host.max_demon_chi]<BR>"

		dat += "<b>Attributes</b><BR>"
		dat += "Strength: [get_a_strength(host)]<BR>"
		dat += "Dexterity: [get_a_dexterity(host)]<BR>"
		dat += "Stamina: [get_a_stamina(host)]<BR>"
		dat += "Charisma: [get_a_charisma(host)]<BR>"
		dat += "Manipulation: [get_a_manipulation(host)]<BR>"
		dat += "Appearance: [get_a_appearance(host)]<BR>"
		dat += "Perception: [get_a_perception(host)]<BR>"
		dat += "Intelligence: [get_a_intelligence(host)]<BR>"
		dat += "Wits: [get_a_wits(host)]<BR>"
		dat += "<b>Abilities</b><BR>"
		dat += "Alertness: [get_a_alertness(host)]<BR>"
		dat += "Athletics: [get_a_athletics(host)]<BR>"
		dat += "Brawl: [get_a_brawl(host)]<BR>"
		dat += "Empathy: [get_a_empathy(host)]<BR>"
		dat += "Intimidation: [get_a_intimidation(host)]<BR>"
		dat += "Crafts: [get_a_crafts(host)]<BR>"
		dat += "Melee: [get_a_melee(host)]<BR>"
		dat += "Firearms: [get_a_firearms(host)]<BR>"
		dat += "Drive: [get_a_drive(host)]<BR>"
		dat += "Security: [get_a_security(host)]<BR>"
		dat += "Finance: [get_a_finance(host)]<BR>"
		dat += "Investigation: [get_a_investigation(host)]<BR>"
		dat += "Medicine: [get_a_medicine(host)]<BR>"
		dat += "Linguistics: [get_a_linguistics(host)]<BR>"
		dat += "Occult: [get_a_occult(host)]<BR>"


		if(host.Myself)
			if(host.Myself.Friend)
				if(host.Myself.Friend.owner)
					dat += "<b>My friend's name is [host.Myself.Friend.owner.true_real_name].</b><BR>"
					if(host.Myself.Friend.phone_number)
						dat += "Their number is [host.Myself.Friend.phone_number].<BR>"
					if(host.Myself.Friend.friend_text)
						dat += "[host.Myself.Friend.friend_text]<BR>"
			if(host.Myself.Enemy)
				if(host.Myself.Enemy.owner)
					dat += "<b>My nemesis is [host.Myself.Enemy.owner.true_real_name]!</b><BR>"
					if(host.Myself.Enemy.enemy_text)
						dat += "[host.Myself.Enemy.enemy_text]<BR>"
			if(host.Myself.Lover)
				if(host.Myself.Lover.owner)
					dat += "<b>I'm in love with [host.Myself.Lover.owner.true_real_name].</b><BR>"
					if(host.Myself.Lover.phone_number)
						dat += "Their number is [host.Myself.Lover.phone_number].<BR>"
					if(host.Myself.Lover.lover_text)
						dat += "[host.Myself.Lover.lover_text]<BR>"
		if(length(host.knowscontacts) > 0)
			dat += "<b>I know some other of my kind in this city. Need to check my phone, there definetely should be:</b><BR>"
			for(var/i in host.knowscontacts)
				dat += "-[i] contact<BR>"
		if(host.hud_used && (iskindred(host) || isghoul(host)))
			dat += "<b>Known disciplines:</b><BR>"
			for(var/datum/action/discipline/D in host.actions)
				if(D)
					if(D.discipline)
						dat += "[D.discipline.name] [D.discipline.level] - [D.discipline.desc]<BR>"
		var/obj/keypad/armory/K = find_keypad(/obj/keypad/armory)
		if(K && (host.mind.assigned_role == "Prince" || host.mind.assigned_role == "Sheriff"))
			dat += "<b>The pincode for the armory keypad is: [K.pincode]</b><BR>"
		var/obj/structure/vaultdoor/pincode/bank/bankdoor = find_door_pin(/obj/structure/vaultdoor/pincode/bank)
		if(bankdoor && (host.mind.assigned_role == "Capo"))
			dat += "<b>The pincode for the bank vault is: [bankdoor.pincode]</b><BR>"
		if(bankdoor && (host.mind.assigned_role == "La Squadra"))
			if(prob(50))
				dat += "<b>The pincode for the bank vault is: [bankdoor.pincode]</b><BR>"
			else
				dat += "<b>Unfortunately you don't know the vault code.</b><BR>"
		for(var/datum/vtm_bank_account/account in GLOB.bank_account_list)
			if(host.bank_id == account.bank_id)
				dat += "<b>My bank account code is: [account.code]</b><BR>"
				break
		host << browse(HTML_SKELETON(dat), "window=vampire;size=400x450;border=1;can_resize=1;can_minimize=0")
		onclose(host, "vampire", src)

/mob/living/carbon/human
	var/datum/morality_path/MyPath
	var/willpower_auto = FALSE

/datum/morality_path
	var/mob/living/carbon/human/owner
	var/name = "Path"
	var/desc = "This is a default path for everyone."
	var/dot = 5
	var/willpower = 5
	var/consience = 1
	var/selfcontrol = 1
	var/courage = 1

	var/list/ready_events = list()
	var/list/bad_events = list()
	var/murder_victms = 0	//So when it hits 5 it's confirmed mass murder


/datum/morality_path/proc/trigger_morality(var/trig_event)
	if(ready_events[trig_event] == 1)
		return
	ready_events[trig_event] = 1
//	switch(trig_event)
//		if("trigger_default")
//			to_chat(owner, "[icon2html('icons/beast.png', owner)] <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Доверься своему телу. Запугивай людей.</span>")

/datum/morality_path/humanity
	name = "Humanity"
	desc = "The Humanity score represents how close a Kindred remains to their human nature, to specific people vital to them, and how easily they slip away from human concerns and instead towards the whims of the Beast."
	ready_events = list("slur" = 0, "attackfirst" = 0, "steal" = 0, "robbery" = 0, "drugdealing" = 0, "organtrade" = 0, "drying" = 0, "kill" = 0, "massmurder" = 0, "cpr" = 0, "shockpaddles" = 0, "donate" = 0, "dance" = 0, "animaldrink" = 0, "ratdrink" = 0, "packetdrink" = 0, "baddrink" = 0, "gooddrink" = 0, "firstfeed" = 0, "suncoming" = 0, "rotshreck" = 0, "bloodhunger" = 0, "pretorpor" = 0, "jumpfail" = 0, "jumpsuccess" = 0, "deadexamine" = 0, "onfire" = 0, "highspeed" = 0, "attacked" = 0, "attackedfail" = 0, "gettingdrunk" = 0, "talkenough" = 0, "cleanenough" = 0, "gettinghigh" = 0, "corpseitems" = 0, "friendmeet" = 0, "lovermeet" = 0)
	bad_events = list("attackfirst", "steal", "robbery", "drugdealing", "organtrade", "drying", "kill", "massmurder")

/datum/morality_path/humanity/trigger_morality(var/trig_event)
	if(bad_events.Find(trig_event))
		for(var/mob/living/carbon/human/H in viewers(7, owner))
			if(H != owner && H.mind?.dharma)
				if("judgement" in H.mind.dharma.tenets)
					to_chat(H, "<span class='warning'>[owner] is doing something bad, I need to punish them!")
					H.mind.dharma.judgement |= owner.real_name

	var/special_role_name
	if(owner.mind)
		if(owner.mind.special_role)
			var/datum/antagonist/A = owner.mind.special_role
			special_role_name = A.name

	if(is_special_character(owner) && special_role_name != "Ambitious")
		return

	if(ready_events[trig_event] == 1)
		return FALSE
	ready_events[trig_event] = 1

	switch(trig_event)
		//humanity lowers
		if ("slur")
			if(dot > 9)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["slur"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Я не сомневаюсь в вашем словарном запасе, [owner.gender == FEMALE ? "мэм" : "сэр"], но это кажется скоро пересечёт границы. Слово не воробей, вылетит - не поймаешь, но в будущем это может встать на пути к нашим взглядам.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Стоит задуматься о покупке словаря. Это совсем никуда не годится! Как можно выражаться таким языком? Чему тебя учили родители?</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Можно было подобрать и более красивую речь. Серьёзно.</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Я подвёл вас. Простите, язык был моей прерогативой.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Искренне извиняюсь, но я сам не знаю таких слов.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Не стоило доверять языку, я его давно подозревал. Так и запишем.</span>")
					adjust(min(0, 9-dot))
			else
				ready_events["slur"] = 0
		if ("attackfirst")
			if(dot > 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["attackfirst"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Это была атака? Нанесение вреда живому, разумному существу? Как такое вообще допустимо?!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — А если твой оппонент погибнет, то кто к нему прийдёт на похороны? А КТО ПРИЙДЁТ НА ПОХОРОНЫ К ТЕБЕ?!</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Это должно быть о-о-очень больно... А если бы напали на тебя?</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Это был хороший ход, но, плохая идея.</span>")
						if(2)
							var/who_to_beat = "жены"
							if(owner.gender == FEMALE)
								if(!HAS_TRAIT(owner, TRAIT_HOMOSEXUAL))
									who_to_beat = "мужа"
							else
								if(HAS_TRAIT(owner, TRAIT_HOMOSEXUAL))
									who_to_beat = "мужа"
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Чёрт подери, чёрт подери... я совсем потерял контроль над руками! А что дальше, перейдём к избиению [who_to_beat]?</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Ай-ай-ай-ай, за такое сдача прилетит вдвойне больше. Прилетит же?</span>")
					adjust(min(0, 8-dot))
			else
				ready_events["attackfirst"] = 0
		/*
		if ("failing")
			if(dot > 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events -= "failing"
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — За попытку спасения зачтётся конечно, хоть и не за самую успешную.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Да, не получилось, бывает. Ничего страшного, это ведь лучше, чем платная медицина, не так-ли?</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — По крайней мере эта смерть была в добрых, заботливых руках.</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — О нет! Клиническая смерть! Доктор, звоните в ритуальные услуги.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Какими руками спасали, такими прийдётся и закапывать...</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Кажется, стоило позвонить более опытному специалисту, а не решать всё самостоятельно...</span>")
					adjust(min(0, 8-dot))
			else
				ready_events -= "failing"
		*/
		if ("steal")
			if(dot > 7)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["steal"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Это не взлом, а просто небольшое взаимствование у потенциального друга. Наверное стоит записать номер владельца и вернуть, как-нибудь потом...</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Перед любопытством все двери открыты. Ты ведь просто посмотришь, что внутри, и закроешь обратно?</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Да, это проникновение. Проникновение с целью... Хмм... А какая у этого может быть цель?</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Хозяин этой собственности явно не будет доволен гостями.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Плохой поступок, взлом и кража - почти одно и то же. Только ствол добавь - и будет разбой.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Эй, слышишь? Подбирай ключи к сердцам, а не к дверям.</span>")
					adjust(min(0, 7-dot))
			else
				ready_events["steal"] = 0
		if ("robbery")
			if(dot > 6)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["robbery"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — До чего докатился этот мир... Нуждающиеся воруют у нуждающихся. Порочный круг бомже-краж.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Нам нужнее, мы ведь вернём то что взяли.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Не переживай, ты не [owner.gender == FEMALE ? "воровка" : "вор"], это всё жестокий фашистский режим капитализма.</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Такое... подлое действие. А что если это было нужнее хозяину? А мы просто взяли что хотели, как животное.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Ворам в древности отрубали руки. Как-то не хочется их терять, они ведь такие ловкие...</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — На что только не пойдёшь, чтобы подзаработать. И что, теперь ты [owner.gender == FEMALE ? "довольна" : "доволен"] собой?</span>")
					adjust(min(0, 6-dot))
			else
				ready_events["robbery"] = 0
		if ("drugdealing")
			if(dot > 5)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["drugdealing"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Употреблять психоактивные вещества - это выбор каждого.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Ты ведь не продаёшь эту дрянь подросткам или беременным мамочкам. Не стоит волноваться.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Когда-нибудь этот картель всё равно накроют, и мир станет лучше. Ты просто дров в костёр подкидываешь.</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Сколько же людей ломают свои жизни от этого дерьма...</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Один пакетик, и тысяча страданий.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Сколько ещё можно продавать яд народу? Этим должны заниматься политики, фармацевтические компании и фургоны хиппи. Зачем ты это делаешь?</span>")
					adjust(min(0, 5-dot))
			else
				ready_events["drugdealing"] = 0
		if ("organtrade")
			if(dot > 5)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["organtrade"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Ты ведь не живых людей продаёшь. По крайней мере, не целиком.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Кому-то эти органы явно нужнее, чем прошлому владельцу.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Интересная мысль: Почему график героизма стремится от нуля до бесконечности за каждую проданную почку, но уходит ниже нуля к заинтересованности полицией, когда проданных почек оказывается три и более?</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Как тебе вообще могла прийти в голову идея продавать чужие части тела на чёрном рынке?!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Что ты делаешь? Это не просто не законно, или не этично. Это бесчеловечно!</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Только не говори, что продаёшь органы нуждающимся больным детям. Нет, в этот раз эта отмазка не прокатит. Ты прекрасно понимаешь, что творишь...</span>")
					adjust(min(0, 5-dot))
			else
				ready_events["organtrade"] = 0
		if ("drying")
			if(dot > 4)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["drying"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Ах! Ничего страшного. Кажется, тело ещё шевелится. Небольшое переливание крови и будет в норме.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Это было необходимо вкусно. Вкусно и точка.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Да, прийдётся поработать над умением контроллировать себя.</span>")
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='discosay'> — Не надо надо мной работать!</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — О-ох... Какой бред, это всё сон. Нет, нет, нельзя сосать до потери пульса!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Боже мой. Труп.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Чёртов голод. Я тут бессилен, это всё вина чёртового голода. Мне что, глистов тоже учиться контролировать?</span>")
					adjust(min(0, 4-dot))
			else
				ready_events["drying"] = 0
			var/replic2 = rand(1, 3)
			switch(replic2)
				if(1)
					to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Тебе не занимать голода... Мне это нравится. Этот вкус, этот запах. Теперь это пустой сосуд, обёртка от сладкой конфеты, мусор. А что? Смертные тоже мусорят, чем мы с тобой хуже, а?</span>")
				if(2)
					to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — КРОВЬ. СОСАТЬ. КРОВЬ. СОСАТЬ. КРОВЬ. СОСАТЬ.</span>")
				if(3)
					to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — О да! Допивай всё до последней капли!</span>")
		if ("kill")
			if(murder_victms >= 5)
				trigger_morality("massmurder")
			else
				if(dot > 3)
					var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
					if(rolls > 2)
						var/replic = rand(1, 3)
						ready_events["kill"] = 0
						switch(replic)
							if(1)
								to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Все, рано или поздно, умирают...</span>")
							if(2)
								to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Да, человек смертен, но это было бы еще полбеды. Плохо то, что он иногда внезапно смертен, вот в чем фокус! И вообще не может сказать, что он будет делать в сегодняшний вечер.</span>")
							if(3)
								to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Выбор только на бумаге. В реальности же его просто нет. Что сделано - то сделано. Кто-то по итогу должен был умереть.</span>")
					else
						murder_victms = murder_victms+1
						var/replic = rand(1, 3)
						switch(replic)
							if(1)
								to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Это было самое настоящее, хладнокровное убийство!</span>")
							if(2)
								to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Психопатия! У нас труп, возможно криминал, по коням.</span>")
							if(3)
								to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Посмотри... Посмотри! Твои руки по локоть в крови и ты даже не акушер в роддоме. Как до такого вообще можно было докатиться?</span>")
						adjust(min(0, 3-dot))
				else
					murder_victms = murder_victms+1
					ready_events["kill"] = 0
				var/replic2 = rand(1, 3)
				switch(replic2)
					if(1)
						to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Одним смертным больше, другим меньше. Какая разница?</span>")
					if(2)
						to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Ха-ха-ха-ха-ха... Кажется, мы находим общий язык.</span>")
					if(3)
						to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Подумаешь, раздавил[owner.gender == FEMALE ? "а" : ""] муравья, сломал[owner.gender == FEMALE ? "а" : ""] ветку, убил[owner.gender == FEMALE ? "а" : ""] человека? В чём проблема?</span>")
//		if ("sadism")
		if ("massmurder")
			if(dot > 0)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					ready_events["massmurder"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Нет. Из всех, кого ты убил[owner.gender == FEMALE ? "а" : ""], этот точно заслужил. Без вариантов.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Не знаю, какое ещё оправдание придумать...</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Серийный убийца? Нет, просто работа такая.</span>")
				else
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Одним смертным больше, другим меньше. Какая разница?</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Ха-ха-ха-ха-ха... Кажется, мы находим общий язык.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Подумаешь, раздавил[owner.gender == FEMALE ? "а" : ""] муравья, сломал[owner.gender == FEMALE ? "а" : ""] ветку, убил[owner.gender == FEMALE ? "а" : ""] человека? В чём проблема?</span>")
					adjust(min(0, 0-dot))
			else
				ready_events["massmurder"] = 0

		//RESTORING
		if ("cpr")
			if(dot < 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Вот так, вдох-выдох, вдох-выдох. ТЫ БУДЕШЬ ЖИТЬ!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Делай не эротический массаж и без интимного подтекста вдувай воздух в губы, это так просто!</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Рано ещё похоронное бюро вызывать... А вот врача - пригодилось бы.</span>")
					adjust(1)
				else
					var/replic = rand(1, 3)
					ready_events["cpr"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — И что ты делаешь? Ты и так не спасёшь эту жизнь...</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Всё напрасно. Здесь летальный исход очевиден.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Стоит ли вообще бороться за эту жизнь?</span>")
			else
				ready_events["cpr"] = 0
		if ("shockpaddles")
			if(dot < 9)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Разряд! Тебе \"туда\" ещё рано!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Нет времени на смерть, нужно жить дальше!</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Отлично! Ещё пара Ватт, и будет как новенький.</span>")
					adjust(1)
				else
					var/replic = rand(1, 3)
					ready_events["shockpaddles"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Хочешь и так страдавшее тело мучать ударами током? Пф-ф...</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Не трать электроэнергию в пустую.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Сотни людей умирают в эту же минуту. А стоит ли этот альтруизм того?</span>")
			else
				ready_events["shockpaddles"] = 0
		if ("donate")
			if(dot < 7)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Драться с супер-злодеями? Ерунда! Денежные пожертвования - вот что делает тебя настоящим героем.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Всего пара зелёных портретов президентов и кому-то станет лучше.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Щедрость - хорошее качество хорошего человека.</span>")
					adjust(1)
				else
					var/replic = rand(1, 3)
					ready_events["donate"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Зачем давать бомжам деньги? Они же тратят их на алкоголь и наркотики.</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Деньги на ветер...</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — И? Ты уже закончил[owner.gender == FEMALE ? "а" : ""]? Доказал[owner.gender == FEMALE ? "а" : ""] себе что ты не кусок дерьма?</span>")
			else
				ready_events["donate"] = 0

		if ("dance")
			if(dot < 10)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic = rand(1, 3)
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Левой, правой, левой, правой. Так держать, суперзвезда!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Танцевать так приятно, что хочется петь...</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'> — Зажги танцпол, детка!</span>")
					adjust(1)
				else
					var/replic = rand(1, 3)
					ready_events["dance"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Хватит двигаться, это выглядит убого! Прекрати! Прошу!</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Это вряд-ли можно назвать танцем. Скорее, предсмертной судорогой.</span>")
						if(3)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Убери чёртову улыбку с лица и прекрати танцевать, тебе уже не десять лет!</span>")
			else
				ready_events["dance"] = 0

		//BEAST
		if ("animaldrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Фу, ну и дрянь. Найди что-то поаппетитнее. Может ещё и крысами начнёшь питаться?</span>")
		if ("ratdrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — КРЫСОСОС[owner.gender == FEMALE ? "КА" : ""].</span>")
		if ("packetdrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Из пакетика? А почему без слюнявчика и трубочки, [owner.gender == FEMALE ? "мадмуазель" : "миссье"]?</span>")
		if ("baddrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Меня сейчас вырвет от этого дерьма...</span>")
		if ("gooddrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — ВКУСНЯТИНА. ХОЧУ ЕЩЁ.</span>")
		if ("firstfeed")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — М-м-м... С этого и стоило начинать.</span>")
		if ("suncoming")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — ПРЯЧЬСЯ ОТ СОЛНЦА, ТУПИЦА!</span>")
		if ("rotshreck")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — А-А-А! ОГОНЬ! ОГОНЬ! ГОРЯЧО! ПОЖАР!</span>")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'> — Самое время сменить приоритеты в жизни и стать пожарным. Фортуна любит отважных!</span>")
		if ("bloodhunger")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — НАСТАЛО ВРЕМЯ ПОДКРЕПИТЬСЯ. Я ГОЛОДЕН.</span>")
		if ("pretorpor")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Смерть? Нет, это блюдо в мой рацион не входит... А ну давай, вставай!</span>")

		//COURAGE
		if ("jumpfail")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'> — А тут высоковато, не находишь? Наверное, не стоит даже пробовать.</span>")
		if ("jumpsuccess")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Success</span> <span class='discosay'> — Ты летишь! Летишь! Столько метров над землёй! Столько кинетического ускорения!</span>")
		if ("deadexamine")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'> — Спокойно. Это просто самый обычный мёртвый человек. Не зомби...</span>")
		if ("onfire")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'> — Это ерунда, ты ведь не сгоришь за секунды как стог сухого сена. Не обращай внимание, пока сильно печь не начнёт.</span>")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — ПОЛУНДРА! ОГОНЬ НА БОРТУ!!</span>")
		if ("highspeed")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'> — Больше оборотов, выше скорость, сильнее ветер, и чтобы вдавливаться в столб было не так больно и мучительно!</span>")
		if ("attacked")
			ready_events["attackedfail"] = 1
			var/replic = rand(1, 3)
			switch(replic)
				if(1)
					to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Success</span> <span class='discosay'> — На тебя напали! Защищайся, как герой! Честь и отвага!</span>")
				if(2)
					to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Success</span> <span class='discosay'> — Драка! Перестрелка! Поножовщина! Порно!</span>")
				if(3)
					to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Success</span> <span class='discosay'> — Это твой звёздный час, чтобы показать свои боевые навыки.</span>")
		if ("attackedfail")
			ready_events["attacked"] = 1
			var/replic = rand(1, 3)
			switch(replic)
				if(1)
					to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Я, пожалуй, отойду. Ты тоже, пожалуй, отойди...</span>")
				if(2)
					to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Пережить развод, взять кредит, жить без родителей - это я могу... А это мне не под силу.</span>")
				if(3)
					to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'> — Знаешь, что я тебе посоветую? Беги, сука, беги!</span>")

		//SELF-CONTROL
		if ("gettingdrunk")
			to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span><span class='discosay'> — Какое интересное ощущение... Хочется подружиться со всеми и спорить о политике до драки. Ты сейчас в розовых очках юности.</span>")
		if ("talkenough")
			to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span><span class='discosay'> — Болтаешь половину ночи, язык скоро отвалится. Но, дикторские навыки нам не помешают, верно?</span>")
		if ("cleanenough")
			to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span><span class='discosay'> — Одни только кровь, ошмётки и моющее средство! Скажи, как давно швабра стала твоей новой конечностью?</span>")

		//CONSIENCE
		if ("gettinghigh")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span><span class='discosay'> — Это состояние изменённого сознания, или сознательного изменения?...</span>")
		if ("corpseitems")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span><span class='discosay'> — Вещи с трупа. Шикарно, но может не стоит грабить мёртвых?</span>")
		if ("friendmeet")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span><span class='discosay'> — В друзьях есть что-то, что позволяет заземлиться, сбросить якорь, зацепиться за бревно в реке постоянных событий...</span>")
		if ("lovermeet")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSIENCE</b></span><span class='discosay'> — Любовь... Бабочки в животе... Бабочки?... В ЖИВОТЕ?!</span>")

	return TRUE
//"slur" = 10, "attackfirst" = 9, "failing" = 8 "steal" = 7, "robbery" = 6, "drying" = 5, "drugdealing" = 4, "killparticipation" = 3, "killcommit" = 2, "sadism" = 1, "burningalive" = 1, "massmurder" = 0

//BEAST
//SELF-CONTROL "hunger", "bloodhunger", "gettingdrunk"
//COURAGE "crinos", "screamelysium"
//CONSIENCE "corpseitems", "gettinghigh"

//	var/analyze_virtue = /datum/virtue
//	var/control_virtue = /datum/virtue
//	var/courage_virtue = /datum/virtue
//	var/beast_virtue = /datum/virtue
//	var/list/virtues = list(/datum/virtue)

/datum/morality_path/proc/adjust(var/point)
	if(!iskindred(owner))
		return

	if(point == 0)
		return

	if(!GLOB.canon_event)
		return

	var/special_role_name
	if(owner.mind)
		if(owner.mind.special_role)
			var/datum/antagonist/A = owner.mind.special_role
			special_role_name = A.name

	if(is_special_character(owner) && special_role_name != "Ambitious")
		return

	if(point < 1 && dot > 0)
		dot = dot+point
		SEND_SOUND(owner, sound('code/modules/wod13/sounds/humanity_loss.ogg', 0, 0, 75))
		to_chat(owner, "<span class='userdanger'><b>[name] decreased!</b></span>")
	if(point > 1 && dot < 10)
		dot = dot+point
		willpower = willpower+1
		SEND_SOUND(owner, sound('code/modules/wod13/sounds/humanity_gain.ogg', 0, 0, 75))
		to_chat(owner, "<span class='userhelp'><b>[name] increased!</b></span>")

	willpower = min(dot, willpower)
	owner.humanity = dot
	var/datum/preferences/P = GLOB.preferences_datums[ckey(owner.key)]
	if(P)
		if(P.humanity != owner.humanity)
			P.humanity = owner.humanity
			P.save_preferences()
			P.save_character()
		if(!owner.antifrenzy)
			if(P.humanity < 1)
				owner.enter_frenzymod()
				reset_shit(owner)
				to_chat(owner, "<span class='userdanger'>You have lost control of the void within you, and it has taken your body. Be more humane next time.</span>")
				owner.ghostize(FALSE)
				P.reason_of_death = "Lost control to the Beast ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
/*
/datum/morality_path/Initialize()
	var/list/initialized_virtues = list()
	for(var/i in virtues)
		var/datum/virtue/V = new i
		V.path = src
		initialized_virtues += V
	virtues = initialized_virtues

/datum/virtue
	var/datum/morality_path/path
	var/name = "VIRTUE"
	var/icon = 'icons/beast.png'
	var/dot = 1
	var/span = "<span class='secradio'>"
	var/list/ready_events = list()

/datum/virtue/proc/trigger(var/trigger_event)
	if(trigger_event in ready_events)
		return
	ready_events += trigger_event
	switch(trigger_event)
		if("trigger_default")
			to_chat(path.owner, "[icon2html(icon, path.owner)] [span]<b>[name]</b></span><span class='discosay'> — Доверься своему телу. Запугивай людей.</span>")

/datum/virtue/beast
	name = "ЗВЕРЬ"
	icon = 'icons/beast.png'
	dot = 5
	span = "<span class='secradio'>"

/datum/virtue/consience
	name = "СОЗНАТЕЛЬНОСТЬ"
	icon = 'icons/consience.png'
//	dot = 1
	span = "<span class='comradio'>"

/datum/virtue/selfcontrol
	name = "САМОКОНТРОЛЬ"
	icon = 'icons/self-control.png'
//	dot = 1
	span = "<span class='medradio'>"

/datum/virtue/courage
	name = "СМЕЛОСТЬ"
	icon = 'icons/courage.png'
//	dot = 1
	span = "<span class='sciradio'>"

/datum/morality_path/humanity
	name = "Человечность"
	desc = "Она показывает, сколько человеческого осталось от персонажа после Объятий. Именно Человечность не дает вампиру стать кровожадным монстром, который думает только о своем пропитании."
//	dot = 5
//	willpower = 5
	virtues = list(/datum/virtue/beast, /datum/virtue/consience, /datum/virtue/selfcontrol, /datum/virtue/courage)
*/
