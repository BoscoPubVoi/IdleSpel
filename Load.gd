extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var loadoutx = $"../OptionButton".get_selected_id()

	if len(Game.savedLoadouts) > loadoutx && Game.savedLoadouts[loadoutx] != null:
		LoadoutSaver.load_loadout(Game.savedLoadouts[loadoutx], get_tree())
