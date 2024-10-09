/var/obj/effect/lobby_image = new/obj/effect/lobby_image()
var/interquote = pick("Bu yerden nefret ediyorum, burdan gitmek için her şeyimi verirdim. Tanrı bize merhamet göstersin.",
"Bütün domuzlar ölmeli.", "Cennette melek kalmadı, hepsi buraya düştü.","Kendi kanatlarımızı düşerken yaparız.","Ben bir korkağım. Bıçağını sapla bana.",
"Ölümü tehdit yapan şey mutluluktur.","3 kişi bir sır tutabilir, ama ikisinin ölmesi gerekir.","Sen benim oyuncağımsın. Artık kaçış yok.",
"Bittiği için üzülme, yaşandığı için mutlu ol.","Bu dünya bir makine. Domuzları katleden bir makine.",
"Sana yalvarıyorum. Sen beni yarattın. Yaratıcım sensin. Yalvarırım Tanrım. Beni yok etme!","Artık benimsin, yaratık. Seni yok edeceğim.",
"Her şey bitti.","Kendilerini canavarlaştıranlar, insan olmanın acısından kurtulurlar.","Beni kurtar, çıkar beni bu mezardan.","Onurunla öl.")
/obj/effect/lobby_image
	name = "Nearweb"
	desc = "Theatre of pain."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "title"
	screen_loc = "WEST,SOUTH"
	plane = 300

/obj/effect/lobby_grain
	name = "Grain"
	desc = "Theatre of pain."
	icon = 'icons/misc/fullscreen.dmi'
	icon_state = "grain"
	screen_loc = "WEST,SOUTH"
	mouse_opacity = 0
	layer = MOB_LAYER+6
	plane = 300

/obj/effect/lobby_image/New()
	if(master_mode == "holywar")
		icon_state = "holywar"
	else
		icon_state = "title"
	overlays += /obj/effect/lobby_grain
	desc = vessel_name()

/mob/new_player/Login()
	..()
	if(ticker?.current_state != GAME_STATE_PLAYING)
		for(var/mob/new_player/N in mob_list)
			to_chat(N, "⠀<span class='passivebold'>A new player has joined the game</span>")
	message_admins("<span class='notice'>Login: [key], id:[computer_id], ip:[client.address]</span>")
	var/list/locinfo = client?.get_loc_info()
	update_Login_details()	//handles setting lastKnownIP and computer_id for use by the ban systems as well as checking for multikeying
	winset(src, null, "mainwindow.title='Nearweb'")//Making it so window is named what it's named.
	if(join_motd)
		if(guardianlist.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='guardianlobby'>Guardian</span>")
		else if(src.client in admins)
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='adminlobby'>[src.client.holder.rank]</span>")
		else if(access_comrade.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='comradelobby'>Comrade</span>")
		else if(access_villain.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='villainlobby'>Villain</span>")
		else if(access_pigplus.Find(ckey(src.client.key)))
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='graytextbold'>Experienced Pig</span>")
		else
			to_chat(src, "Welcome, <span class='graytextbold'>[capitalize(usr.ckey)]</span>! Your reliability level: <span class='graytextbold'>Pig</span>")
		//to_chat(src, "Press <a href='?src=\ref[src];action=f12'>F12</a> find your death!")
		to_chat(src, "Map of the week:</span> <span class='bname'><i>[currentmaprotation]</i></span>")
		to_chat(src, "Country: <span class='bname'>[capitalize(locinfo["country"])]</span>")
		to_chat(src, "<span class='lobby'>Nearweb</span>   <span class='lobbyy'>Story #[story_id]</span>")
		to_chat(src, "<span class='bname'><b>Interzone:</span></b> <i>\"[interquote]\"</i>")
	if(ticker && ticker.current_state == GAME_STATE_PLAYING && master_mode == "inspector")
		to_chat(src, "\n<div class='firstdivmood'><div class='moodbox'><span class='graytext'>You may join as the Inspector or his bodyguard.</span>\n<span class='feedback'><a href='?src=\ref[src];acao=joininspectree'>1. I want to.</a></span>\n<span class='feedback'><a href='?src=\ref[src];acao=nao'>2. I'll pass.</a></span></div></div>")


	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	if(length(newplayer_start))
		loc = pick(newplayer_start)
	else
		loc = locate(1,1,1)
	lastarea = loc


	sight |= SEE_TURFS
	player_list |= src
	client.screen += lobby_image

	new_player_panel()
	src << output(list2params(list(0)), "outputwindow.browser:ChangeTheme")
	spawn(40)
		if(client)
			client.playtitlemusic()
