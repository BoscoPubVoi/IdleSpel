class_name PayCostAndDo extends Operation

@export var costs:Dictionary
@export var operation:Operation

func construct(costs_, operation_):
	costs = costs_
	operation = operation_


func execute(executionState:ExecutionState):
	var boostAmount = executionState.currentBoosts.get("all")
	if boostAmount == null:
		boostAmount = 0
	boostAmount = (1 + boostAmount) * executionState.internalBoostMultiplier

	var maxAfford = min(boostAmount, ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources))

	# Spend the costs
	ResourceHelpers.pay_costs(costs, executionState.gameState.resources, maxAfford)
	executionState.internalBoostMultiplier *= maxAfford
	operation.execute(executionState)

func _duplicate():
	var newOperation = PayCostAndDo.new()
	newOperation.construct(costs, operation)
	return newOperation
