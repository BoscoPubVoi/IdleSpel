extends Panel

@onready var textureRect = $TextureRect

var enabled = true

func _ready():
	
	pass

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
	var slot = _get_index()
	print("before:")
	print(slot)
	print(data["action"].operations)
	print(Game.characters[0].actions)
	Game.characters[0].actions[slot] = data["action"]
	print("after:")
	print(data["action"].operations[0])
	print(Game.characters[0].actions)
	
	
	var fullCycleResult = FullCycleResultEvaluator.evaluate(Game)
	print("outcome")
	print(fullCycleResult.resources)
	
	textureRect.texture = data["texture"].texture
	textureRect.show()

func _get_index():
	return get_parent().get_children().find(self)
