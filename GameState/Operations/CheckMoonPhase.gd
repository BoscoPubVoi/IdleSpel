class_name CheckMoonPhase extends Operation

@export var requiredMoonPhase:Array[int]
@export var operation:Operation

func construct(requiredMoonPhase_, operation_):
	requiredMoonPhase = requiredMoonPhase_
	operation = operation_

func execute(executionState:ExecutionState):
	print(executionState.gameState.placeInCycle)
	if requiredMoonPhase.has(executionState.gameState.placeInCycle):
		operation.execute(executionState)

func _duplicate():
	var newOperation = CheckMoonPhase.new()
	newOperation.construct(requiredMoonPhase, operation._duplicate())
	return newOperation
