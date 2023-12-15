extends PanelContainer



func _on_close_button_pressed():
	visible = false


func _on_credits_button_pressed():
	visible = true


func _on_restart_pressed():
	$MarginContainer/VBoxContainer/Restart.hide()
	$MarginContainer/VBoxContainer/AreYouSure.show()

func _on_are_you_sure_pressed():
	Game.restart_game()


func _on_text_meta_clicked(meta):
	OS.shell_open(meta) # Replace with function body.
