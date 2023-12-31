extends Panel

@export var characterID:int

@onready var char_prod = $CharacterProduction
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	update_worshiper_stats()
	pass


func update_worshiper_stats():
	if !visible:
		return
	
	$Vigor/VigorLabel.text = str(floor(Game.characters[characterID]["stats"]["vigor"]))
	$Wisdom/WisdomLabel.text = str(floor(Game.characters[characterID]["stats"]["wisdom"]))
	$Reverance/ReveranceLabel.text = str(floor(Game.characters[characterID]["stats"]["reverance"]))

func update_cycle_production(newDict):
	char_prod.update(newDict)
