GLOBAL_LIST_EMPTY(auspex_users)

/datum/discipline/auspex
	name = "Auspex"
	desc = "Allows to see entities, auras and their health through walls."
	icon_state = "auspex"
	power_type = /datum/discipline_power/auspex


/datum/discipline/auspex/post_gain()
	GLOB.auspex_users += owner

/datum/discipline_power/auspex
	name = "Auspex power name"
	desc = "Auspex power description"

	activate_sound = 'code/modules/wod13/sounds/auspex.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/auspex_deactivate.ogg'

/datum/discipline_power/auspex/activate()
	. = ..()
	owner.see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+20+maxlevel /// {T.WINER} - Временный фикс на +20, так как почему то си инвизибил лвл обфус меньше обфус инвизибл

/datum/discipline_power/auspex/deactivate()
	. = ..()
	owner.see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+0

//HEIGHTENED SENSES
/datum/discipline_power/auspex/heightened_senses
	name = "Heightened Senses"
	desc = "Enhances your senses far past human limitations."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 1
	vitae_cost = 0

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/heightened_senses/activate()
	. = ..()
	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, AUSPEX_TRAIT, TRAIT_GENERIC)

	owner.update_sight()

/datum/discipline_power/auspex/heightened_senses/deactivate()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, AUSPEX_TRAIT, TRAIT_GENERIC)


	owner.update_sight()

//AURA PERCEPTION
/datum/discipline_power/auspex/aura_perception
	name = "Aura Perception"
	desc = "Allows you to perceive the auras of those near you."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 2

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/aura_perception/activate()
	. = ..()
	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.add_hud_to(owner)

	owner.update_sight()

/datum/discipline_power/auspex/aura_perception/deactivate()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.remove_hud_from(owner)

	owner.update_sight()

//THE SPIRIT'S TOUCH
/datum/discipline_power/auspex/the_spirits_touch
	name = "The Spirit's Touch"
	desc = "Allows you to feel the physical wellbeing of those near you."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 3

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/the_spirits_touch/activate()
	. = ..()
	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.add_hud_to(owner)

	owner.update_sight()

/datum/discipline_power/auspex/the_spirits_touch/deactivate()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.remove_hud_from(owner)

	owner.update_sight()

//TELEPATHY
/datum/discipline_power/auspex/telepathy
	name = "Telepathy"
	desc = "Feel the psychic resonances left on objects you can touch."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 4

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/telepathy/activate()
	. = ..()
	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	owner.auspex_examine = TRUE

	owner.update_sight()

/datum/discipline_power/auspex/telepathy/deactivate()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	owner.auspex_examine = FALSE

	owner.update_sight()

//PSYCHIC PROJECTION
/datum/discipline_power/auspex/psychic_projection
	name = "Psychic Projection"
	desc = "Leave your body behind and fly across the land."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 5

/datum/discipline_power/auspex/psychic_projection/activate()
	. = ..()
	owner.ghostize(can_reenter_corpse = TRUE, aghosted = FALSE, auspex_ghosted = TRUE)
	owner.soul_state = SOUL_PROJECTING

/* ATOM */

/atom
	var/last_investigated = 0

//! So much spaghetti code, but it's can't be avoided

/atom/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/Z = user
		if(Z.auspex_examine)
			if(!isturf(src) && !isobj(src) && !ismob(src))
				return
			var/list/fingerprints = list()
			var/list/blood = return_blood_DNA()
			var/list/fibers = return_fibers()
			var/list/reagents = list()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()


				if(isturf(src))
					var/turf/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type
				if(isobj(src))
					var/obj/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type

			// We gathered everything. Create a fork and slowly display the results to the holder of the scanner.

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			//Killer
			if(isliving(src))
				var/mob/living/LivedYoung = src
				if(LivedYoung.lastattacker)
					for(var/mob/living/carbon/human/huLi in GLOB.player_list)
						if(huLi?.dna?.real_name == LivedYoung.lastattacker)
							to_chat(user, "<span class='info'><B>Aggressive prints:</B> [md5(huLi.dna.uni_identity)]</span>")
							found_something = TRUE

			// Blood
			if (length(blood))
				to_chat(user, "<span class='info'><B>Blood:</B></span>")
				found_something = TRUE
				for(var/B in blood)
					to_chat(user, "Type: <font color='red'>[blood[B]]</font> DNA (UE): <font color='red'>[B]</font>")

			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			//Reagents
			if(length(reagents))
				to_chat(user, "<span class='info'><B>Reagents:</B></span>")
				for(var/R in reagents)
					to_chat(user, "Reagent: <font color='red'>[R]</font> Volume: <font color='red'>[reagents[R]]</font>")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return
		else if((isobj(src) || ismob(src)) && last_investigated <= world.time)
			last_investigated = world.time+30 SECONDS
			if(secret_vampireroll(get_a_perception(user)+get_a_investigation(user), 6, user) < 3)
				return

			var/list/fingerprints = list()
			var/list/fibers = return_fibers()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			//Killer
			if(isliving(src))
				var/mob/living/LivedYoung = src
				if(LivedYoung.lastattacker)
					for(var/mob/living/carbon/human/huLi in GLOB.player_list)
						if(huLi?.dna?.real_name == LivedYoung.lastattacker)
							to_chat(user, "<span class='info'><B>Aggressive prints:</B> [md5(huLi.dna.uni_identity)]</span>")
							found_something = TRUE
			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return
