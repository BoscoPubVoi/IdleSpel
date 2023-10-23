class_name GameState
extends Node

var resources:Dictionary = ResourceHelpers.create_empty_resources()
var resourceCaps:Dictionary = ResourceHelpers.create_some_resources({rocks = 1000, silver=10}) 
var characters:Array = []
var maxSupportedActions = 8
# Buildings: (building, float)
var buildings:Dictionary
var placeInCycle:int

func _duplicate():
	var newGameState = GameState.new()
	newGameState.resources = resources.duplicate()
	newGameState.resourceCaps = resourceCaps.duplicate()
	for character in characters:
		newGameState.characters.push_back(character._duplicate())
	return newGameState
