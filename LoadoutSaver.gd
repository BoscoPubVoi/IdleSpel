class_name LoadoutSaver

static func save_loadout():
	var loadout = Game.get_loadout()
	print(loadout)
	return loadout

static func load_loadout(savedLoadout, tree):
	# Restore all actions currently on characters
	var actionIdents = tree.get_nodes_in_group("ActionIndent")
	for ai in actionIdents:
		if ai.current_data != null:
			tree.get_first_node_in_group("ActionsPanel").reset_action(ai.current_data["original_original"])
			ai.empty_slot()
	
	Game.restore_loadout(savedLoadout, tree)
	
	# Restore actions to their rightful positions
	for ai in actionIdents:
		var slot = ai._get_index()
		var par = ai.get_parent()
		while par != null && !par.is_in_group("ActorPanel"):
			par = par.get_parent()
		
		if par.characterID >= len(Game.characters):
			continue
		
		var char = Game.characters[par.characterID];
		var act = char.actions[slot]
		
		if act != null:
			var data = act._save_origNode.get_drag_data_unconstrained()
			data["target_slot"] = null
			ai._drop_data(null, data)
