class_name BuildBuildingOrIncreaseCap extends Operation

@export var buildingAndCapName:String
@export var buildBuildingAmount:float
@export var increaseCapAmount:float
@export var costs:Dictionary

func constructor(buildingAndCapName_, increaseCapAmount_, costs_):
	buildingAndCapName = buildingAndCapName_
	increaseCapAmount = increaseCapAmount_
	costs = costs_

func execute(executionState:ExecutionState):
	var boostAmount = executionState.currentBoosts.get("all")
	if boostAmount == null:
		boostAmount = 0

	var maxAfford = min(1 + boostAmount, ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources))
	
	if !executionState.gameState.buildings.has(buildingAndCapName):
		executionState.gameState.buildings[buildingAndCapName] = 0
	
	if executionState.gameState.buildings[buildingAndCapName] < 1:
		# Help build the building
		maxAfford = min(maxAfford, 1 - executionState.gameState.buildings[buildingAndCapName])
		executionState.gameState.buildings[buildingAndCapName] += maxAfford
		if executionState.gameState.buildings[buildingAndCapName] > 0.99999:
			executionState.gameState.buildings[buildingAndCapName] = 1
	else:
		# Help increase the cap
		executionState.gameState.resourceCaps[buildingAndCapName] += increaseCapAmount * maxAfford
		
	# For certain buildings, do an unlock of actions somehow
	executionState.unlockActionLocations(0)
	executionState.unlockActionLocations(1)
		
	# Spend the costs
	ResourceHelpers.pay_costs(costs, executionState.gameState.resources, maxAfford)

func _duplicate():
	var newOperation = BuildBuildingOrIncreaseCap.new()
	newOperation.constructor(buildingAndCapName, increaseCapAmount, costs)
	return newOperation
