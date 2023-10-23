class_name ProduceBaseResource extends Operation

@export var resourceTypeToProduce:String
@export var baseProduction:float

func _init(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_

func execute(executionState:ExecutionState):
	executionState.gameState.resources[resourceTypeToProduce] += baseProduction

func _duplicate():
	var newOperation = ProduceBaseResource.new(resourceTypeToProduce, baseProduction)
	return newOperation
