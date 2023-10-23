class_name ExecutionState
var gameState:GameState
var currentCharacter:Character
var currentActionPosition:int
var currentBoosts:Dictionary = {}

func _init(gameState_, currentCharacter_, currentActionPosition_, boosts_):
	gameState = gameState_
	currentCharacter = currentCharacter_
	currentActionPosition = currentActionPosition_
	currentBoosts = boosts_

func prepareForStep():
	currentBoosts = {}
