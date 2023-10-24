class_name IncreaseGlobalProductionBonus extends Operation

@export var resourceToIncrease:String
@export var increaseBonusAmount:float
@export var costs:Dictionary

func constructor(resourceToIncrease_, increaseBonusAmount_, costs_):
	resourceToIncrease = resourceToIncrease_
	increaseBonusAmount = increaseBonusAmount_
	costs = costs_

func execute(executionState:ExecutionState):
	var boostAmount = executionState.currentBoosts.get("all")
	if boostAmount == null:
		boostAmount = 0
	boostAmount = (1 + boostAmount) * executionState.internalBoostMultiplier

	var maxAfford = min(boostAmount, ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources))
	
	var boostAmount2 = executionState.gameState.globalProductionBonuses.get(resourceToIncrease)
	if boostAmount2 == null:
		executionState.gameState.globalProductionBonuses[resourceToIncrease] = 0
	executionState.gameState.globalProductionBonuses[resourceToIncrease] += maxAfford * increaseBonusAmount
	
	# Spend the costs
	ResourceHelpers.pay_costs(costs, executionState.gameState.resources, maxAfford)

func _duplicate():
	var newOperation = IncreaseGlobalProductionBonus.new()
	newOperation.constructor(resourceToIncrease, increaseBonusAmount, costs)
	return newOperation
