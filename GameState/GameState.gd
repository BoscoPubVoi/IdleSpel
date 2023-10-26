class_name GameState
extends Node

var resources:Dictionary = ResourceHelpers.create_empty_resources()
var resourceCaps:Dictionary = ResourceHelpers.create_some_resources({rocks = 50, water = 50, silver=3, favor = 10, relics = 1, moonstone = 3, moonlight = 10, love = 10000000000}) 
var characters:Array = []
var maxSupportedActions = 8
# Buildings: (building, float)
var buildings:Dictionary = {rocks = 0, water = 0, silver = 0, favor = 0, relics = 0, moonstone = 0, moonlight = 0}
var placeInCycle:int
var globalProductionBonuses:Dictionary
var previousMoonStateProduction:Dictionary = ResourceHelpers.create_empty_resources()
var wasFromLoaded:bool = false

func _duplicate():
	var newGameState = GameState.new()
	newGameState.resources = resources.duplicate()
	newGameState.resourceCaps = resourceCaps.duplicate()
	newGameState.buildings = buildings.duplicate(true)
	for character in characters:
		newGameState.characters.push_back(character._duplicate())
	newGameState.globalProductionBonuses = globalProductionBonuses.duplicate(true)
	newGameState.placeInCycle = placeInCycle
	newGameState.previousMoonStateProduction = previousMoonStateProduction
	return newGameState

func onChange():
	var fullCycle = FullCycleResultEvaluator.new()
	fullCycle.evaluate(self)

func restore_state(dict, tree):
	resources = dict.resources
	resourceCaps = dict.resourceCaps
	maxSupportedActions = int(dict.maxSupportedActions)
	buildings = dict.buildings
	characters = []
	for char in dict.characters:
		var newChar = Character.new()
		newChar.restore_state(char, tree)
		characters.push_back(newChar)
	placeInCycle = dict.placeInCycle
	globalProductionBonuses = dict.globalProductionBonuses
	previousMoonStateProduction = dict.previousMoonStateProduction

func get_save_dict():
	var charactersSave = []
	for char in characters:
		charactersSave.push_back(char.get_save_dict())
	return {
		resources = resources,
		resourceCaps = resourceCaps,
		maxSupportedActions = maxSupportedActions,
		buildings = buildings,
		characters = charactersSave,
		placeInCycle = placeInCycle,
		globalProductionBonuses = globalProductionBonuses,
		previousMoonStateProduction = previousMoonStateProduction
	}
