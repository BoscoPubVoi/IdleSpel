extends AnimatedSprite2D

@export var character_ID: int


func move_to(building_position):
	position = building_position + Vector2(-72, 24)

func play_anim():
	play("dancing")
	
