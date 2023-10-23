class_name ProduceSecondaryResource extends Operation

#Costs: formatted like [{resource: "rocks", amount: 5}, {resource: "water", amount: 3}]
var costs:Array = []
var resourceTypeToProduce:String
var baseProduction:float

func constructor(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_

func execute(executionState:ExecutionState):
	# Check whether paying the costs is possible, only produce as far as that is possible
	var maximumPossibleProductionMultiplier = ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources)
	var actualProductionMultiplier = min(1, maximumPossibleProductionMultiplier)
	
	# Take caps into account
	actualProductionMultiplier = min(actualProductionMultiplier,
		(executionState.gameState.resourceCaps[resourceTypeToProduce] -
		executionState.gameState.resources[resourceTypeToProduce]) / baseProduction)
	
	# Pay what you can
	ResourceHelpers.pay_costs(costs, executionState.gameState.resources, actualProductionMultiplier)
	
	# Get what you deserve
	executionState.gameState.resources[resourceTypeToProduce] += baseProduction * actualProductionMultiplier

func _duplicate():
	var newOperation = ProduceSecondaryResource.new()
	newOperation.constructor(resourceTypeToProduce, baseProduction)
	newOperation.costs = costs.duplicate(true)
	return newOperation
