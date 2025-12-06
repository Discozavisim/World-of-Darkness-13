/datum/chi_discipline/feng_shui
	name = "Feng Shui"
	desc = "By manipulating special talismans, the fang shih can direct energies to control and corrupt."
	icon_state = "fengshui"
	ranged = FALSE
	delay = 12 SECONDS
	cost_yang = 1
	cost_yin = 1
	discipline_type = "Chi"
	activate_sound = 'code/modules/wod13/sounds/feng_shui.ogg'

/datum/movespeed_modifier/pacifisting
	multiplicative_slowdown = 3

/datum/chi_discipline/feng_shui/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			var/sound/auspexbeat = sound('code/modules/wod13/sounds/auspex.ogg', repeat = TRUE)
			caster.playsound_local(caster, auspexbeat, 75, 0, channel = CHANNEL_DISCIPLINES, use_reverb = FALSE)
			ADD_TRAIT(caster, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
			caster.see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+level
			caster.update_sight()
			caster.add_client_colour(/datum/client_colour/glass_colour/lightblue)
			var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
			abductor_hud.add_hud_to(caster)
			caster.auspex_examine = TRUE
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.auspex_examine = FALSE
					caster.update_sight()
					abductor_hud.remove_hud_from(caster)
					caster.stop_sound_channel(CHANNEL_DISCIPLINES)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/auspex_deactivate.ogg', 50, FALSE)
					REMOVE_TRAIT(caster, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
					caster.remove_client_colour(/datum/client_colour/glass_colour/lightblue)
					caster.update_sight()
		if(2)
			var/sound/auspexbeat = sound('code/modules/wod13/sounds/auspex.ogg', repeat = TRUE)
			caster.playsound_local(caster, auspexbeat, 75, 0, channel = CHANNEL_DISCIPLINES, use_reverb = FALSE)
			ADD_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
			ADD_TRAIT(caster, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
			caster.see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+level
			caster.update_sight()
			var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
			health_hud.add_hud_to(caster)
			caster.auspex_examine = TRUE
			spawn(delay+caster.discipline_time_plus)
				if(caster)
					caster.auspex_examine = FALSE
					caster.update_sight()
					health_hud.remove_hud_from(caster)
					caster.stop_sound_channel(CHANNEL_DISCIPLINES)
					caster.playsound_local(caster.loc, 'code/modules/wod13/sounds/auspex_deactivate.ogg', 50, FALSE)
					REMOVE_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
					REMOVE_TRAIT(caster, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
					caster.update_sight()
		if(3)
			if(caster.lastattacked)
				if(isliving(caster.lastattacked))
					var/mob/living/cursing_mob = caster.lastattacked
					to_chat(cursing_mob, "<span class='warning'>You feel bigger hunger than usual.</span>")
					if(iskindred(cursing_mob))
						cursing_mob.bloodpool = max(0, cursing_mob.bloodpool-3)
					else if(iscathayan(cursing_mob))
						cursing_mob.yang_chi = max(0, cursing_mob.yang_chi-2)
						cursing_mob.yin_chi = max(0, cursing_mob.yin_chi-2)
					else
						cursing_mob.adjust_nutrition(-100)
					playsound(get_turf(cursing_mob), 'code/modules/wod13/sounds/hunger.ogg', 100, FALSE)
					to_chat(caster, "You send your curse on [cursing_mob], the last creature you attacked.")
				else
					to_chat(caster, "You don't seem to have last attacked soul earlier...")
					return
			else
				to_chat(caster, "You don't seem to have last attacked soul earlier...")
				return
		if(4)
			for(var/mob/living/affected_mob in oviewers(7, caster))
				ADD_TRAIT(affected_mob, TRAIT_PACIFISM, MAGIC_TRAIT)
				affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/pacifisting)
				affected_mob.emote("stare")
				spawn(delay+caster.discipline_time_plus)
					if(affected_mob)
						REMOVE_TRAIT(affected_mob, TRAIT_PACIFISM, MAGIC_TRAIT)
						affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/pacifisting)
		if(5)
			var/list/visuals = list()

			for(var/dx = -2 to 2)
				for(var/dy = -2 to 2)

					// пропускаем центр + клеточки вокруг (то есть квадрат 3×3)
					if(abs(dx) <= 1 && abs(dy) <= 1)
						continue

					var/turf/T = locate(caster.x + dx, caster.y + dy, caster.z)
					if(!T)
						continue

					var/atom/movable/V = new /atom/movable(T)
					V.density = TRUE
					V.anchored = TRUE
					V.layer = ABOVE_ALL_MOB_LAYER
					V.name = "static"
					V.icon = 'icons/effects/effects.dmi'
					V.icon_state = "static_base"
					V.alpha = 128

					visuals += V

			playsound(get_turf(caster), 'sound/effects/smoke.ogg', 50, TRUE)

			spawn(delay + caster.discipline_time_plus)
				for(var/V in visuals)
					qdel(V)
