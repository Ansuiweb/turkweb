/proc/is_murderer(mob/living/carbon/human/M)
    return (M && M.mind && M.mind.special_role == "Murderer")