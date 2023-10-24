class_name BoostCharactersInPosition extends Operation

@export var boostInPosition:String
@export var boostAmount:float #1 = 100%
@export var costs:Dictionary

func constructor(boostInPosition_, boostAmount_, costs_):
	boostInPosition = boostInPosition_
	boostAmount = boostAmount_
	costs = costs_

func executeEarly(executionState:ExecutionState):
	var maxAfford = min(1, ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources))
	
	if maxAfford >= 0.99999999:
		# Spend the costs
		ResourceHelpers.pay_costs(costs, executionState.gameState.resources, 1)
		
		#Then go ahead and give the boost
		if ! executionState.currentBoosts.has(boostInPosition):
			executionState.currentBoosts[boostInPosition] = 0;
		executionState.currentBoosts[boostInPosition] += boostAmount

func _duplicate():
	var newOperation = BoostCharactersInPosition.new()
	newOperation.constructor(boostInPosition, boostAmount, costs)
	return newOperation
