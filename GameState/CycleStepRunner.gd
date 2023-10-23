class_name CycleStepRunner
static func runOneStep():
	Game.placeInCycle += 1
	Game.placeInCycle = Game.placeInCycle % Game.maxSupportedActions
	
	var placeInCycle = Game.placeInCycle
	for character in Game.characters:
		if placeInCycle >= len(character.actions) || character.actions[placeInCycle] == null:
			continue
		
		var currentExecutionState = ExecutionState.new(
			Game,
			character,
			placeInCycle
		)
		character.actions[placeInCycle].execute(currentExecutionState)
