extends Control

@onready var MoonContainer = $AllActorsPanel/MoonCycleContainer

@onready var secondaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/SecondaryActions
@onready var tertiaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/TertiaryActions


var cycleStepRunner = CycleStepRunner.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var newCharacter = Character.new()
	newCharacter.constructor(Game.maxSupportedActions)
	Game.characters.push_back(newCharacter)
	updateMoonCycleIcon()


func unlock_secondary_actions():
	secondaryActions.show()

func unlock_tertiary_actions():
	tertiaryActions.show()



func _on_timer_timeout():
	cycleStepRunner.runOneStep()
	update_resource_labels()
	updateMoonCycleIcon()


func update_resource_labels():
	$ResourcesPanel/RockLabel.text = "Rocks: " + str(Game.resources["rocks"])
	$ResourcesPanel/WaterLabel.text = "Water: " + str(Game.resources["water"])
	$ResourcesPanel/SilverLabel.text = "Silver: " + str(Game.resources["silver"])

func updateMoonCycleIcon():
	Game.placeInCycle
	var i = 0
	for moon in MoonContainer.get_children():
		if i == Game.placeInCycle:
			moon.modulate = Color(1.0,1.0,1.0,1.0)
		else:
			moon.modulate = Color(1.0,1.0,1.0,.1)
		i += 1






