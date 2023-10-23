# A character that would have certain actions & stats
class_name Character
var actions:Array

func constructor(maxSupportedActions):
	actions = []
	actions.resize(maxSupportedActions)
	actions.fill(null)

func _duplicate():
	var newCharacter = Character.new()
	newCharacter.constructor(len(actions))
	newCharacter.actions = []
	for action in actions:
		newCharacter.actions.push_back(null if action == null else action._duplicate())
		
	return newCharacter
