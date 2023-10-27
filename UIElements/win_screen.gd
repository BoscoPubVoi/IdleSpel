extends PanelContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_text_meta_clicked(meta):
	OS.shell_open(meta)
	pass # Replace with function body.


func _on_close_button_pressed():
	visible = false
