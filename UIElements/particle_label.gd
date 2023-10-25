extends Label


func _process(delta):
	position.y -= .1
	modulate.a -= 0.01
	if modulate.a <= 0:
		queue_free()

func create_text(resource_name, amount):
	var newtext = ""
	if amount > 0:
		newtext += "+"
	else:
		newtext += "-"
	newtext += str(amount) + resource_name
	text = newtext

func set_start_point(building_position):
	position = building_position + Vector2(randi()%30 -40, randi()%40 -80)
