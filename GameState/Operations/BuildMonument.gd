class_name BuildMonument extends Operation

@export var buildBuildingAmount:Array[float]
@export var costs:Array[Dictionary]

func constructor(buildBuildingAmount_, costs_):
	buildBuildingAmount = buildBuildingAmount_
	costs = costs_

func execute(executionState:ExecutionState):
	if !executionState.gameState.buildings.has("monument"):
		executionState.gameState.buildings["monument"] = 0
	
	var nextBuildingState = floor(1 + executionState.gameState.buildings["monument"])
	
	if nextBuildingState <= min(len(buildBuildingAmount), len(costs)):
		var boostAmount = executionState.currentBoosts.get("all")
		if boostAmount == null:
			boostAmount = 0
		boostAmount = (1 + boostAmount) * executionState.internalBoostMultiplier

		var maxAfford = min(boostAmount, ResourceHelpers.calculate_max_afford_with_cost(
			costs[nextBuildingState - 1], executionState.gameState.resources))
		
		# Help build the building
		maxAfford = min(maxAfford * buildBuildingAmount[nextBuildingState - 1], nextBuildingState - executionState.gameState.buildings["monument"])
		ResourceHelpers.pay_costs(costs[nextBuildingState - 1], executionState.gameState.resources, maxAfford)
		executionState.gameState.buildings["monument"] += maxAfford
		executionState.setBuildInProgress("monument")
		executionState.setMonumentInProgress(nextBuildingState)
		if executionState.gameState.buildings["monument"] >= nextBuildingState - 0.00001:
			#Unlock the building (i think)
			executionState.gameState.buildings["monument"] = nextBuildingState
			executionState.unlockBuilding("monument")
			executionState.setMonumentTier(nextBuildingState)
			executionState.unlockActionsGroup("monument")
			executionState.unlockActionsGroup("monument" + str(nextBuildingState))

			# For certain buildings, do an unlock of actions somehow
			if nextBuildingState == 1:
				executionState.unlockActionLocations(0)
			elif nextBuildingState == 2:
				executionState.unlockActionLocations(1)
			elif nextBuildingState == 3:
				executionState.unlockActionLocations(2)

func _duplicate():
	var newOperation = BuildMonument.new()
	newOperation.constructor(buildBuildingAmount, costs)
	return newOperation
