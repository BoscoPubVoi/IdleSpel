extends Panel

@onready var characters = [$Character0, $Character1, $Character2]

func assign_characters_to_buildings():
	var current = Game.placeInCycle
	var i = 0
	for char in characters:
		char.hide()
	for character in Game.characters:
		characters[i].show()
		if character.actions[Game.placeInCycle] != null:
			#get the child with the id equal to the array index
			var relevant_kid = get_child(i)
			relevant_kid.show()
			#move them to the relevant building
			var building_name = character.actions[Game.placeInCycle].building
			var building = get_node(building_name)
			#hide all the non relevant ones
			characters[i].move_to(building.position)
		i += 1



func unlock_building(resource):
	for building in get_children():
		if building.name == resource:
			building.show()
