extends Panel

@onready var textureRect = $TextureRect

var enabled = true

var current_data = null


func _ready():
	pass

func _get_drag_data(at_position):
	if current_data != null:
		var data = current_data
		data["origin_node"] = self
		var drag_texture = TextureRect.new()
		drag_texture.texture = textureRect.texture
		drag_texture.size = Vector2(32,32)
		drag_texture.size = Vector2(32,32)
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.position = -0.5 * (drag_texture.size)
		data["texture"] = drag_texture
		set_drag_preview(control)
		return data

func _can_drop_data(at_position, data):
	print(data)
	var target_slot = data
	if target_slot == null:
		data["target_slot"] = null
	else:
		data["target_slot"] = target_slot
	return true

func _drop_data(at_position, data):
#	data["target_slot"] = null
	var origin_slot = data["origin_node"]
	var origin_origin = data["original_original"]
	if data["target_slot"] == null:
		put_in_slot(data)
		
		#empty the old one
		if origin_slot is ActionIcon:
			origin_slot.make_used(true)
		else:
			origin_slot.empty_slot()
	
	#theres something in the slot alrady!!
	else:
#		data["target_slot"] = null
		#enable old one if actionicon, or replace old one if not
		if origin_slot is ActionIcon:
			origin_origin.make_used(true)
			put_in_slot(data)
			#enable the one that was replaced in the actionicons TODO
			
		else:
			#not empty and your trying to replace it
			origin_slot.put_in_slot(data["target_slot"])
			put_in_slot(data)

func put_in_slot(data):
	var slot = _get_index()
	current_data = data
	var par = get_parent()
	while par != null && !par.is_in_group("ActorPanel"):
		par = par.get_parent()
	Game.characters[par.characterID].actions[slot] = data["action"]
	
	
	var fullCycleResult = FullCycleResultEvaluator.evaluate(Game)
	
	textureRect.texture = data["texture"].texture
	textureRect.show()
	tooltip_text = data["tooltip"]


func _get_index():
	return get_parent().get_children().find(self)

func empty_slot():
	current_data = null
	var slot = _get_index()
	Game.characters[0].actions[slot] = null
	textureRect.texture = null
	textureRect.hide()
	tooltip_text = ""
	pass
