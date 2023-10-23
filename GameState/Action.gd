class_name Action

var name:String
var operations:Array

func update(executionState:ExecutionState):
	pass

func _init(operations_):
	operations = operations_

func duplicate():
	var newAction = Operation.new()
	newAction.name = name;
	for operation in operations:
		newAction.operations.push_back(operation.duplicate())
	return newAction
