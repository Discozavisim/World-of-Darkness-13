/datum/morality_path/humanity
	name = "Humanity"
	desc = "The Humanity score represents how close a Kindred remains to their human nature, to specific people vital to them, and how easily they slip away from human concerns and instead towards the whims of the Beast."
	ready_events = list("slur" = 0, "attackfirst" = 0, "steal" = 0, "robbery" = 0, "drugdealing" = 0, "organtrade" = 0, "drying" = 0, "kill" = 0,
	"massmurder" = 0, "diablerie" = 0, "cpr" = 0, "shockpaddles" = 0, "donate" = 0, "dance" = 0, "animaldrink" = 0, "ratdrink" = 0, "packetdrink" = 0,
	"baddrink" = 0, "gooddrink" = 0, "firstfeed" = 0, "suncoming" = 0, "rotshreck" = 0, "bloodhunger" = 0, "pretorpor" = 0, "jumpfail" = 0, "jumpsuccess" = 0,
	"deadexamine" = 0, "onfire" = 0, "highspeed" = 0, "attacked" = 0, "attackedfail" = 0, "gettingdrunk" = 0, "talkenough" = 0, "cleanenough" = 0, "gettinghigh" = 0,
	"corpseitems" = 0, "friendmeet" = 0, "lovermeet" = 0)


/datum/morality_path/humanity/trigger_morality(trig_event)
	. = ..()

	if(ready_events[trig_event] == 1)
		return FALSE
	ready_events[trig_event] = 1

	var/special_role_name
	if(owner.mind)
		if(owner.mind.special_role)
			var/datum/antagonist/A = owner.mind.special_role
			special_role_name = A.name

	if(is_special_character(owner) && special_role_name != "Ambitious")
		return

	switch(trig_event)
		//humanity lowers
		if ("slur")
			if(dot >= 9)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					ready_events["slur"] = 0
					var/slur_replic = pick(" — Я не сомневаюсь в Вашем словарном запасе, [owner.gender == FEMALE ? "мэм" : "сэр"], но это кажется скоро пересечёт границы. Слово не воробей, вылетит - не поймаешь, но в будущем это может встать на пути к нашим взглядам", " — Стоит задуматься о покупке словаря. Это совсем никуда не годится! Как можно выражаться таким языком? Чему тебя учили родители?", " — Можно было подобрать и более красивую речь.",
					" — А с мамой ты тоже этим ртом говорил?", " — Ругаться матом конечно плохо, но вещи просто необходимо называть своими именами.", " —Бог вложил в уста твои благовоние, а ты влагаешь в них слова зловоннее всякого трупа, убиваешь самую душу и соделываешь ее нечувствительною", " — Сказав сие скверные, матерные слова, Вы не только оскверняете, пачкаете свои уста, но и льете грязь в уши окружающих")
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[slur_replic]</span>")
				else
					var/slur_replic_soft = pick(" — Я подвёл вас. Простите, язык был моей прерогативой.", " — Искренне извиняюсь, но я сам не знаю таких слов.", " — Не стоило доверять языку, я его давно подозревал. Так и запишем.", " — Любая пешка может угрожать короля матом. Короли же до мата не опускаются",
					" — Чтобы овладеть хорошим языком, нужно много потрудиться. Чтобы научиться сквернословию – достаточно несколько раз его произнести.", " — Лучше извергать гнилость изо рта, нежели сквернословие.")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[slur_replic_soft]</span>")
					adjust(min(0, 9-dot))
			else
				ready_events["slur"] = 0
		if ("attackfirst")
			if(dot >= 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_attack = pick(" — Это была атака? Нанесение вреда живому, разумному существу? Как такое вообще допустимо?!", " — А если твой оппонент погибнет, то кто к нему прийдёт на похороны? А КТО ПРИЙДЁТ НА ПОХОРОНЫ К ТЕБЕ?!", " — Это должно быть о-о-очень больно... А если бы напали на тебя?",
					" — Нельзя выиграть, если только защищаешься. Чтобы победить надо идти в атаку.", " — Всегда ли смел тот, кто нападает первым?")
					ready_events["attackfirst"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_attack]</span>")
				else
					var/replic = rand(1, 2)
					var/replic_attack_soft = pick(" — Это был хороший ход, но, плохая идея.", " — Ай-ай-ай-ай, за такое сдача прилетит вдвойне больше. Прилетит же?", " — Не жди, когда к тебе повернутся. Бей в спину, это же преимущество!", " — Мы побеждаем, пока нападаем!", " — Если враг у ворот, то ничего не остаётся, кроме как начать нападение.")
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_attack_soft]</span>")
						if(2)
							var/who_to_beat = "жены"
							if(owner.gender == FEMALE)
								if(!HAS_TRAIT(owner, TRAIT_HOMOSEXUAL))
									who_to_beat = "мужа"
							else
								if(HAS_TRAIT(owner, TRAIT_HOMOSEXUAL))
									who_to_beat = "мужа"
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'> — Чёрт подери, чёрт подери... я совсем потерял контроль над руками! А что дальше, перейдём к избиению [who_to_beat]?</span>")
					adjust(min(0, 8-dot))
			else
				ready_events["attackfirst"] = 0
		/*
		if ("failing")
			if(dot > 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_fail = pick(" — За попытку спасения зачтётся конечно, хоть и не за самую успешную.", " — Да, не получилось, бывает. Ничего страшного, это ведь лучше, чем платная медицина, не так-ли?", " — По крайней мере эта смерть была в добрых, заботливых руках.")
					ready_events -= "failing"
					to_chat(owner, "<font size=12>[icon2html('icons/conviction.png', owner)]</font> <span class='servradio'><b>CONVICTION</b></span></span> <span class='info'>Success</span> <span class='discosay'>[replic_fail]</span>")
				else
					var/replic_fail_soft = pick(" — О нет! Клиническая смерть! Доктор, звоните в ритуальные услуги.", " — Какими руками спасали, такими прийдётся и закапывать...", " — Кажется, стоило позвонить более опытному специалисту, а не решать всё самостоятельно...")
					to_chat(owner, "<font size=12>[icon2html('icons/instincts.png', owner)]</font> <span class='boldwarning'><b>INSTINCTS</b></span>'<b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_fail_soft]</span>")
					adjust(min(0, 8-dot))
			else
				ready_events -= "failing"
		*/
		if ("steal")
			if(dot >= 7)
			//	if(dot >= 9)
			//		adjust(min(0, 7-dot)) //ТЕСТОВАЯ ФИЧА
			//		return TRUE
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_steal = pick(" — Это не взлом, а просто небольшое взаимствование у потенциального друга. Наверное стоит записать номер владельца и вернуть, как-нибудь потом...", " — Перед любопытством все двери открыты. Ты ведь просто посмотришь, что внутри, и закроешь обратно?", " — Да, это проникновение. Проникновение с целью... Хмм... А какая у этого может быть цель?",
					" — Взлом — это круто. Вообще за взлом должны давать нобелевскую премию. Но законы несовершенны и за такие вещи дают срок.", " — Невинное проникновение. Приключение туда и обратно на 20 минут!")
					ready_events["steal"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_steal]</span>")
				else
					var/replic_steal_soft = pick(" — Хозяин этой собственности явно не будет доволен гостями.", " — Плохой поступок, взлом и кража - почти одно и то же. Только ствол добавь - и будет разбой.", " — Эй, слышишь? Подбирай ключи к сердцам, а не к дверям.", " — Хозяин этой собственности явно не будет доволен гостями.",
					" — Человек в нужде просит милостыню, крадет булку с прилавка, но не является в пустой дом взламывать замок.", " — Против взлома нет приема!")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_steal_soft]</span>")
					adjust(min(0, 7-dot))
			else
				ready_events["steal"] = 0
		if ("robbery")
			if(dot > 6)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(owner.job == "Doctor" || owner.job == "Chief Doctor")
					ready_events["robbery"] = 0
					var/replic_doctor_robbery = pick(" — Все как по протоколу. Раздеть, понять причину, вылечить!", " — Ну что же... За работу!", " — Засучим рукава, да начнется работа!")
					var/replic_doctor_robbery_soft = pick(" — Ну раздел. И что дальше? Ты уже не спасешь это тело.", " — Прекрати, этого мертвеца не спасти.", " — Бесполезно даже начинать.")
					if(rolls >2)
						to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_doctor_robbery]</span>")
					else
						to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_doctor_robbery_soft]</span>")
					return
				if(rolls > 2)
					var/replic_robbery = pick(" — До чего докатился этот мир... Нуждающиеся воруют у нуждающихся. Порочный круг бомже-краж.", " — Нам нужнее, мы ведь вернём то что взяли.", " — Не переживай, ты не [owner.gender == FEMALE ? "воровка" : "вор"], это всё жестокий фашистский режим капитализма.",
					" — Думаю он сможет прожить без этого.", " — Вору краденное грошом кажется...")
					ready_events["robbery"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_robbery]</span>")
				else
					var/replic_robbery_soft = pick(" — Такое... подлое действие. А что если это было нужнее хозяину? А мы просто взяли что хотели, как животное.", " — Ворам в древности отрубали руки. Как-то не хочется их терять, они ведь такие ловкие...", " — На что только не пойдёшь, чтобы подзаработать. И что, теперь ты [owner.gender == FEMALE ? "довольна" : "доволен"] собой?", " — Он не заслужил этих бумажек",
					" — Дополнительное финансирование", " — Деньги пришли, деньги ушли")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_robbery_soft]</span>")
					adjust(min(0, 6-dot))
			else
				ready_events["robbery"] = 0
		if ("drugdealing")
			if(dot > 5)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_drugdealing = pick(" — Употреблять психоактивные вещества - это выбор каждого.", " — Ты ведь не продаёшь эту дрянь подросткам или беременным мамочкам. Не стоит волноваться.", " — Когда-нибудь этот картель всё равно накроют, и мир станет лучше. Ты просто дров в костёр подкидываешь.",
					" — В магазинах тоже продают алкоголь и сигареты. Чем ты хуже?", " — Телевиденье, поп-культура, мечты. Люди и без тебя уже зависимы.")
					ready_events["drugdealing"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_drugdealing]</span>")
				else
					var/replic_drugdealing_soft = pick(" — Сколько же людей ломают свои жизни от этого дерьма...", " — Один пакетик, и тысяча страданий.", "— Сколько ещё можно продавать яд народу? Этим должны заниматься политики, фармацевтические компании и фургоны хиппи. Зачем ты это делаешь?",
					" — И ещё парочку жизней, семей и психик разрушено. Можешь гордиться собой.")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_drugdealing_soft]</span>")
					adjust(min(0, 5-dot))
			else
				ready_events["drugdealing"] = 0
		if ("organtrade")
			if(dot > 5)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_organtrade = pick(" — Ты ведь не живых людей продаёшь. По крайней мере, не целиком.", " — Кому-то эти органы явно нужнее, чем прошлому владельцу.", " — Интересная мысль: Почему график героизма стремится от нуля до бесконечности за каждую проданную почку, но уходит ниже нуля к заинтересованности полицией, когда проданных почек оказывается три и более?",
					" — Ты даешь людям надежду на новую жизнь. Даже если у этих людей пару миллионов за плечами.")
					ready_events["organtrade"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_organtrade]</span>")
				else
					var/replic_organtrade_soft = pick(" — Как тебе вообще могла прийти в голову идея продавать чужие части тела на чёрном рынке?!", " — Что ты делаешь? Это не просто не законно, или не этично. Это бесчеловечно!", " — Только не говори, что продаёшь органы нуждающимся больным детям. Нет, в этот раз эта отмазка не прокатит. Ты прекрасно понимаешь, что творишь...",
					" — Спрос рождает предложение. Ничего личного, просто бизнес.", " — Что не сделает капитал ради 300% прибыли, не так ли?")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_organtrade_soft]</span>")

					adjust(min(0, 5-dot))
			else
				ready_events["organtrade"] = 0
		if ("drying")
			if(dot > 4)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_drying = pick(" — Ах! Что же я натворил?! Ох, подожди, тело ещё шевелится. Небольшое переливание крови и будет в норме.", " — Монстрами не рождаются, монстрами становятся...", " — Мои руки, нет, клыки в крови невинных... ",
					" — Должно быть он в лучшем... В лучшем месте, чем это...", " — Должно быть смерть проходила в экстазе. В каком-то смысле счастливчик...")
					var/replic = rand(1, 2)
					ready_events["drying"] = 0
					switch(replic)
						if(1)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_drying]</span>")
						if(2)
							to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'> — Да, прийдётся поработать над умением контроллировать себя.</span>")
							to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='discosay'> — Не надо надо мной работать!</span>")
				else
					var/replic_drying_soft = pick(" — О-ох... Какой бред, это всё сон. Нет, нет, нельзя сосать до потери пульса! Но было так.... Так вкусно!", " — Боже мой. Труп.", "— Чёртов голод. Я тут бессилен, это всё вина чёртового голода. Мне что, глистов тоже учиться контролировать?",
					" — Это было необходимо вкусно. Вкусно и точка.", " — Голод не тётка. Чего уж поделать, когда голоден?")
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_drying_soft]</span>")
					adjust(min(0, 4-dot))
			else
				ready_events["drying"] = 0
				var/replic_drying_beast = pick(" — Тебе не занимать голода... Мне это нравится. Этот вкус, этот запах. Теперь это пустой сосуд, обёртка от сладкой конфеты, мусор. А что? Смертные тоже мусорят, чем мы с тобой хуже, а?", " — КРОВЬ. СОСАТЬ. КРОВЬ. СОСАТЬ. КРОВЬ. СОСАТЬ.", " — О да! Допивай всё до последней капли!",
				" — Вот и сказочке конец, а кто всосал - молодец!", " — Даже в плохом человеке можно найти нечто съедобное.")
				to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_drying_beast]</span>")
		if ("kill")
			if(murder_victms >= 5)
				trigger_morality("massmurder")
			else
				if(dot > 3)
					var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
					if(rolls > 2)
						var/replic_kill = pick(" — Все, рано или поздно, умирают...", "  — Да, человек смертен, но это было бы еще полбеды. Плохо то, что он иногда внезапно смертен, вот в чем фокус! И вообще не может сказать, что он будет делать в сегодняшний вечер.", " — Выбор только на бумаге. В реальности же его просто нет. Что сделано - то сделано. Кто-то по итогу должен был умереть.",
						" — Он рано или поздно умер бы, нечего тянуть трагедию...", " — Палач не знает лиц своих жертв... Но палач ли я", " — Надеюсь ты уже в лучшем месте...", " — Нет, нет... куда ты свернул не туда?! Ты должен выбираться из этого состояния!", " — Наступило время, когда мертвые забирают живых...", " — В эту ночь мир обеднел на десять миллионов прекрасных поступков...")
						ready_events["kill"] = 0
						to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_kill]</span>")
					else
						murder_victms = murder_victms+1
						var/replic_kill_soft = pick(" — Это было самое настоящее, хладнокровное убийство!", " — Психопатия! У нас труп, возможно криминал, по коням.", " — Посмотри... Посмотри! Твои руки по локоть в крови и ты даже не акушер в роддоме. Как до такого вообще можно было докатиться?",
						" — Был выбор и выбор был сделан...", " — Он бы и не прожил троя суток, я просто ускорил процесс.", " — Разве смерть - это плохо?", " — Даже фермеру бывает жалко свою корову перед убоем.",
						"Кто-то когда-то сказал, что смерть — не величайшая потеря в жизни. Величайшая потеря — это то, что умирает в нас, когда мы живем...", " — Наша жизнь обречена на смерть, в которую мы не хотим верить, на любовь, которую мы теряем, на свободу, которой боимся и на уникальный личный опыт, который отдаляет нас друг от друга. Это естественно.")
						to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Failure</span>[replic_kill_soft]<span class='discosay'></span>")
						adjust(min(0, 3-dot))
				else
					murder_victms = murder_victms+1
					ready_events["kill"] = 0
				var/replic_kill_beast = pick(" — Одним смертным больше, другим меньше. Какая разница?", " — Ха-ха-ха-ха-ха... Кажется, мы находим общий язык.", " — Подумаешь, раздавил[owner.gender == FEMALE ? "а" : ""] муравья, сломал[owner.gender == FEMALE ? "а" : ""] ветку, убил[owner.gender == FEMALE ? "а" : ""] человека? В чём проблема?",
				" — Умер и умер, с кем не бывает?", " — Желание причинять боль - вот что стоит на первом месте.", " — Пастух не горюет по умершей овце.", " — Твоя жизнь - моя добыча.")
				to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_kill_beast]</span>")
//		if ("sadism")
		if ("massmurder")
			if(dot > 0)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_massmurder = pick(" — Нет. Из всех, кого ты убил[owner.gender == FEMALE ? "а" : ""], этот точно заслужил. Без вариантов.", " — Не знаю, какое ещё оправдание придумать...", " — Серийный убийца? Нет, просто работа такая.",
					" — Убийство? Странно, чувствую себя виновным...", " — Ничего личного, просто бизнес", " — Надеюсь ты уже в лучшем месте...", " — Так жаль.. Не хотелось, чтобы закончить все так!", " — Ещё один, ещё один... Скольких ещё мне погубить в этой бессмысленной бойне?...")
					ready_events["massmurder"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_massmurder]</span>")
				else
					var/replic_massmurder_beast = pick(" — Одним смертным больше, другим меньше. Какая разница?", " — Ха-ха-ха-ха-ха... Кажется, мы находим общий язык.", " — Скот нужен для еды и развлечения.",
					" — Скот живет, скот мрет, а пастух живет", " — Как жаль! Игрушка сломалась... как и всегда", " — Я ненавижу весь проклятый род человеческий", " — Вот и настал твой последний денек, смертный.")
					to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_massmurder_beast]</span>")
					adjust(min(0, 0-dot))
			else
				ready_events["massmurder"] = 0

		//RESTORING
		if ("cpr")
			if(dot < 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_cpr = pick(" — Вот так, вдох-выдох, вдох-выдох. ТЫ БУДЕШЬ ЖИТЬ!", " — Делай не эротический массаж и без интимного подтекста вдувай воздух в губы, это так просто!", " — Рано ещё похоронное бюро вызывать... А вот врача - пригодилось бы.",
					" — Дыхания нет. Пульса нет. 30 нажатий на грудь, по 2 в секунду. Два спасательных вдоха. Повторить.", " — Раз-два, раз-два, вдыхаем воздух, массируем грудь, вдыхаем воздух, массируем грудь!")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_cpr]</span>")
					adjust(1)
				else
					var/replic_cpr_soft = pick(" — И что ты делаешь? Ты и так не спасёшь эту жизнь...", " — Всё напрасно. Здесь летальный исход очевиден.", " — Стоит ли вообще бороться за эту жизнь?",
					" — Прекрати, ничего не выйдет. Ты ему чуть грудь не сломал этим своим \"массажем\".", " — Это не твоя жизнь. Не стоит за неё пытаеться бороться.")
					ready_events["cpr"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_cpr_soft]</span>")
			else
				ready_events["cpr"] = 0
		if ("shockpaddles")
			if(dot < 9)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_shockpaddles = pick(" — Разряд! Тебе \"туда\" ещё рано!", " — Нет времени на смерть, нужно жить дальше!", " — Отлично! Ещё пара Ватт, и будет как новенький.",
					" — Разряд, ещё разряд!", " — Слышишь? Этот стук... Сердце заработало!")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_shockpaddles]</span>")
					adjust(1)
				else
					var/replic_shockpaddles_soft = pick(" — Хочешь и так страдавшее тело мучать ударами током? Ну ты и садист...", " — Не трать электроэнергию в пустую.", " — Сотни людей умирают в эту же минуту. А стоит ли этот альтруизм того?",
					" — Какие тщетные попытки... Ну спасешь ты его сейчас и что с того? Ты лишь отсрочил неизбежное.", " — Хватит тратить время попусту, ты его не спасешь.")
					ready_events["shockpaddles"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_shockpaddles_soft]</span>")
			else
				ready_events["shockpaddles"] = 0
		if ("donate")
			if(dot < 7)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_donat = pick(" — Драться с супер-злодеями? Ерунда! Денежные пожертвования - вот что делает тебя настоящим героем.", " — Всего пара зелёных портретов президентов и кому-то станет лучше.", " — Щедрость - хорошее качество хорошего человека.",
					" — Есть нечто дороже денег - человеческая жизнь.", " — Настоящее богатство человека измеряется тем, что он отдаёт, а не тем, что он оставляет себе", " — Благотворительность — это единственное сокровище, которое не убудет, сколько бы ты ни делился им")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_donat]</span>")
					adjust(1)
				else
					var/replic_donat_soft = pick(" — Зачем давать бомжам деньги? Они же тратят их на алкоголь и наркотики.", " — Деньги на ветер...", " — И? Ты уже закончил[owner.gender == FEMALE ? "а" : ""]? Доказал[owner.gender == FEMALE ? "а" : ""] себе что ты не кусок дерьма?",
					" — Думаешь сделал хорошее дело? Вскоре его найдут в подворотне с передозом герыча купленного на ТВОИ деньги.", " — Молодец, ещё один спонсор черной экономики.")
					ready_events["donate"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_donat_soft]</span>")
			else
				ready_events["donate"] = 0

		if ("dance")
			if(dot < 10)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_dance = pick(" — Левой, правой, левой, правой. Так держать, суперзвезда", " — Танцевать так приятно, что хочется петь...", " — Зажги танцпол, детка!",
					" — Давай, покажи этим зевакам, что такое Страсть, что такое Настоящий Танец!", " — ТАНЦУЙ! ПОЙ! ЛЮБИ! ЖИВИ!")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_dance]!</span>")
					adjust(1)
				else
					var/replic_dance_soft = pick(" — Хватит двигаться, это выглядит убого! Прекрати! Прошу!", " — Это вряд-ли можно назвать танцем. Скорее, предсмертной судорогой.", " — Убери чёртову улыбку с лица и прекрати танцевать, тебе уже не десять лет!",
					" — Это был эпилептический препадок или мне показалось?", " — Так, хорошо, интересные конечно движения... А танец то где?")
					ready_events["dance"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_dance_soft]</span>")
			else
				ready_events["dance"] = 0

		if("syrgery")
			if(dot < 8)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_syrgery = pick(" — Отличная операция! Таких асов, как ты ещё поискать надо!", " — Всё прошло успешно, можно расслабиться.", " — Прекрасная работа, ты настоящий профессионал!",
					" — Вот это да! Ты просто гений хирургии!", " — Пациент в полном порядке, можно закрывать.")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_syrgery]</span>")
					adjust(1)
				else
					var/replic_syrgery_soft = pick(" — Ну... у него осталось не более, чем несколько дней. Впрочем, это уже не наша проблема.", " — Будь что будет. Свою работу мы уже сделали. Дальше - его заботы.", " — Сомневаюсь, что он долго проживет после этой операции. Так или иначе это не должно нас сильно волновать.")
					ready_events["syrgery"] = 0
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_syrgery_soft]</span>")
			else
				ready_events["syrgery"] = 0

		/*
		if("syrgery_fail")
			if(dot > 6)
				var/rolls = secret_vampireroll(consience+selfcontrol, 6, owner, TRUE, FALSE)
				if(rolls > 2)
					var/replic_syrgery = pick(" — Отличная операция! Таких асов, как ты ещё поискать надо!", " — Не повезло, что он попал к тебе.", " — Прекрасная работа, ты настоящий профессионал!",
					" — Вот это да! Ты просто гений хирургии!", " — Пациент в полном порядке, можно закрывать.")
					to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_syrgery]</span>")
				else
					var/replic_syrgery_soft = pick(" — Ты что, вообще не умеешь оперировать?", " — Не повезло, что он попал к тебе.", " — Попасть тебе на стол равносильно алкоголизму - сам не поймешь, как умер.",)

					ready_events["syrgery"] = 0
					adjust(min(0, 6-dot))
					to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_syrgery_soft]</span>")
			else
				ready_events["syrgery"] = 0
*/

		//BEAST
		if("frenzy")
			var/replic_frenzy = pick(" — А вот и я. Кто не спрятался - я не виноват!", " — Ты слишком слаб[owner.gender == FEMALE ? "а" : ""]. Теперь мой черед играться.", " — Время поохотиться!", " — Пойдем поищем что-нибудь вкусненькое.",
			" — Ха-ха-ха! Пора устраивать веселье!", " — Ты больше не хозяин себе. Я возьму всё в свои клыки!", " — Ты лишь гость в этом теле.")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_frenzy]</span>")
		if ("animaldrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — Фу, ну и дрянь. Найди что-то поаппетитнее. Может ещё и крысами начнёшь питаться?</span>")
		if ("ratdrink")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'> — КРЫСОСОС[owner.gender == FEMALE ? "КА" : ""].</span>")
		if("diablerie")
			var/replic_diablerie = pick(" — СОЖРАТЬ. УБЕЙ. ОТДАЙ МНЕ.", " — МОЯ САМАЯ ДОРОГАЯ ДОБЫЧА.",  " — ВЫСОСАТЬ И ЗАБРАТЬ.",
			" — ДО ПОСЛЕДНЕЙ КАПЛИ, ДАВАЙ ЖЕ, НЕПРИЛИЧНО ОСТАВЛЯТЬ ОБЪЕДКИ", " — ДАВИ, ДАВИ, ДАВИ ЕГО! ДАВАЙ ЕЩЕ, Я ХОЧУ ЕЩЕ!",
			" — НУ НАКОНЕЦ-ТО ЧТО-ТО ДЕЙСТВИТЕЛЬНО СТОЯЩЕЕ, [owner.gender == FEMALE ? "ПОДРУГА" : "ПАРЕНЬ"]. Я ДАЖЕ ГОТОВ ПРОСТИТЬ ТЕБЕ ТОТ ПАКЕТИК", "— ПИРШЕСТВО КРОВИ И ДУШИ, ОСОБЕННО ДУШИ, ХЕХЕ")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_diablerie]</span>")
			if(dot > 4)
				adjust(min(0, 4-dot))
			else
				adjust(-2)
		if("diablerie_success")
			var/replic_diablerie_success = pick(" — ТВОЯ ДУША ТЕПЕРЬ МОЯ.", " — Вкусно... ДАЙ ЕЩЁ!!!",  " — КАКАЯ-ТО ДУШЕНКА, А ТАК ПОТОМ ХОРОШО!!",
			" — ИЗУМИТЕЛЬНО, НЕВЕРОЯТНО, ВОСХИТЕЛЬНО... ДАВАЙ ПОВТОРИМ")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_diablerie_success]</span>")
		if("diablerie_jertva")
			var/replic_diablerie_jertva = pick(" — НЕТ, Я НЕ ДАМСЯ!!!", " — УХОДИ ЧЕРТ ПОГАННЫЙ!!!",  " — ВЫ КТО ТАКИЕ, Я ВАС НЕ ЗВАЛ, ИДИТЕ НАХУЙ!!!",
			" — НАСИЛУЮ-Ю-Ю-ЮТ")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_diablerie_jertva]</span>")
		if("diablerie_jertva_uspeh")
			var/replic_diablerie_jertva_uspeh = pick(" — Кто прийдет с мечом - от меча и погибнет.", " — Охотник стал жертвою.",  " — НИКТО НЕ ЗАБЕРЕТ МЕНЯ!")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_diablerie_jertva_uspeh]</span>")
	/*	if("vampire_suck")
			var/replic_vampire_suck = pick(" — ")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_vampire_suck]</span>")
			*/
		if ("packetdrink")
			var/replic_packetdrink = pick(" — Хм, интересно... Из пакетика? Ну-ну...", " — Пакетик... Как мило. Ты что, ребёнок?",
			"Из пакетика? А почему без слюнявчика и трубочки, [owner.gender == FEMALE ? "мадмуазель" : "миссье"]?")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_packetdrink]</span>")
		if ("baddrink")
			var/replic_baddrink = pick(" — Твою ж мать, это же просто отвратительно!", " — Меня сейчас вырвет от этого дерьма...", "  — Это что-то новенькое... Вкус как у тухлой рыбы с примесью бензина.","Фу, ну и дрянь. Найди что-то поаппетитнее.")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_baddrink]</span>")
		if ("gooddrink")
			var/replic_gooddrink = pick(" — ВКУСНЯТИНА. ХОЧУ ЕЩЁ.", " — М-м-м... С этого и стоило начинать.", " — О, это просто божественно!", " — Ням-ням-ням! Ещё бы такого!")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_gooddrink]</span>")
		if ("firstfeed")
			var/replic_firstfeed = pick(" — М-м-м... С этого и стоило начинать.", " — День начинается с кофе, а ночь с крови.", " — Хорошее начало хорошей ночи.")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_firstfeed]</span>")
		if ("suncoming")
			var/replic_suncoming = pick(" — ПРЯЧЬСЯ ОТ СОЛНЦА, ТУПИЦА!", " — СОЛНЦЕ ЖЖЁТ! БЫСТРЕЕ УХОДИ КАК МОЖЕШЬ!", " — СВЕТ. СОЛНЦЕ. СПАСАЙСЯ.")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_suncoming]</span>")
		if ("rotshreck")
			var/replic_rotshreck_beast = pick(" — А-А-А! ОГОНЬ! ОГОНЬ! ГОРЯЧО! ПОЖАР!", " — ГОРЮ, ГОРЮ, СПАСАЙСЯ КТО КАК МОЖЕТ!", " — ОГОНЬ! БЕГИ, БЕГИ, СПАСАЙСЯ!")
			var/replic_rotshreck_courage = pick(" — Самое время сменить приоритеты в жизни и стать пожарным. Фортуна любит отважных!", " — Не паникуй! Нужно срочно потушить огонь!", " — Спасение утопающих - дело рук самих утопающих. Или как там эта пословица?")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_rotshreck_beast]</span>")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'>[replic_rotshreck_courage]</span>")
		if ("bloodhunger")
			var/replic_bloodhunger = pick(" — НАСТАЛО ВРЕМЯ ПОДКРЕПИТЬСЯ. Я ГОЛОДЕН.", " — ГОЛОД ЗОВЁТ. ПОРА ЕГО УДОВЛЕТВОРИТЬ.", " — МОЁ ЧУВСТВО ГОЛОДА НЕПРЕСТАННО РАСТЁТ.", "Гарсон, я голоден!")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_bloodhunger]</span>")
		if ("pretorpor")
			var/replic_pretorpor = pick(" — Смерть? Нет, это блюдо в мой рацион не входит... А ну давай, вставай!", " — Не в этот раз. Вставай.", " — Смерть - не для меня!")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_pretorpor]</span>")

		//COURAGE
		if ("jumpfail")
			var/replic_jumpfail = pick(" — А тут высоковато, не находишь? Наверное, не стоит даже пробовать", " — Ты что, с ума сошел? С такой высоты прыгать? Да ты себя не ценишь!", " — Слишком высоко. Лучше не рисковать своей шкурой.",
			" — Нет, это слишком опасно. Лучше не надо.", " — Ты что, хочешь себе сломать ноги? Забудь об этой идее.")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_jumpfail]</span>")
		if ("jumpsuccess")
			var/replic_jumpsuccess = pick(" — Ты летишь! Летишь! Столько метров над землёй! Столько кинетического ускорения!", "Полетел как птица! Чувствуешь свободу?", " — Ни граму страха, ни капли сомнения! Пархай!")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_jumpsuccess]</span>")
		if ("deadexamine")
			var/replic_deadexamine = pick(" — Спокойно. Это просто самый обычный мёртвый человек. Не зомби...", " — Покойник... Ничего страшного, просто тело без души.", " — Труп. Не волнуйся, он не встанет и не нападёт на тебя.")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'>[replic_deadexamine]</span>")
		if ("onfire")
			var/replic_onfire_courage = pick(" — Это ерунда, ты ведь не сгоришь за секунды как стог сухого сена. Не обращай внимание, пока сильно печь не начнёт.", " — Спокойно, огонь - это просто химическая реакция. Ты справишься!", " — Главное - не паниковать и не раздувать пламя.")
			var/replic_onfire_beast = pick(" — ПОЛУНДРА! ОГОНЬ НА БОРТУ!!", " — В ТОПКУ УГЛЯ ПОДКИНУЛИ!", "ГАСИ ОГОНЬ, ПОКА НЕ ПРОЖАРИЛОСЬ ВСЁ ДО КОСТЕЙ!")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'>[replic_onfire_courage]</span>")
			to_chat(owner, "<font size=12>[icon2html('icons/beast.png', owner)]</font> <span class='secradio'><b>BEAST</b></span><span class='discosay'>[replic_onfire_beast]</span>")
		if ("highspeed")
			var/replic_highspeed = pick(" — Больше оборотов, выше скорость, сильнее ветер, и чтобы вдавливаться в столб было не так больно и мучительно!", " — Педаль в пол и езжай на край земли!", " — Быстрее ветра, выше гор!")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span><span class='discosay'>[replic_highspeed]</span>")
		if ("attacked")
			ready_events["attackedfail"] = 1
			var/replic_attacked = pick(" — На тебя напали! Защищайся, как герой! Честь и отвага!", " — Драка! Перестрелка! Поножовщина! Порно!", " — Это твой звёздный час, чтобы показать свои боевые навыки.",
			" — Закон каменных джунглей: Убей и будь убитым!", " — Держись! Покажи им, кто тут главный!", " — Сверкай, как бабочка, жужжи, как комар и жаль, как пчела!")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Success</span> <span class='discosay'>[replic_attacked]</span>")

		if ("attackedfail")
			ready_events["attacked"] = 1
			var/replic_attackedfail = pick(" — Я, пожалуй, отойду. Ты тоже, пожалуй, отойди...", " — Пережить развод, взять кредит, жить без родителей - это я могу... А это мне не под силу.", " — Знаешь, что я тебе посоветую? Беги, сука, беги!")
			to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_attackedfail]</span>")

		if("electro_act")
			var/replic_electro_act = pick(" — Спокойно, через нас всего лишь прошло несколько тысяч вольт.", " — Не думал, что мы когда-нибудь станем проводниками... Ваш билетик пожалуйста!", " — Хоть это и больно, но хорошо так бодрит!", " — Ух, я прям чувствую прилив ЭНЕРГИИ!")
			var/replic_daun_act = pick(" — Бззз, смотри какая тряска!", " — Нас ударил ток... Но это не точно", " — Гигатокичь нас шарахнул!",  " — Бля какого уровня у тебя асикью, что ты так ебнулся?")
			if(HAS_TRAIT(owner, TRAIT_NON_INT))
				to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_electro_act]</span>")
			else
				to_chat(owner, "<font size=12>[icon2html('icons/courage.png', owner)]</font> <span class='sciradio'><b>COURAGE</b></span> <span class='info'>Failure</span> <span class='discosay'>[replic_daun_act]</span>")

		//SELF-CONTROL
		if ("gettingdrunk")
			var/replic_gettingdrunk = pick(" — Какое интересное ощущение... Хочется подружиться со всеми и спорить о политике до драки. Ты сейчас в розовых очках юности", " — Пьяный не значит безотвественный. Главное - не переборщить.", " — Выпил - закусил, закусил - выпил. Главное не забыть, где твой дом.")
			to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span><span class='discosay'>[replic_gettingdrunk]</span>")
		if ("talkenough")
			var/replic_talkenough = pick(" — Болтаешь половину ночи, язык скоро отвалится. Но, дикторские навыки нам не помешают, верно?", " — Язык без кости.", " — Иногда молчание - золото. Особенно когда ты уже все сказал.")
			to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span><span class='discosay'>[replic_talkenough]</span>")
		if ("cleanenough")
			var/replic_cleanenough = pick(" — Одни только кровь, ошмётки и моющее средство! Скажи, как давно швабра стала твоей новой конечностью?", " — У всего должна быть мера, даже, если это уборка.", " — Ты уже слишком много времени проводишь с тряпкой и ведром. Лучше вилкой чисти!")
			to_chat(owner, "<font size=12>[icon2html('icons/self-control.png', owner)]</font> <span class='medradio'><b>SELF-CONTROL</b></span><span class='discosay'>[replic_cleanenough]</span>")

		//CONSCIENCE
		if ("gettinghigh")
			var/replic_gettinghigh = pick(" — Ох... Как же это здорово... Всё такое яркое и красивое...", " — Это состояние изменённого сознания, или сознательного изменения?...")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span><span class='discosay'>[replic_gettinghigh]</span>")
		if ("corpseitems")
			var/replic_corpseitems = pick(" — Вещи с трупа. Шикарно, но может не стоит грабить мёртвых?", " — Ужасно некрасиво брать вещи у мёртвых...", " — Ты же не из тех, кто роется в вещах мертвых, верно?")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span><span class='discosay'>[replic_corpseitems]</span>")
		if ("friendmeet")
			var/replic_friendmeet = pick(" — В друзьях есть что-то, что позволяет заземлиться, сбросить якорь, зацепиться за бревно в реке постоянных событий...", " — Друзья - это семья, которую мы выбираем сами.", " — Истинная дружба - это когда молчание между двумя людьми не кажется неловким.")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span><span class='discosay'>[replic_friendmeet]</span>")
		if ("lovermeet")
			var/replic_lovermeet = pick(" — Любовь... Комарики в животе... Комарики?... В ЖИВОТЕ?!", " — Любовь - это когда счастье другого важнее твоего собственного.", " — Искра, буря, безумие... Любовь, вот она какая.")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span><span class='discosay'>[replic_lovermeet]</span>")
		if ("diablerie_jertva")
			var/replic_diablerie_jertva = pick(" — Констатирую: Нас пожирают.", " — Меня кто-то ест... Чувствую это...", " — Почему я чувствую, что меня кто-то пожирает изнутри?")
			to_chat(owner, "<font size=12>[icon2html('icons/consience.png', owner)]</font> <span class='comradio'><b>CONSCIENCE</b></span><span class='discosay'>[replic_diablerie_jertva]</span>")

	return TRUE
//"slur" = 10, "attackfirst" = 9, "failing" = 8 "steal" = 7, "robbery" = 6, "drying" = 5, "drugdealing" = 4, "killparticipation" = 3, "killcommit" = 2, "sadism" = 1, "burningalive" = 1, "massmurder" = 0
