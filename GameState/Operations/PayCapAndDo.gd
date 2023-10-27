class_name PayCapAndDo extends Operation

@export var costs:Dictionary
@export var operations:Array[Operation]

func construct(costs_, operation_):
	costs = costs_
	operations = operation_

func execute(executionState:ExecutionState):
	var boostAmount = executionState.currentBoosts.get("all")
	if boostAmount == null:
		boostAmount = 0
	boostAmount = (1 + boostAmount) * executionState.internalBoostMultiplier

	var adjustCaps = executionState.gameState.resourceCaps.duplicate(true)
	for cap in adjustCaps:
		adjustCaps[cap] -= 10

	var maxAfford = min(boostAmount, ResourceHelpers.calculate_max_afford_with_cost(
		costs, adjustCaps))

	# Spend the costs
	ResourceHelpers.pay_costs(costs, executionState.gameState.resourceCaps, maxAfford)
	
	for res in executionState.gameState.resources:
		if executionState.gameState.resources[res] > executionState.gameState.resourceCaps[res]:
			executionState.gameState.resources[res] = executionState.gameState.resourceCaps[res]

	executionState.internalBoostMultiplier *= maxAfford
	for operation in operations:
		operation.execute(executionState)

func _duplicate():
	var newOperation = PayCapAndDo.new()
	newOperation.construct(costs, operations)
	return newOperation
