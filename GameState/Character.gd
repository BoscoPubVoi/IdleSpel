# A character that would have certain actions & stats
class_name Character
var actions:Array

func _init(maxSupportedActions):
	actions = []
	actions.resize(maxSupportedActions)
	actions.fill(null)

func duplicate():
	var newCharacter = Character.new(len(actions))
	for action in actions:
		newCharacter.actions.push_back(action.duplicate())
	return newCharacter
