class_name ExecutionState
var gameState:GameState
var currentCharacter:Character
var currentActionPosition:int

func _init(gameState_, currentCharacter_, currentActionPosition_):
	gameState = gameState_
	currentCharacter = currentCharacter_
	currentActionPosition = currentActionPosition_
