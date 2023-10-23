class_name SimpleGameStateTest extends Object

func _init():
	var gameState = GameState.new()
	var newCharacter = Character.new(gameState.maxSupportedActions)
	newCharacter.actions = [ProduceBaseResource.new("rocks", 10)]
	gameState.characters.push_back(newCharacter)
	var fullCycleResult = FullCycleResultEvaluator.evaluate(gameState)
	print(fullCycleResult.resources.rocks)
