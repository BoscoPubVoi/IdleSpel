extends Control

@onready var secondaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/SecondaryActions
@onready var tertiaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/TertiaryActions


# Called when the node enters the scene tree for the first time.
func _ready():
	var newCharacter = Character.new()
	newCharacter.constructor(Game.maxSupportedActions)
	Game.characters.push_back(newCharacter)
	pass # Replace with function body.


func unlock_secondary_actions():
	secondaryActions.show()

func unlock_tertiary_actions():
	tertiaryActions.show()