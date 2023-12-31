extends Panel

@onready var rel_character = $"../../.."
@onready var textureRect = $TextureRect

@export var enabled = true

var current_data = null

func _ready():
	set_enabled(enabled)
	pass
	
func _get_drag_data(at_position):
	if current_data != null:
		AudioManager.play("pick_up_icon")
		var data = current_data
		data["origin_node"] = self
		var drag_texture = TextureRect.new()
		drag_texture.texture = textureRect.texture
		drag_texture.size = Vector2(32,32)
		drag_texture.size = Vector2(32,32)
		drag_texture.modulate = textureRect.modulate
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.position = -0.5 * (drag_texture.size)
		data["texture"] = drag_texture
		set_drag_preview(control)
		return data

func _can_drop_data(at_position, data):
	if !enabled:
		return false
	
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
			origin_slot.put_in_slot(data["target_slot"], temptexture)
			put_in_slot(data)
	current_data = data

func put_in_slot(data, tempTexture = null):
	AudioManager.play("put_down_icon")
	var slot = _get_index()
	current_data = data
	var par = get_parent()
	while par != null && !par.is_in_group("ActorPanel"):
		par = par.get_parent()
	Game.characters[par.characterID].actions[slot] = current_data["action"]
	Game.onChange()
	
	if !is_instance_valid(current_data["texture"]):
		textureRect.texture = tempTexture
	else:
		textureRect.texture = current_data["texture"].texture
	textureRect.show()
	tooltip_text = current_data["tooltip"]
	
	ActionIcon.set_color_for_primary_type(current_data["action"].operations, textureRect)
	update_production()


func _get_index():
	return get_parent().get_children().find(self)

func empty_slot():
	current_data = null
	var slot = _get_index()
	Game.characters[rel_character.characterID].actions[slot] = null
	Game.onChange()
#	textureRect.texture = null
	textureRect.hide()
	tooltip_text = ""
	update_production()

func set_enabled(enabled_):
	enabled = enabled_
	if enabled:
		remove_theme_stylebox_override("panel")
	else:
		var stylebox = StyleBoxFlat.new()
		add_theme_stylebox_override("panel", stylebox)
		stylebox.set_bg_color(Color(.5, .5, .5, 0.1))
		stylebox.border_color = Color(1.0, 1.0, 1.0, 0.1)
		stylebox.set_border_width_all(2)


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if current_data != null:
				get_tree().get_first_node_in_group("ActionsPanel").reset_action(current_data["original_original"])
				empty_slot()
	pass # Replace with function body.


func update_production():
	get_tree().get_first_node_in_group("main").update_production_for_characters()

func _make_custom_tooltip(for_text):
	var tooltip = preload("res://Tooltip.tscn").instantiate()
	tooltip.viewPortRect = get_viewport_rect().size
	tooltip.text = for_text
	return tooltip


