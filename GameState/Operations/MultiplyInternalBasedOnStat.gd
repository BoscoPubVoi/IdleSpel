class_name MultiplyInternalBasedOnStat extends Operation

@export var stat:String
@export var statMult:float
@export var operation:Operation

func construct(stat_, statMult_, operation_):
	stat = stat_
	statMult = statMult_
	operation = operation_


func execute(executionState:ExecutionState):
	executionState.internalBoostMultiplier *= statMult * executionState.currentCharacter.stats[stat]
	operation.execute(executionState)

func _duplicate():
	var newOperation = MultiplyInternalBasedOnStat.new()
	newOperation.construct(stat, statMult, operation._duplicate())
	return newOperation
