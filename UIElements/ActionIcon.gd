class_name ActionIcon
extends Panel

@export var action_name :String
@export var operations : Array[Operation]
@export var building : String
@export var icon_path : String
@export var tooltip : String
@export var unlock_requirements : Array[UnlockRequirement]
@export var unlock_tooltip : String

@onready var textureRect = $TextureRect

var epic_tooltip

var used = false
var unlocked = true

func _ready():
	textureRect.texture = load(icon_path)
	epic_tooltip = "[b]" + action_name + "[/b]" + ":\n" +  tooltip.replace("\\n", "\n")
	
	# Check for unlocks
	var allUnlocksOK = true
	# Check all unlocks
	for unlock in unlock_requirements:
		if !unlock.meets_requirement(Game):
			allUnlocksOK = false
			break
	if !allUnlocksOK:
		unlocked = false
	
	set_display()

static func set_color_for_primary_type(operations, texture):
	var primaryType = ""
	for op in operations:
		var primaryTypeOfOp = check_primary_type(op)
		if primaryTypeOfOp != "":
			if primaryType != "" && primaryTypeOfOp != primaryType:
				primaryType = "multi"
			else:
				primaryType = primaryTypeOfOp
	
	match primaryType:
		"produce":
			texture.modulate = Color.from_string("#7FFF9F", Color.BLACK)
		"boost":
			texture.modulate = Color.from_string("#FF7F7F", Color.BLACK)
		"build":
			texture.modulate = Color.from_string("#7F88FF", Color.BLACK)
		"stat":
			texture.modulate = Color.from_string("#FFB67F", Color.BLACK)
		"boostPerm":
			texture.modulate = Color.from_string("#FCFF7F", Color.BLACK)
		"multi":
			texture.modulate = Color.from_string("#FFFFFF", Color.BLACK)

static func check_primary_type(operation):
	if operation is ProduceBaseResource:
		return "produce"
	if operation is BoostCharactersInPosition:
		return "boost"
	if operation is BoostCharacterStat:
		return "stat"
	if operation is BoostCharacterStatOfAll:
		return "stat"
	if operation is BoostCharacterStatOfAllEqualToSelf:
		return "stat"
	if operation is BuildBuildingOrIncreaseCap:
		return "build"
	if operation is BuildMonument:
		return "build"
	if (operation is CheckMoonPhase ||
		operation is CheckResource ||
		operation is CheckStat ||
		operation is CheckStatOther ||
		operation is ConsumeStatAndDo ||
		operation is MultiplyInternalBasedOnResource ||
		operation is MultiplyInternalBasedOnStat):
		return check_primary_type(operation.operation)
	if (operation is PayCostAndDo ||
		operation is PayCapAndDo):
		var primaryType = ""
		for op in operation.operations:
			var primaryTypeOfOp = check_primary_type(op)
			if primaryTypeOfOp != "":
				if primaryType != "" && primaryTypeOfOp != primaryType:
					primaryType = "multi"
				else:
					primaryType = primaryTypeOfOp
		return primaryType
	if operation is IncreaseGlobalProductionBonus:
		return "boostPerm"
	
	if operation is ProduceBaseResource:
		return "produce"
	if operation is ProduceSecondaryResource:
		return "produce"
	if operation is SkipAllOtherActions:
		return ""
	return ""

func _process(delta):
	if ! unlocked:
		var allUnlocksOK = true
		# Check all unlocks
		for unlock in unlock_requirements:
			if !unlock.meets_requirement(Game):
				allUnlocksOK = false
				break
		if allUnlocksOK:
			unlocked = true
			if action_name == "Fertility Ritual":
				ShowPopup.show_popup(get_tree(), "Fertility Unlocked",
					"You can now gain Fertility. Gain a Fertility to get an additional follower.")
				get_tree().get_first_node_in_group("love").visible = true
			set_display()
#		$TextureRect.hide()
		$Lock.show()
	else:
		$Lock.hide()

func _get_drag_data(at_position):
	if !used && unlocked:
		AudioManager.play("pick_up_icon")
		return get_drag_data_unconstrained();

func get_drag_data_unconstrained():
		var data = {} 
		data["origin_node"] = self
		data["action"] = Action.new()
		data["action"].constructor(operations)
		data["action"].name = action_name
		data["action"].building = building
		data["tooltip"] = epic_tooltip
		data["original_original"] = self
		var drag_texture = TextureRect.new()
		drag_texture.texture = load(icon_path)
		drag_texture.size = Vector2(32,32)
		set_color_for_primary_type(operations, drag_texture)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.position = -0.5 * (drag_texture.size)
		
		set_drag_preview(control)
		data["texture"] = drag_texture
		return data

func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	get_tree().get_first_node_in_group("ActionsPanel")._drop_data(at_position, data)
	update_production()
	
func make_used(newval):
	used = newval
	set_display()
	
func set_display():
#	$TextureRect.show()
	
	#hide it or something
	if used:
		textureRect.modulate = Color(1.0,1.0,1.0,.1)
		tooltip_text = epic_tooltip
	elif !unlocked:
		textureRect.modulate = Color(1.0,1.0,1.0,.1)
		tooltip_text = unlock_tooltip
	else:
		textureRect.modulate = Color(1.0,1.0,1.0,1.0)
		set_color_for_primary_type(operations, textureRect)
		tooltip_text = epic_tooltip

func update_production():
	get_tree().get_first_node_in_group("main").update_production_for_characters()

func _make_custom_tooltip(for_text):
	var tooltip = preload("res://Tooltip.tscn").instantiate()
	tooltip.viewPortRect = get_viewport_rect().size
	tooltip.text = for_text
	return tooltip
