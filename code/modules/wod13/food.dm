/obj/item/food/vampire
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	eatsound = 'code/modules/wod13/sounds/eat.ogg'
	var/biten = FALSE

/obj/item/food/vampire/proc/got_biten()
	if(biten == FALSE)
		biten = TRUE
		icon_state = "[icon_state]-biten"
//----------FAST FOOD--------///
/obj/item/food/vampire/burger
	name = "burger"
	desc = "The cornerstone of every american trucker's breakfast."
	icon_state = "burger"
	bite_consumption = 3
	tastes = list("bun" = 2, "beef patty" = 4)
	foodtypes = GRAIN | MEAT
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	eat_time = 15

/obj/item/food/vampire/donut
	name = "donut"
	desc = "Goes great with robust coffee."
	icon_state = "donut1"
	bite_consumption = 5
	tastes = list("donut" = 1)
	foodtypes = JUNKFOOD | GRAIN | FRIED | SUGAR | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)

/obj/item/food/vampire/donut/Initialize(mapload)
	. = ..()
	icon_state = "donut[rand(1, 3)]"

/obj/item/food/vampire/pizza
	name = "square pizza slice"
	desc = "A nutritious slice of pizza."
	icon_state = "pizza"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT

/obj/item/food/vampire/taco
	name = "taco"
	desc = "A traditional cornshell taco with meat, cheese, and lettuce."
	icon_state = "taco"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | VEGETABLES

/obj/item/trash/vampirenugget
	name = "chicken wing bone"
	icon_state = "nugget0"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'

/obj/item/food/vampire/nugget
	name = "chicken wing"
	desc = "Big Wing for a big man."
	icon_state = "nugget1"
	trash_type = /obj/item/trash/vampirenugget
	bite_consumption = 1
	tastes = list("chicken" = 1)
	foodtypes = MEAT
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/protein = 3)
	eat_time = 15

//--------PACKAGED SNACKS-----------//

/obj/item/trash/vampirebar
	name = "chocolate bar wrapper"
	icon_state = "bar0"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'

/obj/item/food/vampire/bar
	name = "chocolate bar"
	desc = "A fast way to reduce hunger."
	icon_state = "bar2"
	food_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/nutriment = 1)
	junkiness = 5
	trash_type = /obj/item/trash/vampirebar
	tastes = list("chocolate" = 1)
	food_flags = FOOD_IN_CONTAINER
	foodtypes = JUNKFOOD | SUGAR

/obj/item/food/vampire/bar/proc/open_bar(mob/user)
	to_chat(user, "<span class='notice'>You pull back the wrapper of \the [src].</span>")
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	icon_state = "bar1"
	reagents.flags |= OPENCONTAINER

/obj/item/food/vampire/bar/attack_self(mob/user)
	if(!is_drainable())
		open_bar(user)
	return ..()

/obj/item/food/vampire/bar/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src]'s wrapper hasn't been opened!</span>")
		return FALSE
	return ..()

/obj/item/trash/vampirecrisps
	name = "chips wrapper"
	icon_state = "crisps0"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'

/obj/item/food/vampire/crisps
	name = "chips"
	desc = "\"Days\" chips... Crispy!"
	icon_state = "crisps2"
	trash_type = /obj/item/trash/vampirecrisps
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/salt = 1)
	junkiness = 10
	tastes = list("salt" = 1, "crisps" = 1)
	food_flags = FOOD_IN_CONTAINER
	foodtypes = JUNKFOOD | FRIED
	eatsound = 'code/modules/wod13/sounds/crisp.ogg'

/obj/item/food/vampire/crisps/proc/open_crisps(mob/user)
	to_chat(user, "<span class='notice'>You pull back the wrapper of \the [src].</span>")
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	icon_state = "crisps1"
	reagents.flags |= OPENCONTAINER

/obj/item/food/vampire/crisps/attack_self(mob/user)
	if(!is_drainable())
		open_crisps(user)
	return ..()

/obj/item/food/vampire/crisps/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src]'s wrapper hasn't been opened!</span>")
		return FALSE
	return ..()

/obj/item/food/vampire/icecream
	name = "ice cream"
	desc = "Taste the childhood."
	icon_state = "icecream2"
	food_reagents = list(/datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)
	tastes = list("vanilla" = 2, "ice cream" = 2)
	foodtypes = FRUIT | DAIRY | SUGAR

/obj/item/food/vampire/icecream/chocolate
	icon_state = "icecream1"
	tastes = list("chocolate" = 2, "ice cream" = 2)
	food_reagents = list(/datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)

/obj/item/food/vampire/icecream/berry
	icon_state = "icecream3"
	tastes = list("berry" = 2, "ice cream" = 2)
	food_reagents = list(/datum/reagent/consumable/berryjuice = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)

//---------DRINKS---------//

/obj/item/reagent_containers/food/drinks/coffee/vampire
	name = "coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/drinks/coffee/vampire/robust
	name = "robust coffee"
	icon_state = "coffee-alt"

/obj/item/reagent_containers/food/drinks/beer/vampire
	name = "beer"
	desc = "Beer."
	icon_state = "beer"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)
	foodtype = GRAIN | ALCOHOL
	custom_price = PAYCHECK_EASY

/obj/item/reagent_containers/food/drinks/beer/vampire/blue_stripe
	name = "blue stripe"
	desc = "Blue stripe beer, brought to you by King Breweries and Distilleries!"
	icon_state = "beer_blue"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 40, /datum/reagent/toxin/amatoxin = 10)

/obj/item/reagent_containers/food/drinks/bottle/vampirecola
	name = "two liter cola bottle"
	desc = "Coca cola espuma..."
	icon_state = "colared"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	isGlass = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	list_reagents = list(/datum/reagent/consumable/space_cola = 100)
	foodtype = SUGAR
	age_restricted = FALSE

/obj/item/reagent_containers/food/drinks/bottle/vampirecola/blue
	desc = "Pep Cola. Put some pep in your step"
	list_reagents = list(/datum/reagent/consumable/space_up = 100)
	icon_state = "colablue"

/obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw
	name = "summer thaw"
	desc = "A refreshing drink. Brought to you by King Breweries and Distilleries!"
	icon_state = "soda"
	list_reagents = list(/datum/reagent/consumable/space_cola = 75, /datum/reagent/medicine/muscle_stimulant = 15, /datum/reagent/toxin/amatoxin = 10)

/obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club
	name = "thaw club soda"
	desc = "For your energy needs. Brought to you by King Breweries and Distilleries!"
	icon_state = "soda"
	list_reagents = list(/datum/reagent/consumable/monkey_energy = 50)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/drinks/bottle/vampirewater
	name = "water bottle"
	desc = "H2O."
	icon_state = "water1"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/water = 100)
	age_restricted = FALSE

/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola
	name = "cola"
	desc = "Coca cola espuma..."
	icon_state = "colared2"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/space_cola = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue
	desc = "Pep cola. Put some Pep in your step"
	icon_state = "colablue2"
	list_reagents = list(/datum/reagent/consumable/space_up = 50)

/obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda
	name = "soda"
	desc = "More water..."
	icon_state = "soda"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/condiment/vampiremilk
	name = "milk"
	desc = "More milk..."
	icon_state = "milk"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/food/condiment/vampiremilk/malk
	desc = "a carton of fish-brand milk, a subsidary of malk incorporated."

//--------VENDING MACHINES AND CLERKS--------//

/obj/machinery/mineral/equipment_vendor/fastfood
	name = "Clerk Catalogue"
	desc = "Order some fastfood here."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "menu"
	icon_deny = "menu"
	prize_list = list()
	flags_1 = NODECONSTRUCT_1
	var/dispenses_dollars = TRUE

/obj/machinery/mineral/equipment_vendor/fastfood/sodavendor
	name = "Drink Vendor"
	desc = "Order drinks here."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "vend_r"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/mining_equipment("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	10),
		new /datum/data/mining_equipment("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda, 5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/sodavendor/blue
	icon_state = "vend_c"
	prize_list = list(new /datum/data/mining_equipment("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue,10),
		new /datum/data/mining_equipment("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue, 5),
		new /datum/data/mining_equipment("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/mining_equipment("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 7)
	)
/obj/machinery/mineral/equipment_vendor/fastfood/coffeevendor
	name = "Coffee Vendor"
	desc = "For those sleepy mornings."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "vend_g"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/mining_equipment("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	10),
		new /datum/data/mining_equipment("strong coffee", /obj/item/reagent_containers/food/drinks/coffee/vampire/robust, 5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/AltClick(mob/user)
	. = ..()
	if(points && dispenses_dollars)
		for(var/i in 1 to points)
			new /obj/item/stack/dollar(loc)
		points = 0

/obj/machinery/mineral/equipment_vendor/fastfood/snacks
	name = "Snack Vendor"
	desc = "That candy bar better not get stuck this time..."
	icon_state = "vend_b"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/mining_equipment("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/mining_equipment("chips",	/obj/item/food/vampire/crisps,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bacotell
	prize_list = list(new /datum/data/mining_equipment("taco",	/obj/item/food/vampire/taco,	10),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5),
		new /datum/data/mining_equipment("cherry cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue,	5),
		new /datum/data/mining_equipment("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 8)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bubway
	prize_list = list(new /datum/data/mining_equipment("donut",	/obj/item/storage/fancy/donut_box,	5),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	10),
		new /datum/data/mining_equipment("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	5),
		new /datum/data/mining_equipment("robust coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire/robust,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/pizza
	prize_list = list(new /datum/data/mining_equipment("five-piece chicken wing box",	/obj/item/storage/fancy/nugget_box,	5),
		new /datum/data/mining_equipment("square pizza",	/obj/item/food/vampire/pizza,	10),
		new /datum/data/mining_equipment("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	5),
		new /datum/data/mining_equipment("robust coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire/robust,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/products
	desc = "Purchase junkfood and crap."
	prize_list = list(new /datum/data/mining_equipment("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/mining_equipment("chips",	/obj/item/food/vampire/crisps,	5),
		new /datum/data/mining_equipment("water bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirewater,	3),
		new /datum/data/mining_equipment("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola, 8),
		new /datum/data/mining_equipment("two liter cherry cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola/blue, 8),
		new /datum/data/mining_equipment("milk",	/obj/item/reagent_containers/food/condiment/vampiremilk,	5),
		new /datum/data/mining_equipment("red stripe",	/obj/item/reagent_containers/food/drinks/beer/vampire,	10),
		new /datum/data/mining_equipment("blue stripe", /obj/item/reagent_containers/food/drinks/beer/vampire/blue_stripe, 8)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/clothing
	desc = "Purchase all the finest outfits.. Or don't wagie.."
	prize_list = list(new /datum/data/mining_equipment("crimson red dress",	/obj/item/clothing/under/vampire/primogen_toreador/female	,	350),
		new /datum/data/mining_equipment("black dress",	/obj/item/clothing/under/vampire/business,	250),
		new /datum/data/mining_equipment("leather pants", /obj/item/clothing/under/vampire/leatherpants,	200),
		new /datum/data/mining_equipment("fancy gray suit",	/obj/item/clothing/under/vampire/fancy_gray,	150),
		new /datum/data/mining_equipment("fancy red suit",	/obj/item/clothing/under/vampire/fancy_red,	150),
		new /datum/data/mining_equipment("black luxury suit",	/obj/item/clothing/under/vampire/ventrue,	50),
		new /datum/data/mining_equipment("black luxury suit skirt",	/obj/item/clothing/under/vampire/ventrue/female,	50),
		new /datum/data/mining_equipment("white buisness suit",	/obj/item/clothing/under/vampire/office,	50),
		new /datum/data/mining_equipment("black overcoat",	/obj/item/clothing/under/vampire/rich,	45),
		new /datum/data/mining_equipment("burgundy suit",	/obj/item/clothing/under/vampire/tremere,	35),
		new /datum/data/mining_equipment("burgundy suit skirt",	/obj/item/clothing/under/vampire/tremere/female,	35),
		new /datum/data/mining_equipment("flamboyant outfit",	/obj/item/clothing/under/vampire/toreador,	30),
		new /datum/data/mining_equipment("female flamboyant outfit",	/obj/item/clothing/under/vampire/toreador/female,	30),
		new /datum/data/mining_equipment("purple and black outfit",	/obj/item/clothing/under/vampire/sexy,	25),
		new /datum/data/mining_equipment("slick jacket",	/obj/item/clothing/under/vampire/slickback,		25),
		new /datum/data/mining_equipment("tracksuit",	/obj/item/clothing/under/vampire/sport,	25),
		new /datum/data/mining_equipment("grimey pants",	/obj/item/clothing/under/vampire/malkavian,	20),
		new /datum/data/mining_equipment("odd Goth schoolgirl attire",	/obj/item/clothing/under/vampire/malkavian/female,	20),
		new /datum/data/mining_equipment("gothic clothes",	/obj/item/clothing/under/vampire/gothic,	20),
		new /datum/data/mining_equipment("gothic attire",	/obj/item/clothing/under/vampire/brujah,	20),
		new /datum/data/mining_equipment("female punk attire ",	/obj/item/clothing/under/vampire/brujah/female,	20),
		new /datum/data/mining_equipment("punk outfit",	/obj/item/clothing/under/vampire/emo,	20),
		new /datum/data/mining_equipment("red hipster outfit",	/obj/item/clothing/under/vampire/red,	20),
		new /datum/data/mining_equipment("blue overals",	/obj/item/clothing/under/vampire/mechanic,	20),
		new /datum/data/mining_equipment("black grunge outfit",	/obj/item/clothing/under/vampire/black,	20),
		new /datum/data/mining_equipment("gimp outfit",	/obj/item/clothing/under/vampire/nosferatu,	15),
		new /datum/data/mining_equipment("female gimp outfit",	/obj/item/clothing/under/vampire/nosferatu/female,	15),
		new /datum/data/mining_equipment("rugged attire",	/obj/item/clothing/under/vampire/gangrel,	15),
		new /datum/data/mining_equipment("female rugged attire",	/obj/item/clothing/under/vampire/gangrel/female,	15),
		new /datum/data/mining_equipment("yellow sleeveless shirt",	/obj/item/clothing/under/vampire/larry,	15),
		new /datum/data/mining_equipment("white sleeveless shirt",	/obj/item/clothing/under/vampire/bandit,	15),
		new /datum/data/mining_equipment("biker outfit",	/obj/item/clothing/under/vampire/biker,	15),
		new /datum/data/mining_equipment("burlesque outfit", /obj/item/clothing/under/vampire/burlesque,	15),
		new /datum/data/mining_equipment("daisy dukes", /obj/item/clothing/under/vampire/burlesque/daisyd,	10),
		new /datum/data/mining_equipment("black shoes",	/obj/item/clothing/shoes/vampire,	10),
		new /datum/data/mining_equipment("brown shoes",	/obj/item/clothing/shoes/vampire/brown,	10),
		new /datum/data/mining_equipment("white shoes",	/obj/item/clothing/shoes/vampire/white,	10),
		new /datum/data/mining_equipment("black boots",	/obj/item/clothing/shoes/vampire/jackboots,	10),
		new /datum/data/mining_equipment("work boots",	/obj/item/clothing/shoes/vampire/jackboots/work,	10),
		new /datum/data/mining_equipment("sneakers",	/obj/item/clothing/shoes/vampire/sneakers,	10),
		new /datum/data/mining_equipment("red sneakers",	/obj/item/clothing/shoes/vampire/sneakers/red,	10),
		new /datum/data/mining_equipment("high heels",	/obj/item/clothing/shoes/vampire/heels,	35),
		new /datum/data/mining_equipment("red high heels",	/obj/item/clothing/shoes/vampire/heels/red,	35),
		new /datum/data/mining_equipment("scaly shoes",	/obj/item/clothing/shoes/vampire/businessscaly,	35),
		new /datum/data/mining_equipment("black shoes",	/obj/item/clothing/shoes/vampire/businessblack,	35),
		new /datum/data/mining_equipment("metal tip shoes",	/obj/item/clothing/shoes/vampire/businesstip,	50),
		new /datum/data/mining_equipment("purple fur coat",		/obj/item/clothing/suit/vampire/slickbackcoat,	500),
		new /datum/data/mining_equipment("too much fancy jacket",	/obj/item/clothing/suit/vampire/majima_jacket,	100),
		new /datum/data/mining_equipment("labcoat",	/obj/item/clothing/suit/vampire/labcoat,	75),
		new /datum/data/mining_equipment("fancy gray jacket",	/obj/item/clothing/suit/vampire/fancy_gray,	50),
		new /datum/data/mining_equipment("fancy red jacket",	/obj/item/clothing/suit/vampire/fancy_red,	50),
		new /datum/data/mining_equipment("black trenchcoat",	/obj/item/clothing/suit/vampire/trench,	45),
		new /datum/data/mining_equipment("brown trenchcoat",	/obj/item/clothing/suit/vampire/trench/alt,	35),
		new /datum/data/mining_equipment("brown coat",	/obj/item/clothing/suit/vampire/coat,	15),
		new /datum/data/mining_equipment("green coat",	/obj/item/clothing/suit/vampire/coat/alt,	15),
		new /datum/data/mining_equipment("jacket",	/obj/item/clothing/suit/vampire/jacket,	15),
		new /datum/data/mining_equipment("black coat",	/obj/item/clothing/suit/vampire/coat/winter,	15),
		new /datum/data/mining_equipment("red coat",	/obj/item/clothing/suit/vampire/coat/winter/alt,	15),
		new /datum/data/mining_equipment("yellow aviators",	/obj/item/clothing/glasses/vampire/yellow,	20),
		new /datum/data/mining_equipment("red aviators",	/obj/item/clothing/glasses/vampire/red,	20),
		new /datum/data/mining_equipment("sunglasses",	/obj/item/clothing/glasses/vampire/sun,	20),
		new /datum/data/mining_equipment("prescription glasses",	/obj/item/clothing/glasses/vampire/perception,	20),
		new /datum/data/mining_equipment("leather gloves", /obj/item/clothing/gloves/vampire/leather,	25),
		new /datum/data/mining_equipment("rubber gloves", /obj/item/clothing/gloves/vampire/cleaning,	15),
		new /datum/data/mining_equipment("latex gloves", /obj/item/clothing/gloves/vampire/latex,	5),
		new /datum/data/mining_equipment("black work gloves", /obj/item/clothing/gloves/vampire/work,	45),
		new /datum/data/mining_equipment("bandana",	/obj/item/clothing/head/vampire/bandana,	10),
		new /datum/data/mining_equipment("red bandana",	/obj/item/clothing/head/vampire/bandana/red,	10),
		new /datum/data/mining_equipment("black bandana",	/obj/item/clothing/head/vampire/bandana/black,	10),
		new /datum/data/mining_equipment("baseball cap", /obj/item/clothing/head/vampire/baseballcap, 10),
		new /datum/data/mining_equipment("beanie",	/obj/item/clothing/head/vampire/beanie,	10),
		new /datum/data/mining_equipment("black beanie",	/obj/item/clothing/head/vampire/beanie/black,	10),
		new /datum/data/mining_equipment("rough beanie",	/obj/item/clothing/head/vampire/beanie/homeless,	10),
		new /datum/data/mining_equipment("scarf",	/obj/item/clothing/neck/vampire/scarf,	10),
		new /datum/data/mining_equipment("red scarf",	/obj/item/clothing/neck/vampire/scarf/red,	10),
		new /datum/data/mining_equipment("blue scarf",	/obj/item/clothing/neck/vampire/scarf/blue,	10),
		new /datum/data/mining_equipment("green scarf",	/obj/item/clothing/neck/vampire/scarf/green,	10),
		new /datum/data/mining_equipment("white scarf",	/obj/item/clothing/neck/vampire/scarf/white,	10),
		new /datum/data/mining_equipment("apron",	/obj/item/clothing/suit/apron/chef,  60),
		new /datum/data/mining_equipment("white robes",	/obj/item/clothing/suit/hooded/robes,	40),
		new /datum/data/mining_equipment("black robes",	/obj/item/clothing/suit/hooded/robes/black,	40),
		new /datum/data/mining_equipment("grey robes",	/obj/item/clothing/suit/hooded/robes/grey,	40),
		new /datum/data/mining_equipment("dark red robes",	/obj/item/clothing/suit/hooded/robes/darkred,	40),
		new /datum/data/mining_equipment("yellow robes",	/obj/item/clothing/suit/hooded/robes/yellow,	40),
		new /datum/data/mining_equipment("green robes",	/obj/item/clothing/suit/hooded/robes/green,	40),
		new /datum/data/mining_equipment("red robes",	/obj/item/clothing/suit/hooded/robes/red,	40),
		new /datum/data/mining_equipment("purple robes",	/obj/item/clothing/suit/hooded/robes/purple,	40)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/costumes
	desc = "Purchase a mask for that ugly mug."
	prize_list = list(
		new /datum/data/mining_equipment("balaclava",	 /obj/item/clothing/mask/vampire/balaclava,	10),
		new /datum/data/mining_equipment("bear mask",	 /obj/item/clothing/mask/animal/rat/bear,	13),
		new /datum/data/mining_equipment("rat mask",	/obj/item/clothing/mask/animal/rat,	10),
		new /datum/data/mining_equipment("bee mask",	/obj/item/clothing/mask/animal/rat/bee,	12),
		new /datum/data/mining_equipment("fox mask",	/obj/item/clothing/mask/animal/rat/fox,	10),
		new /datum/data/mining_equipment("bat mask",	/obj/item/clothing/mask/animal/rat/bat,	15),
		new /datum/data/mining_equipment("raven mask",	/obj/item/clothing/mask/animal/rat/raven,	20),
		new /datum/data/mining_equipment("jackal mask",	 /obj/item/clothing/mask/animal/rat/jackal,	20),
		new /datum/data/mining_equipment("scarecrow mask",	/obj/item/clothing/mask/scarecrow,	10),
		new /datum/data/mining_equipment("black and gold luchador mask",	/obj/item/clothing/mask/luchador,	10),
		new /datum/data/mining_equipment("green luchador mask",	/obj/item/clothing/mask/luchador/tecnicos,	10),
		new /datum/data/mining_equipment("red and blue luchador mask",	/obj/item/clothing/mask/luchador/rudos,	10),
		new /datum/data/mining_equipment("Venetian mask",	/obj/item/clothing/mask/vampire/venetian_mask,	30),
		new /datum/data/mining_equipment("fancy Venetian mask",	/obj/item/clothing/mask/vampire/venetian_mask/fancy,	200),
		new /datum/data/mining_equipment("jester mask",	/obj/item/clothing/mask/vampire/venetian_mask/jester,	50),
		new /datum/data/mining_equipment("bloody mask",	/obj/item/clothing/mask/vampire/venetian_mask/scary,	30),
		new /datum/data/mining_equipment("comedy mask", /obj/item/clothing/mask/vampire/comedy,	25),
		new /datum/data/mining_equipment("tragedy mask", /obj/item/clothing/mask/vampire/tragedy,	25)

	)

/obj/food_cart
	name = "food cart"
	desc = "Ding-aling ding dong. Get your cholesterine!"
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "vat1"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER

/obj/food_cart/Initialize(mapload)
	. = ..()
	icon_state = "vat[rand(1, 3)]"

/obj/machinery/mineral/equipment_vendor/fastfood/america
	desc = "Tis' a deal!!!"
	prize_list = list(new /datum/data/mining_equipment("magnum revolver",	/obj/item/gun/ballistic/vampire/revolver,	200),
		new /datum/data/mining_equipment("Colt M1911",	/obj/item/gun/ballistic/automatic/vampire/m1911,	250),
		new /datum/data/mining_equipment("Glock19",	/obj/item/gun/ballistic/automatic/vampire/glock19,	500),
		new /datum/data/mining_equipment("Elite 92G",	/obj/item/gun/ballistic/automatic/vampire/beretta,	400),
		new /datum/data/mining_equipment("desert eagle",	/obj/item/gun/ballistic/automatic/vampire/deagle,	600),
		new	/datum/data/mining_equipment("5.45 ammo",	/obj/item/ammo_box/vampire/c545,	1000),
		new	/datum/data/mining_equipment(".45 ACP ammo",	/obj/item/ammo_box/vampire/c45acp,	2000),
		new /datum/data/mining_equipment("9mm ammo",	/obj/item/ammo_box/vampire/c9mm,	600),
		new /datum/data/mining_equipment(".44 ammo",	/obj/item/ammo_box/vampire/c44,	800),
		new /datum/data/mining_equipment("5.56 ammo",	/obj/item/ammo_box/vampire/c556,	2000),
		new /datum/data/mining_equipment("shotgun",		/obj/item/gun/ballistic/shotgun/vampire, 1000),
		new /datum/data/mining_equipment("12ga shotgun shells, buckshot",/obj/item/ammo_box/vampire/c12g/buck,	800),
		new /datum/data/mining_equipment("12ga shotgun shells",/obj/item/ammo_box/vampire/c12g,	800),
		new /datum/data/mining_equipment("desert eagle magazine",	/obj/item/ammo_box/magazine/m44,	100),
		new /datum/data/mining_equipment("Glock19 magazine",		/obj/item/ammo_box/magazine/glock9mm,	100),
		new /datum/data/mining_equipment("hunting rifle magazine, 5.56",	/obj/item/ammo_box/magazine/vamp556/hunt,	200),
		new /datum/data/mining_equipment("9mm pistol magazine, 18 rounds",		/obj/item/ammo_box/magazine/semi9mm,	100),
		new /datum/data/mining_equipment("Colt M1911 magazine",		/obj/item/ammo_box/magazine/vamp45acp,	50),
		new /datum/data/mining_equipment("baseball bat",	/obj/item/melee/vampirearms/baseball,	200),
		new /datum/data/mining_equipment("knife",	/obj/item/melee/vampirearms/knife,	100),
		new /datum/data/mining_equipment("switchblade",	/obj/item/melee/vampirearms/knife/switchblade, 50),
		new /datum/data/mining_equipment("brass knuckles",	/obj/item/kastet,	100),
		new /datum/data/mining_equipment("brass knuckles (spiked)",	/obj/item/kastet/spiked,	250),
		new /datum/data/mining_equipment("flashlight", /obj/item/flashlight, 50),
		new /datum/data/mining_equipment("seclite", /obj/item/flashlight/seclite, 200),
		new /datum/data/mining_equipment("gas mask",	/obj/item/clothing/mask/vampire/gasmask,	50),
		new /datum/data/mining_equipment("tactical gas mask",	/obj/item/clothing/mask/vampire/gasmask/tactical,	100),
		new /datum/data/mining_equipment("military gas mask",	/obj/item/clothing/mask/vampire/gasmask/military,	200)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/smith
	desc = "Tis' a deal!!!"
	prize_list = list(
		new /datum/data/mining_equipment("sledgehammer",	/obj/item/melee/vampirearms/sledgehammer,	1500),
		new /datum/data/mining_equipment("incendiary 5.56 ammo",	/obj/item/ammo_box/vampire/c556/incendiary,	6000),
		new /datum/data/mining_equipment("silver 9mm ammo",	/obj/item/ammo_box/vampire/c9mm/silver,	4000),
		new /datum/data/mining_equipment("silver .45 ACP ammo",	/obj/item/ammo_box/vampire/c45acp/silver,	4000),
		new /datum/data/mining_equipment("silver .44 ammo",	/obj/item/ammo_box/vampire/c44/silver,	4000),
		new /datum/data/mining_equipment("silver 5.56 ammo",	/obj/item/ammo_box/vampire/c556/silver,	6000),
		new /datum/data/mining_equipment("stake",	/obj/item/vampire_stake,	100),
		new /datum/data/mining_equipment("metal stake",	/obj/item/vampire_stake/metal,	150),
		new /datum/data/mining_equipment("longsword",	/obj/item/storage/belt/vampire/sheathe/longsword,	6000),
		new /datum/data/mining_equipment("rapier",	/obj/item/storage/belt/vampire/sheathe/rapier,	4500),
		new /datum/data/mining_equipment("sabre",	/obj/item/storage/belt/vampire/sheathe/sabre,	4500),
		new /datum/data/mining_equipment("machete", /obj/item/melee/vampirearms/machete, 400),
		new /datum/data/mining_equipment("butcher cleaver",	/obj/item/kitchen/knife/butcher,	100),
		new /datum/data/mining_equipment("beartrap",	/obj/item/restraints/legcuffs/beartrap, 500)
		)

/obj/machinery/mineral/equipment_vendor/fastfood/illegal
	desc = "Is not crime if you pay."
	prize_list = list(
		new /datum/data/mining_equipment("lockpick",	/obj/item/vamp/keys/hack, 85),
		new /datum/data/mining_equipment("DMT pill", /obj/item/reagent_containers/pill/dmt,	150),
		new /datum/data/mining_equipment("LSD pill",	/obj/item/reagent_containers/pill/lsd,	50),
		new /datum/data/mining_equipment("estrogen pill bottle",	/obj/item/storage/pill_bottle/estrogen,	50),
		new /datum/data/mining_equipment("antibirth pill bottle",/obj/item/storage/pill_bottle/antibirth, 50),
		new /datum/data/mining_equipment("phenazepam pills",	/obj/item/storage/pill_bottle/phenazepam,	200),
		new /datum/data/mining_equipment("Ultram",	/obj/item/storage/pill_bottle/tramadolum,	300),
		new /datum/data/mining_equipment("morphine",	/obj/item/reagent_containers/glass/bottle/morphine, 150),
		new /datum/data/mining_equipment("mushrooms package",	/obj/item/reagent_containers/food/drinks/meth/mushroom,	250),
		new /datum/data/mining_equipment("muhomoor package",	/obj/item/reagent_containers/food/drinks/meth/mushroom/muhomor,	220),
		new /datum/data/mining_equipment("mushrooms package",	/obj/item/reagent_containers/food/drinks/meth/mushroom/cecnya,	220),
		new	/datum/data/mining_equipment("meth package",	/obj/item/reagent_containers/food/drinks/meth,	300),
		new	/datum/data/mining_equipment("cocaine package",	/obj/item/reagent_containers/food/drinks/meth/cocaine,	550),
		new	/datum/data/mining_equipment("mephedrone",	/obj/item/reagent_containers/food/drinks/meth/mephedrone,	250),
		new /datum/data/mining_equipment("cannabis package",		/obj/item/weedpack, 200),
		new /datum/data/mining_equipment("cannabis seed",	/obj/item/weedseed,	10),
		new /datum/data/mining_equipment("bong",	/obj/item/bong, 50),
		new /datum/data/mining_equipment("silver 9mm ammo",	/obj/item/ammo_box/vampire/c9mm/silver,	3500),
		new /datum/data/mining_equipment("incendiary 5.56 ammo",	/obj/item/ammo_box/vampire/c556/incendiary,	6000),
		new /datum/data/mining_equipment("zippo lighter",	/obj/item/lighter,	20),
		new /datum/data/mining_equipment("Surgery dufflebag", /obj/item/storage/backpack/duffelbag/med/surgery, 100),
		new /datum/data/mining_equipment("lighter",		/obj/item/lighter/greyscale,	10),
		new /datum/data/mining_equipment("snub-nose revolver",	/obj/item/gun/ballistic/vampire/revolver/snub,	100),
		new /datum/data/mining_equipment("9mm ammo clip", /obj/item/ammo_box/vampire/c9mm/moonclip, 20),
		new /datum/data/mining_equipment("knife",	/obj/item/melee/vampirearms/knife,	85),
		new /datum/data/mining_equipment("switchblade",	/obj/item/melee/vampirearms/knife/switchblade, 85)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/pharmacy
	desc = "Tis' a deal!!!"
	prize_list = list(
		new /datum/data/mining_equipment("ephedrine pill bottle", /obj/item/storage/pill_bottle/ephedrine, 200),
		new /datum/data/mining_equipment("potassium iodide pill bottle", /obj/item/storage/pill_bottle/potassiodide, 100),
		new /datum/data/mining_equipment("iron pill bottle", /obj/item/storage/pill_bottle/iron, 100),
		new /datum/data/mining_equipment("dietary supplements pill bottle", /obj/item/storage/pill_bottle/probital, 200),
		new /datum/data/mining_equipment("antibirth pill bottle",/obj/item/storage/pill_bottle/antibirth, 50),
		new /datum/data/mining_equipment("activated carbon pills", /obj/item/storage/pill_bottle/multiver, 100),
		new /datum/data/mining_equipment("bruise pack", /obj/item/stack/medical/bruise_pack, 50),
		new /datum/data/mining_equipment("burn ointment", /obj/item/stack/medical/ointment, 50),
		new /datum/data/mining_equipment("latex gloves", /obj/item/clothing/gloves/vampire/latex, 150),
		new /datum/data/mining_equipment("box of syringes", /obj/item/storage/box/syringes, 300),
		new /datum/data/mining_equipment("gauze",/obj/item/stack/medical/gauze , 20),
		new /datum/data/mining_equipment("nootrop pills", /obj/item/storage/pill_bottle/nootrop, 100),
		new /datum/data/mining_equipment("medical mask",	/obj/item/clothing/mask/surgical,	10)
	)


/obj/machinery/mineral/equipment_vendor/fastfood/police
	var/last_card_use_time = 0
	dispenses_dollars = FALSE
	prize_list = list(
		new /datum/data/mining_equipment("handcuffs", /obj/item/storage/box/handcuffs, 2),
		new /datum/data/mining_equipment("evidence box", /obj/item/storage/box/evidence, 1),
		new /datum/data/mining_equipment("white crayon", /obj/item/toy/crayon/white, 1),
		new /datum/data/mining_equipment("crime scene tape", /obj/item/barrier_tape/police, 1),
		new /datum/data/mining_equipment("police vest", /obj/item/clothing/suit/vampire/vest/police, 1),
		new /datum/data/mining_equipment("police uniform", /obj/item/clothing/under/vampire/police, 1),
		new /datum/data/mining_equipment("police hat", /obj/item/clothing/head/vampire/police, 1),
		new /datum/data/mining_equipment("magnifier", /obj/item/detective_scanner, 3)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/smoking
	desc = "Tis' a deal!!!"
	prize_list = list(new /datum/data/mining_equipment("malboro",	/obj/item/storage/fancy/cigarettes/cigpack_robust,	50),
		new /datum/data/mining_equipment("newport",		/obj/item/storage/fancy/cigarettes/cigpack_xeno,	30),
		new /datum/data/mining_equipment("camel",	/obj/item/storage/fancy/cigarettes/dromedaryco,	30),
		new /datum/data/mining_equipment("lighter",		/obj/item/lighter/greyscale,	10),
	)

/obj/machinery/mineral/equipment_vendor/fastfood/gas
	desc = "Tis' a deal!!!"
	prize_list = list(new /datum/data/mining_equipment("full gas can",	/obj/item/gas_can/full,	250),
		new /datum/data/mining_equipment("tire iron", /obj/item/melee/vampirearms/tire,	50)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/library
	desc = "Tis' a deal!!!"
	prize_list = list(
		new /datum/data/mining_equipment("candle pack",	/obj/item/storage/fancy/candle_box,	50),
		new /datum/data/mining_equipment("black pen",	/obj/item/pen,  5),
		new /datum/data/mining_equipment("four-color pen",	/obj/item/pen/fourcolor,  10),
		new /datum/data/mining_equipment("fountain pen",	/obj/item/pen/fountain,  15),
		new /datum/data/mining_equipment("paper", /obj/item/paper_bin,  25),
		new /datum/data/mining_equipment("spraycan", /obj/item/toy/crayon/spraycan,  100),
		new /datum/data/mining_equipment("23x23 canvas", /obj/item/canvas/twentythree_twentythree,  100),
		new /datum/data/mining_equipment("23x19 canvas", /obj/item/canvas/twentythree_nineteen,  100),
		new /datum/data/mining_equipment("19x19 canvas", /obj/item/canvas/nineteen_nineteen,  100)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/tech
	desc = "Tis' a deal!!!"
	prize_list = list(
		new /datum/data/mining_equipment("clock",	/obj/item/cockclock, 50),
		new /datum/data/mining_equipment("phone",	/obj/item/vamp/phone, 200),
		new /datum/data/mining_equipment("camera",	/obj/item/camera, 300),
		new /datum/data/mining_equipment("camera film",	/obj/item/camera_film, 50),
		new /datum/data/mining_equipment("headphones",	/obj/item/instrument/piano_synth/headphones, 100),
		new /datum/data/mining_equipment("radio headset",	/obj/item/p25radio, 500),
		new /datum/data/mining_equipment("city bounced radio", /obj/item/radio, 250),
		new /datum/data/mining_equipment("tape recorder", /obj/item/taperecorder, 100),
		new /datum/data/mining_equipment("tape", /obj/item/tape, 50),
		new /datum/data/mining_equipment("wirecutters", /obj/item/wire_cutters, 200),
		new /datum/data/mining_equipment("phone book", /obj/item/phone_book, 200)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/flowershop
	desc = "Tis' a deal!!!"
	prize_list = list(
		new /datum/data/mining_equipment("Respirator",	/obj/item/clothing/mask/vampire,	50),
		new /datum/data/mining_equipment("Basic Fertilizer",	/obj/item/reagent_containers/glass/bottle/nutrient/ez,	100),
		new /datum/data/mining_equipment("Spade", /obj/item/shovel/spade,	100),
		new /datum/data/mining_equipment("Secateurs",	 /obj/item/secateurs,	100),
		new /datum/data/mining_equipment("Cultivator",	/obj/item/cultivator,	100),
		new /datum/data/mining_equipment("Poppy seeds", /obj/item/seeds/poppy, 25),
		new /datum/data/mining_equipment("Sunflower seeds", /obj/item/seeds/sunflower, 25),
		new /datum/data/mining_equipment("Geranium seeds", /obj/item/seeds/poppy/geranium, 25),
		new /datum/data/mining_equipment("Harebell seeds", /obj/item/seeds/harebell, 25),
		new /datum/data/mining_equipment("Lily seeds", /obj/item/seeds/poppy/lily, 25),
		new /datum/data/mining_equipment("Forget me not seeds", /obj/item/seeds/forgetmenot, 25),
		new /datum/data/mining_equipment("Aloe seeds", /obj/item/seeds/aloe, 25),
		new /datum/data/mining_equipment("Cabbage seeds", /obj/item/seeds/cabbage, 25),
		new /datum/data/mining_equipment("Carrot seeds", /obj/item/seeds/carrot, 25),
		new /datum/data/mining_equipment("Parsnip seeds", /obj/item/seeds/carrot/parsnip, 25),
		new /datum/data/mining_equipment("Corn seeds", /obj/item/seeds/corn, 25),
		new /datum/data/mining_equipment("Onion seeds", /obj/item/seeds/onion, 25),
		new /datum/data/mining_equipment("Garlic seeds", /obj/item/seeds/garlic, 25),
		new /datum/data/mining_equipment("Peas seeds", /obj/item/seeds/peas, 25),
		new /datum/data/mining_equipment("Potato seeds", /obj/item/seeds/potato, 25),
		new /datum/data/mining_equipment("Sweet potato seeds", /obj/item/seeds/potato/sweet, 25),
		new /datum/data/mining_equipment("Pumpkin seeds", /obj/item/seeds/pumpkin, 25),
		new /datum/data/mining_equipment("Soy seeds", /obj/item/seeds/soya, 25),
		new /datum/data/mining_equipment("Tomato seeds", /obj/item/seeds/tomato, 25),
		new /datum/data/mining_equipment("Red beetseeds", /obj/item/seeds/redbeet, 25),
		new /datum/data/mining_equipment("White beet seeds", /obj/item/seeds/whitebeet, 25),
		new /datum/data/mining_equipment("Chili seeds", /obj/item/seeds/chili, 25),
		new /datum/data/mining_equipment("bailer",	/obj/item/bailer, 20)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/dishes
	desc = "Tis' a deal!!!"
	prize_list = list(new /datum/data/mining_equipment("bowl",	/obj/item/reagent_containers/glass/bowl,	5),
		new /datum/data/mining_equipment("wine glass",	/obj/item/reagent_containers/food/drinks/drinkingglass/wine_glass,	10),
		new /datum/data/mining_equipment("pint glass",	/obj/item/reagent_containers/food/drinks/drinkingglass/pint,	10),
		new /datum/data/mining_equipment("whiskey glass",	/obj/item/reagent_containers/food/drinks/drinkingglass/whiskey_shot,	10),
		new /datum/data/mining_equipment("martini glass",	/obj/item/reagent_containers/food/drinks/drinkingglass/martini_glass,	10),
		new /datum/data/mining_equipment("shot glass",	/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass,	10),
		new /datum/data/mining_equipment("tray",	/obj/item/storage/bag/tray,	20),
		new /datum/data/mining_equipment("rolling pin",	/obj/item/kitchen/rollingpin,	20),
		new /datum/data/mining_equipment("knife",	/obj/item/kitchen/knife,	100),
		new /datum/data/mining_equipment("small bottle",	/obj/item/reagent_containers/food/drinks/bottle/small,	20),
		new /datum/data/mining_equipment("bottle", /obj/item/reagent_containers/food/drinks/bottle, 30),
		new /datum/data/mining_equipment("canned beans",	/obj/item/food/canned/beans,	25),
		new /datum/data/mining_equipment("canned peaches",	/obj/item/food/canned/peaches,	25),
		new /datum/data/mining_equipment("peppermill",	/obj/item/reagent_containers/food/condiment/peppermill, 30),
		new /datum/data/mining_equipment("salt shaker",	/obj/item/reagent_containers/food/condiment/saltshaker,	30),
		new /datum/data/mining_equipment("bucket",	/obj/item/reagent_containers/glass/bucket,	50),
		new /datum/data/mining_equipment("mop",	/obj/item/mop,	30),
		new /datum/data/mining_equipment("fishing rod",		/obj/item/fishing_rod,	200)
	)
