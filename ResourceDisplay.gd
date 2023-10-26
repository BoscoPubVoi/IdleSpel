extends TextureRect

@export var normalTooltip:String
@export var associatedResource:String
@export var flashUntilMouseOver:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
