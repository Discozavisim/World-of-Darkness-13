/datum/preferences/proc/calculate_loadout_dots()
	loadout_slots_max = CONFIG_GET(number/max_loadout_items)
	loadout_slots = length(equipped_gear)

	loadout_dots_max = CONFIG_GET(number/base_loadout_points)
	loadout_dots = CONFIG_GET(number/base_loadout_points)
	if(!equipped_gear || !length(equipped_gear))
		return

	for(var/i = 1, i <= length(equipped_gear), i++)
		var/datum/gear/selected_gear = SSloadout.gear_datums[equipped_gear[i]]
		loadout_dots -= selected_gear.cost
	if(loadout_slots < 0)
		CRASH("Error - More Loadout Slots have been used then there are to begin with.")

/datum/preferences/proc/process_loadout_links(mob/user, list/href_list)
	switch(href_list["task"])
		if("clear_loadout")
			if(tgui_alert(user, "Are you sure you want to reset your loadout?", "Confirmation", list("Yes", "No")) == "Yes")
				equipped_gear.Cut()
		if("toggle_loadout")
			show_loadout = !show_loadout
		if("select_category")
			gear_tab = href_list["gear_category"]
			if(!gear_tab)
				gear_tab = "General"
			return FALSE
		if("add_gear")
			if(loadout_slots >= loadout_slots_max)
				return FALSE
			var/datum/gear/new_gear = SSloadout.gear_datums[href_list["gear"]]
			if(!new_gear)
				return FALSE
			if(new_gear.cost > loadout_dots)
				return FALSE

			equipped_gear += href_list["gear"]

		if("remove_gear")
			equipped_gear -= href_list["gear"]
	return TRUE

/datum/preferences/proc/Loadout(mob/user, list/dat)
	dat += "<center><h2>[make_font_cool("LOADOUT")]</h2></center>"

	calculate_loadout_dots()
	dat += "<table align='center' width='100%'>"
	dat += "<tr><td colspan=5><b><center>Slots Used: [loadout_slots]/[loadout_slots_max].<br>"
	dat += "Remaining Dots: [loadout_dots]/[loadout_dots_max].<br>"
	dat += "<a href='?_src_=prefs;preference=gear;task=clear_loadout;'>Clear Loadout</a> | <a href='?_src_=prefs;preference=gear;task=toggle_loadout;'>Toggle Loadout</a></center></b></td></tr>"
	dat += "<tr><td colspan=5><center><b>"

	var/firstcat = 1
	for(var/category in SSloadout.loadout_categories)
		if(firstcat)
			firstcat = 0
		else
			dat += " |"
		if(category == gear_tab)
			dat += " <span class='linkOff'>[category]</span> "
		else
			dat += " <a href='?_src_=prefs;preference=loadout;task=select_category;gear_category=[category]'>[category]</a> "
	dat += "</b></center></td></tr>"

	var/datum/loadout_category/loadout_category = SSloadout.loadout_categories[gear_tab]
	dat += "<tr><td colspan=5><hr></td></tr>"
	dat += "<tr><td colspan=5><b><center>[loadout_category.category]</center></b></td></tr>"
	dat += "<tr><td colspan=5><hr></td></tr>"
	dat += "<tr>"
	dat += "<td></td>"
	dat += "<td><b><center>Count</b><center></td>"
	dat += "<td><b><center>Name</b><center></td>"
	dat += "<td></td>"
	dat += "<td><b><center>Description</b><center></td>"
	dat += "<tr><td colspan=5><hr></td></tr>"
	var/i = 1
	for(var/gear_name in loadout_category.gear)
		var/datum/gear/category_gear = loadout_category.gear[gear_name]
		var/equipped = src.equipped_gear.Find(category_gear.display_name)
		var/equipped_count = 0
		if(equipped)
			for(var/equipped_gear_name in src.equipped_gear)
				if(category_gear.display_name == equipped_gear_name)
					equipped_count += 1
			dat += "<tr style='vertical-align:top; background-color:rgba(0, 125, 0, 0.2);'>"
		else if( (i % 2) == 0)
			dat += "<tr style='vertical-align:top; background-color:rgba(128, 128, 128, 0.2);'>"
		else
			dat += "<tr style='vertical-align:top; background-color:rgba(64, 64, 64, 0.2);'>"
		i++
		dat += "<td width=5%><p style='vertical-align: middle;'><center>"
		if(!category_gear.cost)
			dat += "<font size=5>○</font>"
		else
			for (var/y in 1 to category_gear.cost)
				dat += "<font size=5>●</font>"
		dat += "</center></p></td>"
		dat += "<td width=5%><p style='vertical-align: middle;'><center><b>(</b> [equipped_count] <b>)</b></center><p></td>"
		dat += "<td width=25%><p style='vertical-align: middle;'><center>[category_gear.display_name]</p></center></td>"
		dat += "<td width=15%><p style='vertical-align: middle;'><center>"
		if((loadout_slots < loadout_slots_max) && (category_gear.cost < loadout_dots))
			dat += "<a style='white-space:normal;' href='?_src_=prefs;preference=loadout;task=add_gear;gear=[category_gear.display_name]'>Add</a>"
			if(equipped)
				dat += " - "
		if(equipped)
			dat += "<a style='white-space:normal;' href='?_src_=prefs;preference=loadout;task=remove_gear;gear=[category_gear.display_name]'>Remove</a>"
		dat += "</center></p></td>"
		dat += "<td><p style='vertical-align: middle;'><font size=2><i>[category_gear.description]"
		if(category_gear.allowed_roles && length(category_gear.allowed_roles))
			dat += " - [english_list(category_gear.allowed_roles, null, ", ")]"
		dat += "</i></font></p></td></tr>"
	dat += "</table>"
