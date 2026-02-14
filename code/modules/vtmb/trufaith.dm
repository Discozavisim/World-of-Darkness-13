
/proc/get_trufaith_level(mob/M)
	if(!M?.client?.prefs)
		return 0
	if(!SSwhitelists.is_whitelisted(M.client.ckey, "trufaith", M.client.prefs.real_name))
		return 0
	return M.client.prefs.trufaith_level
