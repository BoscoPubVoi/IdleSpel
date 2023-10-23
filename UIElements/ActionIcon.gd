class_name ActionIcon
extends Panel

@export var action_name :String
@export var operations : Array[Operation]


func _ready():
	pass

func _get_drag_data(at_position):
	var data = {} 
	data["action"] = Action.new()
	data["action"].constructor(operations)
	data["action"].name = action_name
	var drag_texture = ActionIcon.new()
	drag_texture.size = Vector2(32,32)
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.position = -0.5 * (drag_texture.size)
	
	set_drag_preview(control)
	return data
	pass

func _can_drop_data(at_position, data):
	return true
	return false

func _drop_data(at_position, data):
	pass
