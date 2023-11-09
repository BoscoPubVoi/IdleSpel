class_name FullCycleResultEvaluator
static func evaluate(gameState:GameState):
	# Make a copy of the game state, then work on that
	var copiedGameState = gameState._duplicate()
	copiedGameState.mockResourcesAt = copiedGameState.resources.duplicate()
	var productionPerCharacter = []
	
	for char in copiedGameState.characters:
		productionPerCharacter.push_back({})
	
	# Pretend we have so many resources, you won't believe it
	for res in copiedGameState.resources:
		copiedGameState.resourceCaps[res] = 100000000
		copiedGameState.resources[res] = 10000000
	
	# Pretend cycle start
	copiedGameState.placeInCycle = 0
	copiedGameState.resources["love"] = 0
	for character in copiedGameState.characters:
		character.onCycleStart()
	
	
	# Go through the whole cycle
	for placeInCycle in copiedGameState.maxSupportedActions:
		copiedGameState.placeInCycle = placeInCycle
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

		for i in len(copiedGameState.characters):
			var character = copiedGameState.characters[i]
			
			if character.skipAllActionsThisCycle:
				continue
			
			if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
				continue
				
			var resourcesPre = copiedGameState.resources.duplicate()

			var currentExecutionState = ExecutionState.new(
				copiedGameState,
				character,
				placeInCycle,
				boosts,
				null
			)
#			
			character.actions[placeInCycle].execute(currentExecutionState)
			
			for res in copiedGameState.resources:
				if copiedGameState.resources[res] != resourcesPre[res]:
					var addProd = copiedGameState.resources[res] - resourcesPre[res]
					if productionPerCharacter[i].has(res):
						productionPerCharacter[i][res] += addProd
					else:
						productionPerCharacter[i][res] = addProd
		
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

	return productionPerCharacter
	
	# return copiedGameState
