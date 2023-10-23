# A character that would have certain actions & stats
class_name Character
var actions:Array
var stats:Dictionary

func constructor(maxSupportedActions):
	actions = []
	actions.resize(maxSupportedActions)
	actions.fill(null)
	stats = {vigor = 0, reverance = 0, wisdom = 0}

func _duplicate():
	var newCharacter = Character.new()
	newCharacter.constructor(len(actions))
	newCharacter.actions = []
	for action in actions:
		newCharacter.actions.push_back(null if action == null else action._duplicate())
	newCharacter.stats = stats.duplicate(true)
		
	return newCharacter

func onCycleStart():
	stats.vigor = 0
	stats.reverance = 0
	stats.wisdom = 0
