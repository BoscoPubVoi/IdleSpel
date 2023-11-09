extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	if not FileAccess.file_exists("user://idlemoonkingdom.save"):
		return # Start a new game
	var save_game = FileAccess.open("user://idlemoonkingdom.save", FileAccess.READ)
	var dat = save_game.get_line()
	
	var json = JSON.new()
	
	var parse_result = json.parse(dat)
	if parse_result != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", dat, " at line ", json.get_error_line())
		return

	var node_data = json.get_data()
	load_our_game(node_data)
	Game.wasFromLoaded = true

func load_our_game(dat):
	AudioManager.muted = true
	
	Game.restore_state(dat.gameState, get_tree())
	# Restore actions to their rightful positions
	var actionIdents = get_tree().get_nodes_in_group("ActionIndent")
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
			
	# Restore the rest of the game state
	var currentExecutionState = ExecutionState.new(
		Game,
		null,
		0,
		{},
		get_tree()
	)
	if Game.buildings.has("monument") && Game.buildings["monument"] >= 1:
		currentExecutionState.unlockActionLocations(0)
		currentExecutionState.unlockActionsGroup("monument1")
		currentExecutionState.setMonumentTier(1)
		currentExecutionState.unlockBuilding("monument")
	if Game.buildings.has("monument") && Game.buildings["monument"] >= 2:
		currentExecutionState.unlockActionLocations(1)
		currentExecutionState.unlockActionsGroup("monument2")
		currentExecutionState.setMonumentTier(2)
	if Game.buildings.has("monument") && Game.buildings["monument"] >= 3:
		currentExecutionState.unlockActionLocations(2)
		currentExecutionState.unlockActionsGroup("monument3")
		currentExecutionState.setMonumentTier(3)
	if Game.buildings.has("monument") && Game.buildings["monument"] - floor(Game.buildings["monument"]) > 0:
		currentExecutionState.setBuildInProgress("monument")
		currentExecutionState.setMonumentInProgress(ceil(Game.buildings["monument"]))

	for bld in Game.buildings:
		if bld == "monument":
			continue
		
		if Game.buildings[bld] >= 1:
			currentExecutionState.unlockActionsGroup(bld)
			currentExecutionState.unlockBuilding(bld, true)
		elif Game.buildings[bld] > 0:
			currentExecutionState.setBuildInProgress(bld)
	
	# unlock actions where appropriate
	var allActions = find_all_action_nodes(get_tree().get_root())
	for action in allActions:
		if !action.unlocked:
			if dat.gameState.has("unlockedActions") && dat.gameState.unlockedActions.has(action.name):
				action.unlocked = true
				action.set_display()
				
				# Perform a Fertility Ritual
				if action.action_name == "Fertility Ritual":
					get_tree().get_first_node_in_group("love").visible = true
		
	# hide any message plz
	$"../PopupWindow".visible = false
	
	# Unlock actors
	var actorPanels = get_tree().get_nodes_in_group("ActorPanel")
	for node in actorPanels:
		if node.characterID <= len(Game.characters) - 1:
			node.visible = true
			
	
	AudioManager.muted = false
	

	var optionsButton = $"../AllActorsPanel/MarginContainer/ScrollContainer/MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/Loadouts/OptionButton"
	for lo in optionsButton.item_count:
		optionsButton.set_item_text(lo, dat.loadoutNames[lo])



func _on_timeout():
	var save_game = FileAccess.open("user://idlemoonkingdom.save", FileAccess.WRITE)
	var data = {}
	data.gameState = Game.get_save_dict();
	
	data.gameState.unlockedActions = {}
	var allActions = find_all_action_nodes(get_tree().get_root())
	for action in allActions:
		if action.unlocked:
			data.gameState.unlockedActions[action.name] = true
			
	var optionsButton = $"../AllActorsPanel/MarginContainer/ScrollContainer/MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer/Loadouts/OptionButton"
	data.loadoutNames = []
	for lo in optionsButton.item_count:
		data.loadoutNames.push_back(optionsButton.get_item_text(lo))

	save_game.store_line(JSON.stringify(data))
	
	save_game.close()

func find_all_action_nodes(node):
	var found_nodes = []
	
	if node is ActionIcon:
		found_nodes.append(node)

	if node is Node:
		for child in node.get_children():
			found_nodes += find_all_action_nodes(child)
	
	return found_nodes
