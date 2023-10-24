extends Panel


func assign_players_to_buildings():
	var i = 0
	for character in Game.characters:
		#get the child with the id equal to the array index
		var relevant_kid = get_child(i)
		#move them to the relevant building
		
		#hide all the non relevant ones
		i += 1
