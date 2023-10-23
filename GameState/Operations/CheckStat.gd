class_name CheckStat extends Operation

@export var statToCheck:String
@export var statMinimum:float
@export var operation:Operation

func construct(statToCheck_, statMinimum_, operation_):
	statToCheck = statToCheck_
	statMinimum = statMinimum_
	operation = operation_


func execute(executionState:ExecutionState):
	if executionState.currentCharacter.stats[statToCheck] >= statMinimum:
		operation.execute(executionState)

func _duplicate():
	var newOperation = CheckStat.new()
	newOperation.construct(statToCheck, statMinimum, operation._duplicate())
	return newOperation
