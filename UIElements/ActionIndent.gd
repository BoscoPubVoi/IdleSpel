extends Panel

@onready var textureRect = $TextureRect

var enabled = true

func _ready():
	pass

func _get_drag_data(at_position):
	var data = {}
	var drag_texture = TextureRect.new()
	drag_texture.texture = textureRect.texture
	drag_texture.size = Vector2(32,32)
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
	Game.characters[0].actions[slot] = data["action"]
	
	
	var fullCycleResult = FullCycleResultEvaluator.evaluate(Game)
	
	textureRect.texture = data["texture"].texture
	textureRect.show()

func _get_index():
	return get_parent().get_children().find(self)
