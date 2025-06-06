/obj/lombard
	name = "pawnshop"
	desc = "Sell your stuff."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	icon_state = "sell"
	icon = 'code/modules/wod13/props.dmi'
	anchored = TRUE
	var/illegal = FALSE


/obj/lombard/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/stack))
		return
	if(istype(W, /obj/item/organ))
		var/obj/item/organ/O = W
		if(O.damage > round(O.maxHealth/2))
			to_chat(user, "<span class='warning'>[W] is too damaged to sell!</span>")
			return
	if(W.cost > 0)
		if(W.illegal == illegal)
			qdel(W)
			for(var/i in 1 to max(2, round((W.cost / 3) * secret_vampireroll(get_a_manipulation(user)+get_a_finance(user), 6, user))))
				new /obj/item/stack/dollar(loc)
			playsound(loc, 'code/modules/wod13/sounds/sell.ogg', 50, TRUE)
			if(istype(W, /obj/item/organ))
				var/mob/living/carbon/human/H = user
				if(H.MyPath)
					H.MyPath.trigger_morality("organtrade")
				else
					H.AdjustHumanity(-1, 2)
				//
				var/enlight = FALSE
				if(H.clane)
					if(H.clane.enlightenment)
						enlight = TRUE
				if(!enlight)
					to_chat(user, "<span class='userdanger'><b>Selling organs is a depraved act! If I keep doing this I will become a wight.</b></span>")
			else if(illegal)
				var/mob/living/carbon/human/H = user
				if(H.MyPath)
					H.MyPath.trigger_morality("drugdealing")
				else
					H.AdjustHumanity(-1, 4)
			//qdel(W)
			return
	else
		..()

/obj/lombard/blackmarket
	name = "black market"
	desc = "Sell illegal goods."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	icon_state = "sell_d"
	icon = 'code/modules/wod13/props.dmi'
	anchored = TRUE
	illegal = TRUE
