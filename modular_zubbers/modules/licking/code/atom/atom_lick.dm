/atom
	var/lick_taste = "The fabric of reality"


/atom/proc/lickxamine(mob/user)
	var/lick_string = get_lick_string(user, thats = TRUE)
	if(lick_string)
		. = list("[lick_string].", EXAMINE_SECTION_BREAK) // SKYRAT EDIT CHANGE
	else
		. = list()

	. += get_name_chaser(user)
	if(lick_taste)
		. += lick_taste

	if(custom_materials)
		// SKYRAT EDIT ADDITION BEGIN - HR sections
		if(length(custom_materials) > 1)
			. += EXAMINE_SECTION_BREAK //SKYRAT EDIT ADDITION
		//SKYRAT EDIT ADDITION END
		var/list/materials_list = list()
		for(var/custom_material in custom_materials)
			var/datum/material/current_material = GET_MATERIAL_REF(custom_material)
			materials_list += "[current_material.name]"
		. += "<u>Its composition tastes like [english_list(materials_list)]</u>."
		// SKYRAT EDIT ADDITION BEGIN - HR sections
		if(length(custom_materials) > 1)
			. += EXAMINE_SECTION_BREAK //SKYRAT EDIT ADDITION
		//SKYRAT EDIT ADDITION END

	if(reagents)
		var/user_sees_reagents = user.can_see_reagents()
		var/reagent_sigreturn = SEND_SIGNAL(src, COMSIG_ATOM_REAGENT_EXAMINE, user, ., user_sees_reagents)
		if(!(reagent_sigreturn & STOP_GENERIC_REAGENT_EXAMINE))
			if(reagents.flags & TRANSPARENT)
				if(reagents.total_volume)
					. += "You can taste <b>[reagents.total_volume]</b> units of various reagents[user_sees_reagents ? ":" : "."]"
					if(user_sees_reagents) //Show each individual reagent for detailed examination
						for(var/datum/reagent/current_reagent as anything in reagents.reagent_list)
							. += "&bull; [round(current_reagent.volume, CHEMICAL_VOLUME_ROUNDING)] units of [current_reagent.name]"
						if(reagents.is_reacting)
							. += span_warning("You can taste the solution reacting!")
						. += span_notice("You can determine by taste that the solution's PH is [round(reagents.ph, 0.01)] and that it has a temperature of [reagents.chem_temp]K.")

				else
					. += "You can also taste:<br>Nothing."
			else if(reagents.flags & AMOUNT_VISIBLE)
				if(!reagents.total_volume)
					. += span_danger("There's nothing to taste inside it.")

	SEND_SIGNAL(src, COMSIG_ATOM_LICK, user, .)

/atom/proc/lick_more(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	RETURN_TYPE(/list)

	. = list()
	SEND_SIGNAL(src, COMSIG_ATOM_LICK_MORE, user, .)
	SEND_SIGNAL(user, COMSIG_MOB_LICKING_MORE, src, .)

/atom/proc/get_lick_string(mob/user, thats = FALSE)
	return "[icon2html(src, user)] [thats? "You get a good taste of ":""][get_lick_name(user)]"

/atom/proc/get_lick_name(mob/user)
	. = "\a <b>[src]</b>"
	var/list/override = list(gender == PLURAL ? "some" : "a", " ", "[name]")
	if(article)
		. = "[article] <b>[src]</b>"
		override[EXAMINE_POSITION_ARTICLE] = article
	if(SEND_SIGNAL(src, COMSIG_ATOM_GET_EXAMINE_NAME, user, override) & COMPONENT_EXNAME_CHANGED)
		. = override.Join("")

/atom/proc/get_id_lick_strings(mob/user)
	. = list()
	return


/atom/ShiftClick(mob/user)
	var/flags = SEND_SIGNAL(user, COMSIG_CLICK_SHIFT, src)
	if(flags & COMSIG_MOB_CANCEL_CLICKON)
		return
	if(user.client && (user.client.eye == user || user.client.eye == user.loc || flags & COMPONENT_ALLOW_EXAMINATE))
		user.lick(src)
