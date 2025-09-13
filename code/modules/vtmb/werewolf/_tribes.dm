/datum/garou_tribe
	var/name
	var/desc
	var/list/tribal_gifts = list()
	var/tribe_keys

/datum/garou_tribe/wendigo
	name = "Wendigo"
	desc = "Tireless trackers and peerless hunters, the galestalkers carry the namesake of the wind that crosses the tundra."
	tribal_gifts = list(
		/datum/action/gift/stoic_pose = 1,
		/datum/action/gift/freezing_wind = 2,
		/datum/action/gift/bloody_feast = 3
	)

/datum/garou_tribe/ghostcouncil
	name = "Ghost Council"
	desc = "Seekers of mystery and highly secretive, the Ghost Council is one of the most misunderstood tribes. Their ranks include guides, academics and the religious."
	tribal_gifts = list(
		/datum/action/gift/shroud = 1,
		/datum/action/gift/coils_of_the_serpent = 2,
		/datum/action/gift/banish_totem = 3
	)

/datum/garou_tribe/glasswalkers
	name = "Glass Walkers"
	desc = "The closest to the Weaver, they find themselves deeply entrenched in modern human society, religion, technology and cities. Every new invention and every new discovery is one that aids the Glass Walkers, instead of impeding them."
	tribal_gifts = list(
		/datum/action/gift/smooth_move = 1,
		/datum/action/gift/digital_feelings = 2,
		/datum/action/gift/elemental_improvement = 3
	)
	tribe_keys = /obj/item/vamp/keys/techstore

/datum/garou_tribe/bonegnawers
	name = "Bone Gnawers"
	desc = "Survivors and scavengers, often destitute and homeless. The Gnawers are seen as mongrels who live off scraps, but they know better. They're the true survivors, patiently waiting for their moment to strike against overconfident foes."
	tribal_gifts = list(
		/datum/action/gift/smooth_move = 1,
		/datum/action/gift/infest = 2,
		/datum/action/gift/gift_of_the_termite = 3
	)

/datum/garou_tribe/silverfangs
	name = "Silver Fangs"
	desc = "Commonly known as the 'Alphas' of the Garou Nation, their ranks consist of traditional rulers and wartime leaders. Known for being honorable and courage, odd mental quirks have begun plaguing their young members, the tribe beginning to suffer from diseases of the spirit and mind."
	tribal_gifts = list(
		/datum/action/gift/stoic_pose = 1,
		/datum/action/gift/freezing_wind = 2,
		/datum/action/gift/bloody_feast = 3
	)

/datum/garou_tribe/blackspiraldancers
	name = "Black Spiral Dancers"
	desc = "The lost tribe. The dreadwolves. Those who dance lockstep with the Wyrm. They who have entered the labyrinth and come back, changed.\n<b>{THIS IS AN ADVANCED TRIBE AND NOT RECOMMENDED FOR BEGINNERS. LORE KNOWLEDGE IS REQUIRED TO PLAY THIS TRIBE}</B>"
	tribal_gifts = list(
		/datum/action/gift/stinky_fur = 1,
		/datum/action/gift/venom_claws = 2,
		/datum/action/gift/burning_scars = 3
	)

/datum/garou_tribe/ronin
	name = "Ronin"
	desc = "Garou who, for one reason or another, find themselves as outcasts of the Nation."
	tribal_gifts = list(
		/datum/action/gift/stoic_pose = 1,
		/datum/action/gift/smooth_move = 2,
		/datum/action/gift/shroud = 3
	)
