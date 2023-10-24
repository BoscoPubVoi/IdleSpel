extends Panel

@onready var textureRect = $TextureRect

var enabled = true

var current_data = null


func _ready():
	pass


	
func _get_drag_data(at_position):
	if current_data != null:
		print(current_data)
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
		print(data)
		return data

func _can_drop_data(at_position, data):
	
	var target_slot = current_data
	if target_slot == null:
		data["target_slot"] = null
	else:
		data["target_slot"] = target_slot
	return true

func _drop_data(at_position, data):
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
			origin_slot.make_used(true)
			put_in_slot(data)
			get_tree().get_first_node_in_group("ActionsPanel").reset_action(data["target_slot"]["original_original"])
		else:
			#not empty and your trying to replace it
			var temptexture = textureRect.texture
#			print(data["target_slot"])
			origin_slot.put_in_slot(data["target_slot"], temptexture)
			put_in_slot(data)

func put_in_slot(data, tempTexture = null):
	var slot = _get_index()
	current_data = data
	var par = get_parent()
	while par != null && !par.is_in_group("ActorPanel"):
		par = par.get_parent()
	Game.characters[par.characterID].actions[slot] = current_data["action"]
	
	
	var fullCycleResult = FullCycleResultEvaluator.evaluate(Game)
	
	if !is_instance_valid(current_data["texture"]):
		textureRect.texture = tempTexture
	else:
		textureRect.texture = current_data["texture"].texture
	textureRect.show()
	tooltip_text = current_data["tooltip"]


func _get_index():
	return get_parent().get_children().find(self)

func empty_slot():
	current_data = null
	var slot = _get_index()
	Game.characters[0].actions[slot] = null
#	textureRect.texture = null
	textureRect.hide()
	tooltip_text = ""
	pass
