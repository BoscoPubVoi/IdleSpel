class_name Action
extends Resource

var name:String
var operations:Array
var building:String

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
		operation.executeEarly(executionState)

func execute(executionState:ExecutionState):
	for operation in operations:
		operation.execute(executionState)

func executeLate(executionState:ExecutionState):
	for operation in operations:
		operation.executeLate(executionState)
