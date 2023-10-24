class_name ExecutionState
var gameState:GameState
var currentCharacter:Character
var currentActionPosition:int
var currentBoosts:Dictionary = {}
var tree:SceneTree
# Multiplier used for anything inside
var internalBoostMultiplier:float = 1

func _init(gameState_, currentCharacter_, currentActionPosition_, boosts_, tree_):
	gameState = gameState_
	currentCharacter = currentCharacter_
	currentActionPosition = currentActionPosition_
	currentBoosts = boosts_
	tree = tree_

func prepareForStep():
	currentBoosts = {}

func unlockActionLocations(tierNo):
	if tree == null:
		return

	if tierNo == 0:
		var newUnlockActions = tree.get_nodes_in_group("FirstUnlockedAction")
		for node in newUnlockActions:
			node.set_enabled(true)

	if tierNo == 1:
		var newUnlockActions = tree.get_nodes_in_group("SecondUnlockedAction")
		for node in newUnlockActions:
			node.set_enabled(true)

func unlockBuilding(resource_name):
	if tree == null:
		return
	tree.get_first_node_in_group("Visualiser").unlock_building(resource_name)
