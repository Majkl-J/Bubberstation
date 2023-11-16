/obj/item/circuitboard/computer/syndicate/trade
	name = "Syndicate trade network computer board"
	build_path = /obj/machinery/computer/syndicate/trade

/obj/machinery/computer/syndicate/trade
	name = "Syndicate trade network console"

	req_access = list(ACCESS_SYNDICATE)
	circuit = /obj/item/circuitboard/computer/syndicate/trade

/obj/machinery/computer/syndicate/trade/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ZubbersSyndicateTrade")
		ui.open()
