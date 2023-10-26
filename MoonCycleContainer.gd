extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for moon in get_children():
		if moon != null:
			moon.pivot_offset = moon.size / 2
			moon.scale = lerp(moon.scale, Vector2(1,1), delta * 8)

func make_moon_big():
	get_children()[Game.placeInCycle].scale = Vector2(1.4, 1.4)
