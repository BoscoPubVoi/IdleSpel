class_name ProduceSecondaryResource extends Operation

@export var costs:Dictionary
@export var resourceTypeToProduce:String
@export var baseProduction:float

func constructor(resourceTypeToProduce_, baseProduction_):
	resourceTypeToProduce = resourceTypeToProduce_
	baseProduction = baseProduction_

func execute(executionState:ExecutionState):
	# Check whether paying the costs is possible, only produce as far as that is possible
	var actualProductionMultiplier = ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources)
	
	if (resourceTypeToProduce == "love" &&
		actualProductionMultiplier < 1):
		return
	
	# Take boosts into account
	actualProductionMultiplier = min(ResourceHelpers.calculate_boost(executionState, resourceTypeToProduce),
		actualProductionMultiplier)
	
	# Take caps into account
	actualProductionMultiplier = min(actualProductionMultiplier,
		(executionState.gameState.resourceCaps[resourceTypeToProduce] -
		executionState.gameState.resources[resourceTypeToProduce]) / baseProduction)
	
	# Pay what you can
	ResourceHelpers.pay_costs(costs, executionState.gameState.resources, actualProductionMultiplier)
	
	var finalProduction = baseProduction * actualProductionMultiplier
	
	# Get what you deserve
	executionState.gameState.resources[resourceTypeToProduce] += finalProduction
	if ! executionState.totalResourcesByType.get(resourceTypeToProduce):
		executionState.totalResourcesByType[resourceTypeToProduce] = finalProduction
	else:
		executionState.totalResourcesByType[resourceTypeToProduce] += finalProduction

func _duplicate():
	var newOperation = ProduceSecondaryResource.new()
	newOperation.constructor(resourceTypeToProduce, baseProduction)
	newOperation.costs = costs.duplicate(true)
	return newOperation
