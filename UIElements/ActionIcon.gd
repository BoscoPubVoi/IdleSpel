class_name ActionIcon
extends Panel

@export var action_name :String
@export var operations : Array[Operation]
@export var icon_path : String

@onready var textureRect = $TextureRect

var used = false

func _ready():
	textureRect.texture = load(icon_path)

func _get_drag_data(at_position):
	if !used:
		var data = {} 
		data["action"] = Action.new()
		data["action"].constructor(operations)
		data["action"].name = action_name
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
	return false

func _drop_data(at_position, data):
	used = true
	
