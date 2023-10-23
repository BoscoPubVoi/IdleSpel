extends Resource
# Base class for all operations
class_name Operation

func execute(executionState:ExecutionState):
	push_error("Error! This operation hasn't been implemented.")

func _duplicate():
	push_error("Error! Duplicate() for this operation hasn't been implemented")
