extends TextureRect

@export var normalTooltip:String
@export var associatedResource:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.globalProductionBonuses.has(associatedResource) && Game.globalProductionBonuses[associatedResource] > 0:
		tooltip_text = normalTooltip + " (" + str(ceil(Game.globalProductionBonuses[associatedResource] * 100)) + "% bonus production)"
	else:
		tooltip_text = normalTooltip
	pass
