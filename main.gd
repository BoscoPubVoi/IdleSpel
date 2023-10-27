extends Control

@onready var MoonContainer = $AllActorsPanel/MoonCycleContainer
@onready var Visualiser = $Panel/HBoxContainer/VisualiserPanel

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
	
	DisplayServer.window_set_min_size(Vector2(1152, 652))
	$Timer.start()
	$GameSave.start()


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
	if Input.is_key_pressed(KEY_F12) and just_pressed:
		get_tree().get_first_node_in_group("MainTimer").wait_time = 0.01 if get_tree().get_first_node_in_group("MainTimer").wait_time == 1 else 1

func reset_game():
	# Erase the save file
	var dir = DirAccess.open("user://")
	dir.remove("idlemoonkingdom.save")
	
	Game.reset()
	
	# Reload the scene
	get_tree().reload_current_scene()

#Search
func _on_line_edit_text_changed(new_text):
	var shouldHidePrevContainer = false;
	var prevContainer = null
	var nothingFound = true
	
	for node in $ActionsPanel/MarginContainer/ScrollContainer/Margin/VBoxContainer/ActionGrid.get_children():
		if node is MarginContainer:
			if node.get_groups().has("UpgradeMonumentHint"):
				if new_text != "":
					node.hide()
				elif Game.buildings.has("relics") && (Game.buildings.has("monument") && Game.buildings["monument"] < 2):
					node.show()
				else:
					node.hide()
				continue
			if node.get_groups().has("UpgradeMonumentHint2"):
				if new_text != "":
					node.hide()
				elif Game.buildings.has("monument") && Game.buildings["monument"] < 3:
					node.show()
				else:
					node.hide()
				continue
			
			if shouldHidePrevContainer:
				prevContainer.hide()
				
			node.show()
			shouldHidePrevContainer = true
			prevContainer = node
			continue
		
		var nt = new_text.to_upper()
		if nt == "ROCKS":
			nt = "ROCK"
		
		if (node.unlocked || new_text == "") && (new_text == "" || (nt in node.action_name.to_upper() || nt in node.tooltip.to_upper())):
			var nodeGroups = node.get_groups()
			for gr in nodeGroups:
				if gr == "monument1":
					if Game.buildings.has("monument") && Game.buildings["monument"] >= 1:
						node.show()
						shouldHidePrevContainer = false
						nothingFound = false
				if gr == "monument2":
					if Game.buildings.has("monument") && Game.buildings["monument"] >= 2:
						node.show()
						shouldHidePrevContainer = false
						nothingFound = false
				if gr == "monument3":
					if Game.buildings.has("monument") && Game.buildings["monument"] >= 3:
						node.show()
						shouldHidePrevContainer = false
						nothingFound = false
				if Game.buildings.has(gr) && Game.buildings[gr] >= 1:
					node.show()
					shouldHidePrevContainer = false
					nothingFound = false
		else:
			node.hide()
	
	if prevContainer != null && shouldHidePrevContainer:
		prevContainer.hide()
	
	if nothingFound:
		get_tree().get_first_node_in_group("searchNothingFound").show()
	else:
		get_tree().get_first_node_in_group("searchNothingFound").hide()
