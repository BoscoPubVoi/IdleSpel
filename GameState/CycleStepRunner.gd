class_name CycleStepRunner


static func runOneStep(sceneTree):
	Game.placeInCycle += 1
	Game.placeInCycle = Game.placeInCycle % Game.maxSupportedActions
	
	if Game.placeInCycle == 0:
		# No love anymore, sorry
		Game.resources["love"] = 0
		# Please go ahead and reset shit
		for character in Game.characters:
			character.onCycleStart()
	
	var placeInCycle = Game.placeInCycle
	var boosts = {}
	
	for character in Game.characters:
		sceneTree.get_first_node_in_group("Visualiser").assign_characters_to_buildings()
	
	var resourcesByBuilding = {}
	
	#early step
	for character in Game.characters:
		if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
			continue
		
		var currentExecutionState = ExecutionState.new(
			Game,
			character,
			placeInCycle,
			boosts,
			sceneTree
		)
		character.actions[placeInCycle].executeEarly(currentExecutionState)
		figure_out_resource_production(character, placeInCycle, resourcesByBuilding, currentExecutionState)
	
	for character in Game.characters:
		if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
			continue
		
		var currentExecutionState = ExecutionState.new(
			Game,
			character,
			placeInCycle,
			boosts,
			sceneTree
		)
		character.actions[placeInCycle].execute(currentExecutionState)
		figure_out_resource_production(character, placeInCycle, resourcesByBuilding, currentExecutionState)
		
	for character in Game.characters:
		if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
			continue
		
		var currentExecutionState = ExecutionState.new(
			Game,
			character,
			placeInCycle,
			boosts,
			sceneTree
		)
		character.actions[placeInCycle].executeLate(currentExecutionState)
		figure_out_resource_production(character, placeInCycle, resourcesByBuilding, currentExecutionState)
		
	# Post step, if there's plenty of love, we can maybe get a new character <3
	if Game.resources["love"] >= get_current_love_goal(Game):
		# Throw in a free new character
		var newCharacter = Character.new()
		newCharacter.constructor(Game.maxSupportedActions)
		Game.characters.push_back(newCharacter)
		var actorPanels = sceneTree.get_nodes_in_group("ActorPanel")
		for node in actorPanels:
			if node.characterID == len(Game.characters) - 1:
				node.visible = true

static func get_current_love_goal(gameState):
	if len(gameState.characters) >= 2:
		return 10000000000000000000
	return 1

static func figure_out_resource_production(character, placeInCycle, resourcesByBuilding, currentExecutionState):
	# Figure out how many resources were produced in this step per building
	var thisBuilding = character.actions[placeInCycle].building
	if ! resourcesByBuilding.has(thisBuilding):
		resourcesByBuilding[thisBuilding] = {}
	for res in currentExecutionState.totalResourcesByType:
		if !resourcesByBuilding[thisBuilding].has(res):
			resourcesByBuilding[thisBuilding][res] = currentExecutionState.totalResourcesByType[res]
		else:
			resourcesByBuilding[thisBuilding][res] += currentExecutionState.totalResourcesByType[res]
