/obj/item/vamp/keys/camarilla
	name = "Camarilla keys"
	accesslocks = list("camarilla")
	color = "#bd3327"

/obj/item/vamp/keys/prince
	name = "Prince's keys"
	accesslocks = list(
		"camarilla",
		"prince",
		"clerk",
		"archive",
		"milleniumCommon"
	)
	color = "#bd3327"

/obj/item/vamp/keys/sheriff
	name = "Sheriff's keys"
	accesslocks = list(
		"camarilla",
		"prince",
		"archive",
		"milleniumCommon"
	)
	color = "#bd3327"

/obj/item/vamp/keys/clerk
	name = "Clerk's keys"
	accesslocks = list(
		"camarilla",
		"clerk",
		"archive",
		"milleniumCommon"
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla
	name = "Millenium Tower keys"
	accesslocks = list(
		"milleniumCommon",
		"clerk",
		"camarilla"
	)

/obj/item/vamp/keys/graveyard
	name = "Graveyard keys"
	accesslocks = list(
		"graveyard"
	)

/obj/item/vamp/keys/clinic
	name = "Clinic keys"
	accesslocks = list(
		"clinic"
	)

/obj/item/vamp/keys/cleaning
	name = "Cleaning keys"
	accesslocks = list(
		"cleaning"
	)

/obj/item/vamp/keys/church
	name = "Church keys"
	accesslocks = list(
		"church"
	)

/obj/item/vamp/keys/archive
	name = "Archive keys"
	accesslocks = list(
		"archive"
	)

/obj/item/vamp/keys/anarch
	name = "Anarch keys"
	accesslocks = list(
		"anarch"
	)
	color = "#434343"

/obj/item/vamp/keys/bar
	name = "Barkeeper keys"
	accesslocks = list(
		"bar",
		"anarch",
	)
	color = "#434343"

/obj/item/vamp/keys/supply
	name = "Supply keys"
	accesslocks = list(
		"supply"
	)
	color = "#434343"

/obj/item/vamp/keys/npc
	name = "Some keys"
	accesslocks = list(
		"npc"
	)

/obj/item/vamp/keys/npc/Initialize(mapload)
	. = ..()
	accesslocks = list(
		"npc[rand(1, 20)]"
	)

/obj/item/vamp/keys/npc/fix
	roundstart_fix = TRUE

/obj/item/vamp/keys/police
	name = "Police keys"
	accesslocks = list(
		"police"
	)

/obj/item/vamp/keys/police/secure
	name = "Sergeant Police keys"
	accesslocks = list(
		"police",
		"police_secure"
	)

/obj/item/vamp/keys/police/secure/lieutenant
	name = "Lieutenant keys"
	accesslocks = list(
		"police",
		"police_secure",
		"police_chief"
	)

/obj/item/vamp/keys/strip
	name = "Strip keys"
	accesslocks = list(
		"strip"
	)

/obj/item/vamp/keys/giovanni
	name = "Mafia keys"
	accesslocks = list(
		"giovanni",
		"bianchiBank"
	)

/obj/item/vamp/keys/capo
	name = "Capo keys"
	accesslocks = list(
		"bankboss",
		"bianchiBank",
		"giovanni"
	)

/obj/item/vamp/keys/taxi
	name = "Taxi keys"
	accesslocks = list(
		"taxi"
	)
	color = "#fffb8b"

/obj/item/vamp/keys/baali
	name = "Satanic keys"
	accesslocks = list(
		"baali"
	)

/obj/item/vamp/keys/daughters
	name = "Eclectic keys"
	accesslocks = list(
		"daughters"
	)

/obj/item/vamp/keys/salubri
	name = "Conspiracy keys"
	accesslocks = list(
		"salubri"
	)

/obj/item/vamp/keys/old_clan_tzimisce
	name = "Regal keys"
	accesslocks = list(
		"old_clan_tzimisce"
	)

/obj/item/vamp/keys/malkav
	name = "Insane keys"
	accesslocks = list(
		"malkav"
	)
	color = "#8cc4ff"

/obj/item/vamp/keys/malkav/primogen
	name = "Really insane keys"
	accesslocks = list(
		"primMalkav",
		"malkav"
	)
	color = "#2c92ff"

/obj/item/vamp/keys/toreador
	name = "Sexy keys"
	accesslocks = list(
		"toreador",
		"toreador1",
		"toreador2",
		"toreador3",
		"toreador4"
	)
	color = "#ffa7e6"

/obj/item/vamp/keys/banuhaqim
	name = "Just keys"
	accesslocks = list(
		"banuhaqim"
	)
	color = "#06053d"

/obj/item/vamp/keys/toreador/primogen
	name = "Really sexy keys"
	accesslocks = list(
		"primToreador",
		"toreador"
	)
	color = "#ff2fc4"

/obj/item/vamp/keys/nosferatu
	name = "Ugly keys"
	accesslocks = list(
		"nosferatu"
	)
	color = "#93bc8e"

/obj/item/vamp/keys/nosferatu/primogen
	name = "Really ugly keys"
	accesslocks = list(
		"primNosferatu",
		"nosferatu"
	)
	color = "#367c31"

/obj/item/vamp/keys/brujah
	name = "Punk keys"
	accesslocks = list(
		"brujah"
	)
	color = "#ecb586"

/obj/item/vamp/keys/brujah/primogen
	name = "Really punk keys"
	accesslocks = list(
		"primBrujah",
		"brujah"
	)
	color = "#ec8f3e"

/obj/item/vamp/keys/ventrue
	name = "Businessy keys"
	accesslocks = list(
		"ventrue",
		"milleniumCommon"
	)
	color = "#f6ffa7"

/obj/item/vamp/keys/ventrue/primogen
	name = "Really businessy keys"
	accesslocks = list(
		"primVentrue",
		"ventrue",
		"milleniumCommon"
	)
	color = "#e8ff29"

/obj/item/vamp/keys/triads
	name = "Rusty keys"
	accesslocks = list(
		"triad",
		"laundromat"
	)

/obj/item/vamp/keys/pentex
	name = "Pentex keys"
	accesslocks = list(
		"pentex"
	)

/obj/item/vamp/keys/children_of_gaia
	name = "Ordinary keys"
	accesslocks = list(
		"children"
	)


/obj/item/vamp/keys/techstore
	name = "Tech Shop keys"
	accesslocks = list(
		"wolftech"
	)
	color = "#466a72"

/obj/item/vamp/keys/swat
	name = "BadAss keys"
	accesslocks = list(
		"swat"
	)
	color = "#161616ff"

/obj/item/vamp/keys/swat/Initialize(mapload)
	. = ..()
	if(prob(30))
		name = "MrDog's keys"

/obj/item/vamp/keys/hack
	name = "\improper lockpick"
	desc = "These can open some doors. Illegally..."
	icon_state = "hack"

