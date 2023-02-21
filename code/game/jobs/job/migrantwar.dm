/mob/living/carbon/human/proc/migequipwar()
	set hidden = 0
	set category = "gpc"
	set name = "ChoosemigrantClass"
	set desc="Choose your migrant class!"
	var/list/migclasses = list("Mushroomcutter", "Cook", "Mercenary","Miner","Acrobat","Healer","Pathfinder","Blacksmith","Hunter","Swineherd","Rifleman")
	var/firstmig
	var/secondmig
	var/thirdmig
	var/fourthmig
	var/mob/living/carbon/human/H = src
	if(H.religion == "Gray Church")
		migclasses.Add("Crusader")
	if(H.gender == FEMALE)
		migclasses.Add("Amuser")
	if(H.religion == "Thanati")
		migclasses.Add("Warrior")
		migclasses.Add("Bomber")
	firstmig = pick(migclasses)
	secondmig = pick(migclasses)
	thirdmig = pick(migclasses)
	fourthmig = pick(migclasses)
	H.remove_verb(/mob/living/carbon/human/proc/migequipwar)
	H.migclass = input(H,"Select a migrant class, you're on the [src.religion] side","MIGRANTS",H.migclass) in list(firstmig,secondmig,thirdmig,fourthmig)
	H.job = H.migclass
	H.old_job = H.migclass
	H << 'sound/Unready_Lobby.ogg'
	H.update_all_team_icons()
	if(master_mode == "holywar")
		if(H.religion == "Gray Church")
			for(var/obj/effect/landmark/L in landmarks_list)
				if (L.name == "GrayChurchWar")
					H.forceMove(L.loc)
					var/obj/item/device/radio/R = new /obj/item/device/radio/headset/syndicate(src)
					R.set_frequency(SEC_FREQ)
					H.equip_to_slot_or_del(R, slot_l_ear)
		else
			for(var/obj/effect/landmark/L in landmarks_list)
				if (L.name == "ThanatiWar")
					H.forceMove(L.loc)
					var/obj/item/device/radio/R = new /obj/item/device/radio/headset/syndicate(src)
					R.set_frequency(SYND_FREQ)
					H.equip_to_slot_or_del(R, slot_l_ear)
	switch(H.migclass)
		if("Mushroomcutter")
			H.equip_to_slot_or_del(new /obj/item/hatchet(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/plebhood(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/storage/backpack/migrant(H), slot_back)
			H.my_skills.change_skill(SKILL_MELEE, rand(7,7))
			H.my_skills.change_skill(SKILL_RANGE, rand(5,5))
			H.my_skills.change_skill(SKILL_FARM, rand(0,0))
			H.my_skills.change_skill(SKILL_CLIMB, rand(10,11))
			H.my_skills.change_skill(SKILL_COOK, rand(4,7))
			H.my_skills.change_skill(SKILL_MASON, 8)
			H.my_skills.change_skill(SKILL_CRAFT, 8)
			H.my_skills.change_skill(SKILL_ENGINE, rand(0,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,0))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,0))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,0))
			H.my_skills.change_skill(SKILL_UNARM, rand(0,1))
			H.my_skills.change_skill(SKILL_SWING, rand(0,2))
			H.my_stats.change_stat(STAT_ST, 1)
			H.my_stats.change_stat(STAT_HT, 1)
			H.my_stats.change_stat(STAT_DX, -1)
			H.my_stats.change_stat(STAT_IN, -1)
			H.add_perk(/datum/perk/illiterate)
		if("Amuser")
			if(H.gender == MALE)
				H.set_species("Femboy")
			var/pickamusersuit = pick("black","red")
			switch(pickamusersuit)
				if("red")
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/hooker(H), slot_wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/fetish(H), slot_shoes)
				if("black")
					H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/fetish/black(H), slot_shoes)
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/hooker/domina(H), slot_wear_suit)
					H.equip_to_slot_or_del(new /obj/item/clothing/gloves/fingerless(H), slot_gloves)
			H.equip_to_slot_or_del(new null(H), slot_w_uniform)
			H.my_skills.change_skill(SKILL_MELEE, rand(1,2))
			H.my_skills.change_skill(SKILL_RANGE, rand(-1,0))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_skills.change_skill(SKILL_COOK, rand(0,2))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(4,5))
			H.my_stats.change_stat(STAT_ST, -1)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, 3)
			H.my_stats.change_stat(STAT_IN, -1)
		if("Rifleman")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/military_jackey(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/stack/bullets/rifle/nine(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/gun/projectile/shotgun/princess(H), slot_r_hand)
			H.my_skills.change_skill(SKILL_MELEE, rand(1,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(4,6))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_skills.change_skill(SKILL_COOK, rand(0,2))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,2))
			H.my_stats.change_stat(STAT_HT, 1)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, 1)
		if("Bomber")
			H.set_species("Midget")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/thanati/thanati(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/silvermask(H), slot_wear_mask)
			H.equip_to_slot_or_del(new /obj/item/grenade/syndieminibomb/frag/suicide(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/grenade/syndieminibomb/frag/suicide(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/grenade/syndieminibomb/frag/suicide(H), slot_r_store)
			H.equip_to_slot_or_del(new /obj/item/grenade/syndieminibomb/frag/suicide(H), slot_l_store)
			H.my_skills.change_skill(SKILL_MELEE, rand(-1,1))
			H.my_skills.change_skill(SKILL_SWIM, rand(6,7))
			H.my_skills.change_skill(SKILL_CLIMB, rand(6,7))
			H.my_stats.change_stat(STAT_ST, -4)
			H.my_stats.change_stat(STAT_HT, -4)
			H.my_stats.change_stat(STAT_DX, 4)
			H.my_stats.change_stat(STAT_IN, -4)
			H.isbomber = TRUE
		if("Warrior")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/jackboots(H), slot_shoes)
			H.equip_to_slot_or_del(new /obj/item/kitchen/utensil/knife/dagger(H), slot_r_store)
			H.equip_to_slot_or_del(new /obj/item/flame/torch/on(H), slot_r_hand)
			var/banditweapon = pick("sword","spear","club")
			var/glovetype = pick("gauntlet","leather")
			var/armortype = pick("cuirass","breastplate","plate")
			var/helmettype = pick("elite","neckguard","open","skull")
			if(prob(45))
				H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/gorget/iron(H), slot_amulet)
			switch(glovetype)
				if("gauntlet")
					H.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat/gauntlet/steel(H), slot_gloves)
				if("leather")
					H.equip_to_slot_or_del(new /obj/item/clothing/gloves/botanic_leather(H), slot_gloves)

			switch(helmettype)
				if("elite")
					H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/lw/elitehelmet(H), slot_head)
				if("neckguard")
					H.equip_to_slot_or_del(new /obj/item/clothing/head/plebhood(H), slot_head)
				if("open")
					H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/lw/ironopenhelmet(H), slot_head)
				if("skull")
					H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/lw/openskulliron(H), slot_head)

			switch(armortype)
				if("cuirass")
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/iron_cuirass(H), slot_wear_suit)
				if("breastplate")
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/iron_breastplate(H), slot_wear_suit)
				if("plate")
					H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/iron_plate(H), slot_wear_suit)

			switch(banditweapon)
				if("sword")
					H.equip_to_slot_or_del(new /obj/item/claymore/falchion(H), slot_belt)
					H.equip_to_slot_or_del(new /obj/item/shield/wood(H), slot_l_hand)
				if("spear")
					H.equip_to_slot_or_del(new /obj/item/claymore/spear(H), slot_l_hand)
				if("club")
					H.equip_to_slot_or_del(new /obj/item/melee/classic_baton/smallclub(H), slot_belt)
					H.equip_to_slot_or_del(new /obj/item/shield/wood(H), slot_l_hand)
			H.my_skills.change_skill(SKILL_MELEE, rand(3,5))
			H.my_skills.change_skill(SKILL_RANGE, rand(1,2))
			H.my_skills.change_skill(SKILL_COOK, rand(0,2))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(-1,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(-1,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(-1,0))
			H.my_skills.change_skill(SKILL_CLIMB, rand(4,6))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_skills.change_skill(SKILL_STEAL, rand(3,5))
			H.my_stats.change_stat(STAT_ST, 2)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, 1)
		if("Hunter")
			H.equip_to_slot_or_del(new /obj/item/crossbow(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.my_skills.change_skill(SKILL_MELEE, rand(3,4))
			H.my_skills.change_skill(SKILL_RANGE, rand(3,4))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(2,3))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,2))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_stats.change_stat(STAT_ST, 1)
			H.my_stats.change_stat(STAT_HT, 1)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, 1)
		if("Swineherd")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			var/friend = /mob/living/simple_animal/pig
			new friend(H.loc)
			H.my_skills.change_skill(SKILL_MELEE, rand(0,2))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,2))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(2,4))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,2))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_stats.change_stat(STAT_ST, 1)
			H.my_stats.change_stat(STAT_HT, 1)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, 1)
		if("Cook")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/chefhat(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet(H), slot_r_store)
			H.equip_to_slot_or_del(new /obj/item/kitchen/utensil/knife(H), slot_l_store)
			H.equip_to_slot_or_del(new /obj/item/storage/backpack/coldpack(H), slot_back)
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_skills.change_skill(SKILL_MELEE, rand(0,2))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,2))
			H.my_skills.change_skill(SKILL_FARM, rand(2,3))
			H.my_skills.change_skill(SKILL_COOK, rand(3,7))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,4))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(1,5))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
		if("Mercenary")
			/*for(var/obj/effect/landmark/L in landmarks_list)
				if (L.name == "Mercenary")
					H.forceMove(L.loc)*/
			if(donation_seaspotter.Find(H.ckey) || tier_marduk.Find(H.ckey))
				H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/leather/seaspotter(H), slot_wear_suit)
				H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
				H.equip_to_slot_or_del(new /obj/item/sheath/claymore(H), slot_belt)
				H.equip_to_slot_or_del(new /obj/item/crossbow(H), slot_back)
				H.equip_to_slot_or_del(new /obj/item/arrow(H), slot_r_store)
				H.equip_to_slot_or_del(new /obj/item/arrow(H), slot_l_store)
				H.my_skills.change_skill(SKILL_MELEE, rand(2,3))
				H.my_skills.change_skill(SKILL_RANGE, rand(3,5))
				H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
				H.my_skills.change_skill(SKILL_COOK, rand(2,4))
				H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
				H.my_skills.change_skill(SKILL_SURG, rand(0,2))
				H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
				H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
				H.my_skills.change_skill(SKILL_CLIMB, rand(3,5))
				H.my_skills.change_skill(SKILL_SWIM, rand(5,7))
				H.my_stats.change_stat(STAT_ST, 2)
				H.my_stats.change_stat(STAT_HT, 1)
				H.my_stats.change_stat(STAT_DX, 1)
				H.my_stats.change_stat(STAT_IN, -1)
			else if(H.ckey in tier_marduk || H.ckey in donation_reddawn)
				H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/leather/reddawn(H), slot_wear_suit)
				H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
				H.equip_to_slot_or_del(new /obj/item/sheath/claymore(H), slot_belt)
				H.equip_to_slot_or_del(new /obj/item/crossbow(H), slot_back)
				H.equip_to_slot_or_del(new /obj/item/arrow(H), slot_r_store)
				H.equip_to_slot_or_del(new /obj/item/arrow(H), slot_l_store)
				H.my_skills.change_skill(SKILL_CLIMB, rand(3,5))
				H.my_skills.change_skill(SKILL_MELEE, rand(4,5))
				H.my_skills.change_skill(SKILL_RANGE, rand(4,5))
				H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
				H.my_skills.change_skill(SKILL_COOK, rand(1,3))
				H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
				H.my_skills.change_skill(SKILL_SURG, rand(0,3))
				H.my_skills.change_skill(SKILL_MEDIC, rand(0,3))
				H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
				H.my_skills.change_skill(SKILL_SWIM, rand(1,3))
				H.my_stats.change_stat(STAT_ST, 2)
				H.my_stats.change_stat(STAT_HT, 2)
				H.my_stats.change_stat(STAT_DX, 1)
				H.my_stats.change_stat(STAT_IN, -1)
			else
				H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/leather(H), slot_wear_suit)
				H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/security(H), slot_w_uniform)
				H.equip_to_slot_or_del(new /obj/item/sheath/claymore(H), slot_belt)
				H.equip_to_slot_or_del(new /obj/item/crossbow(H), slot_back)
				H.equip_to_slot_or_del(new /obj/item/arrow(H), slot_r_store)
				H.equip_to_slot_or_del(new /obj/item/arrow(H), slot_l_store)
				H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
				H.my_skills.change_skill(SKILL_MELEE, rand(2,3))
				H.my_skills.change_skill(SKILL_RANGE, rand(2,3))
				H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
				H.my_skills.change_skill(SKILL_CLIMB, rand(3,5))
				H.my_skills.change_skill(SKILL_COOK, rand(1,3))
				H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
				H.my_skills.change_skill(SKILL_SURG, rand(0,2))
				H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
				H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
				H.my_stats.change_stat(STAT_ST, 2)
				H.my_stats.change_stat(STAT_HT, 2)
				H.my_stats.change_stat(STAT_DX, 1)
				H.my_stats.change_stat(STAT_IN, -1)
		if("Miner")
			H.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/orange(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/breath(H), slot_wear_mask)
			H.equip_to_slot_or_del(new /obj/item/pickaxe(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/shovel(H), slot_belt)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/minerapron(H), slot_wear_suit)
			H.my_skills.change_skill(SKILL_MELEE, rand(1,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,3))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,5))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,2))
			H.my_skills.change_skill(SKILL_MASON, rand(4,6))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
			H.my_stats.change_stat(STAT_ST, 2)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, -1)
			H.my_stats.change_stat(STAT_IN, -2)
			H.stat = CONSCIOUS
			H.nutrition = 300
			H.can_stand = 1
			H.sleeping = 0
			H.update_inv_head()
			H.update_inv_wear_suit()
			H.update_inv_gloves()
			H.update_inv_shoes()
			H.update_inv_w_uniform()
			H.update_inv_glasses()
			H.update_inv_l_hand()
			H.update_inv_r_hand()
			H.update_inv_belt()
			H.update_inv_wear_id()
			H.update_inv_ears()
			H.update_inv_s_store()
			H.update_inv_pockets()
			H.update_inv_back()
			H.update_inv_handcuffed()
			H.update_inv_wear_mask()
			H.updateStatPanel()
			H.special_load()
		if("Engineer")
			H.equip_to_slot_or_del(new /obj/item/flame/torch/lantern/on(H), slot_r_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.my_skills.change_skill(SKILL_MELEE, rand(0,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,4))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_ENGINE, rand(5,7))
			H.my_skills.change_skill(SKILL_MASON, rand(5,7))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
			H.my_stats.change_stat(STAT_ST, 2)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, -1)
		if("Acrobat")
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/throwingknife/silver(H), slot_r_store)
			H.equip_to_slot_or_del(new /obj/item/throwingknife(H), slot_l_store)
			H.my_skills.change_skill(SKILL_MELEE, rand(0,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(4,7))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_CLIMB, rand(5,7))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_stats.change_stat(STAT_ST, -1)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, 4)
			H.my_stats.change_stat(STAT_IN, -1)
		if("Healer")
			H.equip_to_slot_or_del(new /obj/item/storage/firstaid/adv(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/healer(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/plaguedoctor(H), slot_wear_mask)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_skills.change_skill(SKILL_MELEE, rand(1,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,2))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(3,7))
			H.my_skills.change_skill(SKILL_MEDIC, rand(3,7))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_stats.change_stat(STAT_ST, -1)
			H.my_stats.change_stat(STAT_HT, -1)
			H.my_stats.change_stat(STAT_DX, 2)
			H.my_stats.change_stat(STAT_IN, 2)
		if("Pathfinder")
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/horsehead(H), slot_wear_mask)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.my_skills.change_skill(SKILL_MELEE, rand(0,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,3))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,5))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
			H.my_stats.change_stat(STAT_ST, 2)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, 1)
		if("Blacksmith")
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/apron(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/migrant(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/sledgehammer(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/alicate(H), slot_belt)
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_skills.change_skill(SKILL_MELEE, rand(1,3))
			H.my_skills.change_skill(SKILL_RANGE, rand(0,3))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,2))
			H.my_skills.change_skill(SKILL_MEDIC, rand(0,2))
			H.my_skills.change_skill(SKILL_CLEAN, rand(0,3))
			H.my_skills.change_skill(SKILL_SMITH, rand(4,7))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_stats.change_stat(STAT_ST, 2)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, -1)
			H.my_stats.change_stat(STAT_IN, -1)
		if("Crusader")
			H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/vest/iron_plate/crusader(H), slot_wear_suit)
			H.equip_to_slot_or_del(new /obj/item/clothing/under/rank/chaplain(H), slot_w_uniform)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/lw/crusader(H), slot_head)
			H.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat/gauntlet/steel(H), slot_gloves)
			H.equip_to_slot_or_del(new /obj/item/claymore/silver(H), slot_l_hand)
			H.equip_to_slot_or_del(new /obj/item/clothing/head/amulet/gorget/iron(H), slot_amulet)
			H.equip_to_slot_or_del(new /obj/item/sheath(H), slot_belt)
			H.equip_to_slot_or_del(new /obj/item/shield/crusader(H), slot_back)
			H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/paladin(H), slot_shoes)
			H.religion = "Gray Church"
			H.my_skills.change_skill(SKILL_MELEE, rand(3,5))
			H.my_skills.change_skill(SKILL_RANGE, rand(1,2))
			H.my_skills.change_skill(SKILL_FARM, rand(-1,0))
			H.my_skills.change_skill(SKILL_COOK, rand(-1,1))
			H.my_skills.change_skill(SKILL_ENGINE, rand(-1,0))
			H.my_skills.change_skill(SKILL_SURG, rand(0,3))
			H.my_skills.change_skill(SKILL_MEDIC, rand(1,3))
			H.my_skills.change_skill(SKILL_CLEAN, rand(-1,1))
			H.my_skills.change_skill(SKILL_SWIM, rand(-1,3))
			H.my_skills.change_skill(SKILL_CLIMB, rand(3,4))
			H.my_stats.change_stat(STAT_ST, 2)
			H.my_stats.change_stat(STAT_HT, 2)
			H.my_stats.change_stat(STAT_DX, 1)
			H.my_stats.change_stat(STAT_IN, -1)
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/lw/leatherboots(H), slot_shoes)
	H.equip_to_slot_or_del(new /obj/item/flame/torch/on(H), slot_r_hand)
	to_chat(H,"<color green>You're a <b>[H.migclass]</b></color>")
	H.stat = CONSCIOUS
	H.nutrition = 300
	H.can_stand = 1
	H.sleeping = 0
	H.update_inv_head()
	H.update_inv_wear_suit()
	H.update_inv_gloves()
	H.update_inv_shoes()
	H.update_inv_w_uniform()
	H.update_inv_glasses()
	H.update_inv_l_hand()
	H.update_inv_r_hand()
	H.update_inv_belt()
	H.update_inv_wear_id()
	H.update_inv_ears()
	H.update_inv_s_store()
	H.update_inv_pockets()
	H.update_inv_back()
	H.update_inv_handcuffed()
	H.update_inv_wear_mask()
	H.updateStatPanel()
	H.special_load()
