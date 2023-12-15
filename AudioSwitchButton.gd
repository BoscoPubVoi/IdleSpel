extends Button

var icon_mute = preload("res://assets/ui/mute_audio.png")
var icon_muted = preload("res://assets/ui/muted_audio.png")

var muted:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	muted = !muted
	
	if muted:
		icon = icon_muted
		tooltip_text = "Unmute Audio"
	else:
		icon = icon_mute
		tooltip_text = "Mute Audio"
	AudioServer.set_bus_mute(0, muted)

func _make_custom_tooltip(for_text):
	var tooltip = preload("res://Tooltip.tscn").instantiate()
	tooltip.viewPortRect = get_viewport_rect().size
	tooltip.text = for_text
	return tooltip
