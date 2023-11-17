/obj/item/circuitboard/computer/syndicate/trade
	name = "Syndicate trade network computer board"
	build_path = /obj/machinery/computer/syndicate/trade

/obj/machinery/computer/syndicate/trade
	name = "Syndicate trade network console"

	req_access = list(ACCESS_SYNDICATE)
	circuit = /obj/item/circuitboard/computer/syndicate/trade

	///The landing pad connected to the trade computer
	var/datum/weakref/landing_pad

	///Easy linking to the landing pad as part of a map
	var/mapping_id

/obj/machinery/computer/syndicate/trade/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/syndicate/trade/LateInitialize()
	. = ..()
	locate_machinery()

/obj/machinery/computer/syndicate/trade/locate_machinery(multitool_connection)
	if(!mapping_id)
		return
	for(var/obj/machinery/syndicate/trade/landing_pad/main as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/syndicate/trade/landing_pad))
		if(main.mapping_id != mapping_id)
			continue
		register_machine(main)
		return

/obj/machinery/computer/syndicate/trade/proc/register_machine(machine)
	landing_pad = WEAKREF(machine)

/obj/machinery/computer/syndicate/trade/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ZubbersSyndicateTrade")
		ui.open()
