class_name ActionIcon
extends Panel

@export var action_name :String
@export var operations : Array[Operation]
@export var icon_path : String
@export var tooltip : String

@onready var textureRect = $TextureRect

var epic_tooltip

var used = false

func _ready():
	textureRect.texture = load(icon_path)
	epic_tooltip = action_name + ":\n" +  tooltip
	tooltip_text = epic_tooltip

func _get_drag_data(at_position):
	if !used:
		var data = {} 
		data["origin_node"] = self
		data["action"] = Action.new()
		data["action"].constructor(operations)
		data["action"].name = action_name
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
	#hide it or something
	if newval:
		textureRect.modulate = Color(1.0,1.0,1.0,.1)
	else:
		textureRect.modulate = Color(1.0,1.0,1.0,1.0)
