class_name MultiplyInternalBasedOnResource extends Operation

@export var resource:String
@export var resourceMult:float
@export var operation:Operation

func construct(resource_, resourceMult_, operation_):
	resource = resource_
	resourceMult = resourceMult_
	operation = operation_


func executeEarly(executionState:ExecutionState):
	if executionState.gameState.mockResourcesAt.has(resource):
		executionState.internalBoostMultiplier *= resourceMult * executionState.gameState.mockResourcesAt[resource]
	else:
		executionState.internalBoostMultiplier *= resourceMult * executionState.gameState.resources[resource]
	operation.executeEarly(executionState)

func execute(executionState:ExecutionState):
	if executionState.gameState.mockResourcesAt.has(resource):
		executionState.internalBoostMultiplier *= resourceMult * executionState.gameState.mockResourcesAt[resource]
	else:
		executionState.internalBoostMultiplier *= resourceMult * executionState.gameState.resources[resource]
	operation.execute(executionState)
 
func _duplicate():
	var newOperation = MultiplyInternalBasedOnResource.new()
	newOperation.construct(resource, resourceMult, operation._duplicate())
	return newOperation
