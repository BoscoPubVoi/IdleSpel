class_name GameState
extends Node

var resources:Dictionary = ResourceHelpers.create_empty_resources()
var resourceCaps:Dictionary = ResourceHelpers.create_some_resources({rocks = 1000, water = 50, silver=10, favor = 100}) 
var characters:Array = []
var maxSupportedActions = 8
# Buildings: (building, float)
var buildings:Dictionary = {rocks = 0, water = 0, silver = 0, favor = 0, relics = 0, moonstone = 0, moonlight = 0}
var placeInCycle:int
var globalProductionBonuses:Dictionary

func _duplicate():
	var newGameState = GameState.new()
	newGameState.resources = resources.duplicate()
	newGameState.resourceCaps = resourceCaps.duplicate()
	newGameState.buildings = buildings.duplicate(true)
	for character in characters:
		newGameState.characters.push_back(character._duplicate())
	newGameState.globalProductionBonuses = globalProductionBonuses.duplicate(true)
	newGameState.placeInCycle = placeInCycle
	return newGameState
