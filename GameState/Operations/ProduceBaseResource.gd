class_name ProduceBaseResource extends Operation

var resourceTypeToProduce:String
var baseProduction:float

func _init(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_

func execute(executionState:ExecutionState):
	executionState.gameState.resources[resourceTypeToProduce] += baseProduction

func duplicate():
	var newOperation = ProduceBaseResource.new(resourceTypeToProduce, baseProduction)
	return newOperation
