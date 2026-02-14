GLOBAL_DATUM_INIT(manifest, /datum/manifest, new)

/datum/manifest

/datum/manifest/proc/get_manifest()
	var/list/manifest_out = list(
		"Command",
		"Camarilla Authorities",
		"Camarilla Primogen Council",
		"Tremere",
		"Giovanni Family",
		"Unaligned",
		"Anarchs",
		"Warehouse",
		"City Services",
		"Church",
		"Police Force",
		"National Security",
		"Triads",
		"Tzimisce Mansion"
	)

	var/list/departments = list(
		"Command" = GLOB.leader_positions,
		"Camarilla Authorities" = GLOB.command_positions,
		"Camarilla Primogen Council" = GLOB.camarilla_council_positions,
		"Tremere" = GLOB.tremere_positions,
		"Giovanni Family" = GLOB.giovanni_positions,
		"Unaligned" = GLOB.citizen_positions,
		"Anarchs" = GLOB.anarch_positions,
		"Warehouse" = GLOB.warehouse_positions,
		"City Services" = GLOB.services_positions,
		"Church" = GLOB.church_positions,
		"Police Force" = GLOB.police_positions,
		"National Security" = GLOB.national_security_positions,
		"Triads" = GLOB.gang_positions,
		"Tzimisce Mansion" = GLOB.tzimisce_positions,
		"Criminal" = GLOB.criminal_positions
	)
	for(var/datum/data/record/t in GLOB.data_core.general)
		var/name = t.fields["name"]
		var/rank = t.fields["rank"]
		var/has_department = FALSE
		for(var/department in departments)
			var/list/jobs = departments[department]
			if(rank in jobs)
				if(!manifest_out[department])
					manifest_out[department] = list()
				manifest_out[department] += list(list(
					"name" = name,
					"rank" = rank
				))
				has_department = TRUE
		if(!has_department)
			if(!manifest_out["Misc"])
				manifest_out["Misc"] = list()
			manifest_out["Misc"] += list(list(
				"name" = name,
				"rank" = rank
			))
	for (var/department in departments)
		if (!manifest_out[department])
			manifest_out -= department
	return manifest_out

/datum/manifest/ui_state(mob/user)
	return GLOB.always_state

/datum/manifest/ui_status(mob/user, datum/ui_state/state)
	return (isnewplayer(user) || isobserver(user) || isAI(user) || ispAI(user) || user.client?.holder) ? UI_INTERACTIVE : UI_CLOSE

/datum/manifest/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CrewManifest")
		ui.open()

/datum/manifest/ui_data(mob/user)
	return list(
		"manifest" = get_manifest()
	)
