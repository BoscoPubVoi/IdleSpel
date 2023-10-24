extends Panel

@onready var characters = [$Character0, $Character1, $Character2]

var buildings_use= {
	rocks = 0,
	water = 0,
	silver = 0,
	favor = 0,
	relics = 0,
	moonstone = 0,
	moonlight = 0
}

func _ready():
	assign_characters_to_buildings()

func assign_characters_to_buildings():
	var current = Game.placeInCycle
	var i = 0
	for char in characters:
		char.hide()
	for character in Game.characters:
		characters[i].show()
		if character.actions[Game.placeInCycle] != null:
			if character.actions[Game.placeInCycle].building != "" && Game.buildings[character.actions[Game.placeInCycle].building] != 0:
				buildings_use[character.actions[Game.placeInCycle].building] += 1
				#get the child with the id equal to the array index
				var relevant_kid = get_child(i)
				relevant_kid.show()
				#move them to the relevant building
				var building_name = character.actions[Game.placeInCycle].building
				var building = get_node(building_name)
				#hide all the non relevant ones
				characters[i].move_to(building.position + Vector2(buildings_use[character.actions[Game.placeInCycle].building] * 16, 0))
		i += 1



func unlock_building(resource):
	for building in get_children():
		if building.name == resource:
			building.show()
