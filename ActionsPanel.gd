extends Panel

func _can_drop_data(at_position, data):
	return true

func _drop_data(at_position, data):
	AudioManager.play("put_down_icon")
	data["original_original"].make_used(false)
	if !(data["origin_node"] is ActionIcon):
		data["origin_node"].empty_slot()
	#find the child that corresponds with the data, and make them enabled again
	pass
#	make_used(false)


func reset_action(action):
	action.make_used(false)
