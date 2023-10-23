class_name GameState
extends Node

var resources:Dictionary = ResourceHelpers.create_empty_resources()
var resourceCaps:Dictionary = ResourceHelpers.create_empty_resources()
var characters:Array = []
var maxSupportedActions = 8
# Buildings: (building, float)
var buildings:Dictionary


func _duplicate():
	var newGameState = GameState.new()
	newGameState.resources = resources.duplicate()
	newGameState.resourceCaps = resourceCaps.duplicate()
	for character in characters:
		newGameState.characters.push_back(character.duplicate())
	return newGameState
