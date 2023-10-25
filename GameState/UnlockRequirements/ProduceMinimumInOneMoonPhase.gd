class_name ProducesMinimumInOneMoonPhase extends UnlockRequirement

@export var resourceTypeToProduce:String
@export var minAmount:float

func meets_requirement(gameState:GameState):
	return gameState.previousMoonStateProduction[resourceTypeToProduce] >= minAmount
