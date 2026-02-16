// **************************************************************** CALL THE HUNGRY DEAD *************************************************************

/obj/necrorune/question //No bloodpack requirement, but the wraiths aren't implied to owe answers.
	name = "Call the Hungry Dead"
	desc = "Summon a wraith from the Shadowlands to converse."
	icon_state = "rune4"
	word = "METEH' GHM'IEN"
	necrolevel = 2

/mob/living/simple_animal/hostile/ghost/giovanni
	maxHealth = 100 //Can be annoying right back if they're pestered for nothing.
	health = 100
	melee_damage_lower = 30
	melee_damage_upper = 30
	faction = list("Giovanni")

/obj/necrorune/question/complete()
	var/text_question = tgui_input_text(last_activator, "Enter your summons to the wraiths:", "Call the Hungry Dead", encode = FALSE)
	visible_message(span_notice("A call rings out to the dead from the rune..."))
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you wish to speak with a necromancer? (You are allowed to spread meta information) Their summons is : [text_question]", null, null, null, 20 SECONDS, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		notify_ghosts("Question rune has been triggered.", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Question Rune Triggered")
	if(!length(candidates))
		visible_message(span_notice("No one answers the [src.name] rune's call."))
		return
	var/mob/dead/observer/C = pick(candidates)
	var/mob/living/simple_animal/hostile/ghost/giovanni/TR = new(loc)
	TR.key = C.key
	TR.name = C.name
	playsound(loc, 'code/modules/wod13/sounds/necromancy2.ogg', 50, FALSE)
	visible_message(span_notice("[TR.name] slowly fades into view over the rune..."))
	qdel(src)

// **************************************************************** DEATH *************************************************************

/obj/necrorune/death
	name = "Death"
	desc = "Instantly transport yourself to the Shadowlands."
	icon_state = "rune2"
	word = "Y'HO 'LLOH"

/obj/necrorune/death/complete()
	last_activator.death()
	qdel(src)

// **************************************************************** CHILL OF OBLIVION *************************************************************

/obj/necrorune/fireprotection
	name = "Chill of Oblivion"
	desc = "Invite the cold of the Shadowlands into your soul to undo the body's fire-weakness. This profane blessing <b>taints the recipient's aura</b>."
	icon_state = "rune1"
	word = "DHAI'AD BHA'II DAWH'N"
	necrolevel = 4

/obj/necrorune/fireprotection/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody.stat == DEAD)
			to_chat(usr, span_warning("The target is dead, the cold has long settled inside."))
			return

		else valid_bodies += targetbody

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("The ritual's target must remain over the rune."))
		return

	var/mob/living/carbon/victim = pick(valid_bodies)

	if(victim.fakediablerist)
		to_chat(usr, span_warning("The ritual's target has already been claimed by the cold."))
		return

	playsound(loc, 'sound/effects/ghost.ogg', 50, FALSE)
	victim.emote("shiver")
	victim.Immobilize(4 SECONDS)

	to_chat(victim, span_revendanger("Burning ice bleeds out of your soul and into everything else. Paralyzed, you stand in the cold as death lingers."))
	victim.fakediablerist = TRUE
	if(iskindred(victim) || iscathayan(victim) || iszombie(victim)) //made this a deduction rather than a flat set because of an artifact that independently changes damage mods
		victim.dna.species.burnmod = max(0.5, victim.dna.species.burnmod-1)
	else
		victim.dna.species.burnmod = max(0.5, victim.dna.species.burnmod-0.5)
	qdel(src)

// **************************************************************** INSIGHT *************************************************************

/obj/necrorune/insight
	name = "Insight"
	desc = "Determine a cadaver's passing by questioning its soul."
	icon_state = "rune6"
	word = "IH'DET ULYSS RES'SAR"
	necrolevel = 2

/obj/necrorune/insight/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("You cannot invoke this ritual upon yourself."))
			return
		else if(targetbody.stat == DEAD)
			valid_bodies += targetbody
		else
			to_chat(usr, span_warning("The target lives still! Ask them yourself!"))
			return

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("There is no body that can undergo this Ritual."))
		return

	playsound(loc, 'code/modules/wod13/sounds/necromancy1on.ogg', 50, FALSE)

	var/mob/living/carbon/victim = pick(valid_bodies)

	var/mob/dead/observer/victim_ghost = victim.last_mind

	var/permission = null

	if(isnpc(victim))
		to_chat(last_activator, span_notice("[victim.name] is a waning, base Drone. There is no greater knowledge to gleam from this one."))
		to_chat(last_activator, span_notice("<b>Damage taken:<b><br>BRUTE: [victim.getBruteLoss()]<br>OXY: [victim.getOxyLoss()]<br>TOXIN: [victim.getToxLoss()]<br>BURN: [victim.getFireLoss()]<br>CLONE: [victim.getCloneLoss()]"))
		to_chat(last_activator, span_notice("Last melee attacker: [victim.lastattacker]"))
		qdel(src)
		return

	if(victim_ghost)
		permission = tgui_input_list(victim_ghost, "[last_activator.real_name] wishes to know of your passing. Will you give answers?", "Select", list("Yes","No","I don't recall"), "No", 1 MINUTES)

	if(permission == "Yes" && victim_ghost)
		to_chat(last_activator, span_ghostalert("[victim.name]'s haunting whispers flood your mind..."))
		var/deathdesc = tgui_input_text(victim_ghost, "", "How did you die?", "", 300, TRUE, TRUE, 5 MINUTES)
		if(deathdesc == "")
			to_chat(last_activator, span_warning("The Shroud is too thick, their whispers too raving to gleam anything useful."))
		else
			to_chat(last_activator, span_ghostalert("<i>[deathdesc]</i>"))
			//discount scanner
			to_chat(last_activator, span_notice("<b>Damage taken:<b><br>BRUTE: [victim.getBruteLoss()]<br>OXY: [victim.getOxyLoss()]<br>TOXIN: [victim.getToxLoss()]<br>BURN: [victim.getFireLoss()]<br>CLONE: [victim.getCloneLoss()]"))
			to_chat(last_activator, span_notice("Last melee attacker: [victim.lastattacker]")) //guns behave weirdly
			qdel(src)

	else if(permission == "No")
		to_chat(last_activator, span_danger("The wraith turns from you. It will not surrender its secrets."))

// **************************************************************** MINESTRA DI MORTE *************************************************************

/obj/necrorune/locate
	name = "Minestra di Morte"
	desc = "Verify a soul's status and try to divine its location."
	icon_state = "rune5"
	word = "UAH'V OUH'RAN"
	necrolevel = 3
	sacrifices = list(/obj/item/shard)

/obj/necrorune/locate/complete()

	var/chosen_name = tgui_input_text(usr, "Invoke the true name of the soul you seek:", "Minestra di Morte")
	var/target = find_target(chosen_name)

	if(!target)
		to_chat(usr, span_warning("No such soul is present beyond the Shroud, nor here in the Skinlands!"))
		return

	var/area/targetarea = get_area(target)

	if(isavatar(target))
		to_chat(usr, span_ghostalert("This soul has bridged the two realities - their astral projection wanders [targetarea.name]."))
		playsound(loc, 'code/modules/wod13/sounds/necromancy1on.ogg', 50, FALSE)
		qdel(src)
		return

	if(isobserver(target))
		to_chat(usr, span_ghostalert("This soul has departed the realm of the living - they wander [targetarea.name]."))
		playsound(loc, 'code/modules/wod13/sounds/necromancy1off.ogg', 50, FALSE)
		qdel(src)
		return

	if(isliving(target))
		var/mob/living/livetarget = target
		if(livetarget.stat != DEAD)
			to_chat(usr, span_ghostalert("This soul yet persists in the Skinlands at [targetarea.name]."))
			playsound(loc, 'code/modules/wod13/sounds/necromancy1on.ogg', 50, FALSE)

			if(livetarget.stat > SOFT_CRIT)
				to_chat(usr, span_ghostalert("Their connection to this is realm weak, and fading. Death waits for them."))
			if(HAS_TRAIT(livetarget, TRAIT_NECROMANCY_KNOWLEDGE)) //other necromancers catch onto it if targeted
				var/area/userarea = get_area(usr)
				to_chat(livetarget, span_notice("A chill and a whisper. A fellow necromancer has sought out your soul - their own calling out from <b>[userarea.name]</b>."))
			qdel(src)
			return

		if (livetarget.stat == DEAD) //for when they haven't ghosted yet
			to_chat(usr, span_ghostalert("This soul remains caged to its perished vessel at [targetarea.name]."))
			qdel(src)
			return

/obj/necrorune/locate/proc/find_target(chosen_name)
	var/mob/target_found
	for(var/mob/target in GLOB.player_list)
		if(target.real_name == chosen_name)
			target_found = target
			break
	return target_found

// **************************************************************** CALL UPON THE SHADOW'S GRACE *************************************************************

/obj/necrorune/truth
	name = "Call upon the Shadow's Grace"
	desc = "Bring forth the shadows in your victim's mind and force out their darkest truths."
	icon_state = "rune8"
	word = "MIKHH' AHPP"
	necrolevel = 3

/obj/necrorune/truth/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("You cannot invoke this ritual upon yourself."))
			return
		if(targetbody.stat == DEAD)
			to_chat(usr, span_warning("The target is dead, and has taken its secrets to the grave!"))
			return
		else
			valid_bodies += targetbody

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("The ritual's victim must remain over the rune."))
		return

	var/mob/living/carbon/victim = pick(valid_bodies)
	playsound(loc, 'code/modules/wod13/sounds/necromancy1on.ogg', 50, FALSE)

	to_chat(usr, span_ghostalert("You sic [victim.name]'s shadow on [victim.p_them()]; [victim.p_they()] cannot lie to you now."))

	playsound(victim,'sound/hallucinations/veryfar_noise.ogg',50,TRUE)
	playsound(victim,'sound/spookoween/ghost_whisper.ogg',50,TRUE)

	victim.emote("scream")
	victim.AdjustKnockdown(2 SECONDS)
	victim.do_jitter_animation(3 SECONDS)

	to_chat(victim, span_revenboldnotice("Your mouth snaps open, and whatever air you take in can't seem to stay."))
	to_chat(victim, span_revenboldnotice("All the dark secrets you harbor come spilling out before you can even recall them."))
	to_chat(victim, span_hypnophrase("YOU CANNOT LIE."))

	visible_message(span_danger("[victim.name]'s shadow thrashes underneath [victim.p_them()], as if a separate being!"))
	addtimer(CALLBACK(victim, TYPE_PROC_REF(/datum/necrorune/truth, wearoff), victim), 2 MINUTES)
	qdel(src)

/datum/necrorune/truth/proc/wearoff(mob/living/carbon/victim)
	if(!victim)
		return
	to_chat(victim, span_notice("The grip on your soul relents, you feel in control over your secrets."))

// **************************************************************** DAEMONIC POSSESSION *************************************************************

/mob/living
	var/zombie_owner

/obj/necrorune/zombie
	name = "Daemonic Possession"
	desc = "Place a wraith inside of a dead body and raise it as a sentient zombie."
	icon_state = "rune7"
	word = "GI'TI FOA'HP"
	necrolevel = 5
	var/duration_length = 15 SECONDS

/obj/necrorune/zombie/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("You cannot invoke this ritual upon yourself."))
			return
		else if(targetbody.stat == DEAD)
			valid_bodies += targetbody
		else
			to_chat(usr, span_warning("The target lives still!"))
			return

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("There is no body that can undergo this Ritual."))
		return

	usr.visible_message(span_notice("[usr] begins chanting in vile tongues..."), span_notice("You begin the resurrection ritual."))
	playsound(loc, 'code/modules/wod13/sounds/necromancy2.ogg', 50, FALSE)

	if(do_after(usr, duration_length, usr))

		activated = TRUE
		last_activator = usr

		var/mob/living/target_body = pick(valid_bodies)

		var/old_name = target_body.real_name

		// Transform the body into a zombie
		if(!target_body || QDELETED(target_body) || target_body.stat > DEAD)
			return

		// Remove any vampiric actions
		for(var/datum/action/A in target_body.actions)
			if(A && A.vampiric)
				A.Remove(target_body)

		var/original_location = get_turf(target_body)

		// Revive the specimen and turn them into a zombie
		target_body.revive(TRUE)
		target_body.set_species(/datum/species/zombie)
		target_body.real_name = old_name // the ritual for some reason is deleting their old name and replacing it with a random name.
		target_body.name = old_name
		target_body.zombie_owner = usr

		if(target_body.loc != original_location)
			target_body.forceMove(original_location)

		playsound(loc, 'code/modules/wod13/sounds/necromancy.ogg', 50, FALSE)

		// Handle key assignment
		if(!target_body.key)
			var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you wish to play as Sentient Zombie?", null, null, null, 20 SECONDS, src)
			for(var/mob/dead/observer/G in GLOB.player_list)
				if(G.key)
					notify_ghosts("Zombie rune has been triggered.", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Zombie Rune Triggered")
			if(LAZYLEN(candidates))
				var/mob/dead/observer/C = pick(candidates)
				target_body.key = C.key

			var/choice = tgui_alert(target_body, "Do you want to pick a new name as a Zombie?", "Zombie Choose Name", list("Yes", "No"), 10 SECONDS)
			if(choice == "Yes")
				var/chosen_zombie_name = tgui_input_text(target_body, "What is your new name as a Zombie?", "Zombie Name Input")
				target_body.real_name = chosen_zombie_name
				target_body.name = chosen_zombie_name
			else
				target_body.visible_message(span_ghostalert("[target_body.name] twitches to unlife!"))
				qdel(src)
				return

		target_body.visible_message(span_ghostalert("[target_body.name] twitches to unlife!"))
		qdel(src)
