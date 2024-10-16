var/global/list/serialkiller_satisfaction_lines = list("<span class='murderertext'>This is what I live for...</span>", "<span class='murderertext'>I feel, almost alive...</span>", "<span class='murderertext'>I need more...</span>", "<span class='murderertext'>So intoxicating...</span>", "<span class='murderertext'>I just can't help it...</span>", "<span class='murderertext'>It's beautiful...</span>",)

/datum/game_mode
	var/list/datum/mind/serialkiller = list()

/datum/game_mode/serialkiller
	name = "The Serial Killer"
	config_tag = "serialkiller"
	restricted_jobs = list("Cyborg", "Baron", "Merchant", "Marduk", "Tiamat")
	required_players = 1
	required_enemies = 1
	recommended_enemies = 1

/mob/living/carbon/human/proc/serialkiller()
	set name = "Murderer"
	set desc = "Murderer"

/datum/game_mode/serialkiller/can_start()
	if(forcestart == TRUE)
		return 1
	else
		for(var/mob/new_player/player in player_list)
			for(var/mob/new_player/player2 in player_list)
				if(player.ready && player.client.work_chosen == "Baron" && player2.ready && player2.client.work_chosen == "Merchant")
					return 1
	return 0

/datum/game_mode/proc/serialkiller_greeting(datum/mind/serialkiller)
	to_chat(serialkiller.current,"<span class='dreamershitbutitsbigasfuckanditsboldtoo'>Tonight's the night. I'm going to do it again.</span>")
	to_chat(serialkiller.current,"<span class='dreamershitbutitsbigasfuckanditsboldtoo'>The hunt is what keeps me alive. I must chase it.</span>")
	to_chat(serialkiller.current,"<span class='dreamershitbutitsbigasfuckanditsboldtoo'>I'm a very neat monster.</span>")
	return

/datum/game_mode/proc/finalize_serialkiller(datum/mind/serialkiller)
	serialkiller.special_role = "Murderer"

	var/datum/antagonist/murderer = new()
	serialkiller.antag_datums = murderer
	var/mob/living/carbon/human/H = serialkiller.current
	H.terriblethings = TRUE
	
	

	H.verbs += /mob/living/carbon/human/proc/serialkiller
	H.verbs += /mob/living/carbon/human/proc/serialkillerArchetypes
	H.verbs += /mob/living/carbon/human/proc/bloody_doodle
	H.consyte = 0
	H.status_flags |= STATUS_NO_PAIN
	H.is_murderer = TRUE
	starringlist += "[H.key] "
	if(H.religion == "Thanati")
		H.religion = "Gray Church"
	serialkiller.current.updateStatPanel()


/mob/living/carbon/human/proc/serialkillerArchetypes(var/mob/living/carbon/human/H in player_list)
	set hidden = 0
	set name = "serialkillerArchetypes"
	set category = "gpc"//there's a custom category for this, but its logo doesn't show up, so we'll roll with gpc for now
	set desc = "What am I?"

	if(H.is_murderer==TRUE)
		var/list/serialkillerarchetypelist = list("The Ripper")//, "The Mutilator")//, "The Torturer", "The Professional")
		H.serialkillerArchetype = pick(serialkillerarchetypelist)
		switch(H.serialkillerArchetype)
			if("The Ripper")
				H.serialkillerArchetype = SK_RIPPER

				H.my_skills.change_skill(SKILL_MELEE, 6)
				H.my_skills.change_skill(SKILL_UNARM, 3)
				H.my_skills.change_skill(SKILL_RANGE, 0)
				H.my_skills.change_skill(SKILL_CRAFT, 8)
				H.my_skills.change_skill(SKILL_CLIMB, 8)
				H.my_skills.change_skill(SKILL_KNIFE, 6)
				H.my_skills.change_skill(SKILL_SURG, 12)
				H.my_skills.change_skill(SKILL_SNEAK, 15)

				H.my_stats.change_stat(STAT_ST , 4)
				H.my_stats.change_stat(STAT_HT , 2)
				H.my_stats.change_stat(STAT_DX , 2)
				H.my_stats.set_stat(STAT_IN, 17) //smartypants

				H.add_perk(/datum/perk/morestamina)
				H.add_perk(/datum/perk/ref/silent)
				H.add_perk(/datum/perk/ref/jumper)
				H.add_perk(/datum/perk/ref/slippery)
				H.vice = "Dissecting"
				H.verbs -= /mob/living/carbon/human/proc/serialkillerArchetypes
				H.combat_music = 'sound/music/heartbeat.ogg'
				to_chat(H,"<span class='dreamershitbutitsbigasfuckanditsboldtoo'>The ritual of gutting insects satisfies you.</span>")
				H.updateStatPanel()
	
			if("The Mutilator")
				H.serialkillerArchetype = SK_MUTILATOR

				H.my_skills.change_skill(SKILL_MELEE, 17)
				H.my_skills.change_skill(SKILL_RANGE, 0)
				H.my_skills.change_skill(SKILL_CRAFT, 15)
				H.my_skills.change_skill(SKILL_CLIMB, 14)
				H.my_skills.change_skill(SKILL_KNIFE, 14)
				H.my_skills.change_skill(SKILL_SURG, 17)
				H.my_skills.change_skill(SKILL_SNEAK, 14)

				H.my_stats.change_stat(STAT_DX , 4)
				H.my_stats.change_stat(STAT_HT , 4)
				H.my_stats.set_stat(STAT_IN, 16) //smaller smartypants

				H.add_perk(/datum/perk/morestamina)
				H.add_perk(/datum/perk/ref/jumper)
				H.add_perk(/datum/perk/ref/slippery)
				H.vice = "Mutilating"
				H.verbs -= /mob/living/carbon/human/proc/serialkillerArchetypes


/datum/game_mode/serialkiller/pre_setup()
	var/list/possible_killers = get_players_for_antag()
	var/max_killer = 1

	for(var/j = 0, j < max_killer, j++)
		if (!possible_killers.len)
			break
		var/datum/mind/serialkiller_mind = pick(possible_killers)
		serialkiller += serialkiller_mind
		possible_killers.Remove(serialkiller)
	return 1


/datum/game_mode/serialkiller/post_setup()
	for(var/datum/mind/serialkiller_mind in serialkiller)
		spawn(rand(10,100))
			finalize_serialkiller(serialkiller_mind)
			serialkiller_greeting(serialkiller_mind)
			

	modePlayer += serialkiller
	return 1