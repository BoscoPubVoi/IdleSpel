extends Panel

@export var characterID:int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
#	update_worshiper_stats()
	pass


func update_worshiper_stats():
	$Vigor/VigorLabel.text = str(Game.characters[characterID]["stats"]["vigor"])
