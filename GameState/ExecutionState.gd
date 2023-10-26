class_name ExecutionState
var gameState:GameState
var currentCharacter:Character
var currentActionPosition:int
var currentBoosts:Dictionary = {}
var tree:SceneTree
# Multiplier used for anything inside
var internalBoostMultiplier:float = 1
# How many resources were produced in this ExecutionState
var totalResourcesByType:Dictionary = {}

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

func unlockActionsGroup(groupName):
	if tree == null:
		return
		
	var newActionPanelsToUnlock = tree.get_nodes_in_group(groupName)
	for node in newActionPanelsToUnlock:
		node.visible = true

func setBuildInProgress(resource_name):
	if tree == null:
		return
	tree.get_first_node_in_group("Visualiser").set_build_in_progress(resource_name)


func setMonumentInProgress(tier_id):
	if tree == null:
		return
	tree.get_first_node_in_group("Visualiser").set_monument_in_progress(tier_id)

func unlockBuilding(resource_name):
	if tree == null:
		return
	tree.get_first_node_in_group("Visualiser").unlock_building(resource_name)
	
	if resource_name == "water":
		show_popup("Well Built!", "The Well is now fully constructed! Your follower can now gain Wisdom. Note that stats reset at the end of each moon cycle.")
		
		for node in tree.get_nodes_in_group("WisdomLabel"):
			node.modulate = Color(1.0, 1.0, 1.0, 1.0)

	if resource_name == "favor":
		for node in tree.get_nodes_in_group("VigorLabel"):
			node.modulate = Color(1.0, 1.0, 1.0, 1.0)

	if resource_name == "relics":
		for node in tree.get_nodes_in_group("ReveranceLabel"):
			node.modulate = Color(1.0, 1.0, 1.0, 1.0)

func setMonumentTier(tier_id):
	if tree == null:
		return
	tree.get_first_node_in_group("Visualiser").set_monument_tier(tier_id)

	for node in tree.get_nodes_in_group("VigorLabel"):
		node.modulate = Color(1.0, 1.0, 1.0, 1.0)

func show_popup(title, text):
	if tree == null:
		return
	ShowPopup.show_popup(tree, title, text)
	
func flash_rock_icon():
	if tree == null:
		return
		
	tree.get_first_node_in_group("rocksResourceIcon").flashUntilMouseOver = true
