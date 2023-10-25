class_name ConsumeStatAndDo extends Operation

@export var statToCheck:String
@export var statMinimum:float
@export var forAllCharacters:bool
@export var operation:Operation

func construct(statToCheck_, statMinimum_, forAll_, operation_):
	statToCheck = statToCheck_
	statMinimum = statMinimum_
	forAllCharacters = forAll_
	operation = operation_


func execute(executionState:ExecutionState):
	if forAllCharacters:
		var failed = false
		for char in executionState.gameState.characters:
			if executionState.currentCharacter.stats[statToCheck] < statMinimum:
				failed = true
		if !failed:
			for char in executionState.gameState.characters:
				executionState.currentCharacter.stats[statToCheck] -= statMinimum
			
				operation.execute(executionState)
	else:
		if executionState.currentCharacter.stats[statToCheck] >= statMinimum:
			executionState.currentCharacter.stats[statToCheck] -= statMinimum
			operation.execute(executionState)

func _duplicate():
	var newOperation = ConsumeStatAndDo.new()
	newOperation.construct(statToCheck, statMinimum, forAllCharacters, operation._duplicate())
	return newOperation
