/obj/item/food/fish
	desc = "Marine life."
	icon = 'code/modules/wod13/48x32weapons.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	eatsound = 'code/modules/wod13/sounds/eat.ogg'
	tastes = list("fish" = 1)
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/protein = 3)
	foodtypes = RAW | MEAT

/obj/item/food/fish/shark
	name = "leopard shark"
	icon_state = "fish1"
	cost = 400

/obj/item/food/fish/tune
	name = "tune"
	icon_state = "fish2"
	cost = 125

/obj/item/food/fish/catfish
	name = "catfish"
	icon_state = "fish3"
	cost = 50

/obj/item/food/fish/crab
	name = "crab"
	icon_state = "fish4"
	cost = 200

/obj/item/fishing_rod
	name = "fishing rod"
	icon_state = "fishing"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_BULKY
	lefthand_file = 'code/modules/wod13/righthand.dmi'
	righthand_file = 'code/modules/wod13/lefthand.dmi'
	var/catching = FALSE
	var/fishing_speed_base = 15
	var/fishing_dificulty = 6

/obj/item/fishing_rod/attack_self(mob/user)
	. = ..()
	if(isturf(user.loc))
		forceMove(user.loc)
		onflooricon = 'code/modules/wod13/64x64.dmi'
		icon = 'code/modules/wod13/64x64.dmi'
		dir = user.dir
		anchored = TRUE

/obj/item/fishing_rod/MouseDrop(atom/over_object)
	. = ..()
	if(isturf(loc))
		if(istype(over_object, /mob/living))
			if(get_dist(src, over_object) < 2)
				if(anchored)
					anchored = FALSE
					onflooricon = initial(onflooricon)
					icon = onflooricon


/obj/item/fishing_rod/proc/catch_fish_ocean(var/diceroll)
	if(diceroll == -1)
		return /obj/item/trash/can/food
	else if(diceroll <= 2)
		return /obj/item/food/fish/tune
	else if(diceroll <= 3)
		return /obj/item/food/fish/catfish
	else if(diceroll <= 5)
		return /obj/item/food/fish/crab
	else if (diceroll >= 6)
		return /obj/item/food/fish/shark

/obj/item/fishing_rod/proc/catch_fish_sewer(var/diceroll)
	if(diceroll == -1)
		return /obj/item/trash/can/food
	else if(diceroll <= 2)
		return /mob/living/simple_animal/hostile/regalrat
	else if(diceroll <= 3)
		return /mob/living/simple_animal/pet/rat
	else if(diceroll <= 5)
		return /obj/item/clothing/under/vampire/gangrel
	else if(diceroll <= 7)
		return /obj/item/storage/pill_bottle/antibirth
	else if(diceroll <= 8)
		return /obj/item/reagent_containers/food/drinks/beer/vampire
	else if(diceroll <= 9)
		return /obj/item/food/fish/catfish
	else if(diceroll >= 10)
		return /obj/item/reagent_containers/food/drinks/meth/cocaine
	else
		return /obj/item/flashlight

/obj/item/fishing_rod/proc/calc_fishing_speed(var/diceroll)
	if(diceroll == -1)
		return fishing_speed_base + 5
	else
		return fishing_speed_base - diceroll

/obj/item/fishing_rod/proc/catch_fish(var/fishing_roll)
	if(istype(get_step(src, dir), /turf/open/floor/plating/vampocean))
		return catch_fish_ocean(fishing_roll)
	else
		return catch_fish_sewer(fishing_roll)

/obj/item/fishing_rod/attack_hand(mob/living/user)
	if(anchored)
		var/is_ocean =  istype(get_step(src, dir), /turf/open/floor/plating/vampocean)
		var/is_shit = istype(get_step(src, dir), /turf/open/floor/plating/shit)
		if(!is_ocean && !is_shit)
			return
		if(user.isfishing)
			return
		if(!catching)
			catching = TRUE
			user.isfishing = TRUE
			playsound(loc, 'code/modules/wod13/sounds/catching.ogg', 50, FALSE)
			var speed_roll = secret_vampireroll(get_a_crafts(user), fishing_dificulty, user)
			var speed = calc_fishing_speed(speed_roll)
			if(do_mob(user, src, speed SECONDS))
				catching = FALSE
				user.isfishing = FALSE
				var fishing_roll = secret_vampireroll(get_a_dexterity(user) + get_a_crafts(user), fishing_dificulty, user)
				var/catched_object = catch_fish(fishing_roll)
				new catched_object(user.loc)
				playsound(loc, 'code/modules/wod13/sounds/catched.ogg', 50, FALSE)
			else
				catching = FALSE
				user.isfishing = FALSE
		return
	..()
