class_name BoostCharacterStatOfAllEqualToSelf extends Operation

@export var statToIncrease:String

func constructor(statToIncrease_):
	statToIncrease = statToIncrease_

func execute(executionState:ExecutionState):
	var boostAmount = executionState.currentCharacter.stats[statToIncrease]
	
	for char in executionState.gameState.characters:
		if char != executionState.currentCharacter:
			char.stats[statToIncrease] += boostAmount

func _duplicate():
	var newOperation = BoostCharacterStatOfAllEqualToSelf.new()
	newOperation.constructor(statToIncrease)
	return newOperation
