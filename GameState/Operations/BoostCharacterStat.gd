class_name BoostCharacterStat extends Operation

@export var statToIncrease:String
@export var statIncreaseAmount:float
@export var costs:Dictionary

func constructor(statToIncrease_, statIncreaseAmount_, costs_):
	statToIncrease = statToIncrease_
	statIncreaseAmount = statIncreaseAmount_
	costs = costs_

func execute(executionState:ExecutionState):
	var boostAmount = executionState.currentBoosts.get("all")
	if boostAmount == null:
		boostAmount = 0
	
	var maxAfford = min(1 + boostAmount, ResourceHelpers.calculate_max_afford_with_cost(
		costs, executionState.gameState.resources))
	
	if maxAfford >= 0.99999999:
		# Spend the costs
		ResourceHelpers.pay_costs(costs, executionState.gameState.resources, 1)
		
		#Then go ahead and give the boost
		executionState.currentCharacter.stats[statToIncrease] += statIncreaseAmount * (1 + boostAmount)

func _duplicate():
	var newOperation = BoostCharacterStat.new()
	newOperation.constructor(statToIncrease, statIncreaseAmount, costs)
	return newOperation
