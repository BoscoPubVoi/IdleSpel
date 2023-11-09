extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_submitted(new_text):
	var loadoutx = $"../OptionButton".get_selected_id()
	$"../OptionButton".set_item_text(loadoutx, new_text)
	pass # Replace with function body.
