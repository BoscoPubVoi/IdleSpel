extends LineEdit



func _on_button_pressed():
	var loadoutx = $"../OptionButton".get_selected_id()
	$"../OptionButton".set_item_text(loadoutx, $"../LineEdit".text)



func _on_text_submitted(new_text):
	var loadoutx = $"../OptionButton".get_selected_id()
	$"../OptionButton".set_item_text(loadoutx, new_text)


func _on_option_button_item_selected(index):
	$"../LineEdit".text = ""
	pass # Replace with function body.
