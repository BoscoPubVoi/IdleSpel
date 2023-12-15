extends TextureRect

@export var normalTooltip:String
@export var associatedResource:String
@export var flashUntilMouseOver:bool = false

var storeddpi = 96

# Called when the node enters the scene tree for the first time.
func _ready():
	rescale()
	
func rescale():
	var dpi = DisplayServer.screen_get_dpi()
	var scalefactor = clamp(dpi / 96.0, 1, 5)
	var sz = DisplayServer.screen_get_size()
	if sz.x / scalefactor < 1150:
		scalefactor = max(sz.x / 1150, 1)
	if sz.y / scalefactor < 650:
		scalefactor = max(sz.y / 650, 1)
	get_tree().root.content_scale_factor = scalefactor
	storeddpi = dpi
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if DisplayServer.screen_get_dpi() != storeddpi:
		rescale()
	
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
