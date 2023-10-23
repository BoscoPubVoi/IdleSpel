class_name GameState

var resources:Dictionary = ResourceHelpers.create_empty_resources()
var characters:Array = []
var maxSupportedActions = 8

func _init():
	pass

func duplicate():
	var newGameState = GameState.new()
	newGameState.resources = resources.duplicate()
	for character in characters:
		newGameState.characters.push_back(character.duplicate())
	return newGameState
