/////// DISPENSERS //////////////

/obj/structure/delivery_dispenser/oops1
	chute_name = "OOPS Delivery Center - Garage 1"
	delivery_employer_tag = "oops"

/obj/structure/delivery_dispenser/oops2
	chute_name = "OOPS Delivery Center - Garage 2"
	delivery_employer_tag = "oops"

/obj/structure/delivery_dispenser/oops3
	chute_name = "OOPS Delivery Center - Garage 3"
	delivery_employer_tag = "oops"

/obj/structure/delivery_dispenser/oops4
	chute_name = "OOPS Delivery Center - Office 1"
	delivery_employer_tag = "oops"

/obj/structure/delivery_dispenser/oops5
	chute_name = "OOPS Delivery Center - Office 2"
	delivery_employer_tag = "oops"

/obj/structure/delivery_dispenser/oops6
	chute_name = "OOPS Delivery Center - Exterior"
	delivery_employer_tag = "oops"

//millenium

/obj/structure/delivery_dispenser/mt1
	chute_name = "Millenium Tower - Delivery Garage 1"
	delivery_employer_tag = "millenium_delivery"

/obj/structure/delivery_dispenser/mt2
	chute_name = "Millenium Tower - Delivery Garage 2"
	delivery_employer_tag = "millenium_delivery"

/obj/structure/delivery_dispenser/mt3
	chute_name = "Millenium Tower - Back Courtyard 1"
	delivery_employer_tag = "millenium_delivery"

/obj/structure/delivery_dispenser/mt4
	chute_name = "Millenium Tower - Back Courtyard 2"
	delivery_employer_tag = "millenium_delivery"

/obj/structure/delivery_dispenser/mt5
	chute_name = "Millenium Tower - Back Courtyard 3"
	delivery_employer_tag = "millenium_delivery"

/obj/structure/delivery_dispenser/mt6
	chute_name = "Millenium Tower - Delivery Garage Exterior"
	delivery_employer_tag = "millenium_delivery"

//bar

/obj/structure/delivery_dispenser/bar1
	chute_name = "Bar - Delivery Garage 1"
	delivery_employer_tag = "bar_delivery"

/obj/structure/delivery_dispenser/bar2
	chute_name = "Bar - Delivery Garage 2"
	delivery_employer_tag = "bar_delivery"

/obj/structure/delivery_dispenser/bar3
	chute_name = "Bar - Storage Room"
	delivery_employer_tag = "bar_delivery"

/obj/structure/delivery_dispenser/bar4
	chute_name = "Bar - Exterior 1"
	delivery_employer_tag = "bar_delivery"

/obj/structure/delivery_dispenser/bar5
	chute_name = "Bar - Exterior 2"
	delivery_employer_tag = "bar_delivery"

/obj/structure/delivery_dispenser/bar6
	chute_name = "Bar - Exterior 3"
	delivery_employer_tag = "bar_delivery"


////// DOORS{Lurkmore doorcode.dm} AND DELIVERY BOARDS
/obj/structure/vampdoor/glass/oops_office
	name = "OOPS delivery office"
	lock_id = "oops"
	lockpick_difficulty = 6

/obj/structure/delivery_board/oops_office
	name = "OOPS delivery assigment board"
	delivery_employer_tag = "oops"
	desc = "OOPS provides city-wide delivery services in secure containers and at low, low prices. The latter is mostly guaranteed by the fact that most of the actual transportation seems to not be done by certified truck drivers but rather is outsourced by random hires taken off the street. It is very unclear who exactly is funding this initiative or how did OOPS networks become such a popular supplier in the city. Deliveries from this board do not support any particular group."

/area/vtm/interior/delivery/oops_office
	name = "OOPS delivery office"
	delivery_employer_tag = "oops"

/area/vtm/interior/delivery_garage/oops_office
	name = "OOPS delivery office - Garage"
	delivery_employer_tag = "oops"

/obj/effect/landmark/delivery_truck_beacon/oops_office
	spawn_dir = WEST
	delivery_employer_tag = "oops"

// Camarilla variant

/obj/structure/vampdoor/glass/mt_office
	name = "Millenium Tower delivery garage"
	lock_id = "millenium_delivery"
	lockpick_difficulty = 7

/obj/structure/delivery_board/mt_office
	name = "Millenium Tower delivery assigment board"
	delivery_employer_tag = "millenium_delivery"
	desc = "The Millenium Tower Delivery Service was established once the Ventrue caught on and adopted the OOPS model for themselves and serves as a Camarilla-backed member of the delivery market. Camarilla related deliveries focus more on private matters of the cities Kindred and working for this Service will help the Camarilla secure the nightly market surplus for their own means."
	crate_types = list(
		"red" = list(
			"cargo_name" = "Industrial-Grade Cleaning Supplies",
			"color" = "#7c1313",
			"desc" = "Extremely strong cleaning supplies or base chemicals to manufacture them, in high quantities. One could easily sterilize entire rooms with the contents of these crates. Strong septic smell.",
			),
		"blue" = list(
			"cargo_name" = "Books and Correspondence",
			"color" = "#202bca",
			"desc" = "Sets of heavy tomes sealed in special containers preventing damage along with modern paperbacks and archived letters both hand and machine written.",
			),
		"yellow" = list(
			"cargo_name" = "Art Pieces",
			"color" = "#b8ac3f",
			"desc" = "Paintings, Sculptures, Pottery, Artifacts and anything else in between, sealed for safety and sometimes meant for assembly post-delivery. Also any tools required for such assembly.",
			),
		"green" = list(
			"cargo_name" = "Personal Items",
			"color" = "#165f29",
			"desc" = "Private correspondence and deliveries marked as private. It could be cargo belonging to other crates but earmarked for private delivery due to private reselling or personal use. Typically, just mail but shipped in bulk. ",
			),
		)

/area/vtm/interior/delivery_garage/mt_office
	name = "Millenium Tower delivery office - Garage"
	delivery_employer_tag = "millenium_delivery"

/obj/effect/landmark/delivery_truck_beacon/mt_office
	spawn_dir = NORTH
	delivery_employer_tag = "millenium_delivery"

//Anarchs

/obj/structure/vampdoor/glass/bar_office
	name = "Bar delivery garage"
	lock_id = "bar_delivery"
	lockpick_difficulty = 6

/obj/structure/delivery_board/bar_office
	name = "Bar delivery assigment board"
	delivery_employer_tag = "bar_delivery"
	desc = "The Bar Delivery Service is the Anarch-backed entry onto the deliver market and while initially mostly established to get on the local Camarilla representations nerves, has since grown to its own fully fledged member of the market and serves to provide much needed funds to Anarch aligned partners outside of the city."
	crate_types = list(
		"red" = list(
			"cargo_name" = "Homemade Party Favors",
			"color" = "#7c1313",
			"desc" = "The products of underground fermentation and cultivation, separated into containers appropriate for their form, fully cleared and legal for transport.",
			),
		"blue" = list(
			"cargo_name" = "Teaching Aides",
			"color" = "#202bca",
			"desc" = "Sharp or blunt tools used to discipline the unruly and reward the smart. All in their original, legal wrappings and clear for transport.",
			),
		"yellow" = list(
			"cargo_name" = "Care Package",
			"color" = "#b8ac3f",
			"desc" = "Supplies - mostly hermetically sealed food rations, assorted medical supplies as well as clothes and other basics.",
			),
		"green" = list(
			"cargo_name" = "Personal Items",
			"color" = "#165f29",
			"desc" = "Private correspondence and deliveries marked as private. It could be cargo belonging to other crates but earmarked for private delivery due to private reselling or personal use. Typically, just mail but shipped in bulk. ",
			),
		)

/area/vtm/interior/delivery_garage/bar_office
	name = "Bar delivery office - Garage"
	delivery_employer_tag = "bar_delivery"

/obj/effect/landmark/delivery_truck_beacon/bar_office
	spawn_dir = SOUTH
	delivery_employer_tag = "bar_delivery"


	///////////////////// Delivery recievers ///////////////////////

/obj/structure/delivery_reciever/store1
	chute_name = "Bubway - Ghetto"

/obj/structure/delivery_reciever/store2
	chute_name = "Veterinary Clinic - Ghetto"

/obj/structure/delivery_reciever/store3
	chute_name = "Pawn Shop - Ghetto"

/obj/structure/delivery_reciever/store4
	chute_name = "Weapon Shop - Ghetto"

/obj/structure/delivery_reciever/store5
	chute_name = "Pawn Shop - Pacific Heights"

/obj/structure/delivery_reciever/store6
	chute_name = "Gumma Guts(slot machine room) - Fisherman's Wharf"

/obj/structure/delivery_reciever/store7
	chute_name = "Seaside Arcade - Fisherman's Wharf"

/obj/structure/delivery_reciever/store8
	chute_name = "Seaside Grocery Store - Fisherman's Wharf"

/obj/structure/delivery_reciever/store9
	chute_name = "Convineance Store - Fisherman's Wharf"

/obj/structure/delivery_reciever/store10
	chute_name = "Boardwalk Store North - Fisherman's Wharf"

/obj/structure/delivery_reciever/store11
	chute_name = "Boardwalk Store South - Fisherman's Wharf"

/obj/structure/delivery_reciever/store12
	chute_name = "Big Clothing Store - Union Square"

/obj/structure/delivery_reciever/store13
	chute_name = "Small Clothing Store - Union Square"

/obj/structure/delivery_reciever/store14
	chute_name = "Weapon Store - Union Square"

/obj/structure/delivery_reciever/store15
	chute_name = "Medium Clothing Store - Union Square"

/obj/structure/delivery_reciever/store16
	chute_name = "Baco Tell Central - Union Square"

/obj/structure/delivery_reciever/store17
	chute_name = "Baco Tell South - Union Square"

/obj/structure/delivery_reciever/store18
	chute_name = "Clothing Store South - Union Square"

/obj/structure/delivery_reciever/store19
	chute_name = "Gas Station - Pacific Heights"

/obj/structure/delivery_reciever/store20
	chute_name = "Gas Station - Fisherman's Wharf"


/obj/structure/delivery_reciever/special1
	chute_name = "Casino - Chinatown"

/obj/structure/delivery_reciever/special2
	chute_name = "Laundromat - Chinatown"

/obj/structure/delivery_reciever/special3
	chute_name = "Restaurant - Chinatown"

/obj/structure/delivery_reciever/special4
	chute_name = "Hotel - Ghetto"

/obj/structure/delivery_reciever/special5
	chute_name = "Museum Rear - Ghetto"

/obj/structure/delivery_reciever/special6
	chute_name = "City Limits North"

/obj/structure/delivery_reciever/special7
	chute_name = "City Limits East"

/obj/structure/delivery_reciever/special8
	chute_name = "City Limits South"

/obj/structure/delivery_reciever/special9
	chute_name = "City Limits West"

/obj/structure/delivery_reciever/special10
	chute_name = "Church Side Entrance - Pacific Heights"

/obj/structure/delivery_reciever/special11
	chute_name = "Private/Undisclosed Enterprise - Pacific Heights"

/obj/structure/delivery_reciever/special12
	chute_name = "Forest Approach - Pacific Heights"



/////////// OBJECTS //////////////////////////

/obj/item/delivery_contract
	name = "delivery contract"
	desc = "A delivery contract issued by a delivery company. Use it in your hand to scan it for details. If your name is on the contract, use it on someone else to add them to it."
	icon = 'code/modules/wod13/onfloor.dmi'
	icon_state = "masquerade"
	color = "#bbb95c"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'

	var/datum/delivery_datum/delivery
	var/datum/delivery_manifest/manifest

/obj/item/delivery_contract/New(mob/user, obj/board,difficulty)
	delivery = new(user,board,difficulty)
	delivery.contract = src
	manifest = new(delivery)
	. = ..()

/obj/item/delivery_contract/attack(mob/living/M, mob/living/user)
	if(!delivery)
		to_chat(user,span_notice("Error: No delivery datum attached. This is most likely a bug."))
		return
	if(!manifest) return "no_manifest"
	if(M == user)
		if(delivery.check_owner(user) == 0)
			to_chat(user, span_warning("You are not listed on this manifest. Before you can use it, one of its owners needs to add you to the crew handling it by using the manifest on you."))
			return
		else
			manifest.read_data(user)
			return
	if(M.client == null)
		to_chat(user,span_notice("Error: Target mob has no client. This is not a player mob."))
		return
	if(delivery.check_owner(user) == 0)
		to_chat(user,span_warning("You are not listed on this manifest. Before you can use it, one of its owners needs to add you to the crew handling it by using the manifest on you."))
		return
	if(delivery.check_owner(user) == 1)
		if(delivery.check_owner(M) == 0)
			if(tgui_alert(user,"Do you want to add [M] to the delivery contract?","Contract add confirmation",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
				delivery.add_owner(M)
				var/obj/item/vamp/keys/cargo_truck/truck_keys = new(src)
				truck_keys.delivery = delivery
				truck_keys.owner = M
				M.put_in_hands(truck_keys)
				to_chat(user, span_notice("Success! User [M] added."))
			return
		if(delivery.check_owner(M) == 1)
			if(delivery.original_owner == M) return
			if(delivery.original_owner != user)
				to_chat(user,span_notice("Only the original owner of the contract, [delivery.original_owner] can remove people from the contract."))
				return
			else
				if(delivery.delivery_recievers.len == 0)
					to_chat(user,span_warning("This delivery is complete and should be handed in. Removing users is no longer possibe."))
					return
				if(tgui_alert(user,"Do you want to remove [M] from the delivery contract?","Contract remove confirmation",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
					delivery.contract_takers.Remove(M)
					for(var/obj/item/vamp/keys/cargo_truck/truck_keys in delivery.spawned_keys)
						if(truck_keys.owner == M)
							qdel(truck_keys)
					to_chat(user, span_notice("Success! User [M] removed."))
				return

	. = ..()

/obj/item/delivery_contract/attack_hand(mob/user)
	if(!delivery)
		to_chat(user,span_notice("Error: No delivery datum attached. This is most likely a bug."))
		return
	if(!manifest) return "no_manifest"

	if(delivery.check_owner(user) == 0)
		to_chat(user, span_warning("You are not listed on this manifest. Before you can use it, one of its owners needs to add you to the crew handling it by using the manifest on you."))
	else
		manifest.read_data(user)
	. = ..()

/obj/item/delivery_contract/Destroy()
	. = ..()
	if(delivery) qdel(delivery)
	if(manifest) qdel(manifest)


/obj/structure/delivery_board
	color = "#ffb171"
	name = "delivery assignment board"
	desc = "A board made out of cork where delivery contracts are pinned. Use it with an emtpy hand to see if any are available."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nboard02"
	anchored = 1
	density = 0
	var/delivery_started = 0
	var/delivery_employer_tag = "default"
	var/next_delivery_timestamp
	var/list/crate_types = list(
		"red" = list(
			"cargo_name" = "Cleaning Supplies",
			"color" = "#7c1313",
			"desc" = "Red tinted crates typically contain cleaning supplies, including cleaning chemicals, replacement mops, rags and personal safety equipment.",
			),
		"blue" = list(
			"cargo_name" = "Maintenance Supplies",
			"color" = "#202bca",
			"desc" = "Anything and everything related to maintaining electronics in a store or house - replacement batteries, light bulbs, electronic components as well as tools needed to replace and fix devices using them. ",
			),
		"yellow" = list(
			"cargo_name" = "Equipment and Electronics",
			"color" = "#b8ac3f",
			"desc" = "Large items like computers and other electronics, lightning and ventilation systems, AC units as well as shelving and furniture typically in separate elements and needing further assembly. Also, tools required for the assembly of the above.",
			),
		"green" = list(
			"cargo_name" = "Personal Items",
			"color" = "#165f29",
			"desc" = "Private correspondence and deliveries marked as private. It could be cargo belonging to other crates but earmarked for private delivery due to private reselling or personal use. Typically, just mail but shipped in bulk. ",
			),
		)

/obj/structure/delivery_board/proc/delivery_icon()
	icon_state = "nboard02"
	update_icon()

/obj/structure/delivery_board/proc/delivery_cooldown(timer)
	var/time_to_wait = 5 MINUTES
	if(timer) time_to_wait = timer
	addtimer(CALLBACK(src,TYPE_PROC_REF(/obj/structure/delivery_board,delivery_icon)),time_to_wait)

/obj/structure/delivery_board/attack_hand(mob/living/user)
	. = ..()
	if(!delivery_started)
		if(world.time > next_delivery_timestamp)
			if(tgui_alert(user,"A new contract is available. Do you wish to start a delivery?","Delivery available",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
				var/picked_difficulty
				var/difficulty_text
				switch(tgui_input_list(user,"Select a contract length, details will be outlined before accepting.","Contract Selection",list("Short","Medium","Long"),timeout = 10 SECONDS))
					if("Short")
						picked_difficulty = 1
						difficulty_text = "A short contract involves 3 locations with up to 6 crates each, meaning the entire delivery can be completed with one truck. The time limit is 20 minutes."
					if("Medium")
						picked_difficulty = 2
						difficulty_text = "A medium contract involves 5 locations with up to 10 crates each, the entire delivery should be completed in 3 runs. The time limit is 45 minutes. "
					if("Long")
						picked_difficulty = 3
						difficulty_text = "A long contract involves 7 locations with up to 15 crates each, meaning that without partial loads each delivery will require a restock. The timie limit is 90 minutes."
				if(tgui_alert(user,difficulty_text,"Confirm Contract",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
					var/obj/item/delivery_contract/contract = new(user,src,picked_difficulty)
					switch(contract.delivery.start_contract())
						if(1)
							user.put_in_hands(contract)
							icon_state = "nboard00"
							update_icon()
							to_chat(user,span_notice("Success! A new contract was created and aprorpiate items have been created and dispensed. Check the cotnract item for information about your delivery."))
							contract.manifest.save_data(init = TRUE)
							contract.manifest.read_data(contract.delivery.original_owner)
							delivery_started = 1
							return
						if("fail_reci")
							to_chat(user, span_warning("Not enough recievers avaialble in the game world. This is most likley because too many cotnracts are active at the same time, but is very likely a mapping bug."))
							qdel(contract)
						if("fail_garage")
							to_chat(user, span_warning("No garage area found. This is a mapping bug and should be reported."))
							qdel(contract)
						if("fail_disp")
							to_chat(user, span_warning("Not enough dispensers. This is a mapping bug and should be reported."))
							qdel(contract)
						if("fail_truck")
							to_chat(user, span_warning("Truck spawning failed. This is a mapping bug and should be reported."))
							qdel(contract)
					return
		else
			(to_chat(user,span_notice("A contract was just concluded. There are [time2text((next_delivery_timestamp - world.time),"mm:ss")] left until the next contract can be picked.")))
	else
		to_chat(user,span_notice("There are no contracts available."))

/obj/structure/delivery_board/attackby(obj/item/I, mob/living/user, params)
	if(istype(I,/obj/item/delivery_contract/))
		var/obj/item/delivery_contract/contract_item = I
		if(contract_item.delivery.delivery_employer_tag != delivery_employer_tag)
			to_chat(user,span_warning("This contract does not seem to be from this board."))
			return
		if(contract_item.delivery.check_owner(user) == 0)
			to_chat(user,span_warning("You don't seem to be on this contract. Only the person who signed the cotract can add you."))
			return
		if(contract_item.delivery.delivery_recievers.len == 0)
			if(get_area(contract_item.delivery.active_truck) != contract_item.delivery.garage_area)
				to_chat(user,span_warning("Warning: Truck outside of garage area."))
			if(tgui_alert(user,"Do you wish to finalize the contract?","Finalize Confirm",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
				contract_item.delivery.delivery_finish()
				return
		if(tgui_alert(user,"Do you wish to update the information on the contract?","Contract Update",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
			contract_item.manifest.save_data()
			return
		if(get_area(contract_item.delivery.active_truck) != contract_item.delivery.garage_area)
			to_chat(user,span_warning("Warning: Truck outside of garage area."))
		if(tgui_alert(user,"Do you wish to finalize the contract early?","Finalize Confirm",list("Yes","No"),timeout = 10 SECONDS) == "Yes")
			contract_item.delivery.delivery_finish()
			return

	if(istype(I,/obj/item/vamp/keys/cargo_truck))
		var/obj/item/vamp/keys/cargo_truck/truck_keys = I
		if(truck_keys.delivery.delivery_employer_tag != delivery_employer_tag)
			to_chat(user,span_warning("These keys dont's eem to be oes not seem to be from this board."))
			return
		if(tgui_alert(user,"Are you SURE you want to respawn the delivery truck? This will reduce your final grade.","Respawn Truck", list("Yes","No"), timeout = 10 SECONDS) == "Yes")
			var/obj/old_truck = truck_keys.delivery.active_truck
			var/obj/effect/landmark/delivery_truck_beacon/truck_beacon = truck_keys.delivery.truck_spawner
			qdel(old_truck)
			truck_beacon.spawn_truck(truck_keys.delivery)
	. = ..()


/obj/structure/delivery_reciever

	name = "delivery chute"
	desc = "A chute used to handle bulk deliveries. A standard shipping crate should slide right in."
	anchored = 1
	density = 0
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "box_put"
	var/chute_name = "default"
	var/delivery_in_use = 0
	var/reciever_in_use = 0
	var/list/delivery_status = list(
		"red" = 0,
		"blue" = 0,
		"yellow" = 0,
		"green" = 0,
		)
	light_color = "#ffffff"
	light_power = 2

/obj/structure/delivery_reciever/proc/reset_reciever()
	delivery_in_use = 0
	delivery_status = list(
		"red" = 0,
		"blue" = 0,
		"yellow" = 0,
		"green" = 0,
		)
	animate(src, alpha = 0, time = 5 SECONDS)
	mouse_opacity = 0
	set_light(0)

/obj/structure/delivery_reciever/proc/check_deliveries()
	if(delivery_status["red"] != 0 || delivery_status["blue"] != 0 || delivery_status["yellow"] != 0 || delivery_status["green"] != 0) return 0
	return 1

/obj/structure/delivery_reciever/Initialize()
	. = ..()
	alpha = 0
	mouse_opacity = 0
	GLOB.delivery_available_recievers.Add(src)
	name = "[initial(name)] - [capitalize(chute_name)]"

/obj/structure/delivery_reciever/Destroy()
	. = ..()
	GLOB.delivery_available_recievers.Remove(src)

/obj/structure/delivery_reciever/attack_hand(mob/living/user)
	. = ..()
	if(reciever_in_use == 1)
		to_chat(user, span_warning("Someone is already operating this reciever!"))
	if(user.pulling)
		if(delivery_in_use == 0) return
		if(istype(user.pulling,/obj/structure/delivery_crate/))
			var/obj/structure/delivery_crate/pulled_crate = user.pulling
			if(pulled_crate.delivery.check_owner(user) == 0)
				to_chat(user, span_warning("You aren't authorized to handle this delivery. For security reasons, the reciever denies the package."))
				return
			reciever_in_use = 1
			playsound(src,'code/modules/wod13/delevery_club/cargocrate_move.ogg',50,10)
			if(do_after(user, 2 SECONDS, src))
				if(delivery_status[pulled_crate.crate_type] > 0)
					delivery_status[pulled_crate.crate_type] -= 1
					pulled_crate.delivery.delivery_score["delivered_crates"] += 1
					if(check_deliveries() == 1)
						pulled_crate.delivery.reciever_complete(src)
						reset_reciever()
				else
					pulled_crate.delivery.delivery_score["misdelivered_crates"] += 1
				playsound(src,'code/modules/wod13/delevery_club/cargocrate_load.ogg',50,10)
				qdel(pulled_crate)
			reciever_in_use = 0

/obj/structure/delivery_dispenser

	name = "Cargo Dispenser"
	desc = "A chute used to handle bulk deliveries. There is a visible keyhole and a small button to push."
	anchored = 1
	density = 0
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "box_take"
	var/chute_name = "default"
	var/dispenser_active = 0
	var/dispenser_in_use
	var/delivery_employer_tag
	var/crate_type
	light_color = "#ffffff"
	light_power = 20

/obj/structure/delivery_dispenser/Initialize()
	. = ..()
	GLOB.delivery_available_dispensers.Add(src)
	alpha = 0
	mouse_opacity = 0
	name = "[initial(name)] - [capitalize(chute_name)]]"

/obj/structure/delivery_dispenser/Destroy()
	. = ..()
	GLOB.delivery_available_dispensers.Remove(src)

/obj/structure/delivery_dispenser/proc/reset_dispenser()
	dispenser_active = 0
	crate_type = null
	light_color = initial(light_color)
	set_light(0)
	animate(src,alpha = 0,5 SECONDS)
	mouse_opacity = 0

/obj/structure/delivery_dispenser/proc/dispense_cargo(obj/truck_key, turf/target_turf)
	if(!truck_key) return
	var/obj/item/vamp/keys/cargo_truck/key_item = truck_key
	var/obj/structure/delivery_crate/dispensed_crate = new(target_turf)
	dispensed_crate.crate_type = crate_type
	dispensed_crate.delivery = key_item.delivery
	dispensed_crate.name += " - [key_item.delivery.crate_designations["[crate_type]"]["cargo_name"]]"
	dispensed_crate.color = key_item.delivery.crate_designations["[crate_type]"]["color"]
	dispensed_crate.desc += " [key_item.delivery.crate_designations["[crate_type]"]["desc"]]"
	dispensed_crate.update_icon()
	playsound(src,'code/modules/wod13/delevery_club/cargocrate_unload.ogg',50,10)
	key_item.delivery.delivery_score["dispensed_crates"] += 1

/obj/item/delivery_contract/attack_self(mob/user)
	if(!delivery)
		to_chat(user,span_notice("Error: No delivery datum attached. This is most likely a bug."))
		return
	if(!manifest) return "no_manifest"

	if(delivery.check_owner(user) == 0)
		to_chat(user, span_warning("You are not listed on this manifest. Before you can use it, one of its owners needs to add you to the crew handling it by using the manifest on you."))
	else
		manifest.read_data(user)
	. = ..()

/obj/structure/delivery_dispenser/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(dispenser_in_use == 1)
		to_chat(user, span_warning("Someone is already using this dispenser!"))
		return
	if(istype(I,/obj/item/vamp/keys/cargo_truck))
		var/obj/item/vamp/keys/cargo_truck/truck_key = I
		if(truck_key.delivery == null)
			to_chat(user,span_warning("Error, delivery data missing. This is a bug."))
			return
		if(truck_key.delivery.delivery_dispensers.Find(src) == 0)
			to_chat(user,span_notice("They key does not seem to work in this dispenser."))
			return
		var/turf/user_turf = get_turf(user)
		for(var/obj/structure/delivery_crate/potential_crate in user_turf.contents)
			if(potential_crate)
				to_chat(user, span_warning("There is already a crate on the ground here!"))
				return
		dispenser_in_use = 1
		playsound(src,'code/modules/wod13/delevery_club/cargocrate_move.ogg',50,10)
		if(do_after(user, 2 SECONDS, src))
			dispense_cargo(truck_key,user_turf)
		dispenser_in_use = 0

/obj/structure/delivery_crate

	name = "delivery crate"
	desc = "A sealed crate, ready for transport and delivery."
	anchored = 0
	density = 1
	icon = 'icons/obj/crates.dmi'
	icon_state = "crate"
	var/datum/delivery_datum/delivery
	var/obj/structure/delivery_dispenser/source_dispenser
	var/crate_type

/obj/structure/delivery_crate/Initialize()
	if(crate_type) name = initial(name) + " - [crate_type]"
	AddElement(/datum/element/climbable)
	. = ..()

/obj/structure/delivery_crate/Destroy()
	if(delivery)
		delivery.active_crates.Remove(src)
		delivery = null
	. = ..()
						///////////////////// CARS///////////////

/obj/vampire_car/track/delivery_truck
	name = "delivery truck"
	desc = "A truck with specially prepared racks in the back allowing for easy storage and retrieval of delivery packages."
	icon_state = "track"
	max_passengers = 4
	component_type = null
	baggage_limit = 10
	baggage_max = null
	delivery_capacity = 24
//	var/datum/delivery_datum/delivery
//	var/datum/delivery_storage/delivery_trunk

/obj/vampire_car/delivery_truck/Destroy()
	if(delivery)
		if(delivery.active_truck == src) delivery.active_truck = null
		delivery = null
	qdel(delivery_trunk)
	. = ..()

/obj/effect/landmark/delivery_truck_beacon
	name = "delivery truck spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x4"
	invisibility = 101
	density = 0
	var/spawn_dir = NORTH
	var/delivery_employer_tag = "default"

/obj/effect/landmark/delivery_truck_beacon/proc/spawn_truck(datum/linked_datum)
	if(!linked_datum) return
	var/turf/local_turf = get_turf(src)
	var/obj/vampire_car/track/delivery_truck/spawned_truck = new(local_turf)
	spawned_truck.dir = spawn_dir
	switch(spawn_dir)
		if(NORTH)
			spawned_truck.movement_vector = 0
		if(SOUTH)
			spawned_truck.movement_vector = 180
		if(EAST)
			spawned_truck.movement_vector = 90
		if(WEST)
			spawned_truck.movement_vector = 270
	spawned_truck.delivery = linked_datum
	spawned_truck.delivery.active_truck = spawned_truck
	spawned_truck.locked = TRUE
	spawned_truck.access = spawned_truck.delivery.delivery_employer_tag
	var/obj/item/vamp/keys/cargo_truck/spawned_keys = new(local_turf)
	spawned_keys.delivery = linked_datum
	spawned_keys.owner = spawned_keys.delivery.original_owner
	spawned_keys.accesslocks = list(spawned_truck.delivery.delivery_employer_tag)
	spawned_truck.delivery.spawned_keys.Add(spawned_keys)
	spawned_truck.delivery.original_owner.put_in_hands(spawned_keys)

/obj/effect/landmark/delivery_truck_beacon/Initialize()
	GLOB.delivery_available_veh_spawners.Add(src)
	. = ..()

/obj/effect/landmark/delivery_truck_beacon/Destroy()
	GLOB.delivery_available_veh_spawners.Remove(src)
	. = ..()

/obj/item/vamp/keys/cargo_truck

	var/datum/delivery_datum/delivery
	var/mob/living/owner

/obj/item/vamp/keys/cargo_truck/Destroy()
	if(delivery)
		delivery.spawned_keys.Remove(src)
		delivery = null
	. = ..()
