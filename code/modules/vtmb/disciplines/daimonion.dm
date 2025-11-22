/datum/discipline/daimonion
	name = "Daimonion"
	desc = "Draw power from the demons and infernal nature of Hell. Use subtle power to manipulate people and when you must, draw upon fire itself and protect yourself."
	icon_state = "daimonion"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/daimonion

/datum/discipline_power/daimonion
	name = "Daimonion power name"
	desc = "Daimonion power description"

	cooldown_length = 15 SECONDS

	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/protean_deactivate.ogg'

//SENSE THE SIN
/datum/discipline_power/daimonion/sense_the_sin
	name = "Sense the Sin"
	desc = "Sense the weakness."

	level = 1
	range = 7

	target_type = TARGET_HUMAN

/datum/discipline_power/daimonion/sense_the_sin/pre_activation_checks(mob/living/target)
	var/selfcontrol = 3
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		selfcontrol = H.MyPath?.selfcontrol
	var/success_chance = secret_vampireroll(get_a_perception(target)+get_a_empathy(target), selfcontrol+4, owner)
	if(success_chance <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/sense_the_sin/activate(mob/living/carbon/human/target)
	. = ..()
	if(!HAS_TRAIT(target, TRAIT_SENSE_THE_SIN))
		ADD_TRAIT(target, TRAIT_SENSE_THE_SIN, DISCIPLINE_TRAIT)
		addtimer(CALLBACK(src, PROC_REF(timer_deactivation), target), 60 SECONDS)
	if(get_a_strength(target) <= 4)
		to_chat(owner, span_notice("Weak arms betray their lack of might."))
	if(get_a_dexterity(target) <= 4)
		to_chat(owner, span_notice("They stumble where others glide, awkward and unbalanced."))
	if(get_a_stamina(target) <= 4)
		to_chat(owner, span_notice("Their vigor is spent before the struggle even begins."))
	if(get_a_charisma(target) <= 4)
		to_chat(owner, span_notice("Their words drip with dullness, falling dead to the ground."))
	if(get_a_manipulation(target) <= 4)
		to_chat(owner, span_notice("Schemes fall apart in their hands, for none heed their deceit."))
	if(get_a_appearance(target) <= 4)
		to_chat(owner, span_notice("The sight of them is a burden, not a blessing."))
	if(get_a_perception(target) <= 4)
		to_chat(owner, span_notice("Blind to subtleties, the world whispers past them."))
	if(get_a_intelligence(target ) <= 4)
		to_chat(owner, span_notice("Their mind is a barren field, yielding no harvest of thought."))
	if(get_a_wits(target) <= 4)
		to_chat(owner, span_notice("The spark of insight eludes them."))
	if(get_a_willpower(target) <= 4)
		to_chat(owner, span_notice("Their spirit bends like reed before the storm."))

	if(iskindred(target))
		to_chat(owner, span_notice("\nThe fear of fire coils tightly in their soul.\n"))
		if(target.MyPath)
			if(target.MyPath.willpower <= 5)
				to_chat(owner, span_notice("Their resolve falters, like a candle struggling against the wind."))
			if(target.MyPath.consience <= 2)
				to_chat(owner, span_notice("Moral compass shattered, they wander in shadows of doubt."))
			if(target.MyPath.selfcontrol <= 2)
				to_chat(owner, span_notice("Impulse reigns within them, chains of restraint broken."))
			if(target.MyPath.courage <= 2)
				to_chat(owner, span_notice("Fear grips their heart, and even whispers seem like roars."))
		baali_get_moral_failings(target)
		baali_get_stolen_disciplines(target)
		if(target.generation >= 10)
			to_chat(owner, span_notice("Their blood is shallow, hollow before the might of the ancients."))
		else
			to_chat(owner, span_notice("Their blood hums with primal force, resisting dilution."))

	else if(isghoul(target))
		if(target.mind.enslaved_to)
			to_chat(owner, span_notice("Bound to vampiric vitae, their will is chained to a power beyond themselves."))
		else
			to_chat(owner, span_notice("Their hunger for vampiric blood flows freely, guided only by their own will."))

	else if(isgarou(target) || iswerewolf(target))
		to_chat(owner, span_notice("\nTheir flesh shivers at the touch of silver, a bane older than their memory."))
		if(target.client?.prefs?.breed == BREED_HOMID)
			to_chat(owner, span_notice("Between the pulse of nature and the lull of mankind, their strength falters in hesitation."))
		else if(target.client?.prefs?.breed == BREED_LUPUS)
			to_chat(owner, span_notice("They roam with the strength of the wilderness, but human artifice confounds their simple minds."))
		else if(target.client?.prefs?.breed == BREED_METIS)
			to_chat(owner, span_notice("Born of forbidden union, they walk in immense form, yet flaw and fury linger in every step."))

		if(target.client?.prefs?.tribe == "Wendigo")
			to_chat(owner, span_notice("Steeped in the cold and stealth of their totem, they falter when drawn from the purity of the wild."))
		else if(target.client?.prefs?.tribe == "Glasswalkers")
			to_chat(owner, span_notice("Their strength grows with each passing innovation, but the comfort of progress dulls their instincts."))
		else if(target.client?.prefs?.tribe == "Black Spiral Dancers")
			to_chat(owner, span_notice("Twisted by darkness and rage, their power is immense, yet the seed of madness gnaws at every thought."))

	else if(iscathayan(target))
		to_chat(owner, span_notice("\nTheir once fallen soul drifts between vitality and rot."))
		if(target.mind.dharma?.name == "Devil Tiger (P'o)")
			to_chat(owner, span_notice("Quick to act and driven by hidden hunger, their movements betray a restless, dangerous intent."))
		else if(target.mind.dharma?.name == "Song of the Shadow (Yin)")
			to_chat(owner, span_notice("Cold as bone and drifting through darkness, their presence leaves hearts unsettled and minds unheeding."))
		else if(target.mind.dharma?.name == "Resplendent Crane (Hun)")
			to_chat(owner, span_notice("Shadows of past transgressions cling tightly, shaping every step with a weight unseen yet ever felt."))
		else if(target.mind.dharma?.name == "Thrashing Dragon (Yang)")
			to_chat(owner, span_notice("Hunger drives every act, a restless fire that consumes both self and others, masking the doubt that gnaws beneath."))
		else if(target.mind.dharma?.name == "Flame of the Rising Phoenix (Yang+Hun)")
			to_chat(owner, span_notice("Whispers of hunger and imbalance shadow every step, leaving even the most devoted to falter and vanish into silent ruin."))

		if(target.mind.dharma?.Po == "Legalist")
			to_chat(owner, span_notice("Order imposed upon them twists their soul into silent rebellion."))
		else if(target.mind.dharma?.Po == "Rebel")
			to_chat(owner, span_notice("They flinch at touch, guarding freedom like a sacred flame."))
		else if(target.mind.dharma?.Po == "Monkey")
			to_chat(owner, span_notice("Fleeting joys and easy profits tug at them like mischievous strings."))
		else if(target.mind.dharma?.Po == "Demon")
			to_chat(owner, span_notice("Pain enthralls them, both inflicted and endured, addiction in their veins."))
		else if(target.mind.dharma?.Po == "Fool")
			to_chat(owner, span_notice("They shrink from attention, laughter turning their gaze inward in discomfort."))
	else
		to_chat(owner, span_notice("Fragile creature, neither mighty nor marked by weakness."))

/datum/discipline_power/daimonion/sense_the_sin/proc/timer_deactivation(mob/living/target)
	if(HAS_TRAIT(target, TRAIT_SENSE_THE_SIN))
		REMOVE_TRAIT(target, TRAIT_SENSE_THE_SIN, DISCIPLINE_TRAIT)

/datum/discipline_power/daimonion/sense_the_sin/proc/baali_get_moral_failings(target)
	var/mob/living/carbon/human/H = target
	var/clan_messages = list(
		"Toreador" = "Obsessive to a fault, their thoughts circling endlessly.",
		"Daughters of Cacophony" = "Their mind is drowned in ceaseless music.",
		"Ventrue" = "Blood of the poor brings no stir to their spirit.",
		"Lasombra" = "Fear of change grips them tightly, refusing release.",
		"Tzimisce" = "They have a singular desire that burns like fire, consuming all else.",
		"Old Clan Tzimisce" = "Steeped in ancient pride, their bonds run deep and possessive, yet their vision is clouded by millennia-old grudges.",
		"Gangrel" = "Impulses surge unchecked, their reason slipping away.",
		"Malkavian" = "Their presence unsettles all nearby, twisting perception.",
		"Brujah" = "Their anger festers, born of shame long buried.",
		"Nosferatu" = "They are drawn irresistibly to hidden truths and unknown paths.",
		"Tremere" = "Their perfectionism in every act drives relentless pursuit.",
		"Baali" = "They tremble beneath unseen powers, ever fearful.",
		"Banu Haqim" = "Their judgement is absolute, unyielding in every thought.",
		"Banu Haqim Sorcerer" = "Magic clings to their soul, a stain that no veil can hide.",
		"Banu Haqim Vizier" = "Knowledge consumes them as fire consumes parchment.",
		"True Brujah" = "Their emotions are locked deep, impossible to unveil.",
		"Salubri" = "They are bound by consent, every choice weighed heavily.",
		"Salubri Warrior" = "Bound by sacred duty, their resolve is unshakable, yet every step carries the weight of fallen battles.",
		"Giovanni" = "They think no act too great if it serves the family.",
		"Cappadocian" = "They are haunted endlessly by death's reflection.",
		"Kiasyd" = "Cold iron chills them more than flesh, striking fear.",
		"Gargoyle" = "Their mind is a fortress with gates open and unbarred.",
		"Followers of Set" = "Every stain of sin they twist into virtue."
	)

	var/message = clan_messages[H.clane?.name]
	if(!message)
		message = "They've been abandoned by the cold ocean of the night with nobody to keep them afloat."
	to_chat(owner, span_notice(message))

/datum/discipline_power/daimonion/sense_the_sin/proc/baali_get_stolen_disciplines(target)
	var/mob/living/carbon/human/H = target
	var/datum/species/kindred/clan = H.dna.species
	var/discipline_owners = list(
		"Quietus" = list("Banu Haqim"),
		"Protean" = list("Gangrel"),
		"Serpentis" = list("Followers of Set"),
		"Necromancy" = list("Giovanni", "Cappadocian"),
		"Obtenebration" = list("Lasombra"),
		"Dementation" = list("Malkavian"),
		"Vicissitude" = list("Tzimisce"),
		"Melpominee" = list("Daughters of Cacophony"),
		"Daimonion" = list("Baali"),
		"Temporis" = list("True Brujah"),
		"Visceratika" = list("Gargoyle"),
		"Thaumaturgy: Path of Blood" = list("Tremere"),
		"Thaumaturgy: Path of Conjuring" = list("Tremere"),
		"Thaumaturgy: The Lure of Flames" = list("Tremere"),
		"Thaumaturgy: Path of the Levinbolt" = list("Tremere"),
		"Dark Thaumaturgy: The Fires of the Inferno" = list("Baali"),
		"Dark Thaumaturgy: Path of Pain" = list("Baali"),
		"Dark Thaumaturgy: The Taking of the Spirit" = list("Baali"),
		"Healer Valeren" = list("Salubri", "Salubri Warrior"),
		"Warrior Valeren" = list("Salubri", "Salubri Warrior"),
		"Mytherceria" = list("Kiasyd"),
		"Du-Ran-Ki: Awakening of the Steel" = list("Banu Haqim Sorcerer"),
		"Du-Ran-Ki: Path of Blood" = list("Banu Haqim Sorcerer"),
		"Setite Sorcery: Path of Duat" = list("Followers of Set")
	)
	for(var/discipline in discipline_owners)
		if(clan.get_discipline(discipline) && !(H.clane?.name in discipline_owners[discipline]))
			to_chat(owner, span_notice("[H] fears that the fact they stole [discipline_owners[discipline][1]]'s [discipline] will be known."))


//FEAR OF THE VOID BELOW
/datum/discipline_power/daimonion/fear_of_the_void_below
	name = "Fear of the Void Below"
	desc = "Induce fear in a target."

	level = 2
	range = 7
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_LYING | DISC_CHECK_IMMOBILE
	target_type = TARGET_HUMAN | TARGET_VAMPIRE

/datum/discipline_power/daimonion/fear_of_the_void_below/pre_activation_checks(mob/living/target)
	if(!HAS_TRAIT(target, TRAIT_SENSE_THE_SIN))
		to_chat(owner, span_notice("You need to Sense the Sin in them first!"))
		return FALSE
	var/courage = 3
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		courage = H.MyPath?.courage
	var/success_chance = secret_vampireroll(get_a_wits(target)+get_a_intimidation(target), courage+4, owner)
	if(success_chance <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/fear_of_the_void_below/activate(mob/living/carbon/human/target)
	. = ..()
	var/mob/living/carbon/human/frenzied_target = target
	if(iskindred(frenzied_target))
		if(!frenzied_target.in_frenzy) // Cause target to frenzy
			frenzied_target.enter_frenzymod()
			addtimer(CALLBACK(frenzied_target, TYPE_PROC_REF(/mob/living/carbon, exit_frenzymod)), 5 SECONDS)
	else
		if(!(frenzied_target.stat >= UNCONSCIOUS || frenzied_target.IsSleeping() || frenzied_target.IsUnconscious()))
			frenzied_target.Sleeping(20)
	frenzied_target.overlay_fullscreen("STRAH", /atom/movable/screen/fullscreen/yomi_world)
	frenzied_target.clear_fullscreen("STRAH", 3)


//CONFLAGRATION
/datum/discipline_power/daimonion/conflagration
	name = "Conflagration"
	desc = "Draw out the destructive essence of the Beyond."

	level = 3
	range = 7
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE
	hostile = TRUE
	target_type = TARGET_MOB | TARGET_OBJ | TARGET_TURF

/datum/discipline_power/daimonion/conflagration/pre_activation_checks(mob/living/target)
	var/success_chance = secret_vampireroll(get_a_dexterity(target)+get_a_occult(target), 6, owner)
	if(success_chance <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/conflagration/activate(atom/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/magic/aoe/fireball/baali/created_fireball = new(start)
	created_fireball.firer = owner
	created_fireball.preparePixelProjectile(target, start)
	created_fireball.fire(direct_target = target)

//PSYCHOMACHIA
/datum/discipline_power/daimonion/psychomachia
	name = "Psychomachia"
	desc = "Bring forth the target's greatest fear."

	level = 4
	range = 7
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	target_type = TARGET_HUMAN

	target_type = TARGET_HUMAN


/datum/discipline_power/daimonion/psychomachia/pre_activation_checks(mob/living/target)
	if(!HAS_TRAIT(target, TRAIT_SENSE_THE_SIN))
		to_chat(owner, span_notice("You need to Sense the Sin in them first!"))
		return FALSE
	var/lowest_stat = 2
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		lowest_stat = min(H.MyPath?.consience, H.MyPath?.courage, H.MyPath?.selfcontrol)
	var/success_chance = secret_vampireroll(lowest_stat, 6, target)
	if(success_chance <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/psychomachia/activate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, "<span class='warning'><b>You hear infernal laugh!</span></b>")
	new /datum/hallucination/baali(target, TRUE)

//CONDEMNTATION
/datum/discipline_power/daimonion/condemnation
	name = "Condemnation"
	desc = "CURSE OF VTM13."

	level = 5
	range = 7
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	target_type = TARGET_HUMAN | TARGET_LIVING

	var/initialized_curses = FALSE //can't do this in new since it wouldn't have assigned owner yet. this will do.
	var/list/curse_names = list()
	var/list/curses = list()

/datum/discipline_power/daimonion/condemnation/pre_activation_checks(mob/living/target)
	var/success_chance = secret_vampireroll(get_a_intelligence(owner)+get_a_occult(owner), get_a_willpower(target), target)
	if(success_chance <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/condemnation/activate(mob/living/carbon/human/target)
	. = ..()
	if(LAZYLEN(GLOB.cursed_characters) == 0 || LAZYLEN(GLOB.cursed_characters) > 0 && !(GLOB.cursed_characters.Find(target)))
		if(!initialized_curses)
			for(var/i in subtypesof(/datum/curse/daimonion))
				var/datum/curse/daimonion/daimonion_curse = new i
				curses += daimonion_curse
				if(owner.generation <= daimonion_curse.genrequired)
					curse_names += initial(daimonion_curse.name)
				initialized_curses = TRUE

		to_chat(owner, span_userdanger("The greatest of curses come with the greatest of costs. Are you willing to take the risk of total damnation?"))
		var/chosencurse = tgui_input_list(owner, "Pick a curse to bestow:", "Daimonion", curse_names, timeout=15 SECONDS)
		if(!chosencurse)
			return
		for(var/datum/curse/daimonion/C in curses)
			if(C.name == chosencurse)
				C.activate(target)
				owner.maxbloodpool -= C.bloodcurse
				if(owner.bloodpool > owner.maxbloodpool)
					owner.bloodpool = owner.maxbloodpool
				GLOB.cursed_characters += target
				to_chat(owner, span_notice(span_bold("You place a great infernal curse on your victim!")))
	else
		to_chat(owner, span_warning("This one is already cursed!"))

/datum/discipline_power/daimonion/condemnation/post_gain()
	. = ..()
	var/datum/action/antifrenzy/antifrenzy_contract = new()
	antifrenzy_contract.Grant(owner)

/datum/action/antifrenzy
	name = "Resist Beast"
	desc = "Resist Frenzy and Rotshreck by signing a contract with Demons."
	button_icon_state = "resist"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/used = FALSE

/datum/action/antifrenzy/Trigger()
	var/mob/living/carbon/human/user = owner
	if(user.stat >= UNCONSCIOUS || user.IsSleeping() || user.IsUnconscious() || user.IsParalyzed() || user.IsKnockdown() || user.IsStun() || HAS_TRAIT(user, TRAIT_RESTRAINED) || !isturf(user.loc))
		return
	if(used)
		to_chat(owner, span_warning("You've already signed this contract!"))
		return
	used = TRUE
	user.antifrenzy = TRUE
	SEND_SOUND(owner, sound('sound/magic/curse.ogg', 0, 0, 50))
	to_chat(owner, span_warning("You feel control over your Beast, but at what cost..."))
	qdel(src)
