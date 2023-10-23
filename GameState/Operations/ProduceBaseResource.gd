class_name ProduceBaseResource extends Operation

@export var resourceTypeToProduce:String
@export var baseProduction:float


func construct(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_
	pass


func execute(executionState:ExecutionState):
	var thisProduction = baseProduction
	# Take caps into account
	thisProduction = min(thisProduction,
		executionState.gameState.resourceCaps[resourceTypeToProduce] -
		executionState.gameState.resources[resourceTypeToProduce])
	executionState.gameState.resources[resourceTypeToProduce] += thisProduction

func _duplicate():
	var newOperation = ProduceBaseResource.new()
	newOperation.construct(resourceTypeToProduce, baseProduction)
	return newOperation
