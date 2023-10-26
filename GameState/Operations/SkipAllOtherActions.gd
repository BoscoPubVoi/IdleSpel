class_name SkipAllOtherActions extends Operation

func execute(executionState:ExecutionState):
	executionState.currentCharacter.skipAllActionsThisCycle = true

func _duplicate():
	var newOperation = SkipAllOtherActions.new()
	return newOperation
