/datum/job
	var/experience_addition = 0

/datum/outfit/job/post_equip(mob/living/carbon/human/H)
	. = ..()
	var/obj/item/storage/backpack/b = locate() in H
	if(b)
		var/obj/item/vamp/creditcard/card = locate() in b.contents
		if(card && card.has_checked == FALSE)
			for(var/obj/item/vamp/creditcard/caard in b.contents)
				if(caard)
					H.bank_id = caard.account.bank_id
					caard.account.account_owner = H.true_real_name
					caard.has_checked = TRUE
		var/obj/item/passport/pass_port = locate() in b.contents
		if(pass_port)
			pass_port.owner_name = H.real_name
			pass_port.owner_age = H.age
			pass_port.owner_gender = H.gender

	if(!hobo_job)
		for(var/i in 1 to get_a_manipulation(H)+get_a_finance(H))
			H.equip_to_slot_or_del(new /obj/item/stack/dollar/hundred(H),ITEM_SLOT_BACKPACK, TRUE)

//ID

/obj/item/card/id/prince/AltClick(mob/user)
	return

/obj/item/card/id/sheriff/AltClick(mob/user)
	return

/obj/item/card/id/camarilla/AltClick(mob/user)
	return

/obj/item/card/id/clerk/AltClick(mob/user)
	return

/obj/item/card/id/anarch/AltClick(mob/user)
	return

/obj/item/card/id/clinic/AltClick(mob/user)
	return

/obj/item/card/id/archive/AltClick(mob/user)
	return

/obj/item/card/id/cleaning/AltClick(mob/user)
	return

/obj/item/card/id/dealer/AltClick(mob/user)
	return

/obj/item/card/id/supplytech/AltClick(mob/user)
	return

/obj/item/card/id/hunter/AltClick(mob/user)
	return

/obj/item/card/id/primogen/AltClick(mob/user)
	return

/obj/item/card/id/police/AltClick(mob/user)
	return

/obj/item/card/id/hunter
	var/last_detonated = 0

/obj/item/card/id/hunter/attack_self(mob/user)
	. = ..()
	if(last_detonated+300 > world.time)
		return
	if(!user.mind)
		return
	if(user.mind.holy_role != HOLY_ROLE_PRIEST)
		return
	last_detonated = world.time
	do_sparks(rand(5, 9), FALSE, user)
	playsound(user.loc, 'code/modules/wod13/sounds/cross.ogg', 100, FALSE, 8, 0.9)
	for(var/mob/living/M in get_hearers_in_view(4, user.loc))
		bang(get_turf(M), M, user)

/obj/item/card/id/hunter/proc/bang(turf/T, mob/living/M, mob/living/user)
	if(M.stat == DEAD)	//They're dead!
		return
	var/mob/living/carbon/human/H
	if(ishuman(M))
		H = M
	if(H)
		for(var/obj/item/card/id/hunter/HUNT in H.contents)
			if(HUNT)
				if(H.mind)
					if(H.mind.holy_role == HOLY_ROLE_PRIEST)
						return
		if(iskindred(H))
			if(H.clane)
				if(H.clane.name == "Baali")
					H.emote("scream")
					H.pointed(user)

	var/affected_by_faith = (ishuman(M) && (iskindred(M) || isghoul(M) || isgarou(M) || iscathayan(M))) || iswerewolf(M)
	if(affected_by_faith)
		M.show_message("<span class='warning'><b>GOD SEES YOU!</b></span>", MSG_AUDIBLE)
	var/distance = max(0,get_dist(get_turf(src),T))

	if(affected_by_faith && M.flash_act(affect_silicon = 1))
		M.Immobilize(max(10/max(1,distance), 5))

/obj/item/card/id/hunter/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(last_detonated+300 > world.time)
		return
	if(iskindred(target))
		var/mob/living/carbon/human/H = target
		if(H.clane)
			if(H.clane.name == "Baali")
				last_detonated = world.time
				var/turf/lightning_source = get_step(get_step(H, NORTH), NORTH)
				lightning_source.Beam(H, icon_state="lightning[rand(1,12)]", time = 5)
				H.adjustFireLoss(100)
				H.electrocution_animation(50)
				to_chat(H, "<span class='userdanger'>The God has punished you for your sins!</span>", confidential = TRUE)

/obj/item/card/id/prince
	name = "leader badge"
	id_type_name = "leader badge"
	desc = "King in the castle!"
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id6"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id6"
	access = list(1,2)

/obj/item/card/id/sheriff
	name = "head security badge"
	id_type_name = "head security badge"
	desc = "A badge which shows honour and dedication."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id4"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id4"
	access = list(1,2)

/obj/item/card/id/camarilla
	name = "security badge"
	id_type_name = "security badge"
	desc = "A badge which shows honour and dedication."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id3"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id3"
	access = list(2)

/obj/item/card/id/clerk
	name = "clerk badge"
	id_type_name = "clerk badge"
	desc = "A badge which shows buerocracy qualification."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id1"
	access = list(2)

/obj/item/card/id/anarch
	name = "biker badge"
	id_type_name = "biker badge"
	desc = "A badge which shows protest and anarchy."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id5"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id5"

/obj/item/card/id/clinic
	name = "medical badge"
	id_type_name = "medical badge"
	desc = "A badge which shows medical qualification."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id2"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id2"
	access = list(3)

/obj/item/card/id/archive
	name = "scholar badge"
	id_type_name = "scholar badge"
	desc = "A badge which shows a love of culture."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id7"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id7"

/obj/item/card/id/regent
	name = "erudite scholar badge"
	id_type_name = "erudite scholar badge"
	desc = "A badge which shows a deep understanding of culture."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id7_regent"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id7_regent"

/obj/item/card/id/cleaning
	name = "janitor badge"
	id_type_name = "janitor badge"
	desc = "A badge which shows cleaning employment."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id8"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id8"
	access = list(4)

/obj/item/card/id/graveyard
	name = "keeper badge"
	id_type_name = "keeper badge"
	desc = "A badge which shows graveyard employment."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id8"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id8"
	access = list(5)

/obj/item/card/id/dealer
	name = "business badge"
	id_type_name = "business badge"
	desc = "A badge which shows business."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id9"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id9"
	access = list(6)

/obj/item/card/id/supplytech
	name = "technician badge"
	id_type_name = "technician badge"
	desc = "A badge which shows supply employment."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id10"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id10"
	access = list(6)

/obj/item/card/id/hunter
	name = "cross"
	id_type_name = "cross"
	desc = "When you come into the land that the Lord your God is giving you, you must not learn to imitate the abhorrent practices of those nations. No one shall be found among you who makes a son or daughter pass through fire, or who practices divination, or is a soothsayer, or an augur, or a sorcerer, or one who casts spells, or who consults ghosts or spirits, or who seeks oracles from the dead. For whoever does these things is abhorrent to the Lord; it is because of such abhorrent practices that the Lord your God is driving them out before you (Deuteronomy 18:9-12)."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id11"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id11"

/obj/item/card/id/primogen
	name = "mysterious primogen badge"
	id_type_name = "mysterious primogen badge"
	desc = "Sponsored by the Shadow Government."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id12"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id12"
	access = list(2)

/obj/item/card/id/police
	name = "police officer badge"
	id_type_name = "police officer badge"
	desc = "Sponsored by the Government."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id13"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id13"
	access = list(8)

/obj/item/card/id/police/sergeant
	name = "police sergeant badge"
	desc = "Sponsored by the Government. This one seems slightly more worn down than all the others."
	access = list(7,8)

/obj/item/card/id/police/coroner
	name = "police coroner badge"
	icon_state = "id2"
	access = list(7,8)

/obj/item/card/id/police/lieutenant
	name = "police lieutenant badge"
	desc = "Sponsored by the Government. This one has a chrome plated finish."
	access = list(7,8)

/obj/item/card/id/police/fbi
	name = "fbi special agent badge"
	desc = "Sponsored by the Government. This one has all the bells and whistles."
	access = list(8)

/obj/item/card/id/voivode
	name = "ancient badge"
	id_type_name ="ancient badge"
	desc = "You have to wear this filthy thing to be recognized."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id12"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id12"

/obj/item/card/id/bogatyr
	name = "dusty badge"
	id_type_name ="dusty badge"
	desc = "You have to wear this because the Voivode wants you to."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id12"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id12"


/obj/item/card/id/bahari
	name = "cultist badge"
	id_type_name = "cultist badge"
	desc = "This shows your devotion to the dark mother."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id14"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id14"

/obj/item/card/id/noddist
	name = "cultist badge"
	id_type_name = "cultist badge"
	desc = "This shows your devotion to the dark father."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id15"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id15"

// GAROU
/obj/item/card/id/garou
	name = "Base Garou ID"
	id_type_name = "Coder Moment badge"
	desc = "DO NOT USE THIS, THIS IS FOR CODE FOUNDATION ONLY. IF YOU SEE THIS, REPORT IT AS A BUG."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "id5"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	worn_icon = 'code/modules/wod13/worn.dmi'
	worn_icon_state = "id5"

//ENDRON
/obj/item/card/id/garou/spiral
	icon_state = "id9"
	worn_icon_state = "id9"

/obj/item/card/id/garou/spiral/lead
	name = "Endron Branch Leader card"
	desc = "How bad can you possibly be?"
	access = list(9,10)

/obj/item/card/id/garou/spiral/executive
	name = "Endron Executive card"
	desc = "All the customers are buying."
	access = list(9,10)

/obj/item/card/id/garou/spiral/affairs
	name = "Endron Internal Affairs card"
	desc = "And the Lawyers are denying."
	access = list(9,10)

/obj/item/card/id/garou/spiral/secchief
	name = "Endron Chief of Security badge"
	icon_state = "id3"
	worn_icon_state = "id3"
	desc = "Its not illegal if nobody finds out about it. Now if only Endron would pay for a single tank for you."
	access = list(9,10)

/obj/item/card/id/garou/spiral/sec
	name = "Endron Security Agent badge"
	icon_state = "id3"
	worn_icon_state = "id3"
	desc = "Corporate Security, a step above a mall cop. Better paid than a real cop."
	access = list(10)

/obj/item/card/id/garou/spiral/employee
	name = "Endron Employee card"
	desc = "Congratulations, Wagie."
	access = list(10)

/datum/antagonist/ambitious
	name = "Ambitious"
	roundend_category = "ambitious"
	antagpanel_category = "Ambitious"
	job_rank = ROLE_SYNDICATE
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = FALSE

/datum/antagonist/ambitious/on_gain()
	owner.special_role = src
	var/needs_faction = TRUE
	var/no_faction = FALSE
	var/max_objective = 3

	if(iskindred(owner) || isghoul(owner))
		max_objective = 5

	// Fourth if is for the vampire/ghouls since it is only their factions there

	var/objective = rand(1,max_objective)

	switch(objective)
		if(1)
			var/datum/objective/artefact/artefact_objective = new
			artefact_objective.owner = owner
			objectives += artefact_objective
			artefact_objective.update_explanation_text()
		if(2)
			var/datum/objective/money/money_objective = new
			money_objective.owner = owner
			money_objective.amount = rand(3000, 5000)
			objectives += money_objective
			money_objective.update_explanation_text()
		if(3)
			var/list/ambitious = list()
			var/HU_name
			var/mob/living/carbon/human/HU

			for(var/mob/living/carbon/human/H in GLOB.player_list)
				if(H.stat != DEAD && H.true_real_name != owner.current.true_real_name && H.vampire_faction != "Sabbat")
					ambitious += H

			if(length(ambitious))
				HU = pick(ambitious)
				HU_name = HU.true_real_name

			if(HU_name!= "" && HU_name != null)
				var/datum/objective/protect_niga/protect_objective = new
				protect_objective.owner = owner
				protect_objective.mine_target = HU
				objectives += protect_objective
				protect_objective.update_explanation_text()
			else
				var/datum/objective/money/money_objective = new
				money_objective.owner = owner
				money_objective.amount = rand(3000, 5000)
				objectives += money_objective
				money_objective.update_explanation_text()
		if(4)
			if(needs_faction)
				//Since this is called first than most of the iterations, their faction are not set so i had to make it stall abit so people get their faction, the null people will need to wait abit.
				var/retries = 50 // total 5 seconds
				while(owner.current.vampire_faction == null && retries > 0)
					sleep(2) // wait 0.2 seconds
					retries -= 1
			var/list/available_factions = list("Camarilla", "Anarchs", "Sabbat")
			if(owner.current.vampire_faction == null || owner.current.vampire_faction == "Nosferatu" )
				no_faction = TRUE
			if(no_faction)
				var/datum/objective/become_member/member_objective = new
				member_objective.owner = owner
				member_objective.faction = pick(available_factions)
				objectives += member_objective
				member_objective.update_explanation_text()
			else
				var/datum/objective/artefact/artefact_objective = new
				artefact_objective.owner = owner
				objectives += artefact_objective
				artefact_objective.update_explanation_text()
		if(5)
			var/datum/objective/secret/toknow
			for(var/datum/objective/secret/S in GLOB.secrets_list)
				if(S)
					toknow = S
			if(toknow)
				var/datum/objective/reveal/secret_objective = new
				secret_objective.owner = owner
				secret_objective.secret_keeper = toknow.owner.current
				owner.current.reveal_objective = secret_objective
				secret_objective.secret_keeper_name = toknow.owner.current.true_real_name
				objectives += secret_objective
				secret_objective.update_explanation_text()
			else
				var/datum/objective/secret/secret_objective = new
				secret_objective.owner = owner
				secret_objective.thetruth = pick("Эпштейн связан с Камарильей.", "Анархи затевают захват города.", "Князь убил собственного Сира.", "В этом городе затерян саркофаг с Патриархом.", "Кланы против правления Князя.", "Гуй-дзин планируют саботаж всего города.", "Шабаш ожидает возвращение Каина.", "Власти начинают подозревать о сверхъестественном, скоро будет глобальная зачистка.")
				objectives += secret_objective
				GLOB.secrets_list += secret_objective
				secret_objective.update_explanation_text()
				var/datum/action/reveal_secret/infor = new()
				infor.secret_objective = secret_objective
				infor.Grant(owner.current)
	return ..()

/datum/antagonist/ambitious/on_removal()
	..()
	to_chat(owner.current,"<span class='userdanger'>You don't have ambitions anymore.</span>")
	owner.special_role = null

/datum/antagonist/ambitious/greet()
	to_chat(owner.current, "<span class='alertsyndie'>You got some goals that night.</span>")
	owner.announce_objectives()
//TZIMISCE ROLES

/mob/living
	var/datum/objective/reveal/reveal_objective

/datum/action/reveal_secret
	name = "Reveal Secret"
	desc = "Reveal the truth..."
	button_icon_state = "secret"
	check_flags = AB_CHECK_CONSCIOUS
	var/datum/objective/secret/secret_objective

/datum/action/reveal_secret/Trigger()
	if(owner.say("[secret_objective.thetruth]"))
		secret_objective.truthkept = FALSE
		for(var/mob/living/L in oviewers(7, owner))
			if(L.reveal_objective)
				if(L.reveal_objective.secret_keeper == owner)
					to_chat(L, "<span class='alertsyndie'>Now you know the secret... [secret_objective.thetruth]</span>")
					L.reveal_objective.truthrevealed = TRUE
