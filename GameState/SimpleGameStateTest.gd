class_name SimpleGameStateTest extends Object

func _init():
	var gameState = GameState.new()
	var newCharacter = Character.new(gameState.maxSupportedActions)
	var newResource = ProduceBaseResource.new()
	newResource.construct("rocks", 10)
	newCharacter.actions = [newResource]
	gameState.characters.push_back(newCharacter)
	var fullCycleResult = FullCycleResultEvaluator.evaluate(gameState)
	print(fullCycleResult.resources.rocks)
