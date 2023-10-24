class_name RequiresStat extends UnlockRequirement

@export var stat:String
@export var minOfStat:float

func meets_requirement(gameState:GameState):
	for char in gameState.characters:
		if char.stats[stat] >= minOfStat:
			return true
	return false
