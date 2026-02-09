////////////////////////// GERERAL || ОСНОВНОЕ/////////////////////////

/datum/gear/general
	subtype_path = /datum/gear/general
	sort_category = "General"
	cost = 1

// Dices

/datum/gear/general/dice_bag
	display_name = "bag of dices"
	path = /obj/item/storage/pill_bottle/dice
	cost = 1

/datum/gear/general/d20
	display_name = "d20"
	path = /obj/item/dice/d20
	cost = 0

// Lipsticks

/datum/gear/general/lipstick_black
	display_name = "lipstick, black"
	path = /obj/item/lipstick/black

/datum/gear/general/lipstick_red
	display_name = "lipstick, red"
	path = /obj/item/lipstick

// Lighters

/datum/gear/general/cheap_lighter
	display_name = "lighter, cheap"
	path = /obj/item/lighter/greyscale
	cost = 0

/datum/gear/general/zippo_lighter
	display_name = "lighter, zippo"
	path = /obj/item/lighter
	cost = 2

// Pens

/datum/gear/general/pen
	display_name = "pen, regular"
	path = /obj/item/pen
	cost = 0

/datum/gear/general/pen_fourcolor
	display_name = "pen, four color"
	path = /obj/item/pen/fourcolor
	cost = 0

/datum/gear/general/pen_fountain
	display_name = "pen, fountain"
	path = /obj/item/pen/fountain
	cost = 1

// Cards

/datum/gear/general/card_playing
	display_name = "deck of cards, playing"
	path = /obj/item/toy/cards/deck

/datum/gear/general/card_tarot
	display_name = "deck of cards, tarot"
	description = "A deck of tarot cards."
	path = /obj/item/toy/cards/deck/tarot

/datum/gear/general/card_kotahi
	display_name = "deck of cards, kotahi"
	description = "A deck of kotahi cards."
	path = /obj/item/toy/cards/deck/kotahi

// Misc

/datum/gear/general/spray_can
	display_name = "spray can"
	path = /obj/item/toy/crayon/spraycan

///////////////////////////// EYEWEAR || ОЧКИ////////////////////////

/datum/gear/eyewear
	subtype_path = /datum/gear/eyewear
	slot = ITEM_SLOT_EYES
	sort_category = "Eyewear"
	cost = 1

/datum/gear/eyewear/yellow_aviator
	display_name = "aviator, yellow"
	path = /obj/item/clothing/glasses/vampire/yellow

/datum/gear/eyewear/red_aviator
	display_name = "aviator, red"
	path = /obj/item/clothing/glasses/vampire/red

/datum/gear/eyewear/sunglasses
	display_name = "sunglasses"
	path = /obj/item/clothing/glasses/vampire/sun

//Prescription glasses
/datum/gear/eyewear/glasses
	display_name = "glasses, prescription"
	path = /obj/item/clothing/glasses/vampire/perception
	cost = 1


//////////////////////////////// FOOTWEAR || ОБУВЬ ////////////////////////////////

/datum/gear/footwear
	subtype_path = /datum/gear/footwear
	slot = ITEM_SLOT_FEET
	sort_category = "Footwear"
	cost = 1

// Regular shoes
/datum/gear/footwear/shoes
	subtype_path = /datum/gear/footwear/shoes

/datum/gear/footwear/shoes/black
	display_name = "shoes, black"
	path = /obj/item/clothing/shoes/vampire

/datum/gear/footwear/shoes/black_fancy
	display_name = "shoes, fancy black"
	path = /obj/item/clothing/shoes/vampire/businessblack

/datum/gear/footwear/shoes/brown
	display_name = "shoes, brown"
	path = /obj/item/clothing/shoes/vampire/brown

/datum/gear/footwear/shoes/white
	display_name = "shoes, white"
	path = /obj/item/clothing/shoes/vampire/white

/datum/gear/footwear/shoes/scaly
	display_name = "shoes, scaly"
	path = /obj/item/clothing/shoes/vampire/businessscaly

/datum/gear/footwear/shoes/metal_tip
	display_name = "shoes, metal tip"
	path = /obj/item/clothing/shoes/vampire/businesstip

// Sneakers
/datum/gear/footwear/sneakers
	subtype_path = /datum/gear/footwear/sneakers

/datum/gear/footwear/sneakers/white
	display_name = "sneakers, white"
	path = /obj/item/clothing/shoes/vampire/sneakers

/datum/gear/footwear/sneakers/red
	display_name = "sneakers, red"
	path = /obj/item/clothing/shoes/vampire/sneakers/red

// Misc

/datum/gear/footwear/jackboots
	display_name = "boots, black"
	path = /obj/item/clothing/shoes/vampire/jackboots

/datum/gear/footwear/jackboots_work
	display_name = "boots, work"
	path = /obj/item/clothing/shoes/vampire/jackboots/work

/datum/gear/footwear/high_heels_black
	display_name = "high heels, black"
	path = /obj/item/clothing/shoes/vampire/heels

/datum/gear/footwear/high_heels_red
	display_name = "high heels, red"
	path = /obj/item/clothing/shoes/vampire/heels/red

//////////////////////////////// GLOVES || ПЕРЧАТКИ ////////////////////////////////

/datum/gear/gloves
	subtype_path = /datum/gear/gloves
	slot = ITEM_SLOT_GLOVES
	sort_category = "Accessories"
	cost = 1

/datum/gear/gloves/leather
	display_name = "gloves, leather"
	path = /obj/item/clothing/gloves/vampire/leather

/datum/gear/gloves/rubber
	display_name = "gloves, rubber"
	path = /obj/item/clothing/gloves/vampire/cleaning

/datum/gear/gloves/latex
	display_name = "gloves, latex"
	path = /obj/item/clothing/gloves/vampire/latex

/datum/gear/gloves/black
	display_name = "gloves, black"
	path = /obj/item/clothing/gloves/vampire/work

//////////////////////////////// HATS || ШЛЯПЫ ////////////////////////////////

/datum/gear/hat
	subtype_path = /datum/gear/hat
	slot = ITEM_SLOT_HEAD
	sort_category = "Headwear"
	cost = 1

/datum/gear/hat/svadba
	subtype_path = /datum/gear/hat/svadba
	display_name = "wedding veil"
	path = /obj/item/clothing/head/weddingveil

// Bandana
/datum/gear/hat/bandana
	subtype_path = /datum/gear/hat/bandana

/datum/gear/hat/bandana/brown
	display_name = "bandana, brown"
	path = /obj/item/clothing/head/vampire/bandana

/datum/gear/hat/bandana/red
	display_name = "bandana, red"
	path = /obj/item/clothing/head/vampire/bandana/red

/datum/gear/hat/bandana/black
	display_name = "bandana, black"
	path = /obj/item/clothing/head/vampire/bandana/black

// Beret
/datum/gear/hat/beret
	subtype_path = /datum/gear/hat/beret

/datum/gear/hat/beret/red
	display_name = "beret, red"
	description = "A stylish beret." // Consistency.
	path = /obj/item/clothing/head/beret

/datum/gear/hat/beret/black
	display_name = "beret, black"
	description = "A stylish beret." // Consistency.
	path = /obj/item/clothing/head/beret/black

// Beanie
/datum/gear/hat/beanie
	subtype_path = /datum/gear/hat/beanie

/datum/gear/hat/beanie/white
	display_name = "beanie, white"
	path = /obj/item/clothing/head/vampire/beanie

/datum/gear/hat/beanie/black
	display_name = "beanie, black"
	path = /obj/item/clothing/head/vampire/beanie/black

/datum/gear/hat/beanie/homeless
	display_name = "beanie, rough"
	path = /obj/item/clothing/head/vampire/beanie/homeless

// Misc
/datum/gear/hat/baseball_cap
	display_name = "baseball cap"
	description = "A soft hat with a rounded crown and a stiff bill projecting in front." // Shortened
	path = /obj/item/clothing/head/vampire/baseballcap

/datum/gear/hat/ushanka
	display_name = "ushanka"
	path = /obj/item/clothing/head/vampire/ushanka

/datum/gear/hat/hijab
	display_name = "hijab"
	path = /obj/item/clothing/head/vampire/hijab

/datum/gear/hat/taqiyah
	display_name = "taqiyah"
	path = /obj/item/clothing/head/vampire/taqiyah

/datum/gear/hat/kalimavkion
	display_name = "kalimavkion"
	path = /obj/item/clothing/head/vampire/kalimavkion

/datum/gear/hat/habit
	display_name = "habit"
	path = /obj/item/clothing/head/vampire/nun

/datum/gear/hat/ushanka_modern
	display_name = "modern ushanka"
	path = /obj/item/clothing/head/uzanka/blue

/datum/gear/hat/ushanka_red
	display_name = "red ushanka"
	path = /obj/item/clothing/head/uzanka/red

/datum/gear/hat/ushanka_soviet
	display_name = "soviet ushanka"
	path = /obj/item/clothing/head/uzanka

/datum/gear/hat/worker_helmet
	display_name = "Yellow working helmet"
	path = /obj/item/clothing/head/kaska

/datum/gear/hat/pro_helmet
	display_name = "Orange working helmet"
	path = /obj/item/clothing/head/kaska/pro

/datum/gear/hat/prorab_helmet
	display_name = "White working helmet"
	path = /obj/item/clothing/head/kaska/prorab

//////////////////////////////// NECK || ШЕЯ ////////////////////////////////

/datum/gear/neck
	subtype_path = /datum/gear/neck
	slot = ITEM_SLOT_NECK
	sort_category = "Accessories"
	cost = 1

// Scarf
/datum/gear/neck/scarf
	subtype_path = /datum/gear/neck/scarf

/datum/gear/neck/scarf/black
	display_name = "scarf, black"
	path = /obj/item/clothing/neck/vampire/scarf

/datum/gear/neck/scarf/red
	display_name = "scarf, red"
	path = /obj/item/clothing/neck/vampire/scarf/red

/datum/gear/neck/scarf/blue
	display_name = "scarf, blue"
	path = /obj/item/clothing/neck/vampire/scarf/blue

/datum/gear/neck/scarf/green
	display_name = "scarf, green"
	path = /obj/item/clothing/neck/vampire/scarf/green

/datum/gear/neck/scarf/white
	display_name = "scarf, white"
	path = /obj/item/clothing/neck/vampire/scarf/white

// Tie
/datum/gear/neck/tie
	subtype_path = /datum/gear/neck/tie

/datum/gear/neck/tie/black
	display_name = "tie, black"
	path = /obj/item/clothing/neck/tie/black

/datum/gear/neck/tie/red
	display_name = "tie, red"
	path = /obj/item/clothing/neck/tie/red

/datum/gear/neck/tie/blue
	display_name = "tie, blue"
	path = /obj/item/clothing/neck/tie/blue

/datum/gear/neck/tie/btie
	display_name = "bow tie, red"
	path = /obj/item/clothing/neck/vampire/btie

/datum/gear/neck/tie/jabo
	display_name = "jabo, black"
	path = /obj/item/clothing/neck/vampire/jabo

/datum/gear/neck/tie/jabored
	display_name = "jabo, red"
	path = /obj/item/clothing/neck/vampire/jabo/red

/datum/gear/neck/tie/jabowhite
	display_name = "jabo, white"
	path = /obj/item/clothing/neck/vampire/jabo/white

//////////////////////////////// SUITS || КОСТЮМЫ ////////////////////////////////

/datum/gear/suit
	subtype_path = /datum/gear/suit
	slot = ITEM_SLOT_OCLOTHING
	sort_category = "External Wear"
	cost = 2

// Coats
/datum/gear/suit/coat
	subtype_path = /datum/gear/suit/coat

/datum/gear/suit/coat/slickbackcoat
	display_name = "coat, purple fur"
	description = "	A warm and heavy purple furred coat."
	path = /obj/item/clothing/suit/vampire/slickbackcoat

/datum/gear/suit/coat/labcoat
	display_name = "labcoat"
	path = /obj/item/clothing/suit/vampire/labcoat

/datum/gear/suit/coat/brown
	display_name = "coat, brown"
	path = /obj/item/clothing/suit/vampire/coat

/datum/gear/suit/coat/green
	display_name = "coat, green"
	path = /obj/item/clothing/suit/vampire/coat/alt

/datum/gear/suit/coat/black
	display_name = "coat, black"
	description = "A warm and heavy brown coat." // Consistency!
	path = /obj/item/clothing/suit/vampire/coat/winter

/datum/gear/suit/coat/red
	display_name = "coat, red"
	path = /obj/item/clothing/suit/vampire/coat/winter/alt

// Jackets
/datum/gear/suit/jacket
	subtype_path = /datum/gear/suit/jacket

/datum/gear/suit/jacket/majima_jacket
	display_name = "fancy jacket, too much"
	description = "A fancy jacket for a fancy punk."
	path = /obj/item/clothing/suit/vampire/majima_jacket

/datum/gear/suit/jacket/fancy_gray
	display_name = "fancy jacket, gray" // the correct word is grey
	path = /obj/item/clothing/suit/vampire/fancy_gray

/datum/gear/suit/jacket/fancy_red
	display_name = "fancy jacket, red"
	path = /obj/item/clothing/suit/vampire/fancy_red

/datum/gear/suit/jacket/black_leather
	display_name = "jacket, black leather"
	description = "	True clothing for any punk."
	path = /obj/item/clothing/suit/vampire/jacket

/datum/gear/suit/jacket/dutch
	display_name = "jacket, dutch"
	path = /obj/item/clothing/suit/dutch

/datum/gear/suit/jacket/military
	display_name = "jacket, military"
	description = "A canvas jacket styled after classical American military garb."
	path = /obj/item/clothing/suit/jacket/miljacket

/datum/gear/suit/jacket/black_suit
	display_name = "jacket, black suit"
	path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/gear/suit/jacket/plainjacket
	display_name = "jacket, plain"
	path = /obj/item/clothing/suit/vampire/jacket/better/plain

// Trenchcoats
/datum/gear/suit/trenchcoat
	subtype_path = /datum/gear/suit/trenchcoat

/datum/gear/suit/trenchcoat/gray
	display_name = "trenchcoat, gray"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench

/datum/gear/suit/trenchcoat/black
	display_name = "trenchcoat, black"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench/black

/datum/gear/suit/trenchcoat/white
	display_name = "trenchcoat, white"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench/white

/datum/gear/suit/trenchcoat/red
	display_name = "trenchcoat, red"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench/red

/datum/gear/suit/trenchcoat/blackred
	display_name = "trenchcoat, red and black"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench/blackred

/datum/gear/suit/trenchcoat/redblack
	display_name = "trenchcoat, red and black (Alt)"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench/redblack

/datum/gear/suit/trenchcoat/brown
	display_name = "trenchcoat, brown"
	description = "Best noir clothes for night."
	path = /obj/item/clothing/suit/vampire/trench/alt

/datum/gear/suit/trenchcoat/burgundy
	display_name = "trenchcoat, burgundy"
	path = /obj/item/clothing/suit/vampire/trench/archive/pidors
	cost = 3

// Misc

/datum/gear/suit/kasaya
	display_name = "kasaya"
	path = /obj/item/clothing/suit/vampire/kasaya

/datum/gear/suit/imam
	display_name = "imam robe"
	path = /obj/item/clothing/suit/vampire/imam

/datum/gear/suit/orthodox
	display_name = "orthodox robe"
	path = /obj/item/clothing/suit/vampire/orthodox

/datum/gear/suit/nun
	display_name = "nun frock"
	path = /obj/item/clothing/suit/vampire/nun


/datum/gear/suit/hawaiian
	display_name = "hawaiian overshirt"
	path = /obj/item/clothing/suit/hawaiian

/datum/gear/suit/striped_sweater
	display_name = "striped sweater"
	path = /obj/item/clothing/suit/striped_sweater

/datum/gear/suit/letterman_red
	display_name = "letterman, red"
	path = /obj/item/clothing/suit/jacket/letterman_syndie

/datum/gear/suit/jeletka
	display_name = "Working west"
	path = /obj/item/clothing/suit/gastarbaiters

//////////////////////////////// UNIFORMS || ФОРМЫ ////////////////////////////////

/datum/gear/uniform
	subtype_path = /datum/gear/uniform
	slot = ITEM_SLOT_ICLOTHING
	sort_category = "Uniforms and Casual Dress"
	cost = 2

/datum/gear/uniform/svadba
	subtype_path = /datum/gear/uniform/svadba
	display_name = "weddin dress"
	path = /obj/item/clothing/under/dress/wedding_dress

// Suits (and suitskirts)
/datum/gear/uniform/suit
	subtype_path = /datum/gear/uniform/suit
	cost = 4 // Suits aren't cheap!

/datum/gear/uniform/suit/fancy_gray
	display_name = "fancy suit, gray"
	path = /obj/item/clothing/under/vampire/fancy_gray

/datum/gear/uniform/suit/kon4atel
	display_name = "black T-shirt."
	description = "I hate crimes..."
	path = /obj/item/clothing/under/vampire/kon4atel

/datum/gear/uniform/suit/fancy_red
	display_name = "fancy suit, red"
	path = /obj/item/clothing/under/vampire/fancy_red

/datum/gear/uniform/suit/fancy_black
	display_name = "luxury suit, black"
	path = /obj/item/clothing/under/vampire/ventrue

/datum/gear/uniform/suit/fancy_black_skirt
	display_name = "luxury suitskirt, black"
	path = /obj/item/clothing/under/vampire/ventrue/female

/datum/gear/uniform/suit/formal_white
	display_name = "plain suit, white"
	path = /obj/item/clothing/under/vampire/office

/datum/gear/uniform/suit/formal_burgundy
	display_name = "plain suit, burgundy"
	path = /obj/item/clothing/under/vampire/tremere

/datum/gear/uniform/suit/formal_burgundy_skirt
	display_name = "plain suitskirt, burgundy"
	path = /obj/item/clothing/under/vampire/tremere/female

/datum/gear/uniform/suit/plain_black
	display_name = "plain suit, black"
	path = /obj/item/clothing/under/vampire/suit

/datum/gear/uniform/suit/plain_black_skirt
	display_name = "plain suitskirt, black"
	path = /obj/item/clothing/under/vampire/suit/female

/datum/gear/uniform/suit/plain_red
	display_name = "plain suit, red"
	path = /obj/item/clothing/under/vampire/sheriff
	allowed_roles = ("Sheriff")

/datum/gear/uniform/suit/plain_red_skirt
	display_name = "plain suitskirt, red"
	path = /obj/item/clothing/under/vampire/sheriff/female
	allowed_roles = ("Sheriff")

/datum/gear/uniform/suit/plain_blue
	display_name = "plain suit, blue"
	path = /obj/item/clothing/under/vampire/clerk

/datum/gear/uniform/suit/plain_blue_skirt
	display_name = "plain suitskirt, blue"
	path = /obj/item/clothing/under/vampire/clerk/female

/datum/gear/uniform/suit/plain_brown
	display_name = "plain suit, brown"
	description = "Some business clothes." // Consistency
	path = /obj/item/clothing/under/vampire/archivist

/datum/gear/uniform/suit/plain_brown_skirt
	display_name = "plain suit, brown"
	description = "Some business clothes." // Consistency!
	path = /obj/item/clothing/under/vampire/archivist/female

/datum/gear/uniform/suit/calico
	display_name = "plain suit, red and black"
	description = "Some business clothes."
	path = /obj/item/clothing/under/vampire/calico

/datum/gear/uniform/suit/prince
	display_name = "prince suit"
	path = /obj/item/clothing/under/vampire/prince
	allowed_roles = list("Prince")

/datum/gear/uniform/suit/prince_skirt
	display_name = "prince suitskirt"
	path = /obj/item/clothing/under/vampire/prince/female
	allowed_roles = list("Prince")

// Skirt
/datum/gear/uniform/skirt
	subtype_path = /datum/gear/uniform/skirt

/datum/gear/uniform/skirt/pentagram
	display_name = "outfit, skirt pentagram"
	description = "A red pentagram on a black t-shirt." // Shortened, as we don't want to bloat the menu with long descriptions
	path = /obj/item/clothing/under/vampire/baali/female


// Turtleneck
/datum/gear/uniform/turtleneck
	subtype_path = /datum/gear/uniform/turtleneck

/datum/gear/uniform/turtleneck/black
	display_name = "turtleneck, black"
	description = "A black turtleneck" // Consistency!
	path = /obj/item/clothing/under/vampire/turtleneck_black

/datum/gear/uniform/turtleneck/navy
	display_name = "turtleneck, navy"
	path = /obj/item/clothing/under/vampire/turtleneck_navy

/datum/gear/uniform/turtleneck/red
	display_name = "turtleneck, red"
	path = /obj/item/clothing/under/vampire/turtleneck_red

/datum/gear/uniform/turtleneck/bloodred
	display_name = "turtleneck, bloodred"
	path = /obj/item/clothing/under/vampire/red_turtleneck

/datum/gear/uniform/turtleneck/white
	display_name = "turtleneck, white"
	description = "A white turtleneck" // Consistency!
	path = /obj/item/clothing/under/vampire/turtleneck_white



// Pants
/datum/gear/uniform/pants
	subtype_path = /datum/gear/uniform/pants
	cost = 2

/datum/gear/uniform/pants/leather
	display_name = "pants, leather"
	path = /obj/item/clothing/under/vampire/leatherpants

/datum/gear/uniform/pants/grimey
	display_name = "pants, grimey"
	path = /obj/item/clothing/under/vampire/malkavian

// Misc
/datum/gear/uniform/dress
	display_name = "dress, black"
	path = /obj/item/clothing/under/vampire/business

/datum/gear/uniform/dress_red
	display_name = "dress, red"
	path = /obj/item/clothing/under/vampire/primogen_toreador/female

/datum/gear/uniform/black_overcoat
	display_name = "overcoat, black"
	path = /obj/item/clothing/under/vampire/rich

/datum/gear/uniform/flamboyant
	display_name = "outfit, flamboyant"
	path = /obj/item/clothing/under/vampire/toreador

/datum/gear/uniform/flamboyant_female
	display_name = "outfit, flamboyant female"
	description = "	Some sexy clothes." // Consistency!
	path = /obj/item/clothing/under/vampire/toreador/female

/datum/gear/uniform/sexy
	display_name = "outfit, purple and black"
	path = /obj/item/clothing/under/vampire/sexy

/datum/gear/uniform/slickback
	display_name = "jacket, slick"
	path = /obj/item/clothing/under/vampire/slickback

/datum/gear/uniform/tracksuit
	display_name = "tracksuit"
	path = /obj/item/clothing/under/vampire/sport

/datum/gear/uniform/schoolgirl
	display_name = "outfit, goth schoolgirl"
	path = /obj/item/clothing/under/vampire/malkavian/female

/datum/gear/uniform/gothic
	display_name = "outfit, gothic"
	path = /obj/item/clothing/under/vampire/gothic

/datum/gear/uniform/punk
	display_name = "outfit, punk"
	path = /obj/item/clothing/under/vampire/brujah

/datum/gear/uniform/punk_female
	display_name = "outfit, punk female"
	path = /obj/item/clothing/under/vampire/brujah/female

/datum/gear/uniform/pentagram
	display_name = "outfit, pentagram"
	description = "A red pentagram on a black t-shirt." // Shortened, as we don't want to bloat the menu with long descriptions
	path = /obj/item/clothing/under/vampire/baali

/datum/gear/uniform/emo
	display_name = "outfit, emo"
	path = /obj/item/clothing/under/vampire/emo

/datum/gear/uniform/hipster
	display_name = "outfit, red hipster"
	path = /obj/item/clothing/under/vampire/red

/datum/gear/uniform/messy
	display_name = "outfit, messy shirt"
	path = /obj/item/clothing/under/vampire/bouncer

/datum/gear/uniform/overalls
	display_name = "overalls"
	path = /obj/item/clothing/under/vampire/mechanic

/datum/gear/uniform/black_grunge
	display_name = "outfit, black grunge"
	path = /obj/item/clothing/under/vampire/black

/datum/gear/uniform/gimp
	display_name = "outfit, gimp"
	path = /obj/item/clothing/under/vampire/nosferatu

/datum/gear/uniform/gimp_female
	display_name = "outfit, gimp female"
	path = /obj/item/clothing/under/vampire/nosferatu/female

/datum/gear/uniform/gangrel
	display_name = "outfit, rugged"
	path = /obj/item/clothing/under/vampire/gangrel

/datum/gear/uniform/gangrel_female
	display_name = "outfit, rugged female"
	path = /obj/item/clothing/under/vampire/gangrel/female

/datum/gear/uniform/sleeveless_yellow
	display_name = "outfit, yellow shirt"
	path = /obj/item/clothing/under/vampire/larry

/datum/gear/uniform/sleeveless_white
	display_name = "outfit, white shirt"
	path = /obj/item/clothing/under/vampire/bandit

/datum/gear/uniform/biker
	display_name = "outfit, biker"
	path = /obj/item/clothing/under/vampire/biker

/datum/gear/uniform/burlesque
	display_name = "outfit, burlesque"
	path = /obj/item/clothing/under/vampire/burlesque

/datum/gear/uniform/daisyd
	display_name = "daisy dukes"
	path = /obj/item/clothing/under/vampire/burlesque/daisyd

/datum/gear/uniform/maid_costume
	display_name = "maid uniform (costume)"
	cost = 2 // And your dignity.
	path = /obj/item/clothing/under/costume/maid


/datum/gear/uniform/maid
	display_name = "maid uniform (authentic)"
	cost = 4
	path = /obj/item/clothing/under/vampire/maid

/datum/gear/uniform/redeveninggown
	display_name = "evening gown, red"
	path = /obj/item/clothing/under/dress/redeveninggown

/datum/gear/uniform/baron
	display_name = "red shirt"
	path = /obj/item/clothing/under/vampire/bar
	allowed_roles = list("Baron")

/datum/gear/uniform/baron_female
	display_name = "red skirt"
	path = /obj/item/clothing/under/vampire/bar/female
	allowed_roles = list("Baron")

/datum/gear/uniform/gray_attire
	display_name = "grey attire"
	path = /obj/item/clothing/under/vampire/salubri

/datum/gear/uniform/gray_attire
	display_name = "grey attire (female)"
	path = /obj/item/clothing/under/vampire/salubri/female
