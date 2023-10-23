class_name ProduceBaseResource extends Operation

@export var resourceTypeToProduce:String
@export var baseProduction:float


func construct(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_
	pass


func execute(executionState:ExecutionState):
	executionState.gameState.resources[resourceTypeToProduce] += baseProduction

func _duplicate():
	var newOperation = ProduceBaseResource.new()
	newOperation.construct(resourceTypeToProduce, baseProduction)
	return newOperation
