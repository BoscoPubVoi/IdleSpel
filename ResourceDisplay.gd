extends TextureRect

@export var normalTooltip:String
@export var associatedResource:String
@export var flashUntilMouseOver:bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Game.globalProductionBonuses.has(associatedResource) && Game.globalProductionBonuses[associatedResource] > 0:
		tooltip_text = normalTooltip + " (" + str(ceil(Game.globalProductionBonuses[associatedResource] * 100)) + "% bonus production)"
	else:
		tooltip_text = normalTooltip

	if flashUntilMouseOver:
		self.modulate = Color.from_string("#f8ff00", Color.BLACK) if Engine.get_frames_drawn() % 30 < 15 else Color.WHITE
	else:
		self.modulate = Color.WHITE

func _on_mouse_entered():
	flashUntilMouseOver = false
	self.modulate = Color.WHITE


func _make_custom_tooltip(for_text):
	var tooltip = preload("res://Tooltip.tscn").instantiate()
	tooltip.viewPortRect = get_viewport_rect().size
	tooltip.text = for_text
	tooltip.textLiveUpdate = func():
		if Game.globalProductionBonuses.has(associatedResource) && Game.globalProductionBonuses[associatedResource] > 0:
			return normalTooltip + " (" + str(ceil(Game.globalProductionBonuses[associatedResource] * 100)) + "% bonus production)"
		else:
			return normalTooltip
	return tooltip
