class_name RequiresMinimumAmountOfResource extends UnlockRequirement

@export var resourceTypeToProduce:String
@export var minAmount:float

func meets_requirement(gameState:GameState):
	return gameState.resources[resourceTypeToProduce] >= minAmount
