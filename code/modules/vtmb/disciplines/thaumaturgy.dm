/datum/discipline/thaumaturgy
	name = "Thaumaturgy"
	desc = "Opens the secrets of blood magic and how you use it, allows to steal other's blood. Violates Masquerade."
	icon_state = "thaumaturgy"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/thaumaturgy

/datum/discipline/thaumaturgy/post_gain()
	. = ..()
	owner.faction |= "Tremere"
	if(level >= 1)
		var/datum/action/thaumaturgy/thaumaturgy = new()
		thaumaturgy.Grant(owner)
		thaumaturgy.level = level
		owner.thaumaturgy_knowledge = TRUE
	if(level >= 3)
		var/datum/action/bloodshield/bloodshield = new()
		bloodshield.Grant(owner)

/datum/discipline_power/thaumaturgy
	name = "Thaumaturgy power name"
	desc = "Thaumaturgy power description"

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 7

	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS
	multi_activate = TRUE

//A TASTE FOR BLOOD
/obj/effect/projectile/tracer/thaumaturgy
	name = "blood beam"
	icon_state = "cult"

/obj/effect/projectile/muzzle/thaumaturgy
	name = "blood beam"
	icon_state = "muzzle_cult"

/obj/effect/projectile/impact/thaumaturgy
	name = "blood beam"
	icon_state = "impact_cult"

/obj/projectile/thaumaturgy
	name = "blood beam"
	icon_state = "thaumaturgy"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 5
	damage_type = BURN
	hitsound = 'code/modules/wod13/sounds/drinkblood1.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = LASER
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 0
	ricochet_chance = 0
	tracer_type = /obj/effect/projectile/tracer/thaumaturgy
	muzzle_type = /obj/effect/projectile/muzzle/thaumaturgy
	impact_type = /obj/effect/projectile/impact/thaumaturgy
	var/level = 1

/obj/projectile/thaumaturgy/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(ishuman(firer))
		var/mob/living/carbon/human/VH = firer
		if(isliving(target))
			var/mob/living/VL = target
			if(isgarou(VL))
				if(VL.bloodpool >= 1 && VL.stat != DEAD)
					var/sucked = min(VL.bloodpool, 2)
					VL.bloodpool = max(VL.bloodpool - sucked, 0)
					VL.apply_damage(45, BURN)
					VL.visible_message(span_danger("[target]'s wounds spray boiling hot blood!"), "<span class='userdanger'>Your blood boils!</span>")
					VL.add_splatter_floor(get_turf(target))
					VL.add_splatter_floor(get_turf(get_step(target, target.dir)))
				if(!iskindred(target))
					if(VL.bloodpool >= 1 && VL.stat != DEAD)
						var/sucked = min(VL.bloodpool, 2)
						VL.bloodpool = max(VL.bloodpool - sucked, 0)
					if(ishuman(VL))
						if(VL.bloodpool >= 1 && VL.stat != DEAD)
							var/mob/living/carbon/human/VHL = VL
							VHL.bloodpool = max(VHL.bloodpool - 1, 0)
			else
				if(VL.bloodpool >= 1)
					var/sucked = min(VL.bloodpool, level)
					VL.bloodpool = max(VL.bloodpool - sucked, 0)
					VH.bloodpool = min(VH.bloodpool + sucked, VH.maxbloodpool)

/datum/discipline_power/thaumaturgy/a_taste_for_blood
	name = "A Taste for Blood"
	desc = "Touch the blood of a subject and gain information about their bloodline."

	level = 1

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/blood_rage,
		/datum/discipline_power/thaumaturgy/blood_of_potency,
		/datum/discipline_power/thaumaturgy/theft_of_vitae,
		/datum/discipline_power/thaumaturgy/cauldron_of_blood
	)

/datum/discipline_power/thaumaturgy/a_taste_for_blood/activate(mob/living/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/thaumaturgy/H = new(start)
	H.firer = owner
	H.preparePixelProjectile(target, start)
	H.fire(direct_target = target)

//BLOOD RAGE
/datum/discipline_power/thaumaturgy/blood_rage
	name = "Blood Rage"
	desc = "Impose your will on another Kindred's vitae and force them to spend it as you wish."

	level = 2

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/a_taste_for_blood,
		/datum/discipline_power/thaumaturgy/blood_of_potency,
		/datum/discipline_power/thaumaturgy/theft_of_vitae,
		/datum/discipline_power/thaumaturgy/cauldron_of_blood
	)

/datum/discipline_power/thaumaturgy/blood_rage/activate(mob/living/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/thaumaturgy/H = new(start)
	H.firer = owner
	H.damage = 10 + owner.thaum_damage_plus
	H.preparePixelProjectile(target, start)
	H.level = 2
	H.fire(direct_target = target)

//BLOOD OF POTENCY
/datum/discipline_power/thaumaturgy/blood_of_potency
	name = "Blood of Potency"
	desc = "Supernaturally thicken your vitae as if you were of a lower Generation."

	level = 3

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/a_taste_for_blood,
		/datum/discipline_power/thaumaturgy/blood_rage,
		/datum/discipline_power/thaumaturgy/theft_of_vitae,
		/datum/discipline_power/thaumaturgy/cauldron_of_blood
	)

/datum/discipline_power/thaumaturgy/blood_of_potency/activate(mob/living/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/thaumaturgy/H = new(start)
	H.firer = owner
	H.damage = 15 + owner.thaum_damage_plus
	H.preparePixelProjectile(target, start)
	H.level = 2
	H.fire(direct_target = target)

/datum/discipline_power/thaumaturgy/theft_of_vitae
	name = "Theft of Vitae"
	desc = "Draw your target's blood to you, supernaturally absorbing it as it flies."

	level = 4

	effect_sound = 'code/modules/wod13/sounds/vomit.ogg'

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/a_taste_for_blood,
		/datum/discipline_power/thaumaturgy/blood_rage,
		/datum/discipline_power/thaumaturgy/blood_of_potency,
		/datum/discipline_power/thaumaturgy/cauldron_of_blood
	)

/datum/discipline_power/thaumaturgy/theft_of_vitae/activate(mob/living/target)
	. = ..()
	if(iscarbon(target))
		target.Stun(2.5 SECONDS)
		target.visible_message(span_danger("[target] throws up!"), "<span class='userdanger'>You throw up!</span>")
		target.add_splatter_floor(get_turf(target))
		target.add_splatter_floor(get_turf(get_step(target, target.dir)))
	else
		owner.bloodpool = min(owner.bloodpool + target.bloodpool, owner.maxbloodpool)
		if(!istype(target, /mob/living/simple_animal/hostile/megafauna))
			target.tremere_gib()

//CAULDRON OF BLOOD
/datum/discipline_power/thaumaturgy/cauldron_of_blood
	name = "Cauldron of Blood"
	desc = "Boil your target's blood in their body, killing almost anyone."

	level = 5

	effect_sound = 'code/modules/wod13/sounds/vomit.ogg'

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/a_taste_for_blood,
		/datum/discipline_power/thaumaturgy/blood_rage,
		/datum/discipline_power/thaumaturgy/blood_of_potency,
		/datum/discipline_power/thaumaturgy/theft_of_vitae
	)

/datum/discipline_power/thaumaturgy/cauldron_of_blood/activate(mob/living/target)
	. = ..()
	if(iscarbon(target))
		target.Stun(2.5 SECONDS)
		target.visible_message(span_danger("[target] throws up!"), "<span class='userdanger'>You throw up!</span>")
		target.add_splatter_floor(get_turf(target))
		target.add_splatter_floor(get_turf(get_step(target, target.dir)))
	else
		owner.bloodpool = min(owner.bloodpool + target.bloodpool, owner.maxbloodpool)
		if(!istype(target, /mob/living/simple_animal/hostile/megafauna))
			target.tremere_gib()

//MISCELLANEOUS BULLSHIT
/datum/action/thaumaturgy
	name = "Thaumaturgy"
	desc = "Blood magic rune drawing."
	button_icon_state = "thaumaturgy"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_IMMOBILE | AB_CHECK_LYING | AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/drawing = FALSE
	var/level = 1

/datum/action/thaumaturgy/Trigger()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.bloodpool < 2)
		to_chat(H, "<span class='warning'>You need more <b>BLOOD</b> to do that!</span>")
		return
	if(drawing)
		return

	if(istype(H.get_active_held_item(), /obj/item/arcane_tome))
		var/list/shit = list()
		for(var/i in subtypesof(/obj/ritualrune))
			var/obj/ritualrune/R = new i(owner)
			if(R.thaumlevel <= level)
				shit += i
			qdel(R)
		var/ritual = input(owner, "Choose rune to draw:", "Thaumaturgy") as null|anything in shit
		if(ritual)
			drawing = TRUE
			if(do_after(H, 5 SECONDS, H))
				var/result = secret_vampireroll(get_a_intelligence(H)+get_a_occult(H), 6, H)
				if(result > 1)
					drawing = FALSE
					new ritual(H.loc)
					H.bloodpool = max(0, H.bloodpool-2)
					if(H.CheckEyewitness(H, H, 7, FALSE))
						H.AdjustMasquerade(-1)
				else
					drawing = FALSE
					if(result == -1)
						H.AdjustKnockdown(3 SECONDS)
			else
				drawing = FALSE
	else
		var/list/shit = list()
		for(var/i in subtypesof(/obj/ritualrune))
			var/obj/ritualrune/R = new i(owner)
			if(R.thaumlevel <= level)
				shit += i
			qdel(R)
		var/ritual = input(owner, "Choose rune to draw (You need an Arcane Tome to reduce random):", "Thaumaturgy") as null|anything in list("???")
		if(ritual)
			drawing = TRUE
			if(do_after(H, 5 SECONDS, H))
				var/result = secret_vampireroll(get_a_intelligence(H)+get_a_occult(H), 6, H)
				if(result > 1)
					drawing = FALSE
					var/rune = pick(shit)
					new rune (H.loc)
					H.bloodpool = max(0, H.bloodpool-2)
					if(H.CheckEyewitness(H, H, 7, FALSE))
						H.AdjustMasquerade(-1)
				else
					drawing = FALSE
					if(result == -1)
						H.AdjustKnockdown(3 SECONDS)
			else
				drawing = FALSE

/datum/action/bloodshield
	name = "Bloodshield"
	desc = "Gain armor with blood."
	button_icon_state = "bloodshield"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/abuse_fix = 0

/datum/action/bloodshield/Trigger()
	. = ..()
	if((abuse_fix + 25 SECONDS) > world.time)
		return
	var/mob/living/carbon/human/H = owner
	if(H.bloodpool < 2)
		to_chat(owner, span_warning("You don't have enough <b>BLOOD</b> to do that!"))
		return
	H.bloodpool = max(H.bloodpool - 2, 0)
	playsound(H.loc, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
	abuse_fix = world.time
	H.physiology.damage_resistance += 60
	animate(H, color = "#ff0000", time = 10, loop = 1)
	if(H.CheckEyewitness(H, H, 7, FALSE))
		H.AdjustMasquerade(-1)
	spawn(15 SECONDS)
		if(H)
			playsound(H.loc, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
			H.physiology.damage_resistance -= 60
			H.color = initial(H.color)

/*
/datum/discipline/bloodshield
	name = "Blood shield"
	desc = "Boosts armor."
	icon_state = "bloodshield"
	cost = 2
	ranged = FALSE
	delay = 15 SECONDS
	activate_sound = 'code/modules/wod13/sounds/thaum.ogg'

/datum/discipline/bloodshield/activate(mob/living/target, mob/living/carbon/human/owner)
	..()
	var/mod = level_casting
	owner.physiology.armor.melee = owner.physiology.armor.melee+(15*mod)
	owner.physiology.armor.bullet = owner.physiology.armor.bullet+(15*mod)
	animate(owner, color = "#ff0000", time = 1 SECONDS, loop = 1)
//	owner.color = "#ff0000"
	spawn(delay+owner.discipline_time_plus)
		if(owner)
			playsound(owner.loc, 'code/modules/wod13/sounds/thaum.ogg', 50, FALSE)
			owner.physiology.armor.melee = owner.physiology.armor.melee-(15*mod)
			owner.physiology.armor.bullet = owner.physiology.armor.bullet-(15*mod)
			owner.color = initial(owner.color)
*/
