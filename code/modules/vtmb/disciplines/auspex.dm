GLOBAL_LIST_EMPTY(auspex_users)

/datum/discipline/auspex
	name = "Auspex"
	desc = "Allows to see entities, auras and their health through walls."
	icon_state = "auspex"
	power_type = /datum/discipline_power/auspex


/datum/discipline/auspex/post_gain()
	. = ..()
	GLOB.auspex_users += owner

/datum/discipline_power/auspex
	name = "Auspex power name"
	desc = "Auspex power description"

	activate_sound = 'code/modules/wod13/sounds/auspex.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/auspex_deactivate.ogg'
	var/health = FALSE

/datum/discipline_power/auspex/post_gain()
	. = ..()
	if(maxlevel > 3)
		health = TRUE

/datum/discipline_power/auspex/activate()
	. = ..()
	owner.see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+20+maxlevel /// {T.WINER} - Временный фикс на +20, так как почему то си инвизибил лвл обфус меньше обфус инвизибл

/datum/discipline_power/auspex/deactivate()
	. = ..()
	owner.see_invisible = SEE_INVISIBLE_LEVEL_OBFUSCATE+0

//HEIGHTENED SENSES
/datum/discipline_power/auspex/heightened_senses
	name = "Heightened Senses"
	desc = "Enhances your senses far past human limitations."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 1
	vitae_cost = 0

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/heightened_senses/activate()
	. = ..()
	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, AUSPEX_TRAIT, TRAIT_GENERIC)

	owner.update_sight()

/datum/discipline_power/auspex/heightened_senses/deactivate()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, AUSPEX_TRAIT, TRAIT_GENERIC)


	owner.update_sight()

//AURA PERCEPTION
/datum/discipline_power/auspex/aura_perception
	name = "Aura Perception"
	desc = "Allows you to perceive the auras of those near you."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 2
	vitae_cost = 0

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/aura_perception/activate()
	. = ..()
	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.add_hud_to(owner)
	if(health)
		var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		health_hud.add_hud_to(owner)

	owner.update_sight()

/datum/discipline_power/auspex/aura_perception/deactivate()
	. = ..()
	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.remove_hud_from(owner)
	if(health)
		var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		health_hud.remove_hud_from(owner)

	owner.update_sight()

//THE SPIRIT'S TOUCH
/datum/discipline_power/auspex/the_spirits_touch
	name = "The Spirit's Touch"
	desc = "Allows you to feel the physical wellbeing of those near you."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 3

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/the_spirits_touch/activate()
	. = ..()
//	owner.add_client_colour(/datum/client_colour/glass_colour/lightblue)

	owner.auspex_examine = TRUE

	owner.update_sight()

/datum/discipline_power/auspex/the_spirits_touch/deactivate()
	. = ..()
//	owner.remove_client_colour(/datum/client_colour/glass_colour/lightblue)

	owner.auspex_examine = FALSE

	owner.update_sight()

//TELEPATHY
/datum/discipline_power/auspex/telepathy
	name = "Telepathy"
	desc = "Feel the psychic resonances left on objects you can touch."

	check_flags = DISC_CHECK_CONSCIOUS
	target_type = TARGET_MOB | TARGET_LIVING

	level = 4

	toggled = TRUE
	duration_length = 30 SECONDS

/datum/discipline_power/auspex/telepathy/proc/get_info(mob/target)
	var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)

	var/roll = secret_vampireroll(get_a_intelligence(owner)+get_a_intimidation(owner), get_a_willpower(target), owner)
	if(roll <= -1)
		to_chat(owner, "Ты чувствуешь необычное осознание свободы. ы мог ненавидить. Как и испытывать другие теплые чувства. Ты ощущаешь... Пустоту.")
		if(brain)
			brain.applyOrganDamage(50)
	switch(roll)
		if(0)
			switch(rand(1, 4))
				if(1)
					to_chat(owner, "<span class='warning'> Твои мысли путаются с мыслями [target.name]... Ты ничего не разобрал </span>")
					return
				if(2)
					to_chat(owner, "<span class='warning'> Машина, свет, сладкий экстаз... Нет, нет, все не то... </span>")
					return
				if(3)
					to_chat(owner, "<span class='warning'> Цель, кровь, те два чепушилы... Твои мысли спутаны.</span>")
					return
				if(4)
					to_chat(owner, "<span class='warning'> Гусеница, что, я сейчас, крик мужчины и женский, сладкий стон... Это... Это не те мысли! </span>")
					return
		if(1 to INFINITY)
			for(var/i =0, i<roll, i++)
				to_chat(owner, "<span class='warning'> Ты пробираешься в глубины разума [target.name]...</span>")
				if(!do_after(owner, 5))
					to_chat(owner, "Твой фокус исчез! Ты теряешь связь!")
					break
					return
				spawn(5)
					switch(i)
						if(1)
							to_chat(owner, "<span class 'danger'>[interpratete(target, "usual", "usual_info_1")]</span>")
						if(2)
							to_chat(owner, "<span class 'danger'>[interpratete(target, "usual", "usual_info_2")]</span>")
						if(3)
							to_chat(owner, "<span class 'danger'>Ты чувствуешь[interpratete(target, "intresting", "intresting_info_1")]</span>")
						if(4)
							to_chat(owner, "<span class 'danger'>[interpratete(target, "intresting", "intresting_info_2")]</span>")
						if(5)
							to_chat(owner, "<span class 'danger'>[interpratete(target, "critical", "critical_info_1")]</span>")
						if(6)
							to_chat(owner, "<span class 'danger'>[interpratete(target, "critical", "critical_info_2")]</span>")
						if(7 to 14)
							to_chat(owner, "<span class 'danger'>[interpratete(target, "super", "super_info_1")]</span>")
					//	if(8)
					//		to_chat(owner, "<span class 'danger'>[interpratete(target, "super", "super_info_2")]</span>")

///// {T.WINER} - Таргет, класс информации и сама инфа. Простенько в исполнении, труднее придумать текст

/datum/discipline_power/auspex/telepathy/proc/interpratete(mob/living/target, info_class, info)
	var/bank_code = 0
	var/clane_info = 0
	var/mission = 0
	for(var/datum/antagonist/A in target.mind.antag_datums)
		if(A.objectives)
			mission = 1

	if(info_class == "usual")
		switch(info)
			if("usual_info_1")
				if(!isgarou(target) && !iskindred(target) && !iscathayan(target))
					return "Ты чувствуешь необычное осознание свободы. Твоё сердце бьется, легкие дышат, а глаза рефлекторно моргают. Нету гнета <span class='secradio'><b>ЗВЕРЯ</b></span>, нету страха за свои поступки. Ты чувствуешь себя... Живым."
				else if(isnpc(target))
					var/mob/living/carbon/human/npc/NPC = target
					if(NPC.last_attacker)
						return "В тебя выстреливает поток боли, злобы и несбыточных обещаний. Некто вступил в битву с [NPC.name]. Вдруг ты ощущаешь незнакомое чувство...  Ты видишь слова.. имена... Оглушительный крик врезается в твой разум. Ты слышишь \"БУДЬ ТЫ ПРОКЛЯТ, [NPC.last_attacker.name]!\""
				else if(isanimal(target))
					var/mob/living/simple_animal/SA = target
					if(SA.warform.humanform)
						return "Ты ощущаешь сверхъестественное нутро этого существа. За ним есть кто-то или нечто более, чем животное начало... Ты чувствуеш чужого  <span class='secradio'><b>ЗВЕРЯ</b></span>, ты чувствуешь чье-то имя..."
					else
						return "Твою голову наполняют простые, но столь важные для тебя задачи: Найти еду, найти ночлег, размножиться, жить, ухаживть за потомством... Ты чувствуешь себя животным."
				else if(mission)
					return "Ты ощущаешь некоторую волнительность и важность, словно ты занят этой ночью и тебе нужно нечто сделать или заработать..."
				//	return "Пучины этого разума сложны и комплексны... Ты чувствуешь привычное чувство Сверхъестественного бытия."

			if("usual_info_2")
				var/mob/living/carbon/human/target1 = target
				if(target1.mind.enslaved_to)
					return "Ты чувствуешь приятные чувства, чуть ли не любовь. Стекающая хладная, но все такая же вкусная жидкость стекает тебе в рот. "
				else if(target1.Myself.Lover.owner)
					return "Ты ощущаешь любовь. Звонкое имя \"[target1.Myself.Lover.owner.true_real_name]\" звучит в твоем сердце снова и снова. Любовь, любовь... "
				else if(target1.Myself.Friend.owner)
					return "Партнерство, дружба, братство - эти слова отзываются в твоем сердце наилучшим образом и не единожды. Ты ощущаешь, как сидишь в кампании друзей. Одна из имен тебе хорошо знакомо - \"[target1.Myself.Friend.owner.true_real_name]]\""
				else if(target1.Myself.Enemy.owner)
					return "Ненависть, страх, агрессия. Ты чувстваешь множество негативных эмоций в направлении некоторых особ. Ты ощущаешь, что твои враги повсюду. Они тебе мешают и ты помешаешь им. Однако одно из этих лиц находится прямо в этом городе. Ты прочувствовал всю ненависть к имени \"[target1.Myself.Enemy.owner.true_real_name]\""
				else
					return "Ты ощущаешь... Одиночество. Здесь нету кого ты бы мог ненавидить. Как и испытывать другие теплые чувства. Ты ощущаешь... Пустоту."


	if(info_class == "intresting")
		for(var/datum/vtm_bank_account/account in GLOB.bank_account_list)
			var/mob/living/carbon/human/tra = target
			if(tra.bank_id == account.bank_id)
				bank_code = account.code
				break
		switch(info)

			if("intresting_info_1")
				if(isgarou(target))
					return "нарастающую ярость, твое сердце бьется все чаще и чаще. Тебя переполняет желания пойти и звыть на луну."
				else if(iskindred(target))
					return "столь знакомый и неизмеримый <span class='secradio'><b>ГОЛОД</b></span>... Твои клыки окрапляются чужой кровью и ты хочешь ещё. "
				else if(iscathayan(target))
					if(target.yin_chi > target.yang_chi+2)
						return "холод, смерть и разрушение. Ты не чувствуешь в себе жизни, но это чувство отлично от твоего бытия."
					else if(target.yang_chi > target.yin_chi+2)
						return "энергию, жизнь и силу! Ты хоть и мертв, но жизнь течет в тебе ручьем!"
					else
						return "спокойствие, баланс и гармонию. Все в твоем теле есть суть активность и покой. Ты ощущаешь столь привычную не-жизнь, но у неё другая природа, у неё другой замысел, другой баланс..."

				else if(isnpc(target))
					return "абсолютное безразличие к остальным. Чужие жизни тебя не волнуют, пока не коснутся тебя. Некоторые отголоски совести в тебе ещё живы, но ты врятли на них обратишь внимания."

		//		else if()
		//			return

			if("intresting_info_2")
				if(bank_code)
					return "Быстрое клацанье по клавишам, набор цифр [bank_code], сладкий хруст купюр... Ты усмехаешься, чувствуя на руках эти бумажки."

		//		else if()

	if(info_class == "critical")
		switch(info)
			if("critical_info_1")
				var/mob/living/carbon/human/target1 = target
				var/obj/keypad/armory/K = find_keypad(/obj/keypad/armory)
				var/obj/structure/vaultdoor/pincode/bank/bankdoor = find_door_pin(/obj/structure/vaultdoor/pincode/bank)
				if(K && (target1.mind.assigned_role == "Prince" || target1.mind.assigned_role == "Sheriff"))
					return "Терпкий запах пороха вдарил тебе в нос. Ты наблюдаешь, как несколько озадаченных и готовых к бою фигур стоят около тебя. Ты быстро вводишь [K.pincode], после чего ставни отворяются и ты видишь кучу оружия... "

				else if(bankdoor && (target1.mind.assigned_role == "Capo"))
					return "Ты слышишь знакомые тебе голоса, голоса членов твоей семьи. Они спорят. Ты сердишься, но не встреваешь. После ты пишешь на бумаге [bankdoor.pincode] и кладешь бумажку в карман своего братца, пока он продолжает спорить..."

				else if(iskindred(target1))
					switch(rand(1, 2))
						if(1)
							if(target1.humanity == owner.humanity)
								return "Это ощущение тебе знакомо. <span class='secradio'><b>ЗВЕРЬ</b></span> ли или просто высокий контроль - это все неважно. Обрывки воспоминаний всплывают в твоем разуме - холод, <span class='secradio'><b>ГОЛОД</b></span> и страх. Ты ощущаешь некоторую схожесть в мировосприятии с этим существом."
							else if(target1.humanity > 7)
								return "Ты чувствуешь необычаемую доброту, милость и чистоту. Ты словно очистился от своих грехов. Чистота мысли и жалобный стон <span class='secradio'><b>ЗВЕРЯ</b></span> преследуют тебя."
							else if(target1.humanity < 7)
								return "Ты ощущаешь нестерпимое желание <span class='secradio'><b>УБИТЬ</b></span>, исходящие приямо из недр подсознания и зов <span class='secradio'><b>ЗВЕРЯ</b></span>, что возможно уже обнаружил твоё \"проникновение\" в пучины этого разума. "
							else
								return "Абсолютное чувство \"нормальности\" нестерпимо вертится в твоем подсознании. Тебе ни холодно, ни тепло от чужих и прочих людей. Ты чувствуешь себя таким же, как и все. Ещё не монстр, но и не человек."
						if(2)
						///// {T.WINER} - Проклятье/темперамент(или его отсутствие) клана очень сильно влияет на эмоциональную окраску своего состояния. Поэтому они здесь
							if(target1.clane.name == owner.clane)
								clane_info = 1
								return "Внезапно перед твоими глазами вспыхивают образы.<span class='secradio'><b>Кровавое родство</b></span>, родные тебе люди и вещи... Ты чувствуешь некоторую <span class='secradio'><b>РОДСТВЕННУЮ СВЯЗЬ</b></span> с этим сущестом."

							else if(target1.clane.name == "Brujah")
								clane_info = 1
								if(owner.clane.name == "Ventrue")
									return "Ты чувствуешь желание мстить, убивать и крушить. Некоторая потеря отзывается в твоем сердце, пока твой <span class='secradio'><b>ЗВЕРЬ</b></span> хохочет. Внезапно ты чувствуешь чей-то взгляд на себе, а после слышишь: \"КАРФАГЕН НЕ ЗАБЫТ.\""
								return "Ты чувствуешь нестерпимую <span class='secradio'><b>ЯРОСТЬ</b></span>. Ты хочешь крушить и уничтожать все вокруг."

							else if(target1.clane.name == "Daughters of Cacophony")
								return "Ты слышишь некоторую мелодию на границах твоего разума... Ты начинаешь ощущаеть каждый звук и каждый звук отражается в твоей голове музокой."
							else if(target1.clane.name == "Gangrel")
								return "Ты слышишь чей-то шепот. Ты видишь два красных глаза, клыки, хизный оскал <span class='secradio'><b>ЗВЕРЯ...</b></span>... Кажется кто-то заметил твоё прибывание в чужом разуме... "
							else if(target1.clane.name == "Gargoyle")
								clane_info = 1
								return "Ты чувствуешь глубокое презрение, смешанное с таким же сильным уважением и преданностью. Ты ощущаешь, как твоя кожа становится твердой, как камень..."

							else if(target1.clane.name == "Kiasyd" && owner.clane.name == "Lasombra")
								clane_info = 1
								return "Ты ощущаешь нечто родственное. Нечто незримое близкое, но далекое. Ты видишь пустоту, ваши лица и слышишь чей-то смех. Что же ты будешь делать?"
							else if(target1.clane.name == "Lasombra" && owner.clane.name == "Kiasyd")
								clane_info = 1
								return "Бездна. Темная, безликая. Ты видишь пустоту. Тьму. Тень. Ты чувствуешь неопредолимое чувство страха. Страха неизвестного. Ты видишь чьи-то глаза в каждой тени..."
							else if(target1.clane.name == "Malkavian")
								clane_info = 1
								var/replic = ""
								switch(rand(1, 4))
									if(1)
										replic = "ХИХИХХИИ, А КТО ЭТО НОВЕНЬКИЙ У НАС? ОН НЕ БУЗЕ! АХАХАХАХАХАХАХХА! А Я ТЕБЯ ВИЖУ [owner.true_real_name]!!"
									if(2)
										replic = "Ну я думаю можно убить [owner.true_real_name] или лучше ПОСЛАТЬ НАХУЙ ЕГО НАХУЙ? Гусеница, а я дума... ПОДОЖДИ, ОН ЗДЕСЬ, ОН НАС СЛЫШИТ."
									if(3)
										replic = "А вы знали, что если смешать вите с апельсиновым соком вы будете выглядить как фишмалк? Нет, не знал. Любую хуйню можно творить будучи ребенком 12-ти девочек."
									if(4)
										replic = "Я ТАК СИЛЬНО ЛЮБЛЮ [owner.true_real_name], КАК ЖЕ Я ХОЧУ С [target1.gender == FEMALE ? "НЕЙ" : "НИМ"] ПОМУРЛЫКАТЬСЯ. Андрей, заканчивай блять. НУ СТАРЕЙШИНААААА... Заебал, иди сюда и поцелуй меня в хладные уста, пока [owner.gender == FEMALE ? "эта" : "этот"] [target1.true_real_name] куколдит."
								return "Ты слышишь чьи-то голоса. Ты чувствуешь шорохи, звуки, крики. Ты дуреешь, ты безумен... Они исходят повсюду, они везде. ОНИ УЖЕ В ТВОЕЙ ГОЛОВЕ.<span class='ghostalert'>[replic]</span>"
							else if(target1.clane.name == "Followers of Set")
								clane_info = 1
								return ""
							else if(target1.clane.name == "Old Clan Tzimisce" && owner.clane.name == "Tzimisce")
								clane_info = 1
								return "Твоё не-мертвое нутро подсказывает тебе нечто до боли знакомое чувство. Ты видишь  огонь, воду, а после и взлетающего дракона. Ту чувствуешь родственную связь по <span class='medradio'><b>ДУХУ</b></span>, а не по <span class='secradio'><b>ПЛОТИ</b></span>."

							else if(target1.clane.name == "Toreador")
								return "Ты ощуаешь всю красоту этого мира, каждый звук отзывается в твоем ухе звучной мелодией, каждая клякса уже есть картина, а всякий закат и рассвет настолько красив, что ты готов ради этой красоты сгореть."
							else if(target1.clane.name == "Tremere")
								clane_info = 1
								if(owner.clane.name == "Tzimisce" || owner.clane.name == "Old Clan Tzimisce" || owner.clane.name == "Salubri" || owner.clane.name == "Gangrel" )
									if(owner.chronological_age > 500)
										return "Ты оущащешь внезапную ненависть, злобу и скрепящую жажду убить [target1.name]. Ты ощущаешь, как твоя кровь вскипает, ты видишь давние образы битвы, погибших сородичей и терпкий запах гнили перемешанный с кровью. Ты кое-как пересиливаешь себя, чтобы не впасть в безумие. "
									else
										return "В тебе возникает чувство настороженности. Перед тобой мелькают образы битв, кровавых рун и сотворения всеразличных ритуалов. Внезапно чувство настороженности превращается в ненависть, а после и жажду убийства. Неужели [target1.name] из тех \"самых\" о которых ОНИ говорили?"
								return "Ты видишь образы: кровь, нож, черная метка, красные глаза, белый червь.. Ты видишь, как некто делает ритуал, танцуя и расхаживая около руны, а после заливается смехом... Ты чувствуешь себя не по себе после такого."
							else if(target1.clane.name == "True Brujah")
								return "Ты чувствуешь... Ничего. Ни ненависти, ни страха, ни злобы. Словно твои эмоции утекли, исчезли. Ты ощущаешь себя безэмоциональным и апатичным."

							else if(target1.clane.name == "Ventrue")
								clane_info = 1
								if(owner.clane.name == "Brujah")
									return "Одно видение исчезает за другим. Руины античного города, кровавые слезы, земля усыпанная солью... Ты чувствуешь правдный гнев, но это не взывает в тебе зверя."
								return "Ты ощущаешь превосходство. Ты выше других. Ты пастух всякого сородича, ты их направляешь по пути верному, а они тебя слушаются, как крестьяне короля."

		//		else
		//			return ""
			if("critical_info_2")
				var/mob/living/carbon/C = target
				if(C.diablerist)
					return "Ты чувствуешь потаенное желание, страсть к пожиранию душ. Ты ощущаешь чужое вите стекающие по твоем клыкам прямо в твою глотку. Блаженное ощущение появляется внутри тебя, когда ты высасываешь чью-то душу..."
				if(iskindred(target))
					if(target.generation > owner.generation)
						return "Ты ощущаешь, как твои силы меркнут, а кровь слабееть. Ты чувствуешь, как ты стал дальше от своего <span class='secradio'><b>ПРЕДКА</b></span>"
					else if(target.generation < owner.generation)
						return "Чувство наполняющейся силы распирает тебя. Твоя кровь сгущается, мускулы крепчают, а великолепие растет. Ты чувствуешь, как стал ближе к своему <span class='secradio'><b>ПРЕДКУ</b></span>"
					else if(target.generation == owner.generation)
						return "В тебе возникает чувство равенства. Ты не ощущаешь сильного прироста силы, но и не её утекания."

				//	else if(isgarou(target))

	if(info_class == "super")
		switch(info) /////////////////{T.WINER} - Персонажи этих практически с 100% шансом таят тайны о себе, так как опасно. Поэтому знание о них так глубоко зарыто.
			if("super_info_1")
				var/mob/living/carbon/human/target1 = target
				if(!clane_info)
					if(target1.clane.name == "Baali")
						if(owner.clane.name == "Banu Haqim")
							return "Ты видишь кровавую луну, ужасный, терзающий твою не-мертвую тушу крик и ощущаешь злобный взгляд на себе. Ты видишь присутствия Шайтанов."
						return "Ты слышишь чей-то смех. Хтонический, ужасный потусторонний смех. Тебя парализует непонятное чувство страха. Кто-то начинает говорить в твоей голове: ПРИСОЕДИНИСЬ К НАМ, СТАНЬ ОДНИМ ИЗ НАС ВО СЛАВУ ГОСПОДИНА НАШЕГО!"
					else if(target1.clane.name == "Nosferatu")	//// Когда будет третья точка "Маска 1000 лиц эта фича обретет новые краски
						return "В твой разум вонзаются тысячи игл состоящих из информация разного толка. Сородич с нарисованной короной говорит с отребьем. Старец с кровью на руках и хищным оскалом идет за придателями. Демонопоклонники в городе. За [owner.true_real_name] идет слежка."
					else if(target1.clane.name == "Kiasyd")
						return "Перед твоим взором предстают множество существ. Ты чувствуешь одно основание, но разную природу с ними. Ты видишь, как некогда светлые краски угасают, как и твоя надежда... Или все же нет?"
					else if(target1.clane.name == "Banu Haqim")
						return "Жесткие устои, каменное сердце и страсть к каннибализму. Ты есть воин, исследователь или законник - не важно. Ты служишь Отцу верой и правдой. Ты длань его. "
					else if(target1.clane.name == "Caitiff")
						return "В тебе пробуждается некоторый страх смешанный с отвращением. Ты не чувствуешь в нем неопределенность и слабость. В тебе возникает чувство предходящего конца..."
					else if(target1.clane.name == "Cappadocian")
						return "Скелеты, кости, смерть, кладбища, черепа - все это отзывается в тебе. Ты есть повилитель той и этой стороны."

					else if(target1.clane.name == "Giovanni")
						return "Скелеты, кости, смерть, кладбища, черепа, семья - все это отзывается в тебе. Ты есть повилитель той и этой стороны. А семейные узы лишь этому помогают."
					else if(target1.clane.name == "Salubri")
						return "Секреты, жертвы, плачь. Ты чувствуешь горькое чувство утраты. Утраты Отца. Ты чувствуешь это каждой своей клеточкой, как и ненависть к Убийцам."
					else if(target1.clane.name == "Tzimisce")
						return "Все вокруг тебя стало темным, словно ты вступил на чужую землю... Словно жертва заманенная к хищнику. Внезапно ты видишь кровь, расчлененные и неестественно скрепленные тела и слышишь чью-то просьу о помощи. Кажется ты чувствуешь небольшой смешок от [owner.true_real_name]..."
				else if(target1.chronological_age > owner.chronological_age)
					return "Ты ощущаешь некоторую степень замешательства, давление исходящие от [target1.name]. Давление воспоминаний... Ты слышишь гул в голове, как вдруг ты словно вселяешься в [target1.name]! Ты видишь и чувствуешь всю радость, печаль и вкус жизни и не-жизни! Ты словно переживаешь чужую жизнь..."
				else
					return "Ты ощущаешь некоторую степень замешательства, пустоту исходящую от [target1.name], словно твой опыт и воспоминания намного больше, чем у твоей жертвы. Твоя голова начинает странно гудеть... "

	//		if("super_info_2")


//// {T.WINER} - простая передача мыслей в голову. Адаптированый код с spell'а телепатии
/datum/discipline_power/auspex/telepathy/proc/say_to(mob/target)
	var/roll = secret_vampireroll(get_a_intelligence(owner)+get_a_intimidation(owner), get_a_willpower(target), owner)
	if(roll == 0)
		to_chat(owner, "<span class='warning'>Твои мысли и мысли [target.name] слишком спутаны... Ты не можешь донести свою мысль!</span>")
		return
	if(roll <= -1)
		to_chat(owner, "<span class='danger'>Ты чувствуешь, как сотни игл вонзаются в твою голову!</span>")
		to_chat(target, "<span class='warning'>Некто пытался управлять потоком твоих мыслей... Он где-то рядом</span>")
		return

	var/msg = stripped_input(owner, "What do you wish to tell [target]?", null, "")
	if(!msg)
		return
	log_directed_talk(owner, target, msg, LOG_SAY, "[name]")
	to_chat(owner, "<span class='boldnotice'>Ты вселил свои мысли в [target]:</span> <span class='notice'>[msg]</span>")
	to_chat(target, "<span class='boldnotice'>Ты слышишь, как кто-то говорит прямо в твоей голове...</span> <span class='notice'>[msg]</span>")

/datum/discipline_power/auspex/telepathy/pre_activation_checks(mob/living/target)
	if(iskindred(target) || iscathayan(target) || iswerewolf(target))
		if(owner.willpower_auto)
			return TRUE
		to_chat(owner, "<span class='boldnotice'> Мысли слишком сложны для понимания... Тебе придеться потратить много усилий и Воли, чтобы проникнуть в разум [target].</span>")
		return FALSE
	return TRUE

/datum/discipline_power/auspex/telepathy/activate(mob/living/target)
	. = ..()
	var/vibor = input(owner, "Твои действия:", "Телепатия") as null|anything in list("Сказать", "Прочесть мысли")
	switch(vibor)
		if("Сказать")
			say_to(target)
		if("Прочесть мысли")
			get_info(target)



//PSYCHIC PROJECTION
/datum/discipline_power/auspex/psychic_projection
	name = "Psychic Projection"
	desc = "Leave your body behind and fly across the land."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 5

/datum/discipline_power/auspex/psychic_projection/activate()
	. = ..()
	owner.ghostize(can_reenter_corpse = TRUE, aghosted = FALSE, auspex_ghosted = TRUE)
	owner.soul_state = SOUL_PROJECTING

/* ATOM */

/atom
	var/last_investigated = 0
	var/stealthy3 = 0

//! So much spaghetti code, but it's can't be avoided

/atom/examine(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/Z = user
		if(Z.auspex_examine)
			if(!isturf(src) && !isobj(src) && !ismob(src))
				return
			var/list/fingerprints = list()
			var/list/blood = return_blood_DNA()
			var/list/fibers = return_fibers()
			var/list/reagents = list()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(src.stealthy3)
					to_chat(user, "Ты чувствуешь, что [H.name] является не тем, кто есть на самом деле... Возможно это [H.true_real_name]")
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()


				if(isturf(src))
					var/turf/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type
				if(isobj(src))
					var/obj/T = src
					// Only get reagents from non-mobs.
					if(T.reagents && T.reagents.reagent_list.len)

						for(var/datum/reagent/R in T.reagents.reagent_list)
							T.reagents[R.name] = R.volume

							// Get blood data from the blood reagent.
							if(istype(R, /datum/reagent/blood))

								if(R.data["blood_DNA"] && R.data["blood_type"])
									var/blood_DNA = R.data["blood_DNA"]
									var/blood_type = R.data["blood_type"]
									LAZYINITLIST(blood)
									blood[blood_DNA] = blood_type

			// We gathered everything. Create a fork and slowly display the results to the holder of the scanner.

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			//Killer
			if(isliving(src))
				var/mob/living/LivedYoung = src
				if(LivedYoung.lastattacker)
					for(var/mob/living/carbon/human/huLi in GLOB.player_list)
						if(huLi?.dna?.real_name == LivedYoung.lastattacker)
							to_chat(user, "<span class='info'><B>Aggressive prints:</B> [md5(huLi.dna.uni_identity)]</span>")
							found_something = TRUE

			// Blood
			if (length(blood))
				to_chat(user, "<span class='info'><B>Blood:</B></span>")
				found_something = TRUE
				for(var/B in blood)
					to_chat(user, "Type: <font color='red'>[blood[B]]</font> DNA (UE): <font color='red'>[B]</font>")

			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			//Reagents
			if(length(reagents))
				to_chat(user, "<span class='info'><B>Reagents:</B></span>")
				for(var/R in reagents)
					to_chat(user, "Reagent: <font color='red'>[R]</font> Volume: <font color='red'>[reagents[R]]</font>")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return
		else if((isobj(src) || ismob(src)) && last_investigated <= world.time)
			last_investigated = world.time+30 SECONDS
			if(secret_vampireroll(get_a_perception(user)+get_a_investigation(user), 6, user) < 3)
				return

			var/list/fingerprints = list()
			var/list/fibers = return_fibers()

			if(ishuman(src))
				var/mob/living/carbon/human/H = src
				if(!H.gloves)
					fingerprints += md5(H.dna.uni_identity)

			else if(!ismob(src))
				fingerprints = return_fingerprints()

			var/found_something = FALSE

			// Fingerprints
			if(length(fingerprints))
				to_chat(user, "<span class='info'><B>Prints:</B></span>")
				for(var/finger in fingerprints)
					to_chat(user, "[finger]")
				found_something = TRUE

			//Killer
			if(isliving(src))
				var/mob/living/LivedYoung = src
				if(LivedYoung.lastattacker)
					for(var/mob/living/carbon/human/huLi in GLOB.player_list)
						if(huLi?.dna?.real_name == LivedYoung.lastattacker)
							to_chat(user, "<span class='info'><B>Aggressive prints:</B> [md5(huLi.dna.uni_identity)]</span>")
							found_something = TRUE
			//Fibers
			if(length(fibers))
				to_chat(user, "<span class='info'><B>Fibers:</B></span>")
				for(var/fiber in fibers)
					to_chat(user, "[fiber]")
				found_something = TRUE

			if(!found_something)
				to_chat(user, "<I># No forensic traces found #</I>") // Don't display this to the holder user
			return
