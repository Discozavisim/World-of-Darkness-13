/mob/living/proc/kislota_trip()
	if(client)
		animate(client, color = GLOB.hapi_palaci, time = 10, delay=1)
		animate(client, color = GLOB.kent, time = 5, delay=10)
		animate(client, color = GLOB.xorek, time = 5, delay=10)
		animate(client, color = GLOB.meomoor, time = 5, delay=10)
		animate(client, color = GLOB.trip_black, time = 5, delay=10)
		animate(client, color = GLOB.xorek, time = 5, delay=10)
		animate(client, color = GLOB.meomoor, time = 5, delay=10)
		animate(client, color = GLOB.kent, time = 5, delay=10)
		animate(client, color = GLOB.meomoor, time = 5, delay=10)
		animate(client, color = GLOB.trip_black, time = 5, delay=10)

/mob/living/proc/crazy_screen(start = TRUE, x, y, size)
	if(!x)
		x = 5
	if(!y)
		y = 10
	if(!size)
		size = 5
	var/filter
	var/list/screens = list(hud_used.plane_masters["[FLOOR_PLANE]"], hud_used.plane_masters["[LIGHTING_PLANE]"], hud_used.plane_masters["[O_LIGHTING_VISUAL_PLANE]"],  hud_used.plane_masters["[GAME_PLANE]"])
	if(client)
		switch(start)
			if(TRUE)
				for(var/atom/whole_screen in screens)
					for(var/i in 1 to 7)
						whole_screen.add_filter("wibbly-[i]", 5, wave_filter(x = x, y = y, size = size, offset = rand()))
			else
				for(var/atom/whole_screen in screens)
					for(var/i in 1 to 7)
						filter = whole_screen.get_filter("wibbly-[i]")
						animate(filter)
						whole_screen.remove_filter("wibbly-[i]")


/mob/living/proc/rotation_screen(rotation = 0, start = TRUE)
	var/list/screens = list(hud_used.plane_masters["[FLOOR_PLANE]"], hud_used.plane_masters["[LIGHTING_PLANE]"], hud_used.plane_masters["[O_LIGHTING_VISUAL_PLANE]"],  hud_used.plane_masters["[GAME_PLANE]"])
	if(client)
		switch(start)
			if(TRUE)
				for(var/atom/negr_screen in screens)
					animate(negr_screen, transform = matrix(rotation, MATRIX_ROTATE), time = 2.0 SECONDS, easing = QUAD_EASING, loop = -1)
					animate(transform = matrix(-rotation, MATRIX_ROTATE), time = 1.0 SECONDS, easing = QUAD_EASING)
			else
				for(var/atom/negr_screen in screens)
					animate(negr_screen, transform = matrix(), time = 0.5 SECONDS, easing = QUAD_EASING)


/*
/mob/living/ghostize/(can_reenter_corpse = TRUE, aghosted = FALSE)
	. = ..()
	src.client << sound(null)

*/

/mob/living/carbon/human/proc/revert_to_cursed_form()
	set_body_sprite()
	to_chat(src, span_warning("Your cursed appearance reasserts itself!"))

/**
 *
 *
 * Перенос пендоского кода для удобства лол
 *
 * Assigns a human an alternative body sprite
 * accounting for body model. If no sprite name
 * is supplied, sets it to the default for the
 * human depending on species or clane.
 *
 * Arguments:
 * * sprite_name - Name of the sprite that'll be used as the base for this human's limbs.
 */
/mob/living/carbon/human/proc/set_body_sprite(sprite_name)
	// Cannot be used without species code as this relies on limbs_id
	CHECK_DNA_AND_SPECIES(src)

	// If no base sprite is supplied, get a default from either the species or the clane
	if (!sprite_name)
		if (clane?.alt_sprite)
			sprite_name = clane.alt_sprite
		else
			sprite_name = initial(dna.species.limbs_id)

	// Assigns a body model and an alternative sprite
	dna.species.limbs_id = base_body_mod + sprite_name

	// Update icons to reflect new body sprite
	update_body()

/**
 * Changes the body model (weight) of a human
 * between slim, normal, and fat, then updates icons
 * and limbs_id to match.
 *
 * Arguments:
 * * new_body_model - Body model the human is being given.
 */
/mob/living/carbon/human/proc/set_body_model(new_body_model = NORMAL_BODY_MODEL)
	// Remove old body model if it was found in limbs_id
	if (base_body_mod && (findtext(dna.species.limbs_id, base_body_mod) == 1))
		dna.species.limbs_id = copytext(dna.species.limbs_id, 2)

	// Add body model to limbs_id
	base_body_mod = new_body_model
	dna.species.limbs_id = base_body_mod + dna.species.limbs_id

	// Assign clothing sprites for new body model
	switch (base_body_mod)
		if (SLIM_BODY_MODEL)
			if (gender == FEMALE)
				body_sprite = 'code/modules/wod13/worn_slim_f.dmi'
			else
				body_sprite = 'code/modules/wod13/worn_slim_m.dmi'
		if (NORMAL_BODY_MODEL)
			body_sprite = null
		if (FAT_BODY_MODEL)
			body_sprite = 'code/modules/wod13/worn_fat.dmi'

	// Update icon to reflect new body model
	update_body()

