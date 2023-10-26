class_name MultiplyInternalBasedOnResource extends Operation

@export var resource:String
@export var resourceMult:float
@export var operation:Operation

func construct(resource_, resourceMult_, operation_):
	resource = resource_
	resourceMult = resourceMult_
	operation = operation_


func executeEarly(executionState:ExecutionState):
	executionState.internalBoostMultiplier *= resourceMult * executionState.gameState.resources[resource]
	operation.executeEarly(executionState)

func execute(executionState:ExecutionState):
	executionState.internalBoostMultiplier *= resourceMult * executionState.gameState.resources[resource]
	operation.execute(executionState)
 
func _duplicate():
	var newOperation = MultiplyInternalBasedOnStat.new()
	newOperation.construct(resource, resourceMult, operation._duplicate())
	return newOperation
