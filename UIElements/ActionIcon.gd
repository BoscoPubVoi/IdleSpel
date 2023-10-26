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
	epic_tooltip = action_name + ":\n" +  tooltip.replace("\\n", "\n")
	
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
				ShowPopup.show_popup(get_tree(), "Love Unlocked",
					"You can now gain Love. Gain a Love to get an additional follower.")
				get_tree().get_first_node_in_group("love").visible = true
			set_display()
#		$TextureRect.hide()
		$Lock.show()
	else:
		$Lock.hide()

func _get_drag_data(at_position):
	if !used && unlocked:
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
		tooltip_text = epic_tooltip
