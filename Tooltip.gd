extends Label

var viewPortRect:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	_process(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().position.x = min(viewPortRect.x - get_parent().size.x - 10, get_parent().position.x)
	get_parent().position.y = min(viewPortRect.y - get_parent().size.y - 10, get_parent().position.y)
	pass


func _on_resized():
	get_parent().position.x = min(viewPortRect.x - get_parent().size.x - 10, get_parent().position.x)
	get_parent().position.y = min(viewPortRect.y - get_parent().size.y - 10, get_parent().position.y)
	pass
