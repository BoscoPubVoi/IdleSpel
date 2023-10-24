extends AnimatedSprite2D

@export var character_ID: int


func move_to(building_position):
	position = building_position + Vector2(5, 16)

func play_anim():
	play("dancing")
	
