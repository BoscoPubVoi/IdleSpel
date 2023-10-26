extends Control

@onready var MoonContainer = $AllActorsPanel/MoonCycleContainer
@onready var Visualiser = $VisualiserPanel

@onready var secondaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/SecondaryActions
@onready var tertiaryActions = $ActionsPanel/ScrollContainer/Margin/WholeActionContainer/TertiaryActions


var cycleStepRunner = CycleStepRunner.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if ! Game.wasFromLoaded:
		Game.buildings["rocks"] = 1
		Visualiser.unlock_building("rocks")
		
		var newCharacter = Character.new()
		newCharacter.constructor(Game.maxSupportedActions)
		Game.characters.push_back(newCharacter)

	update_resource_labels()
	updateMoonCycleIcon()
	$AudioStreamPlayer.play()


func unlock_secondary_actions():
	secondaryActions.show()

func unlock_tertiary_actions():
	tertiaryActions.show()



func _on_timer_timeout():
	cycleStepRunner.runOneStep(get_tree())
	update_resource_labels()
	updateMoonCycleIcon()


func update_resource_labels():
	$ResourcesPanel/Rocks/RockLabel.text = str(floor(Game.resources["rocks"])) + " / " + str(floor(Game.resourceCaps["rocks"]))
	$ResourcesPanel/Water/WaterLabel.text = str(floor(Game.resources["water"])) + " / " + str(floor(Game.resourceCaps["water"]))
	$ResourcesPanel/Silver/SilverLabel.text = str(floor(Game.resources["silver"])) + " / " + str(floor(Game.resourceCaps["silver"]))
	$ResourcesPanel/Favor/FavorLabel.text = str(floor(Game.resources["favor"])) + " / " + str(floor(Game.resourceCaps["favor"]))
	$ResourcesPanel/Relic/RelicLabel.text = str(floor(Game.resources["relics"])) + " / " + str(floor(Game.resourceCaps["relics"]))
	$ResourcesPanel/Moonstone/MoonstoneLabel.text = str(floor(Game.resources["moonstone"])) + " / " + str(floor(Game.resourceCaps["moonstone"]))
	$ResourcesPanel/Moonlight/MoonlightLabel.text = str(floor(Game.resources["moonlight"])) + " / " + str(floor(Game.resourceCaps["moonlight"]))
	var loveGoal = CycleStepRunner.get_current_love_goal(Game)
	if loveGoal < 10000:
		$ResourcesPanel/Fertility/FertilityLabel.text = str(floor(Game.resources["love"])) + (" / " + str(CycleStepRunner.get_current_love_goal(Game)))
	else:
		$ResourcesPanel/Fertility/FertilityLabel.text = str(floor(Game.resources["love"]))

func updateMoonCycleIcon():
	Game.placeInCycle
	var i = 0
	for moon in MoonContainer.get_children():
		if i == Game.placeInCycle:
			moon.modulate = Color(1.0,1.0,1.0,1.0)
		else:
			moon.modulate = Color(1.0,1.0,1.0,.1)
		i += 1

func _input(event):
	if OS.has_feature("standalone"):
		return
	
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_C) and just_pressed:
		get_tree().get_first_node_in_group("MainTimer").wait_time = 0.01 if get_tree().get_first_node_in_group("MainTimer").wait_time == 1 else 1




