extends Panel


func _get_drag_data(at_position):
	var data = {}
	var drag_texture = ActionIcon.new()
	drag_texture.size = Vector2(32,32)
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.position = -0.5 * (drag_texture.size)
	
	set_drag_preview(control)
	return data

func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	pass
