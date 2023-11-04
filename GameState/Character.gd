# A character that would have certain actions & stats
class_name Character
var actions:Array
var stats:Dictionary
var skipAllActionsThisCycle:bool = false

func constructor(maxSupportedActions):
	actions = []
	actions.resize(maxSupportedActions)
	actions.fill(null)
	stats = {vigor = 0, reverance = 0, wisdom = 0}
	skipAllActionsThisCycle = false

func _duplicate():
	var newCharacter = Character.new()
	newCharacter.constructor(len(actions))
	newCharacter.actions = []
	for action in actions:
		newCharacter.actions.push_back(null if action == null else action._duplicate())
	newCharacter.stats = stats.duplicate(true)
	newCharacter.skipAllActionsThisCycle = skipAllActionsThisCycle

	return newCharacter

func onCycleStart():
	stats.vigor = 0
	stats.reverance = 0
	stats.wisdom = 0
	skipAllActionsThisCycle = false

func restore_state(dict, tree):
	stats = dict.stats
	skipAllActionsThisCycle = dict.skipAllActionsThisCycle
	restore_state_actions(dict, tree)
	
func restore_state_actions(dict, tree):
	actions = []
	for action in dict.actions:
		if action == null:
			actions.push_back(null)
			continue
		var newAction = Action.new()
		newAction.restore_state(action, tree)
		actions.push_back(newAction)
	

func get_save_dict():
	var actionsSave = []
	for action in actions:
		if action == null:
			actionsSave.push_back(null)
		else:
			actionsSave.push_back(action.get_save_dict())
	
	return {
		actions = actionsSave,
		stats = stats,
		skipAllActionsThisCycle = skipAllActionsThisCycle
	}
