/datum/chi_discipline/flesh_shintai
	name = "Flesh Shintai"
	desc = "Manipulate own flesh and flexibility."
	icon_state = "flesh"
	ranged = FALSE
	cost_yang = 1
	delay = 12 SECONDS
	activate_sound = 'code/modules/wod13/sounds/fleshshintai_activate.ogg'
	var/datum/component/tackler

/obj/item/chameleon/temp
	name = "Appearance Projector"
	item_flags = DROPDEL

//obj/item/chameleon/temp/Initialize()
//	. = ..()
//	ADD_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)

//Meat Hook
/obj/item/gun/magic/hook/flesh_shintai
	name = "obviously long arm"
	ammo_type = /obj/item/ammo_casing/magic/hook/flesh_shintai
	icon_state = "hook_hand"
	icon = 'code/modules/wod13/weapons.dmi'
	inhand_icon_state = "hook_hand"
	lefthand_file = 'code/modules/wod13/lefthand.dmi'
	righthand_file = 'code/modules/wod13/righthand.dmi'
	fire_sound = 'code/modules/wod13/sounds/vicissitude.ogg'
	max_charges = 1
	item_flags = DROPDEL | NOBLUDGEON
	force = 18

/obj/item/ammo_casing/magic/hook/flesh_shintai
	name = "hand"
	desc = "A hand."
	projectile_type = /obj/projectile/flesh_shintai
	caliber = CALIBER_HOOK
	icon_state = "hook"

/obj/projectile/flesh_shintai
	name = "hand"
	icon_state = "hand"
	icon = 'code/modules/wod13/icons.dmi'
	pass_flags = PASSTABLE
	damage = 0
	stamina = 20
	hitsound = 'sound/effects/splat.ogg'
	var/chain
	var/knockdown_time = (0.5 SECONDS)

/obj/projectile/flesh_shintai/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "arm")
		if(iscathayan(firer))
			var/mob/living/carbon/human/H = firer
			if(H.CheckEyewitness(H, H, 7, FALSE))
				H.AdjustMasquerade(-1)
	..()

/obj/projectile/flesh_shintai/on_hit(atom/target)
	. = ..()
	if(ismovable(target))
		var/atom/movable/movable_target = target
		if(movable_target.anchored)
			return
		movable_target.visible_message("<span class='danger'>[movable_target] is snagged by [firer]'s hand!</span>")
		movable_target.forceMove(get_turf(get_step_towards(firer, movable_target)))
		if (isliving(target))
			var/mob/living/fresh_meat = target
			fresh_meat.grabbedby(firer, supress_message = FALSE)
			fresh_meat.Knockdown(knockdown_time)
			return
		//TODO: keep the chain beamed to movable_target
		//TODO: needs a callback to delete the chain

/obj/projectile/flesh_shintai/Destroy()
	qdel(chain)
	return ..()

/obj/structure/flesh_grip
	name = "flesh grip"
	desc = "A huge flesh meat structure."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "flesh_grip"
	can_buckle = TRUE
	anchored = TRUE
	density = TRUE
	max_buckled_mobs = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/flesh_grip/user_unbuckle_mob(mob/living/buckled_mob, mob/living/carbon/human/user)
	if(buckled_mob)
		if(buckled_mob != user)
			buckled_mob.visible_message("<span class='notice'>[user] tries to pull [buckled_mob] free of [src]!</span>",\
				"<span class='notice'>[user] is trying to pull you off [src], opening up fresh wounds!</span>",\
				"<span class='hear'>You hear a squishy wet noise.</span>")
			if(!do_after(user, 30 SECONDS, target = src))
				if(buckled_mob?.buckled)
					buckled_mob.visible_message("<span class='notice'>[user] fails to free [buckled_mob]!</span>",\
					"<span class='notice'>[user] fails to pull you off of [src].</span>")
				return
		else
			if(iswerewolf(buckled_mob))
				buckled_mob.visible_message("<span class='warning'>[buckled_mob] tears through the [src]!</span>",\
				"<span class='notice'>You tear through the [src], attempting to free yourself!</span>",\
				"<span class='hear'>You hear a wet squishing noise..</span>")
				if(do_after(buckled_mob, 3 SECONDS, target = src))
					unbuckle_mob(buckled_mob, force = TRUE)
					visible_message(text("<span class='danger'>[buckled_mob] falls free of [src]!</span>"))
					qdel(src)
					return
			buckled_mob.visible_message("<span class='warning'>[buckled_mob] struggles to break free from [src]!</span>",\
			"<span class='notice'>You struggle to break free from [src], exacerbating your wounds! (Stay still for two minutes.)</span>",\
			"<span class='hear'>You hear a wet squishing noise..</span>")
			buckled_mob.adjustBruteLoss(30)
			if(!do_after(buckled_mob, 10 SECONDS, target = src))
				if(buckled_mob?.buckled)
					to_chat(buckled_mob, "<span class='warning'>You fail to free yourself!</span>")
				return
		if(!buckled_mob.buckled)
			return
		release_mob(buckled_mob)

/obj/structure/flesh_grip/proc/release_mob(mob/living/buckled_mob)
	buckled_mob.pixel_y = buckled_mob.base_pixel_y + PIXEL_Y_OFFSET_LYING
	buckled_mob.adjustBruteLoss(30)
	visible_message(text("<span class='danger'>[buckled_mob] falls free of [src]!</span>"))
	unbuckle_mob(buckled_mob, force = TRUE)
	buckled_mob.emote("scream")
	buckled_mob.AdjustParalyzed(2 SECONDS)
	qdel(src)

/datum/chi_discipline/flesh_shintai/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			var/obj/item/gun/magic/hook/flesh_shintai/fleshhook = new (caster)
			caster.drop_all_held_items()
			caster.put_in_active_hand(fleshhook)
			spawn(delay+caster.discipline_time_plus)
				qdel(fleshhook)
		if(2)
			caster.remove_overlay(PROTEAN_LAYER)
			var/mutable_appearance/potence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "flesh_arms", -PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = potence_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			caster.attributes.strength_bonus += level
			caster.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
			tackler = caster.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 2+level_casting, speed = 1, skill_mod = 0, min_distance = 0)
			caster.attributes.potence_bonus += level
			ADD_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.remove_overlay(PROTEAN_LAYER)
					caster.attributes.potence_bonus -= level
					caster.attributes.strength_bonus -= level
					caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
					qdel(tackler)
					REMOVE_TRAIT(caster, TRAIT_NONMASQUERADE, TRAUMA_TRAIT)
		if(3)
			ADD_TRAIT(caster, TRAIT_HANDS_BLOCK_PROJECTILES, "flesh shintai 3")
			to_chat(caster, "<span class='notice'>Your muscles relax and start moving unintentionally. You feel perfect at projectile evasion skills...</span>")
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					REMOVE_TRAIT(caster, TRAIT_HANDS_BLOCK_PROJECTILES, "flesh shintai 3")
					to_chat(caster, "<span class='warning'>Your muscles feel natural again..</span>")
		if(4)
			var/obj/structure/flesh_grip/flesh_grip = new (get_turf(caster))
			if(caster.pulling)
				if(isliving(caster.pulling))
					flesh_grip.buckle_mob(caster.pulling, TRUE, FALSE)
			else
				for(var/mob/living/grabbed_mob in (range(2, caster) - caster))
					if(grabbed_mob.stat != DEAD)
						flesh_grip.buckle_mob(grabbed_mob, TRUE, FALSE)
		if(5)
			caster.drop_all_held_items()
			caster.put_in_active_hand(new /obj/item/chameleon/temp(caster))
