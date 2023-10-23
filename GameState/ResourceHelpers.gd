class_name ResourceHelpers

static func create_empty_resources():
	return {water = 0, rocks = 0, silver = 0, favor = 0, relics = 0, moonstone = 0, moonlight = 0}

static func create_some_resources(changes):
	var baseResources = create_empty_resources()
	for change in changes:
		baseResources[change] += changes[change]
	return baseResources

static func calculate_max_afford_with_cost(costs, resources):
	var maximumPossibleProductionMultiplier = INF;
	for cost in costs:
		maximumPossibleProductionMultiplier = min(maximumPossibleProductionMultiplier,
			resources[cost] / costs[cost])
	return maximumPossibleProductionMultiplier;

static func pay_costs(costs, resources, actualProductionMultiplier):
	for cost in costs:
		resources[cost] -= costs[cost] * actualProductionMultiplier

static func calculate_boost(executionState, resource):
	var totalBoost = 1
	
	var boostAmount = executionState.currentBoosts.get(resource)
	if boostAmount != null:
		totalBoost *= 1 + boostAmount
		
	var boostAmount2 = executionState.gameState.globalProductionBonuses.get(resource)
	if boostAmount2 != null:
		totalBoost *= 1 + boostAmount2
		
	return totalBoost
