class_name RequiresMultipleCharactersStat extends UnlockRequirement

@export var stat:String
@export var minOfStat:float
@export var numOfFollowers:int

func meets_requirement(gameState:GameState):
	var counter = 0
	for char in gameState.characters:
		if char.stats[stat] < minOfStat:
			continue
		counter += 1
	
	if counter >= numOfFollowers:
		return true
	else:
		return false
