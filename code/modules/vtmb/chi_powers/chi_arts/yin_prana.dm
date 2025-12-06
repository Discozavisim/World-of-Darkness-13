/datum/chi_discipline/yin_prana
	name = "Yin Prana"
	desc = "Allows to tap into and manipulate Kuei-Jin internal Yin energy"
	icon_state = "yin_prana"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yin = 2
	discipline_type = "Chi"
	activate_sound = 'code/modules/wod13/sounds/yin_prana.ogg'

/obj/item/melee/touch_attack/yin_touch
	name = "\improper shadow touch"
	desc = "This is kind of like when you rub your feet on a shag rug so you can zap your friends, only a lot less safe."
	icon = 'code/modules/wod13/weapons.dmi'
	catchphrase = null
	on_use_sound = 'sound/magic/disintegrate.ogg'
	icon_state = "quietus"
	color = "#343434"
	inhand_icon_state = "mansus"

/obj/item/melee/touch_attack/yin_touch/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/structure/vampdoor))
		var/obj/structure/vampdoor/door = target
		if (door.lockpick_difficulty > 10)
			return ..()
		playsound(get_turf(target), 'code/modules/wod13/sounds/get_bent.ogg', 100, FALSE)
		var/obj/item/shield/door/door_item = new(get_turf(target))
		door_item.icon_state = door.baseicon
		var/atom/throw_target = get_edge_target_turf(target, user.dir)
		door_item.throw_at(throw_target, rand(2, 4), 4, src)
		qdel(target)
	if(isliving(target))
		var/mob/living/target_mob = target
		target_mob.adjustCloneLoss(20)
		target_mob.AdjustKnockdown(2 SECONDS)
	return ..()

/datum/chi_discipline/yin_prana/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			caster.invisibility = INVISIBILITY_LEVEL_OBFUSCATE+level
			caster.alpha = 100
			caster.obfuscate_level = level
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.obfuscate_level = 0
					if(caster.alpha != initial(caster.invisibility))
						caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/obfuscate_deactivate.ogg', 50, FALSE)
						caster.invisibility = initial(caster.invisibility)
						caster.alpha = 255
		if(2)
			var/atom/movable/light_source = new(target)
			light_source.set_light(5, -7)
			spawn(delay+caster.discipline_time_plus)
				light_source.set_light(0)
				qdel(light_source)
		if(3)
			for(var/mob/living/affected_mob in oviewers(7, caster))
				affected_mob.AdjustKnockdown(2 SECONDS)
				affected_mob.adjustStaminaLoss(50, TRUE)
			var/matrix/double_size = matrix()
			double_size.Scale(2, 2)
			for (var/i in 1 to 3)
				var/obj/effect/celerity/celerity_effect = new(get_turf(caster))
				celerity_effect.appearance = caster.appearance
				celerity_effect.dir = caster.dir
				celerity_effect.color = "#000000"
				animate(celerity_effect, pixel_x = pick(-16, 0, 16), pixel_y = pick(-16, 0, 16), alpha = 0, transform = double_size, time = 2 SECONDS)
		if(4)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/melee/touch_attack/yin_touch(caster))
		if(5)
			for(var/mob/living/affected_mob in oviewers(7, caster))
				for (var/i in 1 to 5)
					new /datum/hallucination/dangerflash(affected_mob, TRUE)
			do_sparks(5, FALSE, caster)
