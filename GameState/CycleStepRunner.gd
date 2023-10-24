class_name CycleStepRunner


static func runOneStep(sceneTree):
	Game.placeInCycle += 1
	Game.placeInCycle = Game.placeInCycle % Game.maxSupportedActions
	
	if Game.placeInCycle == 0:
		# Please go ahead and reset shit
		for character in Game.characters:
			character.onCycleStart()
	
	var placeInCycle = Game.placeInCycle
	var boosts = {}
	
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
