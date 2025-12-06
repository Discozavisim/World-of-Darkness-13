/datum/chi_discipline/storm_shintai
	name = "Storm Shintai"
	desc = "Use the chi energy flow to control lightnings and weather."
	icon_state = "storm"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	activate_sound = 'code/modules/wod13/sounds/stormshintai_activate.ogg'

/obj/item/melee/touch_attack/storm_shintai
	name = "Storm touch"
	desc = "ELECTROCUTE YOURSELF!"
	catchphrase = null
	on_use_sound = 'code/modules/wod13/sounds/lightning.ogg'
	icon_state = "zapper"
	inhand_icon_state = "zapper"

/obj/item/melee/touch_attack/storm_shintai/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity || target == user || !isliving(target) || !iscarbon(user)) //getting hard after touching yourself would also be bad
		return
	if(!(user.mobility_flags & MOBILITY_USE))
		to_chat(user, "<span class='warning'>You can't reach out!</span>")
		return
	var/mob/living/human_target = target
	if(human_target.anti_magic_check())
		to_chat(user, "<span class='warning'>The spell can't seem to affect [human_target]!</span>")
		to_chat(human_target, "<span class='warning'>You feel your flesh turn to stone for a moment, then revert back!</span>")
		..()
		return
	human_target.electrocute_act(50, src, siemens_coeff = 1, flags = NONE)
	return ..()

/obj/item/gun/magic/hook/storm_shintai
	name = "electric hand"
	ammo_type = /obj/item/ammo_casing/magic/hook/storm_shintai
	icon_state = "zapper"
	inhand_icon_state = "zapper"
	icon = 'icons/obj/items_and_weapons.dmi'
	lefthand_file = 'code/modules/wod13/lefthand.dmi'
	righthand_file = 'code/modules/wod13/righthand.dmi'
	fire_sound = 'code/modules/wod13/sounds/lightning.ogg'
	max_charges = 1
	item_flags = DROPDEL | NOBLUDGEON
	force = 18

/obj/item/ammo_casing/magic/hook/storm_shintai
	name = "lightning"
	desc = "Electricity."
	projectile_type = /obj/projectile/storm_shintai
	caliber = CALIBER_HOOK
	icon_state = "hook"

/obj/item/gun/magic/hook/storm_shintai/process_fire()
	. = ..()
	if(charges == 0)
		qdel(src)

/obj/projectile/storm_shintai
	name = "lightning"
	icon_state = "spell"
	pass_flags = PASSTABLE
	damage = 0
	stamina = 20
	hitsound = 'code/modules/wod13/sounds/lightning.ogg'
	var/chain
	var/knockdown_time = (0.5 SECONDS)

/obj/projectile/storm_shintai/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state="lightning[rand(1,12)]")
		if(iscathayan(firer))
			var/mob/living/carbon/human/H = firer
			if(H.CheckEyewitness(H, H, 7, FALSE))
				H.AdjustMasquerade(-1)
	..()

/obj/projectile/storm_shintai/on_hit(atom/target)
	. = ..()
	if(ismovable(target))
		var/atom/movable/A = target
		if(A.anchored)
			return
		A.visible_message("<span class='danger'>[A] is snagged by lightning!</span>")
		playsound(get_turf(target), 'code/modules/wod13/sounds/lightning.ogg', 100, FALSE)
		if (isliving(target))
			var/mob/living/L = target
			L.Stun(0.5 SECONDS)
			L.electrocute_act(50, src, siemens_coeff = 1, flags = NONE)
			return

/obj/projectile/storm_shintai/Destroy()
	qdel(chain)
	return ..()

/datum/chi_discipline/storm_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			caster.remove_overlay(FORTITUDE_LAYER)
			var/mutable_appearance/fortitude_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "tornado", -FORTITUDE_LAYER)
			fortitude_overlay.alpha = 128
			caster.overlays_standing[FORTITUDE_LAYER] = fortitude_overlay
			caster.apply_overlay(FORTITUDE_LAYER)
			spawn()
				wind_aura_loop(caster, delay + caster.discipline_time_plus)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(FORTITUDE_LAYER)
		if(2)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/melee/touch_attack/storm_shintai(caster))
		if(3)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/gun/magic/hook/storm_shintai(caster))
		if(4)
			caster.dna.species.ToggleFlight(caster)
			caster.remove_overlay(FORTITUDE_LAYER)
			var/mutable_appearance/fortitude_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "tornado", -FORTITUDE_LAYER)
			fortitude_overlay.pixel_y = -16
			caster.overlays_standing[FORTITUDE_LAYER] = fortitude_overlay
			caster.apply_overlay(FORTITUDE_LAYER)
			spawn((delay+caster.discipline_time_plus) - 3 SECONDS)
				if(caster)
					to_chat(caster, span_warning("Your flying ability is about to end!"))
				spawn(3 SECONDS)
					if(caster)
						caster.dna.species.ToggleFlight(caster)
						caster.remove_overlay(FORTITUDE_LAYER)
		if(5)
			caster.remove_overlay(FORTITUDE_LAYER)
			var/mutable_appearance/fortitude_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "puff_const", -FORTITUDE_LAYER)
			fortitude_overlay.alpha = 128
			caster.overlays_standing[FORTITUDE_LAYER] = fortitude_overlay
			caster.apply_overlay(FORTITUDE_LAYER)
			spawn()
				storm_aura_loop(caster, delay + caster.discipline_time_plus)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(FORTITUDE_LAYER)

/datum/chi_discipline/storm_shintai/proc/wind_aura_loop(mob/living/carbon/human/caster, duration)
	var/loop_started_time = world.time
	while (world.time <= (loop_started_time + duration))
		for(var/mob/living/pushed_by_wind in oviewers(7, caster))
			step_away(pushed_by_wind, caster)

		sleep(1 SECONDS)

/datum/chi_discipline/storm_shintai/proc/storm_aura_loop(mob/living/carbon/human/caster, duration)
	var/loop_started_time = world.time
	while (world.time <= (loop_started_time + duration))
		for(var/mob/living/shocked_mob in oviewers(7, caster))
			if(prob(25))
				var/turf/lightning_source = get_turf(caster)
				lightning_source.Beam(shocked_mob, icon_state="lightning[rand(1,12)]", time = 0.5 SECONDS)
				shocked_mob.Stun(0.5 SECONDS)
				shocked_mob.electrocute_act(10, caster, siemens_coeff = 1, flags = NONE)
				playsound(get_turf(shocked_mob), 'code/modules/wod13/sounds/lightning.ogg', 100, FALSE)

		sleep(3 SECONDS)
