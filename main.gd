extends Control

@onready var MoonContainer = $AllActorsPanel/MoonCycleContainer

@onready var secondaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/SecondaryActions
@onready var tertiaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/TertiaryActions


var cycleStepRunner = CycleStepRunner.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.buildings["rocks"] = 1
	
	var newCharacter = Character.new()
	newCharacter.constructor(Game.maxSupportedActions)
	Game.characters.push_back(newCharacter)
	
	var newCharacter2 = Character.new()
	newCharacter2.constructor(Game.maxSupportedActions)
	Game.characters.push_back(newCharacter2)
	update_resource_labels()
	updateMoonCycleIcon()


func unlock_secondary_actions():
	secondaryActions.show()

func unlock_tertiary_actions():
	tertiaryActions.show()



func _on_timer_timeout():
	cycleStepRunner.runOneStep(get_tree())
	update_resource_labels()
	updateMoonCycleIcon()


func update_resource_labels():
	$ResourcesPanel/Rocks/RockLabel.text = str(Game.resources["rocks"]) + " / " + str(Game.resourceCaps["rocks"])
	$ResourcesPanel/Water/WaterLabel.text = str(Game.resources["water"]) + " / " + str(Game.resourceCaps["water"])
	$ResourcesPanel/Silver/SilverLabel.text = str(Game.resources["silver"]) + " / " + str(Game.resourceCaps["silver"])
	$ResourcesPanel/Favor/FavorLabel.text = str(Game.resources["favor"]) + " / " + str(Game.resourceCaps["favor"])
	$ResourcesPanel/Relic/RelicLabel.text = str(Game.resources["relics"]) + " / " + str(Game.resourceCaps["relics"])
	$ResourcesPanel/Moonstone/MoonstoneLabel.text = str(Game.resources["moonstone"]) + " / " + str(Game.resourceCaps["moonstone"])
	$ResourcesPanel/Moonlight/MoonlightLabel.text = str(Game.resources["moonlight"]) + " / " + str(Game.resourceCaps["moonlight"])

func updateMoonCycleIcon():
	Game.placeInCycle
	var i = 0
	for moon in MoonContainer.get_children():
		if i == Game.placeInCycle:
			moon.modulate = Color(1.0,1.0,1.0,1.0)
		else:
			moon.modulate = Color(1.0,1.0,1.0,.1)
		i += 1






