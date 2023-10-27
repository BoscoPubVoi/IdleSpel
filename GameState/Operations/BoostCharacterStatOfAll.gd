class_name BoostCharacterStatOfAll extends Operation

@export var statToIncrease:String
@export var amount:int

func constructor(statToIncrease_):
	statToIncrease = statToIncrease_

func execute(executionState:ExecutionState):
	var boostAmount = amount
	
	for char in executionState.gameState.characters:
		if char != executionState.currentCharacter:
			char.stats[statToIncrease] += boostAmount

func _duplicate():
	var newOperation = BoostCharacterStatOfAllEqualToSelf.new()
	newOperation.constructor(statToIncrease)
	return newOperation
