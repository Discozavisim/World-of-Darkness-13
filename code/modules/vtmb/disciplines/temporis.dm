/datum/discipline/temporis
	name = "Temporis"
	desc = "Temporis is a Discipline unique to the True Brujah. Supposedly a refinement of Celerity, Temporis grants the Cainite the ability to manipulate the flow of time itself."
	icon_state = "temporis"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/temporis

/datum/discipline_power/temporis
	name = "Temporis power name"
	desc = "Temporis power description"

	activate_sound = 'code/modules/wod13/sounds/temporis.ogg'

	var/datum/martial_art/cowalker/style = new()

/datum/discipline_power/temporis/proc/celerity_explode(datum/source, datum/discipline_power/power, atom/target)
	SIGNAL_HANDLER

	if (!istype(power, /datum/discipline_power/celerity))
		return

	to_chat(owner, "<span class='userdanger'>You try to use Celerity, but your active Temporis causes your body to wrench itself apart!</span>")
	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/living/carbon/human, gib)), 3 SECONDS)

	return POWER_CANCEL_ACTIVATION

//HOURGLASS OF THE MIND
/datum/discipline_power/temporis/hourglass_of_the_mind
	name = "Hourglass of the Mind"
	desc = "Gain a perfect sense of time. Know exactly when you are."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0

/datum/discipline_power/temporis/hourglass_of_the_mind/activate()
	. = ..()
	to_chat(owner, "<b>[SScity_time.timeofnight]</b>")

//RECURRING CONTEMPLATION
/datum/discipline_power/temporis/recurring_contemplation
	name = "Recurring Contemplation"
	desc = "Trap your target into repeating the same set of actions."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7

	hostile = TRUE

	cooldown_length = 15 SECONDS

/datum/discipline_power/temporis/recurring_contemplation/activate(mob/living/target)
	. = ..()
	target.AddComponent(/datum/component/dejavu, rewinds = 4, interval = 2 SECONDS)

/mob/living
	var/temporis_lapse = FALSE

/datum/discipline_power/temporis/lapse
	name = "Lapse"
	desc = "Halves the speed of movement of one individual through time."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7
	vitae_cost = 2

	hostile = TRUE

	multi_activate = TRUE
	duration_length = 0
	cooldown_length = 15 SECONDS

/datum/discipline_power/temporis/lapse/activate(mob/living/target)
	. = ..()
	var/roll = secret_vampireroll(get_a_stamina(owner)+get_a_intimidation(owner), get_a_willpower(target), owner)
	if(roll < 1)
		to_chat(owner, span_warning("Тебе не удалось активировать Lapse."))
		return
	if(target.temporis_lapse)
		to_chat(owner, span_warning("Цель уже под эффектом!"))
		return
	addtimer(CALLBACK(src, PROC_REF(lapse_activation), target, roll), 1 TURNS)
	to_chat(target, span_boldwarning("Мир вокруг тебя начинает ускоряться - ты ощущаешь, что всё начинается двигаться слишком быстро!"))

/datum/discipline_power/temporis/lapse/proc/lapse_activation(mob/living/target, dices)
	target.temporis_lapse = TRUE
	target.add_movespeed_modifier(/datum/movespeed_modifier/temporis)
	addtimer(CALLBACK(src, PROC_REF(lapse_deactivation), target), dices TURNS)

/datum/discipline_power/temporis/lapse/proc/lapse_deactivation(mob/living/target)
	target.temporis_lapse = FALSE
	target.remove_movespeed_modifier(/datum/movespeed_modifier/temporis)
	to_chat(target, span_boldwarning("Время возвращается в норму. Ты снова двигаешься в обычном ритме."))

/datum/movespeed_modifier/temporis
	multiplicative_slowdown = 7.5

//PATIENCE OF THE NORNS
/datum/discipline_power/temporis/patience_of_the_norns
	name = "Patience of the Norns"
	desc = "Be in multiple places at once, creating several false images."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE

	violates_masquerade = TRUE

	toggled = TRUE
	cancelable = TRUE

	duration_length = 10 SECONDS
	cooldown_length = 15 SECONDS

	grouped_powers = list(
		/datum/discipline_power/temporis/clothos_gift
	)

/datum/discipline_power/temporis/patience_of_the_norns/activate()
	. = ..()
	owner.temporis_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/temporis4)
	var/matrix/initial_matrix = matrix(owner.transform)
	var/matrix/secondary_matrix = matrix(owner.transform)
	var/matrix/tertiary_matrix = matrix(owner.transform)
	initial_matrix.Translate(1,0)
	secondary_matrix.Translate(0,1)
	tertiary_matrix.Translate(1)
	animate(owner, transform = initial_matrix, time = 1 SECONDS, loop = 0)
	animate(owner, transform = secondary_matrix, time = 1 SECONDS, loop = 0, ANIMATION_PARALLEL)
	animate(owner, transform = tertiary_matrix, time = 1 SECONDS, loop = 0, ANIMATION_PARALLEL)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(temporis_visual))
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(celerity_explode))
	style.teach(owner, make_temporary = TRUE)
	owner.next_move_modifier -= 0.6
	owner.attributes.celerity_bonus += 4

/datum/discipline_power/temporis/patience_of_the_norns/deactivate()
	. = ..()
	owner.temporis_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/temporis4)
	style.remove(owner)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	owner.next_move_modifier += 0.6
	owner.attributes.celerity_bonus -= 4


/datum/discipline_power/temporis/patience_of_the_norns/proc/temporis_visual(datum/discipline_power/temporis/source, atom/newloc, dir)
	SIGNAL_HANDLER

	spawn()
		var/obj/effect/temporis/temporis_visual = new(owner.loc)
		temporis_visual.name = owner.name
		temporis_visual.appearance = owner.appearance
		temporis_visual.dir = owner.dir
		animate(temporis_visual, pixel_x = rand(-32,32), pixel_y = rand(-32,32), alpha = 255, time = 1 SECONDS)
		if(owner.CheckEyewitness(owner, owner, 7, FALSE))
			owner.AdjustMasquerade(-1)

/obj/effect/temporis
	name = "Za Warudo"
	desc = "..."
	anchored = 1

/obj/effect/temporis/Initialize(mapload)
	. = ..()
	spawn(0.5 SECONDS)
		qdel(src)

/datum/movespeed_modifier/temporis4
	multiplicative_slowdown = -1.5

//CLOTHO'S GIFT
/datum/discipline_power/temporis/clothos_gift
	name = "Clotho's Gift"
	desc = "Accelerate yourself through time and magnify your speed."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	vitae_cost = 3

	violates_masquerade = TRUE

	toggled = TRUE
	cancelable = TRUE

	duration_length = 10 SECONDS
	cooldown_length = 15 SECONDS

	grouped_powers = list(
		/datum/discipline_power/temporis/patience_of_the_norns
	)

/datum/discipline_power/temporis/clothos_gift/activate()
	. = ..()
	owner.temporis_blur = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/temporis5)
	owner.next_move_modifier -= 0.8
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(temporis_blur))
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(celerity_explode))
	style.teach(owner, make_temporary = TRUE)
	owner.attributes.celerity_bonus += 5

/datum/discipline_power/temporis/clothos_gift/deactivate()
	. = ..()
	owner.temporis_blur = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/temporis5)
	owner.next_move_modifier += 0.8
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	style.remove(owner)
	owner.attributes.celerity_bonus -= 5

/datum/discipline_power/temporis/clothos_gift/proc/temporis_blur(datum/discipline_power/temporis/source, atom/newloc, dir)
	SIGNAL_HANDLER

	spawn()
		var/obj/effect/temporis/temporis_blur = new(owner.loc)
		temporis_blur.name = owner.name
		temporis_blur.appearance = owner.appearance
		temporis_blur.dir = owner.dir
		animate(temporis_blur, pixel_x = rand(-32,32), pixel_y = rand(-32,32), alpha = 155, time = 0.5 SECONDS)
		if(owner.CheckEyewitness(owner, owner, 7, FALSE))
			owner.AdjustMasquerade(-1)

/datum/movespeed_modifier/temporis5
	multiplicative_slowdown = -2
