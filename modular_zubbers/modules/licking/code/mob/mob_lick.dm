/mob/verb/lick(atom/lickify as mob|obj|turf in range(1, src))
	set name = "Lick"
	set category = "IC"

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(run_licking), lickify))

/mob/proc/run_licking(atom/examinify)
	if(isturf(examinify) && !(sight & SEE_TURFS) && !(examinify in view(client ? client.view : world.view, src)))
		// shift-click catcher may issue examinate() calls for out-of-sight turfs
		return

	var/turf/examine_turf = get_turf(examinify)
	if(is_blind()) //blind people see things differently (through touch)
		if(!blind_examine_check(examinify))
			return
	else if(examine_turf && !(examine_turf.luminosity || examine_turf.dynamic_lumcount) && \
		get_dist(src, examine_turf) > 1 && \
		!has_nightvision()) // If you aren't blind, it's in darkness (that you can't see) and farther then next to you
		return

	face_atom(examinify)
	var/list/result
	if(client)
		LAZYINITLIST(client.recent_examines)
		var/ref_to_atom = ref(examinify)
		var/examine_time = client.recent_examines[ref_to_atom]
		if(examine_time && (world.time - examine_time < EXAMINE_MORE_WINDOW))
			result = examinify.examine_more(src)
			if(!length(result))
				result += span_notice("<i>You examine [examinify] closer, but find nothing of interest...</i>")
		else
			result = examinify.lickxamine(src)
			client.recent_examines[ref_to_atom] = world.time // set to when we last normal examine'd them
			addtimer(CALLBACK(src, PROC_REF(clear_from_recent_examines), ref_to_atom), RECENT_EXAMINE_MAX_WINDOW)
			handle_eye_contact(examinify)
	else
		result = examinify.lickxamine(src) // if a tree is examined but no client is there to see it, did the tree ever really exist?

	//SKYRAT EDIT CHANGE
	if(result.len)
		for(var/i = 1; i <= length(result); i++)
			if(result[i] != EXAMINE_SECTION_BREAK)
				result[i] += "\n"
			else
				// remove repeated <hr's> and ones on the ends.
				if((i == 1) || (i == length(result)) || (result[i - 1] == EXAMINE_SECTION_BREAK))
					result.Cut(i, i + 1)
					i--
	//SKYRAT EDIT END

	to_chat(src, examine_block("<span class='infoplain'>[result.Join()]</span>"))
	SEND_SIGNAL(src, COMSIG_MOB_EXAMINATE, examinify)
