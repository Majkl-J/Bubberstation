/mob/verb/lick(atom/lickify as mob|obj|turf in range(1, src))
	set name = "Lick"
	set category = "IC"

	DEFAULT_QUEUE_OR_CALL_VERB(VERB_CALLBACK(src, PROC_REF(run_licking), lickify))
