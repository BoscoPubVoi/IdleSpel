extends PanelContainer

var autoDisappear:bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if autoDisappear && Game.resources["rocks"] >= 1:
		visible = false
		autoDisappear = false
	pass
