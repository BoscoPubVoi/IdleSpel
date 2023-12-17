extends Control

@onready var MoonContainer = $AllActorsPanel/MoonCycleContainer
@onready var Visualiser = $Panel/HBoxContainer/VisualiserPanel

static var savedLoadout = null;

var cycleStepRunner = CycleStepRunner.new()

var storeddpi = 96
var makeSmaller = false

func rescale():
	var dpi = DisplayServer.screen_get_dpi()
	var scalefactor = clamp(dpi / 96.0, 1, 5)

	var sz = DisplayServer.screen_get_size()
	if sz.x / scalefactor < 1150:
		scalefactor = max(sz.x / 1150, 1)
	if sz.y / scalefactor < 650:
		scalefactor = max(sz.y / 650, 1)
	if makeSmaller:
		scalefactor = clamp(floor(scalefactor / 2), 1, 3)

	get_tree().root.content_scale_factor = scalefactor
	storeddpi = dpi
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if DisplayServer.screen_get_dpi() != storeddpi:
		rescale()

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
	AudioServer.set_bus_mute(0, false)
	$WinScreen.hide()
	DisplayServer.window_set_min_size(Vector2(1152, 652))
	$Timer.start()
	$GameSave.start()
	rescale()

func _on_timer_timeout():
	cycleStepRunner.runOneStep(get_tree())
	update_resource_labels()
	updateMoonCycleIcon()
	

func floorx(n):
	if n <= 0:
		return 0
	return floor(n)

func update_resource_labels():
	$ResourcesPanel/Rocks/RockLabel.text = str(floorx(Game.resources["rocks"])) + " / " + str(floor(Game.resourceCaps["rocks"]))
	$ResourcesPanel/Water/WaterLabel.text = str(floorx(Game.resources["water"])) + " / " + str(floor(Game.resourceCaps["water"]))
	$ResourcesPanel/Silver/SilverLabel.text = str(floorx(Game.resources["silver"])) + " / " + str(floor(Game.resourceCaps["silver"]))
	$ResourcesPanel/Favor/FavorLabel.text = str(floorx(Game.resources["favor"])) + " / " + str(floor(Game.resourceCaps["favor"]))
	$ResourcesPanel/Relic/RelicLabel.text = str(floorx(Game.resources["relics"])) + " / " + str(floor(Game.resourceCaps["relics"]))
	$ResourcesPanel/Moonstone/MoonstoneLabel.text = str(floorx(Game.resources["moonstone"])) + " / " + str(floor(Game.resourceCaps["moonstone"]))
	$ResourcesPanel/Moonlight/MoonlightLabel.text = str(floorx(Game.resources["moonlight"])) + " / " + str(floor(Game.resourceCaps["moonlight"]))
	var loveGoal = CycleStepRunner.get_current_love_goal(Game)
	if loveGoal < 10000:
		$ResourcesPanel/Fertility/FertilityLabel.text = str(floorx(Game.resources["love"])) + (" / " + str(CycleStepRunner.get_current_love_goal(Game)))
	else:
		$ResourcesPanel/Fertility/FertilityLabel.text = str(floorx(Game.resources["love"]))

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
	var just_pressed = event.is_pressed() and not event.is_echo()
	#if Input.is_key_pressed(KEY_F12) and just_pressed:
		#get_tree().get_first_node_in_group("MainTimer").wait_time = 0.01 if get_tree().get_first_node_in_group("MainTimer").wait_time == 1 else 1
	if Input.is_key_pressed(KEY_SHIFT) and Input.is_key_pressed(KEY_F9) and just_pressed:
		makeSmaller = !makeSmaller
		rescale()

#Search
func _on_line_edit_text_changed(new_text):
	var shouldHidePrevContainer = false;
	var prevContainer = null
	var nothingFound = true
	
	for node in $ActionsPanel/MarginContainer/MarginContainer/ScrollContainer/Margin/ActionGrid.get_children():
		if node is MarginContainer:
			if node.get_groups().has("UpgradeMonumentHint"):
				if new_text != "":
					node.hide()
				elif (Game.buildings.has("relics") && Game.buildings["relics"] == 1) && (Game.buildings.has("monument") && Game.buildings["monument"] < 2):
					node.show()
				else:
					node.hide()
				continue
			if node.get_groups().has("UpgradeMonumentHint2"):
				if new_text != "":
					node.hide()
				elif (Game.buildings.has("moonlight") && Game.buildings["moonlight"] == 1) && (Game.buildings.has("monument") && Game.buildings["monument"] < 3):
					node.show()
				else:
					node.hide()
				continue
			
			if node.get_groups().has("promo"):
				if new_text == "" && Game.buildings.has("monument") && Game.buildings["monument"] >= 1:
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


func _on_credits_pressed():
	$Credits.show()


func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	pass


func update_production_for_characters():
	var actorPanelContainer = 	$AllActorsPanel/MarginContainer/ScrollContainer/MarginContainer/HBoxContainer/VBoxContainer
	var new_character_productions = FullCycleResultEvaluator.evaluate(Game)
	if Game.characters[0] != null:
		actorPanelContainer.get_children()[0].update_cycle_production(new_character_productions[0])
	if Game.characters.size() >= 2:
		actorPanelContainer.get_children()[1].update_cycle_production(new_character_productions[1])
	if Game.characters.size() >= 3:
		actorPanelContainer.get_children()[2].update_cycle_production(new_character_productions[2])
	if Game.characters.size() >= 4:
		actorPanelContainer.get_children()[3].update_cycle_production(new_character_productions[3])


func _on_label_3_meta_clicked(meta):
	OS.shell_open(meta)
