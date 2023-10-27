class_name RequiresMinimumCap extends UnlockRequirement

@export var resource:String
@export var minOfCapacity:float

func meets_requirement(gameState:GameState):
	return gameState.resourceCaps[resource] >= minOfCapacity
