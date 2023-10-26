class_name CheckStatOther extends Operation

@export var statToCheck:String
@export var statMinimum:float
@export var minPeopleWithStat:int
@export var operation:Operation

func construct(statToCheck_, statMinimum_, minPeopleWithStat_, operation_):
	statToCheck = statToCheck_
	statMinimum = statMinimum_
	minPeopleWithStat = minPeopleWithStat_
	operation = operation_


func execute(executionState:ExecutionState):
	var compliantCharacters = 0
	
	for character in executionState.gameState.characters:
		if character.stats[statToCheck] >= statMinimum:# && character != executionState.currentCharacter:
			compliantCharacters += 1
	
	if compliantCharacters >= minPeopleWithStat:
		operation.execute(executionState)

func _duplicate():
	var newOperation = CheckStatOther.new()
	newOperation.construct(statToCheck, statMinimum, minPeopleWithStat, operation._duplicate())
	return newOperation
