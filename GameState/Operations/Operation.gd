extends Resource
# Base class for all operations
class_name Operation

func execute(executionState:ExecutionState):
	push_error("Error! This operation hasn't been implemented.")

# Optional: execute something before execution of any other ops
func executeEarly(executionState:ExecutionState):
	pass

# Optional: execute something after execution of any other ops
func executeLate(executionState:ExecutionState):
	pass

func _duplicate():
	push_error("Error! Duplicate() for this operation hasn't been implemented")
