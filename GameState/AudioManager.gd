extends Node

var audio_files = \
{
	"building_done": ["res://assets/music/sfx/building_done.ogg", 1],
	"building" : ["res://assets/music/sfx/building.ogg", 1],
	"button" : ["res://assets/music/sfx/button.ogg", 1],
	"monument_building" : ["res://assets/music/sfx/monument_building.ogg", 1],
	"monument_done" : ["res://assets/music/sfx/monument_done.ogg", 1],
	"pick_up_icon" : ["res://assets/music/sfx/pick_up_icon.ogg", 1],
	"put_down_icon" : ["res://assets/music/sfx/put_down_icon.ogg", 1]
}

var audio_streams = {}
var audio_buses = {}
var audio_stream_players = {}


var music_streams = []

var current_music = null
var current_music_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	load_audio() # probs change 	

		
func load_audio():
	for key in audio_files:
		var stream = load(audio_files[key][0])
		audio_streams[key] = stream 
		audio_buses[key] = audio_files[key][1]


func play(sound_name, volume = -5, pitch = 0.5, fade = 0):
	if !audio_streams.has(sound_name):
		print("Cannot find sound %s" % sound_name)
		return null
		
	var stream_player = AudioStreamPlayer.new()
	stream_player.set_stream(audio_streams[sound_name])
	stream_player.set_bus("SFX")
	stream_player.set_pitch_scale(pitch)
	stream_player.set_volume_db(volume)
	add_sound(stream_player)
	stream_player.play()
	
func add_sound(sound):
	add_child(sound)
	
