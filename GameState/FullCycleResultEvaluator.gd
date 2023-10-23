class_name FullCycleResultEvaluator
static func evaluate(gameState:GameState):
	# Make a copy of the game state, then work on that
	var copiedGameState = gameState._duplicate()
	
	# Go through the whole cycle
	for placeInCycle in copiedGameState.maxSupportedActions:
		for character in copiedGameState.characters:
			if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
				continue
			
			var currentExecutionState = ExecutionState.new(
				copiedGameState,
				character,
				placeInCycle
			)
			character.actions[placeInCycle].execute(currentExecutionState)
		
	return copiedGameState
