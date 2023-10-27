class_name CheckResource extends Operation

@export var resourceToCheck:String
@export var resourceMinimum:float
@export var operation:Operation

func construct(resourceToCheck_, resourceMinimum_, operation_):
	resourceToCheck = resourceToCheck_
	resourceMinimum = resourceMinimum_
	operation = operation_


func executeEarly(executionState:ExecutionState):
	if executionState.gameState.resources[resourceToCheck] >= resourceMinimum:
		operation.executeEarly(executionState)
		
func execute(executionState:ExecutionState):
	if executionState.gameState.resources[resourceToCheck] >= resourceMinimum:
		operation.execute(executionState)

func _duplicate():
	var newOperation = CheckResource.new()
	newOperation.construct(resourceToCheck, resourceMinimum, operation._duplicate())
	return newOperation 
