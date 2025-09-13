#define DOGGY_ANIMATION_COOLDOWN 30 DECISECONDS

/datum/action/gift
	icon_icon = 'code/modules/wod13/werewolf_abilities.dmi'
	button_icon = 'code/modules/wod13/werewolf_abilities.dmi'
	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	var/rage_req = 0
	var/gnosis_req = 0
	var/cool_down = 0

	var/allowed_to_proceed = FALSE

/datum/action/gift/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	icon_icon = 'code/modules/wod13/werewolf_abilities.dmi'
	button_icon = 'code/modules/wod13/werewolf_abilities.dmi'
	. = ..()

/datum/action/gift/Trigger()
	. = ..()
	if(istype(owner, /mob/living/carbon))
		var/mob/living/carbon/H = owner
		if(H.stat == DEAD)
			allowed_to_proceed = FALSE
			return
		if(rage_req)
			if(H.auspice.rage < rage_req)
				to_chat(owner, "<span class='warning'>You don't have enough <b>RAGE</b> to do that!</span>")
				SEND_SOUND(owner, sound('code/modules/wod13/sounds/werewolf_cast_failed.ogg', 0, 0, 75))
				allowed_to_proceed = FALSE
				return
			if(H.auspice.gnosis < gnosis_req)
				to_chat(owner, "<span class='warning'>You don't have enough <b>GNOSIS</b> to do that!</span>")
				SEND_SOUND(owner, sound('code/modules/wod13/sounds/werewolf_cast_failed.ogg', 0, 0, 75))
				allowed_to_proceed = FALSE
				return
		if(cool_down+20 SECONDS >= world.time)
			allowed_to_proceed = FALSE
			return
		cool_down = world.time
		allowed_to_proceed = TRUE
		if(rage_req)
			adjust_rage(-rage_req, owner, FALSE)
		if(gnosis_req)
			adjust_gnosis(-gnosis_req, owner, FALSE)
		to_chat(owner, "<span class='notice'>You activate the [name]...</span>")

/datum/action/gift/falling_touch
	name = "Falling Touch"
	desc = "This Gift allows the Garou to send her foe sprawling with but a touch."
	button_icon_state = "falling_touch"
	rage_req = 1

/datum/action/gift/falling_touch/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		playsound(get_turf(owner), 'code/modules/wod13/sounds/falling_touch.ogg', 75, FALSE)
		H.put_in_active_hand(new /obj/item/melee/touch_attack/werewolf(H))

/datum/action/gift/inspiration
	name = "Inspiration"
	desc = "The Garou with this Gift lends new resolve and righteous anger to his brethren."
	button_icon_state = "inspiration"
	rage_req = 1

/mob/living/carbon/Life()
	. = ..()
	if(inspired)
		if(stat != DEAD)
			adjustBruteLoss(-10, TRUE)
			var/obj/effect/celerity/C = new(get_turf(src))
			C.appearance = appearance
			C.dir = dir
			var/matrix/ntransform = matrix(C.transform)
			ntransform.Scale(2, 2)
			animate(C, transform = ntransform, alpha = 0, time = 3)

/mob/living/carbon/proc/inspired()
	inspired = TRUE
	to_chat(src, "<span class='notice'>You feel inspired...</span>")
	spawn(20 SECONDS)
		to_chat(src, "<span class='warning'>You no longer feel inspired...</span>")
		inspired = FALSE

/datum/action/gift/inspiration/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		playsound(get_turf(owner), 'code/modules/wod13/sounds/inspiration.ogg', 75, FALSE)
		H.emote("scream")
		if(H.CheckEyewitness(H, H, 7, FALSE))
			H.adjust_veil(-1)
		for(var/mob/living/carbon/C in range(5, owner))
			if(C)
				if(iswerewolf(C) || isgarou(C))
					if(C.auspice.tribe == H.auspice.tribe)
						C.inspired()

/datum/action/gift/razor_claws
	name = "Razor Claws"
	desc = "By raking his claws over stone, steel, or another hard surface, the Ahroun hones them to razor sharpness."
	button_icon_state = "razor_claws"
	rage_req = 1

/datum/action/gift/razor_claws/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'code/modules/wod13/sounds/razor_claws.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.dna.species.attack_verb = "slash"
			H.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			H.dna.species.miss_sound = 'sound/weapons/slashmiss.ogg'
			H.dna.species.punchdamagelow += 5
			H.dna.species.punchdamagehigh += 5
			H.dna.species.attack_type = CLONE
			to_chat(owner, "<span class='notice'>You feel your claws sharpening...</span>")
			if(H.CheckEyewitness(H, H, 7, FALSE))
				H.adjust_veil(-1)
			spawn(20 SECONDS)
				H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
				H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
				H.dna.species.miss_sound = initial(H.dna.species.miss_sound)
				H.dna.species.punchdamagelow = initial(H.dna.species.punchdamagelow)
				H.dna.species.punchdamagehigh = initial(H.dna.species.punchdamagehigh)
				H.dna.species.attack_type = initial(H.dna.species.attack_type)
				to_chat(owner, "<span class='warning'>Your claws are not sharp anymore...</span>")
		else
			playsound(get_turf(owner), 'code/modules/wod13/sounds/razor_claws.ogg', 75, FALSE)
			var/mob/living/carbon/H = owner
			H.melee_damage_lower = H.melee_damage_lower+5
			H.melee_damage_upper = H.melee_damage_upper+5
			to_chat(owner, "<span class='notice'>You feel your claws sharpening...</span>")
			spawn(20 SECONDS)
				H.melee_damage_lower = initial(H.melee_damage_lower)
				H.melee_damage_upper = initial(H.melee_damage_upper)
				to_chat(owner, "<span class='warning'>Your claws are not sharp anymore...</span>")

/datum/action/gift/beast_speech
	name = "Beast Speech"
	desc = "The werewolf with this Gift may communicate with any animals from fish to mammals."
	button_icon_state = "beast_speech"
	rage_req = 1
	//gnosis_req = 1

/datum/action/gift/beast_speech/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		if(length(C.beastmaster) > 3)
			var/mob/living/simple_animal/hostile/beastmaster/B = pick(C.beastmaster)
			qdel(B)
		playsound(get_turf(owner), 'code/modules/wod13/sounds/wolves.ogg', 75, FALSE)
		if(!length(C.beastmaster))
			var/datum/action/beastmaster_stay/E1 = new()
			E1.Grant(C)
			var/datum/action/beastmaster_deaggro/E2 = new()
			E2.Grant(C)
		var/mob/living/simple_animal/hostile/beastmaster/D = new(get_turf(C))
		D.my_creator = C
		C.beastmaster |= D
		D.beastmaster = C

/datum/action/gift/call_of_the_wyld
	name = "Call Of The Wyld"
	desc = "The werewolf may send her howl far beyond the normal range of hearing and imbue it with great emotion, stirring the hearts of fellow Garou and chilling the bones of all others."
	button_icon_state = "call_of_the_wyld"
	rage_req = 1

/datum/action/gift/call_of_the_wyld/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.emote("howl")
		playsound(get_turf(C), pick('code/modules/wod13/sounds/awo1.ogg', 'code/modules/wod13/sounds/awo2.ogg'), 100, FALSE)
		for(var/mob/living/carbon/A in orange(6, owner))
			if(A)
				if(isgarou(A) || iswerewolf(A))
					A.emote("howl")
					playsound(get_turf(A), pick('code/modules/wod13/sounds/awo1.ogg', 'code/modules/wod13/sounds/awo2.ogg'), 100, FALSE)
					spawn(10)
						adjust_gnosis(1, A, TRUE)
//	awo1

/datum/action/gift/mindspeak
	name = "Mindspeak"
	desc = "By invoking the power of waking dreams, the Garou can place any chosen characters into silent communion."
	button_icon_state = "mindspeak"
//	gnosis_req = 1

/datum/action/gift/mindspeak/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/new_thought = input(owner, "What do you want to tell to your Tribe?") as text|null
		if(new_thought)
			var/mob/living/carbon/C = owner
			to_chat(C, "You transfer this message to your tribe members nearby: <b>[sanitize_text(new_thought)]</b>")
			for(var/mob/living/carbon/A in orange(9, owner))
				if(A)
					if(isgarou(A) || iswerewolf(A))
						if(A.auspice.tribe == C.auspice.tribe)
							to_chat(A, "You hear a message in your head... <b>[sanitize_text(new_thought)]</b>")

/datum/action/gift/resist_pain
	name = "Resist Pain"
	desc = "Through force of will, the Philodox is able to ignore the pain of his wounds and continue acting normally."
	button_icon_state = "resist_pain"
	rage_req = 2

/datum/action/gift/resist_pain/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'code/modules/wod13/sounds/resist_pain.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.attributes.stamina_bonus += 4
			to_chat(owner, "<span class='notice'>You feel your skin thickering...</span>")
			spawn(20 SECONDS)
				H.attributes.stamina_bonus -= 4
				to_chat(owner, "<span class='warning'>Your skin is thin again...</span>")
		else
			playsound(get_turf(owner), 'code/modules/wod13/sounds/resist_pain.ogg', 75, FALSE)
			var/mob/living/carbon/werewolf/H = owner
			H.werewolf_armor = 40
			to_chat(owner, "<span class='notice'>You feel your skin thickering...</span>")
			spawn(20 SECONDS)
				H.werewolf_armor = initial(H.werewolf_armor)
				to_chat(owner, "<span class='warning'>Your skin is thin again...</span>")

/datum/action/gift/scent_of_the_true_form
	name = "Scent Of The True Form"
	desc = "This Gift allows the Garou to determine the true nature of a person."
	button_icon_state = "scent_of_the_true_form"
	gnosis_req = 1

/datum/action/gift/scent_of_the_true_form/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(HAS_TRAIT(owner, TRAIT_SCENTTRUEFORM))
			REMOVE_TRAIT(owner, TRAIT_SCENTTRUEFORM, WEREWOLF_TRAIT)
			to_chat(owner, "<span class='notice'>You allow the essence of the spirit to leave your senses.</span>")

		else
			ADD_TRAIT(owner, TRAIT_SCENTTRUEFORM, WEREWOLF_TRAIT)
			to_chat(owner, "<span class='notice'>Your nose gains a clarity for the supernal around you...</span>")

/datum/action/gift/truth_of_gaia
	name = "Truth Of Gaia"
	desc = "As judges of the Litany, Philodox have the ability to sense whether others have spoken truth or falsehood."
	button_icon_state = "truth_of_gaia"
//	rage_req = 1

/datum/action/gift/truth_of_gaia/Trigger()
	. = ..()
//	if(allowed_to_proceed)
//

/datum/action/gift/mothers_touch
	name = "Mother's Touch"
	desc = "The Garou is able to heal the wounds of any living creature, aggravated or otherwise, simply by laying hands over the afflicted area."
	button_icon_state = "mothers_touch"
	rage_req = 2
	//gnosis_req = 1

/datum/action/gift/mothers_touch/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		H.put_in_active_hand(new /obj/item/melee/touch_attack/mothers_touch(H))

/datum/action/gift/sense_wyrm
	name = "Sense Wyrm"
	desc = "This Gift allows the werewolf to trace the location of all wyrm-tainted entities within the area."
	button_icon_state = "sense_wyrm"
	rage_req = 1

/datum/action/gift/sense_wyrm/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/list/mobs_in_range = list()
		for(var/mob/living/carbon/target in orange(owner, 30))
			mobs_in_range += target
		for(var/mob/living/carbon/target in mobs_in_range)
			var/is_wyrm = 0
			if(iscathayan(target))
				var/mob/living/carbon/human/kj = target
				if(!kj.check_kuei_jin_alive())
					is_wyrm = 1
			if (iskindred(target))
				var/mob/living/carbon/human/vampire = target
				if (vampire.humanity < 7 || vampire.clane?.name == "Baali")
					is_wyrm = 1
			if (isgarou(target) || iswerewolf(target))
				var/mob/living/carbon/wolf = target
				if(wolf.auspice.tribe.name == "Black Spiral Dancers")
					is_wyrm = 1
			if(is_wyrm)
				to_chat(owner, "A stain is found at [get_area_name(target)], X:[target.x] Y:[target.y].")
				is_wyrm = 0

/datum/action/gift/spirit_speech
	name = "Spirit Speech"
	desc = "This Gift allows the Garou to communicate with encountered spirits."
	button_icon_state = "spirit_speech"
	//gnosis_req = 1

/datum/action/gift/spirit_speech/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.see_invisible = SEE_INVISIBLE_OBSERVER
		spawn(20 SECONDS)
			C.update_sight()

/datum/action/gift/blur_of_the_milky_eye
	name = "Blur Of The Milky Eye"
	desc = "The Garou's form becomes a shimmering blur, allowing him to pass unnoticed among others."
	button_icon_state = "blur_of_the_milky_eye"
	rage_req = 2
	//gnosis_req = 1

/datum/action/gift/blur_of_the_milky_eye/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.obfuscate_level = clamp(C.client.prefs.auspice_level*2, 1, 5)
		C.alpha = 100
		C.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+clamp(C.client.prefs.auspice_level*2, 1, 5)
		owner.playsound_local(get_turf(owner), 'code/modules/wod13/sounds/milky_blur.ogg', 75, FALSE)
		spawn(20 SECONDS)
			C.obfuscate_level = 0
			C.alpha = 255
			C.invisibility = initial(C.invisibility)

/datum/action/gift/open_seal
	name = "Open Seal"
	desc = "With this Gift, the Garou can open nearly any sort of closed or locked physical device."
	button_icon_state = "open_seal"
//	gnosis_req = 1

/datum/action/gift/open_seal/Trigger()
	. = ..()
	if(allowed_to_proceed)
		for(var/obj/structure/vampdoor/V in range(5, owner))
			if(V)
				if(V.closed)
					if(V.lockpick_difficulty < clamp(10*owner.client.prefs.auspice_level, 10, 30))
						V.locked = FALSE
						playsound(V, V.open_sound, 75, TRUE)
						V.icon_state = "[V.baseicon]-0"
						V.density = FALSE
						V.opacity = FALSE
						V.layer = OPEN_DOOR_LAYER
						to_chat(owner, "<span class='notice'>You open [V].</span>")
						V.closed = FALSE

/datum/action/gift/infectious_laughter
	name = "Infectious Laughter"
	desc = "When the Ragabash laughs, those around her are compelled to follow along, forgetting their grievances."
	button_icon_state = "infectious_laughter"
	rage_req = 1

/datum/action/gift/infectious_laughter/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.emote("laugh")
		C.Stun(10)
		playsound(get_turf(owner), 'code/modules/wod13/sounds/infectious_laughter.ogg', 100, FALSE)
		for(var/mob/living/L in oviewers(4, owner))
			if(L)
				L.emote("laugh")
				L.Stun(20)

/datum/action/gift/rage_heal
	name = "Rage Heal"
	desc = "This Gift allows the Garou to heal severe injuries with rage."
	button_icon_state = "rage_heal"
	rage_req = 1
	check_flags = null

/datum/action/gift/rage_heal/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		if(C.stat != DEAD)
			SEND_SOUND(owner, sound('code/modules/wod13/sounds/rage_heal.ogg', 0, 0, 75))
			C.adjustBruteLoss(-30*C.auspice.level, TRUE)
			C.adjustFireLoss(-30*C.auspice.level, TRUE)
			C.adjustCloneLoss(-15*C.auspice.level, TRUE)
			C.adjustToxLoss(-15*C.auspice.level, TRUE)
			C.adjustOxyLoss(-25*C.auspice.level, TRUE)
			C.bloodpool = min(C.bloodpool + C.auspice.level, C.maxbloodpool)
			C.blood_volume = min(C.blood_volume + 56 * C.auspice.level, BLOOD_VOLUME_NORMAL)
			if(ishuman(owner))
				var/mob/living/carbon/human/BD = owner
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()

/datum/action/change_apparel
	name = "Change Apparel"
	desc = "Choose the clothes of your Crinos form."
	button_icon_state = "choose_apparel"
	icon_icon = 'code/modules/wod13/werewolf_abilities.dmi'
	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS

/datum/action/change_apparel/Trigger()
	. = ..()
	var/mob/living/carbon/werewolf/crinos/C = owner
	if(C.stat == CONSCIOUS)
		if(C.sprite_apparel == 4)
			C.sprite_apparel = 0
		else
			C.sprite_apparel = min(4, C.sprite_apparel+1)

/datum/action/gift/hispo
	name = "Hispo Form"
	desc = "Change your Lupus form into Hispo and backwards."
	button_icon_state = "hispo"

/datum/action/gift/hispo/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/werewolf/lupus/H = owner
		playsound(get_turf(owner), 'code/modules/wod13/sounds/transform.ogg', 50, FALSE)
		var/matrix/ntransform = matrix(owner.transform)
		if(H.hispo)
			ntransform.Scale(0.95, 0.95)
			animate(owner, transform = ntransform, color = "#000000", time = DOGGY_ANIMATION_COOLDOWN)
			addtimer(CALLBACK(src, PROC_REF(trans_doggy), H), DOGGY_ANIMATION_COOLDOWN)
		else
			ntransform.Scale(1.05, 1.05)
			animate(owner, transform = ntransform, color = "#000000", time = DOGGY_ANIMATION_COOLDOWN)
			addtimer(CALLBACK(src, PROC_REF(trans_hispo), H), DOGGY_ANIMATION_COOLDOWN)

/datum/action/gift/hispo/proc/trans_doggy(mob/living/carbon/werewolf/lupus/H)
	if(HAS_TRAIT(H, TRAIT_DOGWOLF))
		H.icon = 'code/modules/wod13/werewolf_lupus.dmi'
	else
		H.icon = 'code/modules/wod13/vtm_lupus.dmi'
	H.pixel_w = 0
	H.pixel_z = 0
	H.melee_damage_lower = initial(H.melee_damage_lower)
	H.melee_damage_upper = initial(H.melee_damage_upper)
	H.armour_penetration = initial(H.armour_penetration)
	H.hispo = FALSE
	H.attributes.strength -= 3
	H.attributes.dexterity -= 2
	H.attributes.stamina -= 3
	H.attributes.manipulation += 3
	H.regenerate_icons()
	H.update_transform()
	animate(H, transform = null, color = "#FFFFFF", time = 1)
	H.remove_movespeed_modifier(/datum/movespeed_modifier/crinosform)
	H.add_movespeed_modifier(/datum/movespeed_modifier/lupusform)

/datum/action/gift/hispo/proc/trans_hispo(mob/living/carbon/werewolf/lupus/H)
	H.icon = 'code/modules/wod13/hispo.dmi'
	H.pixel_w = -16
	H.pixel_z = -16
	H.melee_damage_lower = 30
	H.melee_damage_upper = 30
	H.armour_penetration = 35
	H.hispo = TRUE
	H.attributes.strength += 3
	H.attributes.dexterity += 2
	H.attributes.stamina += 3
	H.attributes.manipulation -= 3
	H.regenerate_icons()
	H.update_transform()
	animate(H, transform = null, color = "#FFFFFF", time = 1)
	H.remove_movespeed_modifier(/datum/movespeed_modifier/lupusform)
	H.add_movespeed_modifier(/datum/movespeed_modifier/crinosform)

/datum/movespeed_modifier/hispoform
	multiplicative_slowdown = -0.5

/datum/action/gift/glabro
	name = "Glabro Form"
	desc = "Change your Homid form into Glabro and backwards."
	button_icon_state = "glabro"

/datum/action/gift/glabro/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/human/H = owner
		var/datum/species/garou/G = H.dna.species
		playsound(get_turf(owner), 'code/modules/wod13/sounds/transform.ogg', 50, FALSE)
		if(G.glabro)
			H.remove_overlay(PROTEAN_LAYER)
			H.melee_damage_lower = initial(H.melee_damage_lower)
			H.melee_damage_upper = initial(H.melee_damage_upper)
			H.armour_penetration = initial(H.armour_penetration)
			H.dna.species.attack_type = initial(H.dna.species.attack_type)
			H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
			H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
			H.dna.species.miss_sound = initial(H.dna.species.miss_sound)
			H.limb_destroyer = initial(H.limb_destroyer)
			H.attributes.strength -= 2
			H.attributes.stamina -= 2
			H.attributes.appearance += 1
			H.attributes.manipulation += 1
			var/matrix/M = matrix()
			M.Scale(1)
			animate(H, transform = M, time = 1 SECONDS)
			G.glabro = FALSE
			H.update_icons()
		else
			H.remove_overlay(PROTEAN_LAYER)
			var/mob/living/carbon/werewolf/crinos/crinos = H.transformator.crinos_form?.resolve()
			var/mutable_appearance/glabro_overlay = mutable_appearance('code/modules/wod13/werewolf_abilities.dmi', crinos?.sprite_color, -PROTEAN_LAYER)
			H.overlays_standing[PROTEAN_LAYER] = glabro_overlay
			H.apply_overlay(PROTEAN_LAYER)
			H.melee_damage_lower = 30
			H.melee_damage_upper = 30
			H.armour_penetration = 35
			H.dna.species.attack_type = CLONE
			H.dna.species.attack_verb = "slash"
			H.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			H.dna.species.miss_sound = 'sound/weapons/slashmiss.ogg'
			H.limb_destroyer = 1
			H.attributes.strength += 2
			H.attributes.stamina += 2
			H.attributes.appearance -= 1
			H.attributes.manipulation -= 1
			var/matrix/M = matrix()
			M.Scale(1.23)
			animate(H, transform = M, time = 1 SECONDS)
			G.glabro = TRUE
			H.update_icons()

/datum/action/gift/howling
	name = "Howl"
	desc = "The werewolf may send her howl far beyond the normal range of hearing and communicate a single word or concept to all other Garou across the city."
	button_icon_state = "call_of_the_wyld"
	rage_req = 1
	cool_down = 5
	check_flags = null
	var/list/howls = list(
		"attack" = list(
			"menu" = "Attack",
			"message" = "<b>A wolf howls a fierce call to attack</b>"
		),
		"retreat" = list(
			"menu" = "Retreat",
			"message" = "<b>A wolf howls a warning to retreat</b>"
		),
		"help" = list(
			"menu" = "Help",
			"message" = "<b>A wolf howls a desperate plea for help</b>"
		),
		"gather" = list(
			"menu" = "Gather",
			"message" = "<b>A wolf howls to gather the pack</b>"
		),
		"victory" = list(
			"menu" = "Victory",
			"message" = "<b>A wolf howls in celebration of victory</b>"
		),
		"dying" = list(
			"menu" = "Dying",
			"message" = "<b>A wolf howls in pain and despair</b>"
		),
		"mourning" = list(
			"menu" = "Mourning",
			"message" = "<b>A wolf howls in deep mourning for the fallen</b>"
		)
	)

/datum/action/gift/howling/Trigger()
	. = ..()
	if(allowed_to_proceed)

		if(istype(get_area(owner), /area/vtm/interior/penumbra))
			to_chat(owner, span_warning("Your howl echoes and dissapates into the Umbra, it's sound blanketed by the spiritual energy of the Velvet Shadow."))
			return

		var/mob/living/carbon/C = owner
		var/list/menu_options = list()
		for (var/howl_key in howls)
			menu_options += howls[howl_key]["menu"]
		menu_options += "Cancel"

		var/choice = tgui_input_list(owner, "Select a howl to use!", "Howl Selection", menu_options)
		if(choice && choice != "Cancel")
			var/howl
			for (var/howl_key in howls)
				if (howls[howl_key]["menu"] == choice)
					howl = howls[howl_key]
					break

			var/message = howl["message"]
			var/tribe = C.auspice.tribe.name
			if (tribe)
				message = replacetext(message, "tribe", tribe)

			C.emote("howl")
			var/origin_turf = get_turf(C)
			playsound(origin_turf, pick('code/modules/wod13/sounds/awo1.ogg', 'code/modules/wod13/sounds/awo2.ogg'), 50, FALSE)
			var/list/sound_hearers = list()

			for(var/mob/living/carbon/HearingGarou in range(17))
				if(isgarou(HearingGarou) || iswerewolf(HearingGarou))
					sound_hearers += HearingGarou

			var/howl_details
			var/final_message
			for(var/mob/living/carbon/Garou in GLOB.player_list)
				if((isgarou(Garou) || iswerewolf(Garou)) && Garou != owner && Garou.auspice?.tribe == C.auspice?.tribe)
					if(!sound_hearers.Find(Garou))
						Garou.playsound_local(get_turf(Garou), pick('code/modules/wod13/sounds/awo1.ogg', 'code/modules/wod13/sounds/awo2.ogg'), 25, FALSE)
					howl_details = get_message(Garou, origin_turf)
					final_message = message + howl_details
					to_chat(Garou, final_message, confidential = TRUE)


/datum/action/gift/howling/proc/get_message(mob/living/carbon/Garou, turf/origin_turf)

	var/distance = get_dist(Garou, origin_turf)
	var/dirtext = "to the "
	var/direction = get_dir(Garou, origin_turf)

	switch(direction)
		if(NORTH)
			dirtext += "north"
		if(SOUTH)
			dirtext += "south"
		if(EAST)
			dirtext += "east"
		if(WEST)
			dirtext += "west"
		if(NORTHWEST)
			dirtext += "northwest"
		if(NORTHEAST)
			dirtext += "northeast"
		if(SOUTHWEST)
			dirtext += "southwest"
		if(SOUTHEAST)
			dirtext += "southeast"
		else //Where ARE you.
			dirtext = "although I cannot make out an exact direction"

	var/disttext
	switch(distance)
		if(0 to 20)
			disttext = " within 20 feet"
		if(20 to 40)
			disttext = " 20 to 40 feet away"
		if(40 to 80)
			disttext = " 40 to 80 feet away"
		if(80 to 160)
			disttext = " far"
		else
			disttext = " very far"

	var/place = get_area_name(origin_turf)

	var/returntext = "<b>[disttext], [dirtext], at [place].</b>"

	return returntext

/datum/action/gift/stoic_pose
	name = "Stoic Pose"
	desc = "With this gift garou sends theirself into cryo-state, ignoring all incoming damage but also covering themself in a block of ice."
	button_icon_state = "stoic_pose"
	rage_req = 2
	gnosis_req = 2
	var/in_use = FALSE

/datum/action/gift/stoic_pose/Trigger()
	. = ..()
	if(!allowed_to_proceed)
		return

	playsound(get_turf(owner), 'code/modules/wod13/sounds/ice_blocking.ogg', 100, FALSE)
	var/mob/living/carbon/C = owner
	var/obj/W

	if(in_use)
		in_use = FALSE
		C.forceMove(get_turf(W))
		qdel(W)

	if(isgarou(C))
		W = new /obj/were_ice(get_turf(owner))
	if(iscrinos(C))
		W = new /obj/were_ice/crinos(get_turf(owner))
	if(islupus(C))
		W = new /obj/were_ice/lupus(get_turf(owner))

	C.Stun(300 SECONDS)
	C.forceMove(W)
	in_use = TRUE
	spawn(300 SECONDS)
		C.forceMove(get_turf(W))
		qdel(W)
		in_use = FALSE


/datum/action/gift/freezing_wind
	name = "Freezing Wind"
	desc = "Garou of Wendigo Tribe can create a stream of cold, freezing wind, and strike her foes with it."
	button_icon_state = "freezing_wind"
	rage_req = 1
	//gnosis_req = 1

/datum/action/gift/freezing_wind/Trigger()
	. = ..()
	if(allowed_to_proceed)
		playsound(get_turf(owner), 'code/modules/wod13/sounds/wind_cast.ogg', 100, FALSE)
		for(var/turf/T in range(3, get_step(get_step(owner, owner.dir), owner.dir)))
			if(owner.loc != T)
				var/obj/effect/wind/W = new(T)
				W.dir = owner.dir
				W.strength = 100
				spawn(20 SECONDS)
					qdel(W)
//	if(allowed_to_proceed)

/datum/action/gift/bloody_feast
	name = "Bloody Feast"
	desc = "By eating a grabbed corpse, garou can redeem their lost health and heal the injuries."
	button_icon_state = "bloody_feast"
	rage_req = 2
	gnosis_req = 1

/datum/action/gift/bloody_feast/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		if(C.pulling)
			if(isliving(C.pulling))
				var/mob/living/L = C.pulling
				if(L.stat == DEAD)
					playsound(get_turf(owner), 'code/modules/wod13/sounds/bloody_feast.ogg', 50, FALSE)
					qdel(L)
					C.revive(full_heal = TRUE, admin_revive = TRUE)

/datum/action/gift/stinky_fur
	name = "Stinky Fur"
	desc = "Garou creates an aura of very toxic smell, which disorientates everyone around."
	button_icon_state = "stinky_fur"

/datum/action/gift/stinky_fur/Trigger()
	. = ..()
	if(allowed_to_proceed)
		playsound(get_turf(owner), 'code/modules/wod13/sounds/necromancy.ogg', 75, FALSE)
		for(var/mob/living/carbon/C in orange(5, owner))
			if(C)
				if(prob(25))
					C.vomit()
				C.dizziness += 10
				C.add_confusion(10)

/datum/action/gift/venom_claws
	name = "Venom Claws"
	desc = "While this ability is active, strikes with claws poison foes of garou."
	button_icon_state = "venom_claws"
	rage_req = 1

/datum/action/gift/venom_claws/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'code/modules/wod13/sounds/venom_claws.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.dna.species.attack_verb = "slash"
			H.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			H.dna.species.miss_sound = 'sound/weapons/slashmiss.ogg'
			H.dna.species.punchdamagelow += 5
			H.dna.species.punchdamagehigh += 5
			H.dna.species.attack_type = CLONE
			H.tox_damage_plus = 15
			H.stam_damage_plus = 35
			to_chat(owner, span_notice("You feel your claws filling with pure venom..."))
			spawn(20 SECONDS)
				H.tox_damage_plus = 0
				H.stam_damage_plus = 0
				H.melee_damage_lower = initial(H.melee_damage_lower)
				H.melee_damage_upper = initial(H.melee_damage_upper)
				H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
				H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
				H.dna.species.miss_sound = initial(H.dna.species.miss_sound)
				H.dna.species.attack_type = initial(H.dna.species.attack_type)
				to_chat(owner, span_warning("Your claws are not poison anymore..."))
		else
			playsound(get_turf(owner), 'code/modules/wod13/sounds/venom_claws.ogg', 75, FALSE)
			var/mob/living/carbon/H = owner
			H.dna.species.attack_verb = "slash"
			H.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			H.dna.species.miss_sound = 'sound/weapons/slashmiss.ogg'
			H.dna.species.punchdamagelow += 5
			H.dna.species.punchdamagehigh += 5
			H.dna.species.attack_type = CLONE
			H.tox_damage_plus = 15
			H.stam_damage_plus = 35
			to_chat(owner, span_notice("You feel your claws filling with pure venom..."))
			spawn(20 SECONDS)
				H.tox_damage_plus = 0
				H.stam_damage_plus = 0
				H.melee_damage_lower = initial(H.melee_damage_lower)
				H.melee_damage_upper = initial(H.melee_damage_upper)
				H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
				H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
				H.dna.species.miss_sound = initial(H.dna.species.miss_sound)
				H.dna.species.attack_type = initial(H.dna.species.attack_type)
				to_chat(owner, span_warning("Your claws are not poison anymore..."))

/datum/action/gift/burning_scars
	name = "Burning Scars"
	desc = "Garou creates an aura of very hot air, which burns everyone around."
	button_icon_state = "burning_scars"
	rage_req = 2
	gnosis_req = 1

/datum/action/gift/burning_scars/Trigger()
	. = ..()
	if(allowed_to_proceed)
		owner.visible_message(span_userdanger("[owner.name] crackles with heat!</span>"), span_warning("You crackle with heat, charging up your Gift!"))
		playsound(owner, 'sound/magic/burning_scars.ogg', 100, TRUE, extrarange = 5)
		owner.move_resist = MOVE_FORCE_STRONG
		if(do_after(owner, 1.5 SECONDS))
			owner.move_resist = initial(owner.move_resist)
			for(var/mob/living/L in orange(5, owner))
				if(L)
					L.adjustFireLoss(40)
			for(var/turf/T in orange(4, get_turf(owner)))
				var/obj/effect/fire/F = new(T)
				spawn(6)
					qdel(F)
		else
			owner.move_resist = initial(owner.move_resist)

/datum/action/gift/smooth_move
	name = "Smooth Move"
	desc = "Garou jumps forward, avoiding every damage for a moment."
	button_icon_state = "smooth_move"
	//rage_req = 1   somewhat useless gift with MMB pounce

/datum/action/gift/smooth_move/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/turf/T = get_turf(get_step(get_step(get_step(owner, owner.dir), owner.dir), owner.dir))
		if(!T || T == owner.loc)
			return
		owner.visible_message(span_danger("[owner] charges!"))
		owner.setDir(get_dir(owner, T))
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(owner.loc,owner)
		animate(D, alpha = 0, color = "#FF0000", transform = matrix()*2, time = 1)
		spawn(3)
			owner.throw_at(T, get_dist(owner, T), 1, owner, 0)

/datum/action/gift/digital_feelings
	name = "Digital Feelings"
	desc = "Every technology creates an electrical strike, which hits garou's enemies."
	button_icon_state = "digital_feelings"
	rage_req = 2
	gnosis_req = 1

/datum/action/gift/digital_feelings/Trigger()
	. = ..()
	if(allowed_to_proceed)
		owner.visible_message(span_danger("[owner.name] crackles with static electricity!"), span_danger("You crackle with static electricity, charging up your Gift!"))
		playsound(owner, 'sound/magic/digital_feelings.ogg', 100, TRUE, extrarange = 5)
		owner.move_resist = MOVE_FORCE_STRONG
		if(do_after(owner, 1.5 SECONDS))
			owner.move_resist = initial(owner.move_resist)
			playsound(owner, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
			tesla_zap(owner, 3, 30, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN | ZAP_ALLOW_DUPLICATES)
			for(var/mob/living/L in orange(6, owner))
				if(L)
					L.electrocute_act(30, owner, siemens_coeff = 1, flags = NONE)
		else
			owner.move_resist = initial(owner.move_resist)

/datum/action/gift/hands_full_of_thunder
	name = "Hands Full of Thunder"
	desc = "Invoke the machine spirits to support you in these trying times. Abstain from needing bullets when you fire a gun."
	button_icon_state = "hands_full_of_thunder"
	gnosis_req = 1

/datum/action/gift/hands_full_of_thunder/Trigger()
	. = ..()
	if(allowed_to_proceed)
		ADD_TRAIT(owner, TRAIT_THUNDERSHOT, WEREWOLF_TRAIT)
		to_chat(owner, span_notice("You feel your fingers tingling with electricity...!"))
		spawn(10 SECONDS)
			REMOVE_TRAIT(owner, TRAIT_THUNDERSHOT, WEREWOLF_TRAIT)
			to_chat(owner, span_notice("The buzz in your fingertips ebbs..."))

/datum/action/gift/elemental_improvement
	name = "Elemental Improvement"
	desc = "Garou flesh replaces itself with prothesis, making it less vulnerable to brute damage, but more for burn damage."
	button_icon_state = "elemental_improvement"
	rage_req = 2
	gnosis_req = 1

/datum/action/gift/elemental_improvement/Trigger()
	. = ..()
	if(allowed_to_proceed)
		animate(owner, color = "#6a839a", time = 10)
		if(ishuman(owner))
			playsound(get_turf(owner), 'code/modules/wod13/sounds/electro_cast.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.attributes.stamina_bonus += 4
			H.attributes.dexterity_bonus += 2
			to_chat(owner, span_notice("You feel your skin replaced with the machine..."))
			spawn(20 SECONDS)
				H.attributes.stamina_bonus -= 4
				H.attributes.dexterity_bonus -= 2
				to_chat(owner, span_warning("Your skin is natural again..."))
				owner.color = "#FFFFFF"
		else
			playsound(get_turf(owner), 'code/modules/wod13/sounds/electro_cast.ogg', 75, FALSE)
			var/mob/living/carbon/werewolf/H = owner
			H.werewolf_armor = 45
			to_chat(owner, span_notice("You feel your skin replaced with the machine..."))
			spawn(20 SECONDS)
				H.werewolf_armor = initial(H.werewolf_armor)
				to_chat(owner, span_warning("Your skin is natural again..."))
				owner.color = "#FFFFFF"

/datum/action/gift/guise_of_the_hound
	name = "Guise of the Hound"
	desc = "Wear the skin of the fleabitten dog to pass without concern."
	button_icon_state = "guise_of_the_hound"
	rage_req = 1

/datum/action/gift/guise_of_the_hound/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(!HAS_TRAIT(owner,TRAIT_DOGWOLF))
			ADD_TRAIT(owner, TRAIT_DOGWOLF, WEREWOLF_TRAIT)
			to_chat(owner, span_notice("You feel your canid nature softening!"))
		else
			REMOVE_TRAIT(owner, TRAIT_DOGWOLF, WEREWOLF_TRAIT)
			to_chat(owner, span_notice("You feel your lupine nature intensifying!"))

		if(istype(owner, /mob/living/carbon/werewolf/lupus))
			var/mob/living/carbon/werewolf/lupus/lopor = owner

			if(lopor && !lopor.hispo)
				playsound(get_turf(owner), 'code/modules/wod13/sounds/transform.ogg', 50, FALSE)
				var/matrix/ntransform = matrix(owner.transform)
				ntransform.Scale(0.95, 0.95)
				animate(owner, transform = ntransform, color = "#000000", time = 3 SECONDS)
				addtimer(CALLBACK(src, PROC_REF(trans_doggy), lopor), 3 SECONDS)

/datum/action/gift/guise_of_the_hound/proc/trans_doggy(mob/living/carbon/werewolf/lupus/H)
	if(HAS_TRAIT(H, TRAIT_DOGWOLF))
		H.icon = 'code/modules/wod13/werewolf_lupus.dmi'
	else
		H.icon = 'code/modules/wod13/vtm_lupus.dmi'
	H.regenerate_icons()
	H.update_transform()
	animate(H, transform = null, color = "#FFFFFF", time = 1)

/datum/action/gift/infest
	name = "Infest"
	desc = "Call forth the vermin in the area to serve you against your enemies."
	button_icon_state = "infest"
	rage_req = 1

/datum/action/gift/infest/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(iscarbon(owner))
			var/mob/living/carbon/C = owner
			if(length(C.beastmaster) > get_a_intelligence(C)+get_a_occult(C))
				var/mob/living/simple_animal/hostile/beastmaster/beast = pick(C.beastmaster)
				beast.death()
			if(!length(C.beastmaster))
				var/datum/action/beastmaster_stay/stay = new()
				stay.Grant(C)
				var/datum/action/beastmaster_deaggro/deaggro = new()
				deaggro.Grant(C)

			var/mob/living/simple_animal/hostile/beastmaster/cockroach/roach = new(get_turf(C))
			roach.my_creator = C
			C.beastmaster |= roach
			roach.beastmaster = C

/mob/living/simple_animal/hostile/beastmaster/cockroach
	name = "cockroach"
	desc = "It flutters like the giant, unhealthy skittering thing it is."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "cockroach"
	icon_living = "cockroach"
	icon_dead = "cockroach_no_animation"
	emote_hear = list("chitters.")
	emote_see = list("flutters its' wings.", "wriggles its' antennae.")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_chance = 0
	turns_per_move = 5
	see_in_dark = 10
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently sweeps aside"
	response_disarm_simple = "gently sweep aside"
	response_harm_continuous = "smashes"
	response_harm_simple = "smash"
	can_be_held = FALSE
	density = FALSE
	anchored = FALSE
	footstep_type = FOOTSTEP_MOB_CLAW
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 1
	maxbloodpool = 1
	del_on_death = 1
	maxHealth = 5
	health = 5
	melee_damage_type = TOX
	harm_intent_damage = 7
	melee_damage_lower = 7
	melee_damage_upper = 7
	is_flying_animal = TRUE
	speed = -0.8
	dodging = TRUE

/datum/action/gift/gift_of_the_termite
	name = "Gift of the Termite"
	desc = "Eat through structures. Obey no laws but the litany."
	button_icon_state = "gift_of_the_termite"
	rage_req = 3
	gnosis_req = 2

/datum/action/gift/gift_of_the_termite/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		H.put_in_active_hand(new /obj/item/melee/touch_attack/werewolf/gift_of_the_termite(H))


/datum/action/gift/shroud
	name = "Shroud"
	desc = "Call together the shadows, blocking line of sight."
	button_icon_state = "shroud"
	rage_req = 1

/datum/action/gift/shroud/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/atom/movable/shadow
		shadow = new(owner)
		shadow.set_light(5, -10)
		spawn(20 SECONDS)
			if (shadow)
				QDEL_NULL(shadow)

/datum/action/gift/coils_of_the_serpent
	name = "Coils of the Serpent"
	desc = "Summon forth tendrils of shadow to assault an opponent."
	button_icon_state = "coils_of_the_serpent"
	rage_req = 1

/datum/action/gift/coils_of_the_serpent/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			if(H.CheckEyewitness(H, H, 7, FALSE))
				H.adjust_veil(-1)
			H.drop_all_held_items()
			H.put_in_r_hand(new /obj/item/melee/vampirearms/knife/gangrel/lasombra(owner))
			H.put_in_l_hand(new /obj/item/melee/vampirearms/knife/gangrel/lasombra(owner))
			for(var/obj/item/melee/vampirearms/knife/gangrel/lasombra/arm in H.contents)
				arm.name = "\improper shadow coil"
				arm.desc = "Squeeze tight."
				spawn(20 SECONDS)
					qdel(arm)

/datum/action/gift/banish_totem
	name = "Banish Totem"
	desc = "Choose a target. Dissolve the gnosis and connection they hold temporarily to their totem."
	button_icon_state = "banish_totem"
	rage_req = 3
	gnosis_req = 2

/datum/action/gift/banish_totem/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/valid_tribe = FALSE
		var/list/targets = list()
		for(var/mob/living/carbon/werewolf/wtarget in orange(7,owner))
			targets += wtarget
		for(var/mob/living/carbon/human/htarget in orange(7,owner))
			targets += htarget
		var/mob/living/carbon/target = tgui_input_list(owner, "Select a target", "Banish Totem", sort_list(targets))
		if(target && (iswerewolf(target) || isgarou(target)))
			valid_tribe = target.auspice.tribe
		for(var/mob/living/carbon/targetted in targets)
			if(targetted && targetted.auspice.tribe.name == valid_tribe)
				targetted.auspice.gnosis = 0
				to_chat(targetted, span_userdanger("You feel your tie to your totem snap, gnosis leaving you...!"))
				to_chat(owner, span_danger("You feel [target.name]'s gnostic ties fray...!"))

#undef DOGGY_ANIMATION_COOLDOWN
