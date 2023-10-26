class_name FullCycleResultEvaluator
static func evaluate(gameState:GameState):
	# Make a copy of the game state, then work on that
	var copiedGameState = gameState._duplicate()
	
	# Pretend cycle start
	copiedGameState.placeInCycle = 0
	copiedGameState.resources["love"] = 0
	for character in copiedGameState.characters:
		character.onCycleStart()
	
	
	# Go through the whole cycle
	for placeInCycle in copiedGameState.maxSupportedActions:
		var boosts = {}

		for character in copiedGameState.characters:
			if character.skipAllActionsThisCycle:
				continue
			
			if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
				continue

			var currentExecutionState = ExecutionState.new(
				copiedGameState,
				character,
				placeInCycle,
				boosts,
				null
			)
			character.actions[placeInCycle].executeEarly(currentExecutionState)

		for character in copiedGameState.characters:
			if character.skipAllActionsThisCycle:
				continue
			
			if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
				continue

			var currentExecutionState = ExecutionState.new(
				copiedGameState,
				character,
				placeInCycle,
				boosts,
				null
			)
			character.actions[placeInCycle].execute(currentExecutionState)

		for character in copiedGameState.characters:
			if character.skipAllActionsThisCycle:
				continue
				
			if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
				continue
			
			var currentExecutionState = ExecutionState.new(
				copiedGameState,
				character,
				placeInCycle,
				boosts,
				null
			)
			character.actions[placeInCycle].executeLate(currentExecutionState)

	return copiedGameState
