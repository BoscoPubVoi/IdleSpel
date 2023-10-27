class_name Action
extends Resource

var name:String
var operations:Array
var building:String

var _save_origNode

func update(executionState:ExecutionState):
	pass

func constructor(operations_):
	operations = operations_

func _duplicate():
	var newAction = Action.new()
	newAction.name = name;
	for operation in operations:
		newAction.operations.push_back(operation._duplicate())
	return newAction

func executeEarly(executionState:ExecutionState):
	for operation in operations:
		executionState.internalBoostMultiplier = 1
		operation.executeEarly(executionState)

func execute(executionState:ExecutionState):
	for operation in operations:
		executionState.internalBoostMultiplier = 1
		operation.execute(executionState)

func executeLate(executionState:ExecutionState):
	for operation in operations:
		executionState.internalBoostMultiplier = 1
		operation.executeLate(executionState)
		
func get_save_dict():
	return {
		name = name,
		building = building
	}

func restore_state(dict, tree):
	name = dict.name
	building = dict.building
	
	# Go ahead and try to find this action in the scene tree somehow
	var allActions = find_all_action_nodes(tree.get_root())
	var thisSpecificAction = allActions.filter (func(ac):
		return ac.action_name == name
	)[0]
	_save_origNode = thisSpecificAction

func find_all_action_nodes(node):
	var found_nodes = []
	
	if node is ActionIcon:
		found_nodes.append(node)

	if node is Node:
		for child in node.get_children():
			found_nodes += find_all_action_nodes(child)
	
	return found_nodes
