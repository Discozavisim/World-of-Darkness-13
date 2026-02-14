/obj/item/vamp/keys/prince
	name = "Millenium Chief Executive Officer keys"
	accesslocks = list(
		"camarilla",
		"prince",
		"clerk",
		"milleniumCommon",
		"theatre"
	)
	color = "#70202f"

/obj/item/vamp/keys/sheriff
	name = "Millenium Security Officer keys"
	accesslocks = list(
		"camarilla",
		"prince",
		"milleniumCommon",
		"theatre"
	)
	color = "#70202f"

/obj/item/vamp/keys/clerk
	name = "Millenium Chief Operating Officer keys"
	accesslocks = list(
		"camarilla",
		"clerk",
		"milleniumCommon",
		"theatre"
	)
	color = "#70202f"

/obj/item/vamp/keys/camarilla
	name = "Millenium Tower Personnel keys"
	accesslocks = list(
		"milleniumCommon",
		"camarilla",
		"theatre"
	)
	color = "#8f2e40"

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
	color = "#68b6bd"

/obj/item/vamp/keys/cleaning
	name = "Cleaning keys"
	accesslocks = list(
		"cleaning"
	)
	color = "#6c6860"

/obj/item/vamp/keys/church
	name = "Church keys"
	accesslocks = list(
		"church"
	)
	color = "#fffb8b"

/obj/item/vamp/keys/archive
	name = "Chronicler keys"
	accesslocks = list(
		"archive",
		"theatre"
	)
	color = "#704678"


/obj/item/vamp/keys/anarch
	name = "Rebel keys"
	accesslocks = list(
		"anarch",
		"fightclub"
	)
	color = "#784234"

/obj/item/vamp/keys/bar
	name = "Barkeeper keys"
	accesslocks = list(
		"bar",
		"anarch",
		"fightclub"
	)
	color = "#784234"

/obj/item/vamp/keys/supply
	name = "Supply keys"
	accesslocks = list(
		"supply"
	)
	color = "#6c6860"

/obj/item/vamp/keys/npc
	name = "Apartment keys"
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
	color = "#263068"

/obj/item/vamp/keys/police/secure
	name = "Police Sergeant keys"
	accesslocks = list(
		"police",
		"police_secure"
	)
	color = "#263068"

/obj/item/vamp/keys/police/secure/lieutenant
	name = "Police Lieutenant keys"
	accesslocks = list(
		"police",
		"police_secure",
		"police_chief"
	)
	color = "#263068"

/obj/item/vamp/keys/strip
	name = "Strip keys"
	accesslocks = list(
		"strip"
	)

/obj/item/vamp/keys/giovanni
	name = "Bianchi Associate keys"
	accesslocks = list(
		"giovanni",
		"bianchiBank"
	)
	color = "#99FF99"

/obj/item/vamp/keys/capo
	name = "Bianchi Executive keys"
	accesslocks = list(
		"bankboss",
		"bianchiBank",
		"giovanni"
	)
	color = "#66AA66"

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
		"strip"
	)
	color = "#ffa7e6"

/obj/item/vamp/keys/toreador/primogen
	name = "Really sexy keys"
	accesslocks = list(
		"primToreador",
		"toreador",
		"strip"
	)
	color = "#ff2fc4"

/obj/item/vamp/keys/banuhaqim
	name = "Just keys"
	accesslocks = list(
		"banuhaqim"
	)
	color = "#263068"

/obj/item/vamp/keys/nosferatu
	name = "Ugly keys"
	accesslocks = list(
		"nosferatu",
		"cleaning"
	)
	color = "#93bc8e"

/obj/item/vamp/keys/nosferatu/primogen
	name = "Really ugly keys"
	accesslocks = list(
		"primNosferatu",
		"nosferatu",
		"cleaning"
	)
	color = "#367c31"

/obj/item/vamp/keys/brujah
	name = "Punk keys"
	accesslocks = list(
		"brujah",
		"fightclub"
	)
	color = "#ecb586"

/obj/item/vamp/keys/brujah/primogen
	name = "Really punk keys"
	accesslocks = list(
		"primBrujah",
		"brujah",
		"fightclub"
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

/obj/item/vamp/keys/sabbat
	name = "Blood-soaked keys"
	accesslocks = list(
		"sabbat"
	)
	color = "#6c0404"

/obj/item/vamp/keys/triads
	name = "Guilded keys"
	accesslocks = list(
		"triad",
		"laundromat"
	)
	color = "#fff468"

/obj/item/vamp/keys/pentex
	name = "Endron Personnel keys"
	accesslocks = list(
		"pentex"
	)
	color = "#337852"

/obj/item/vamp/keys/pentextop
	name = "Endron Executive keys"
	accesslocks = list(
		"pentex",
		"pentextop"
	)
	color = "#225d3c"

/obj/item/vamp/keys/children_of_gaia
	name = "Green-touched keys"
	accesslocks = list(
		"children"
	)
	color = "#578000"

/obj/item/vamp/keys/techstore
	name = "Nightwolf Associate keys"
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

