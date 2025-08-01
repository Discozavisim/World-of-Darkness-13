/datum/vampireclane/tzimisce
	name = "Tzimisce"
	desc = "If someone were to call a Tzimisce inhuman and sadistic, the Tzimisce would probably commend them for their perspicacity, and then demonstrate that their mortal definition of sadism was laughably inadequate. The Tzimisce have left the human condition behind gladly, and now focus on transcending the limitations of the vampiric state. At a casual glance or a brief conversation, a Tzimisce appears to be one of the more pleasant vampires. Polite, intelligent, and inquisitive, they seem a stark contrast to the howling Sabbat mobs or even the apparently more humane Brujah or Nosferatu. However, upon closer inspection, it becomes clear that this is merely a mask hiding something alien and monstrous."
	curse = "Grounded to material domain."
//	alt_sprite = "tzi"
//	no_hair = TRUE
//	no_facial = TRUE	//FUCK WRONG RULEBOOK
	clane_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/animalism,
		/datum/discipline/vicissitude
	)
	violating_appearance = FALSE
	male_clothes = /obj/item/clothing/under/vampire/sport
	female_clothes = /obj/item/clothing/under/vampire/red
	enlightenment = TRUE
	var/obj/item/heirl
	whitelisted = TRUE
	current_accessory = "none"
	accessories = list("spines", "spines_slim", "animal_skull", "none")
	accessories_layers = list("spines" = UNICORN_LAYER, "spines_slim" = UNICORN_LAYER, "animal_skull" = UNICORN_LAYER, "none" = UNICORN_LAYER)


/obj/effect/proc_holder/spell/targeted/shapeshift/tzimisce
	name = "Tzimisce Form"
	desc = "Take on the shape a beast."
	charge_max = 10 SECONDS
	cooldown_min = 10 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/tzimisce_beast

/obj/effect/proc_holder/spell/targeted/shapeshift/bloodcrawler
	name = "Blood Crawler"
	desc = "Take on the shape a beast."
	charge_max = 5 SECONDS
	cooldown_min = 5 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/simple_animal/hostile/bloodcrawler

/datum/vampireclane/tzimisce/post_gain(mob/living/carbon/human/H)
	..()
	var/obj/item/ground_heir/heirloom = new(get_turf(H))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(heirloom, slots, FALSE)
	heirl = heirloom

/obj/effect/decal/gut_floor
	name = "gut floor"
	icon = 'code/modules/wod13/tiles.dmi'
	icon_state = "tzimisce_floor"


/datum/action/vicissitude
	name = "Vicissitude Appearance"
	desc = "Steal the appearance of your victim."
	button_icon_state = "vicissitude"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/last_hair
	var/last_facehair
	var/last_skintone
	var/last_gender
	var/last_bodytype
	var/last_haircolor
	var/last_facialhaircolor
	var/last_bodysprite
	var/last_eyecolor
	var/last_realname
	var/last_headshot
	var/last_age
	var/last_body_mode
	var/last_phonevoicetag

	var/original_hair
	var/original_facehair
	var/original_headshot
	var/original_skintone
	var/original_gender
	var/original_bodytype
	var/original_haircolor
	var/original_facialhaircolor
	var/original_bodysprite
	var/original_eyecolor
	var/original_realname
	var/original_age
	var/original_body_mode
	var/original_phonevoicetag
	var/furry_changed = FALSE

/datum/movespeed_modifier/centipede
	multiplicative_slowdown = -0.6

/mob/living/simple_animal/hostile/bloodcrawler
	var/collected_blood = 0

/mob/living/simple_animal/hostile/bloodcrawler/Move(NewLoc, direct)
	. = ..()
	var/obj/structure/vampdoor/V = locate() in NewLoc
	var/obj/machinery/door/poddoor/shutters/S = locate() in NewLoc
	if(V)
	//	if(V.lockpick_difficulty <= 10)
		if(!V.magic_lock)
			forceMove(get_turf(V))
	if(S)
		forceMove(get_turf(S))
	for(var/obj/effect/decal/cleanable/blood/B in range(1, NewLoc))
		if(B)
			if(B.bloodiness)
				collected_blood = collected_blood+1
				bloodpool = min(bloodpool+round(collected_blood/2), maxbloodpool)
				visible_message("<span class='warning'>Кровь без следа впитывается в эту массу...")
				var/turf/T = get_turf(B)
				if(T)
					T.wash(CLEAN_WASH)

/datum/action/vicissitude/Trigger()
	. = ..()
	var/mob/living/carbon/human/H = owner
//	H.put_in_r_hand(new /obj/item/chameleon(H))
	var/list/nibbers = list()
	for(var/mob/living/carbon/human/HU in oviewers(6, H))
		if(HU)
			nibbers += HU
	if(!furry_changed)
		if(last_hair)
			if(alert("Continue with last saved appearance?",,"Yes","No")=="Yes")
		//		H.switch_masquerade(H)
				original_hair = H.hairstyle
				original_facehair = H.facial_hairstyle
				original_skintone = H.skin_tone
				original_gender = H.gender
				original_bodytype = H.body_type
				original_haircolor = H.hair_color
				original_facialhaircolor = H.facial_hair_color
				original_bodysprite = H.unique_body_sprite
				original_eyecolor = H.eye_color
				original_realname = H.real_name
				original_headshot = H.headshot_link
				original_age = H.age
				original_phonevoicetag = H.phonevoicetag
				original_body_mode = H.base_body_mod
				playsound(get_turf(H), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)
				H.Stun(10)
				H.do_jitter_animation(10)
				H.hairstyle = last_hair
				H.facial_hairstyle = last_facehair
				H.skin_tone = last_skintone
				H.gender = last_gender
				H.body_type = last_bodytype
				H.hair_color = last_haircolor
				H.facial_hair_color = last_facialhaircolor
				H.unique_body_sprite = last_bodysprite
				H.eye_color = last_eyecolor
				H.real_name = last_realname
				H.headshot_link = last_headshot
				H.name = H.real_name
				H.age = last_age
				H.phonevoicetag = last_phonevoicetag
				H.base_body_mod = last_body_mode
				H.update_body()
				H.update_hair()
				H.update_body_parts()
				furry_changed = TRUE
				return
		if(length(nibbers) >= 1)
			var/victim = input(owner, "Choose victim to copy:", "Vicissitude Appearance") as null|mob in nibbers
			if(victim)
			//	H.switch_masquerade(H)
				original_hair = H.hairstyle
				original_facehair = H.facial_hairstyle
				original_skintone = H.skin_tone
				original_gender = H.gender
				original_bodytype = H.body_type
				original_haircolor = H.hair_color
				original_facialhaircolor = H.facial_hair_color
				original_bodysprite = H.unique_body_sprite
				original_eyecolor = H.eye_color
				original_realname = H.real_name
				original_headshot = H.headshot_link
				original_age = H.age
				original_phonevoicetag = H.phonevoicetag
				original_body_mode = H.base_body_mod
				playsound(get_turf(H), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)
				H.Stun(10)
				H.do_jitter_animation(10)
				var/mob/living/carbon/human/ZV = victim
				H.hairstyle = ZV.hairstyle
				H.facial_hairstyle = ZV.facial_hairstyle
				H.skin_tone = ZV.skin_tone
				H.gender = ZV.gender
				H.body_type = ZV.body_type
				H.hair_color = ZV.hair_color
				H.facial_hair_color = ZV.facial_hair_color
				H.unique_body_sprite = ZV.unique_body_sprite
				H.eye_color = ZV.eye_color
				H.real_name = ZV.real_name
				H.headshot_link = ZV.headshot_link
				H.name = H.real_name
				H.age = ZV.age
				H.phonevoicetag = ZV.phonevoicetag
				H.base_body_mod = ZV.base_body_mod
				H.update_body()
				H.update_hair()
				H.update_body_parts()
				last_hair = H.hairstyle
				last_facehair = H.facial_hairstyle
				last_skintone = H.skin_tone
				last_gender = H.gender
				last_bodytype = H.body_type
				last_haircolor = H.hair_color
				last_facialhaircolor = H.facial_hair_color
				last_bodysprite = H.unique_body_sprite
				last_eyecolor = H.eye_color
				last_realname = H.real_name
				last_headshot = H.headshot_link
				last_age = H.age
				last_phonevoicetag = H.phonevoicetag
				last_body_mode = H.base_body_mod
				furry_changed = TRUE
			else
				return
		else
			to_chat(H, "<span class='warning'>You see no soul which can be copied...</span>")
			return
		return
	else
	//	H.switch_masquerade(H)
		playsound(get_turf(H), 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE, -6)
		H.Stun(10)
		H.do_jitter_animation(10)
		H.hairstyle = original_hair
		H.facial_hairstyle = original_facehair
		H.skin_tone = original_skintone
		H.gender = original_gender
		H.body_type = original_bodytype
		H.hair_color = original_haircolor
		H.facial_hair_color = original_facialhaircolor
		H.unique_body_sprite = original_bodysprite
		if(H.additional_armor)
			H.unique_body_sprite = "tziarmor"
		H.eye_color = original_eyecolor
		H.real_name = original_realname
		H.name = H.real_name
		H.headshot_link = original_headshot
		H.age = original_age
		H.phonevoicetag = original_phonevoicetag
		H.base_body_mod = original_body_mode
		H.update_body()
		H.update_hair()
		H.update_body_parts()
		furry_changed = FALSE
		return

/obj/effect/decal/gut_floor/Initialize()
	. = ..()
	if(isopenturf(get_turf(src)))
		var/turf/open/T = get_turf(src)
		if(T)
			T.slowdown = 1

/obj/effect/decal/gut_floor/Destroy()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = initial(T.slowdown)

/datum/crafting_recipe/tzi_stool
	name = "Arm Stool"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 5, /obj/item/bodypart/r_arm = 2, /obj/item/bodypart/l_arm = 2)
	result = /obj/structure/chair/old/tzimisce
	always_available = FALSE
	category = CAT_TZIMISCE

/obj/structure/chair/old/tzimisce
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "tzimisce_stool"

/obj/item/guts
	name = "guts"
	desc = "Just blood and guts..."
	icon_state = "guts"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/spine
	name = "spine"
	desc = "If only I had control..."
	icon_state = "spine"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/mob/living/simple_animal/hostile/biter
	name = "biter"
	desc = "A ferocious, fang-bearing creature that resembles a spider."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "biter"
	icon_living = "biter"
	icon_dead = "biter_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	speed = -1
	maxHealth = 75
	health = 75

	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("gnashes")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list("Tzimisce")
	pressure_resistance = 200
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 2
	maxbloodpool = 2

/mob/living/simple_animal/hostile/biter/lasombra
	name = "shadow abomination"
	mob_biotypes = MOB_SPIRIT
	icon_state = "shadow"
	icon_living = "shadow"
	del_on_death = TRUE
	maxHealth = 100
	health = 100
	bloodpool = 0
	maxbloodpool = 0
	faction = list("Lasombra")

/mob/living/simple_animal/hostile/biter/lasombra/better
	icon_state = "shadow2"
	icon_living = "shadow2"
	maxHealth = 200
	health = 200
	melee_damage_lower = 30
	melee_damage_upper = 30

/mob/living/simple_animal/hostile/fister
	name = "fister"
	desc = "True abomination walking on both hands."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "fister"
	icon_living = "fister"
	icon_dead = "fister_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 125
	health = 125
	butcher_results = list(/obj/item/stack/human_flesh = 2)
	harm_intent_damage = 5
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	status_flags = CANPUSH
	faction = list("Tzimisce")
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 5
	maxbloodpool = 5

/mob/living/simple_animal/hostile/tanker
	name = "tanker"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "tanker"
	icon_living = "tanker"
	icon_dead = "tanker_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 350
	health = 350
	butcher_results = list(/obj/item/stack/human_flesh = 4)
	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	faction = list("Tzimisce")
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 7
	maxbloodpool = 7

/mob/living/simple_animal/hostile/gangrel
	name = "Gangrel Form"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "gangrel_f"
	icon_living = "gangrel_f"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speak_chance = 0
	speed = -1
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 40
	melee_damage_upper = 40
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dextrous = TRUE
	held_items = list(null, null)
	possible_a_intents = list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)

/mob/living/simple_animal/hostile/gangrel/better
	maxHealth = 500
	health = 500
	melee_damage_lower = 45
	melee_damage_upper = 45
	speed = -0.6

/mob/living/simple_animal/hostile/gangrel/best
	icon_state = "gangrel_m"
	icon_living = "gangrel_m"
	maxHealth = 600
	health = 600
	melee_damage_lower = 50
	melee_damage_upper = 50
	speed = -1

/mob/living/simple_animal/hostile/gargoyle
	name = "Gargoyle"
	desc = "Stone-skinned..."
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "gargoyle_m"
	icon_living = "gargoyle_m"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	speed = -1
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 45
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dextrous = TRUE
	held_items = list(null, null)
	possible_a_intents = list(INTENT_HELP, INTENT_GRAB, INTENT_DISARM, INTENT_HARM)
	faction = list("Tremere")

/mob/living/simple_animal/hostile/gargoyle/proc/gain_nigs()
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as Embraced Gargoyle?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, "<span class='ghostalert'>New Gargoyle has been made.</span>")
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		key = C.key

/mob/living/simple_animal/hostile/gargoyle/Initialize()
	. = ..()
	var/datum/action/gargoyle/G = new()
	G.Grant(src)

/datum/action/gargoyle
	name = "Turn into stone"
	desc = "Save some time till healing..."
	button_icon_state = "gargoyle"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/abuse_fix = 0

/datum/action/gargoyle/Trigger()
	. = ..()
	if(abuse_fix+100 > world.time)
		return
	abuse_fix = world.time
	var/mob/living/simple_animal/hostile/gargoyle/G = owner
	G.adjustBruteLoss(-300)
	G.adjustFireLoss(-300)
	G.Stun(50)
	G.petrify(50)

/mob/living/simple_animal/hostile/tzimisce_beast
	name = "Tzimisce Beast Form"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'code/modules/wod13/48x64.dmi'
	icon_state = "4armstzi"
	icon_living = "4armstzi"
	pixel_w = -16
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	AIStatus = AI_OFF
	speak_chance = 0
	speed = -1
	maxHealth = 575
	health = 575
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 35
	melee_damage_upper = 50
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dodging = TRUE

/mob/living/simple_animal/hostile/bloodcrawler
	name = "Tzimisce Blood Form"
	desc = "The peak of abominations. Unbelievably undamagable..."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "liquid"
	icon_living = "liquid"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	speed = 3
	maxHealth = 100
	health = 100
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 20
	maxbloodpool = 20

/mob/living/simple_animal/hostile/biter/hostile
	faction = list("hostile")

/mob/living/simple_animal/hostile/fister/hostile
	faction = list("hostile")

/mob/living/simple_animal/hostile/tanker/hostile
	faction = list("hostile")

/obj/item/ground_heir
	name = "bag of ground"
	desc = "Boghatyrskaya sila taitsa zdies'..."
	icon_state = "dirt"
	icon = 'code/modules/wod13/icons.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/stack/human_flesh
	name = "human flesh"
	desc = "What the fuck..."
	singular_name = "human flesh"
	icon_state = "human"
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	mats_per_unit = list(/datum/material/pizza = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/human_flesh
	max_amount = 50

/obj/item/stack/human_flesh/fifty
	amount = 50
/obj/item/stack/human_flesh/twenty
	amount = 20
/obj/item/stack/human_flesh/ten
	amount = 10
/obj/item/stack/human_flesh/five
	amount = 5

/obj/item/stack/human_flesh/update_icon_state()
	var/amount = get_amount()
	switch(amount)
		if(30 to INFINITY)
			icon_state = "human_3"
		if(10 to 30)
			icon_state = "human_2"
		else
			icon_state = "human"

/obj/item/extra_arm
	name = "extra arm installer"
	desc = "Distantly related to the technology of the Man-Machine Interface, this state-of-the-art syndicate device adapts your nervous and circulatory system to the presence of an extra limb..."
	icon = 'code/modules/wod13/icons.dmi'
	icon_state = "vicissitude"
	var/used = FALSE

/obj/item/extra_arm/attack_self(mob/living/carbon/M)
	if(!used)
		var/limbs = M.held_items.len
		M.change_number_of_hands(limbs+1)
		used = TRUE
		icon_state = "extra_arm_none"
		M.visible_message("<span class='notice'>[M] presses a button on [src], and you hear a disgusting noise.</span>", "<span class='notice'>You feel a sharp sting as [src] plunges into your body.</span>")
		to_chat(M, "<span class='notice'>You feel more dexterous.</span>")
		playsound(get_turf(M), 'sound/misc/splort.ogg', 50, 1)
		desc += "Looks like it's been used up."

//GiveSpeciesFlight(mob/living/carbon/human/H)
