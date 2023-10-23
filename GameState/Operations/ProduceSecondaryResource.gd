class_name ProduceSecondaryResource extends Operation

#Costs: formatted like [{resource: "rocks", amount: 5}, {resource: "water", amount: 3}]
var costs:Array = []
var resourceTypeToProduce:String
var baseProduction:float

func _init(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_

func execute(executionState:ExecutionState):
	# Check whether paying the costs is possible, only produce if that is possible
	var maximumPossibleProductionMultiplier = INF;
#	for cost in costs:
#		cost.resource
	
	executionState.gameState.resources[resourceTypeToProduce] += baseProduction

func _duplicate():
	var newOperation = ProduceSecondaryResource.new(resourceTypeToProduce, baseProduction)
	newOperation.costs = costs.duplicate(true)
	return newOperation
