extends Panel

var characters = [$Character0, $Character1]

func assign_players_to_buildings():
	var i = 0
	for char in characters:
		char.hide()
	for character in Game.characters:
		#get the child with the id equal to the array index
		var relevant_kid = get_child(i)
		relevant_kid.show()
		#move them to the relevant building
		
		#hide all the non relevant ones
		i += 1



func unlock_building(resource):
	for building in get_children():
		if building.name == resource:
			building.show()
