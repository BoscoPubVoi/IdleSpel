class_name BoostCharacterStatOfAll extends Operation

@export var statToIncrease:String
@export var amount:int = 0

func constructor(statToIncrease_):
	statToIncrease = statToIncrease_

func execute(executionState:ExecutionState):
	var boostAmount = amount
	
	for char in executionState.gameState.characters:
		if char != executionState.currentCharacter:
			char.stats[statToIncrease] += boostAmount

func _duplicate():
	var newOperation = BoostCharacterStatOfAll.new()
	newOperation.constructor(statToIncrease)
	newOperation.amount = amount
	return newOperation
