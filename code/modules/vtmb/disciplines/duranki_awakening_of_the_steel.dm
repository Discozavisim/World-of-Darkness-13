/datum/discipline/duranki_awakening_of_the_steel
	name = "Du-Ran-Ki: Awakening of the Steel"
	desc = "Learn how to strengthen your blade and become the one with the sword."
	icon_state = "valeren"
	learnable_by_clans = list(/datum/vampireclane/banu_haqim_sorcerer)
	power_type = /datum/discipline_power/duranki_awakening_of_the_steel

/datum/discipline/duranki_awakening_of_the_steel/post_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_THAUMATURGY_KNOWLEDGE, DISCIPLINE_TRAIT)
	owner.mind.teach_crafting_recipe(/datum/crafting_recipe/arctome)

/datum/discipline_power/duranki_awakening_of_the_steel
	name = "Du-Ran-Ki: Awakening of the Steel power name"
	desc = "Du-Ran-Ki: Awakening of the Steel power description"

	activate_sound = 'code/modules/wod13/sounds/quietus.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED

	duration_length = 15 SECONDS
	cooldown_length = 15 SECONDS

/datum/discipline_power/duranki_awakening_of_the_steel/pre_activation_checks(atom/target)
	. = ..()
	var/success_roll
	success_roll = secret_vampireroll(get_a_willpower(owner)+get_a_occult(owner), level+3, owner)
	if(success_roll <= 0)
		to_chat(owner, span_notice("Your magic fizzles out!"))
		owner.Stun(3 SECONDS)
		owner.do_jitter_animation(10)
		return FALSE
	return TRUE

/datum/discipline_power/duranki_awakening_of_the_steel/confer_with_the_blade
	name = "Confer with the Blade"
	desc = "Speak with the weapon's Soul"
	level = 1
	var/obj/item/I_examined

/datum/discipline_power/duranki_awakening_of_the_steel/confer_with_the_blade/activate(atom/target)
	. = ..()
	I_examined = owner.get_active_held_item()
	if(!I_examined || !I_examined.force || !I_examined.sharpness)
		to_chat(owner, span_warning("You need to hold a sharp weapon in your hands!"))
		return
	to_chat(owner, span_notice("Your [I_examined.name] shudders. \nYour sword has a force of [I_examined.force] and a throwforce of [I_examined.throwforce]. It deals [I_examined.damtype] damage."))
	if(I_examined.block_chance)
		to_chat(owner, span_notice("You have [I_examined.block_chance]% chance to block attacks with this weapon."))
	if(I_examined.armour_penetration)
		to_chat(owner, span_notice("It pierces through [I_examined.armour_penetration]% of armor."))
	if(I_examined.wound_bonus)
		to_chat(owner, span_notice("The blade has a wound bonus of [I_examined.wound_bonus]."))
	if(I_examined.bare_wound_bonus)
		to_chat(owner, span_notice("It also has a bare wound bonus of [I_examined.bare_wound_bonus]."))

/datum/discipline_power/duranki_awakening_of_the_steel/grasp_of_the_mountain
	name = "Grasp of the Mountain"
	desc = "Strengthen the spiritual bond between the sword and the swordsman"
	level = 2
	duration_length = 1 SCENES
	cooldown_length = 1 SCENES
	toggled = TRUE
	cancelable = TRUE
	var/obj/item/I_held

/datum/discipline_power/duranki_awakening_of_the_steel/grasp_of_the_mountain/activate(atom/target)
	. = ..()
	I_held = owner.get_active_held_item()
	if(!I_held || !I_held.force || !I_held.sharpness)
		to_chat(owner, span_warning("You need to hold a sharp weapon in your hands!"))
		return
	if(!HAS_TRAIT(I_held, TRAIT_NODROP))
		ADD_TRAIT(I_held, TRAIT_NODROP, DISCIPLINE_TRAIT)
		to_chat(owner, span_notice("You hold on the [I_held.name] tight."))
	else
		to_chat(owner, span_warning("You're already holding [I_held.name] firmly enough!"))

/datum/discipline_power/duranki_awakening_of_the_steel/grasp_of_the_mountain/deactivate(atom/target)
	. = ..()
	if(HAS_TRAIT(I_held, TRAIT_NODROP))
		REMOVE_TRAIT(I_held, TRAIT_NODROP, DISCIPLINE_TRAIT)
		to_chat(owner, span_warning("Your grip on [I_held.name] weakens."))


/datum/discipline_power/duranki_awakening_of_the_steel/pierce_steels_skin
	name = "Pierce Steel's Skin"
	desc = "Strike at an opponent's physical protection"
	level = 3
	grouped_powers = list(
		/datum/discipline_power/duranki_awakening_of_the_steel/razors_shield,
		/datum/discipline_power/duranki_awakening_of_the_steel/strike_at_the_true_flesh
	)
	toggled = TRUE
	cancelable = TRUE

/datum/discipline_power/duranki_awakening_of_the_steel/pierce_steels_skin/activate(atom/target)
	. = ..()
	ADD_TRAIT(owner, TRAIT_ARMOR_BREAK, DISCIPLINE_TRAIT)
	to_chat(owner, span_notice("You start targeting armor!"))

/datum/discipline_power/duranki_awakening_of_the_steel/pierce_steels_skin/deactivate(atom/target)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_ARMOR_BREAK, DISCIPLINE_TRAIT)
	to_chat(owner, span_warning("You no longer target just the armor."))


/datum/discipline_power/duranki_awakening_of_the_steel/razors_shield
	name = "Razor's Shield"
	desc = "Parry ranged blows with the sword"
	level = 4
	grouped_powers = list(
		/datum/discipline_power/duranki_awakening_of_the_steel/pierce_steels_skin
	)
	toggled = TRUE
	cancelable = TRUE

/datum/discipline_power/duranki_awakening_of_the_steel/razors_shield/activate(atom/target)
	. = ..()
	ADD_TRAIT(owner, TRAIT_HANDS_BLOCK_PROJECTILES, DISCIPLINE_TRAIT)
	to_chat(owner, span_notice("Your muscles relax and start moving unintentionally. You feel perfect at projectile evasion skills..."))

/datum/discipline_power/duranki_awakening_of_the_steel/razors_shield/deactivate(atom/target)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_HANDS_BLOCK_PROJECTILES, DISCIPLINE_TRAIT)
	to_chat(owner, span_warning("Your muscles feel natural again..."))


/datum/discipline_power/duranki_awakening_of_the_steel/strike_at_the_true_flesh
	name = "Strike at the True Flesh"
	desc = "Slash through anything"
	level = 5
	grouped_powers = list(
		/datum/discipline_power/duranki_awakening_of_the_steel/pierce_steels_skin
	)

/datum/discipline_power/duranki_awakening_of_the_steel/strike_at_the_true_flesh/activate(atom/target)
	. = ..()
	ADD_TRAIT(owner, TRAIT_FORTITUDE_NEGATION, DISCIPLINE_TRAIT)
	to_chat(owner, span_notice("You feel like you're capable of shredding through magical armor."))

/datum/discipline_power/duranki_awakening_of_the_steel/strike_at_the_true_flesh/deactivate(atom/target)
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_FORTITUDE_NEGATION))
		REMOVE_TRAIT(owner, TRAIT_FORTITUDE_NEGATION, DISCIPLINE_TRAIT)
		to_chat(owner, span_warning("You can't shred through magical armor no longer."))
