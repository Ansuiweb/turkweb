/datum/game_mode
	// this includes admin-appointed traitors and multitraitors. Easy!
	var/list/datum/mind/traitcerb = list()

/datum/game_mode/traitcerb
	name = "Traitor Tiamat"
	config_tag = "traitcerb"
	restricted_jobs = list("Cyborg")//They are part of the AI if he is traitor so are they, they use to get double chances
	required_players = 1
	required_enemies = 1
	recommended_enemies = 1

/datum/game_mode/traitcerb/announce()
	spawn(400)
		to_chat(world, "<span class='baronboldoutlined'>One of the Tiamatii is a traitor!</span> <span class='baron'>Rumors about the turncoat have tormented the fortress for weeks, but the villain`s identity has yet to be uncovered.</span>")

/datum/game_mode/traitcerb/can_start()
	if(forcestart == TRUE)
		return 1
	else
		for(var/mob/new_player/player in player_list)
			for(var/mob/new_player/player2 in player_list)
				if(player.ready && player.client.work_chosen == "Baron" && player2.ready && player2.client.work_chosen == "Merchant")
					return 1
	return 0

/datum/game_mode/proc/greet_cerb(var/datum/mind/traitorcerb)
	//ticker.mode.learn_basic_spells(current)
	to_chat(traitorcerb.current, "<span class='baronboldoutlined'>You are the Turncoat Tiamat </span><span class='baron'>Your pay is pathetic, your tasks are suicidal, and the Thanati offered you enough wealth to buy a dozen fortresses.</span>")
	to_chat(traitorcerb.current, "<span class='baronboldoutlined'>OBJECTIVE: </span><span class='baron'>Assassinate the Baron and survive with your ring.</span>")

/datum/game_mode/proc/finalize_cerb(var/datum/mind/traitorcerb)
	traitorcerb.special_role = "traitcerb"
	var/mob/living/carbon/human/H = traitorcerb.current
	H.combat_music = 'sound/lfwbsounds/bloodlust1.ogg'

/datum/game_mode/traitcerb/pre_setup()
	var/list/possible_traitcerb = get_players_for_role(BE_TRAITOR)
	var/max_traitcerb = 1

	for(var/datum/mind/player in possible_traitcerb)
		if(player.assigned_role != "Tiamat")
			possible_traitcerb -= player
	for(var/j = 0, j < max_traitcerb, j++)
		if (!possible_traitcerb.len)
			break
		var/datum/mind/traitorcerb_mind = pick(possible_traitcerb)
		traitcerb += traitorcerb_mind
		possible_traitcerb.Remove(traitcerb)
	return 1



/datum/game_mode/traitcerb/post_setup()
	for(var/datum/mind/traitorcerberus in traitcerb)
		spawn(rand(10,100))
			finalize_cerb(traitorcerberus)
			greet_cerb(traitorcerberus)

	modePlayer += dreamer
	return 1

/datum/game_mode/dreamer/declare_completion()
	to_chat(world, "\n<span class='ricagames'>[vessel_name()] (Story #1)</span>")
	to_chat(world, "\n<span class='dreamershitbutitsbigasfuckanditsboldtoo'>			     The Traitor</span>\n\n\n")
	var/amountswon = 0
	var/mob/living/carbon/human/cerberustraedo = null
	for(var/mob/living/carbon/human/H in world)
		if(H.job == "Baron" && H.stat == DEAD)
			amountswon++
		if(H.job == "Tiamat" && H.stat == 0 && H.mind.special_role == "traitcerb")
			cerberustraedo = H
			var/list/all_items = H.get_contents()
			for(var/obj/item/I in all_items)
				if(istype(I, /obj/item/card/id/lord))
					amountswon++

	if(amountswon >= 0)
		to_chat(world, "<span class='dreamershitfuckcomicao1'>Starring: [capitalize(pick(cerberustraedo.ckey))]</span>")
		cerberustraedo.client.ChromieWinorLoose(-5)

	if(amountswon >= 2)
		to_chat(world, "<span class='dreamershitfuckcomicao1'>Estrelando: [capitalize(pick(cerberustraedo.ckey))]</span>")
		to_chat(world, "<span class='dreamershitbutitsactuallypassivebutitactuallyisbigandbold'>The Traitor Tiamat succeeded!</span>")
		traitcerb.farwebcompletionantagonist = 1

	if(traitcerb.farwebcompletionantagonist)
		cerberustraedo.client.ChromieWinorLoose(6)
