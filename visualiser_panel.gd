extends Panel

var particle_label = preload("res://UIElements/particle_label.tscn")

@onready var characters = [$Character0, $Character1, $Character2, $Character3]

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
	buildings_use = ResourceHelpers.create_empty_resources()
	buildings_use["monument"] = 0
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
				if building_name != "monument":
					characters[i].move_to(building.position + Vector2(buildings_use[character.actions[Game.placeInCycle].building] * 32, building.texture.get_height()/2))
				else:
					characters[i].move_to(building.position + Vector2(buildings_use[character.actions[Game.placeInCycle].building] * 32, 30 + building.texture.get_height()/2))
		i += 1



func unlock_building(resource):
	for building in get_children():
		if building.name == resource:
			building.frame = 1
			building.show()
			building.get_child(0).hide()

func set_build_in_progress(resource):
	for building in get_children():
		var progbar = building.get_child(0)
		if building.name == resource:
			if Game.buildings[resource] == 0:
				building.hide()
			elif Game.buildings[resource] < 1:
				building.show()
				progbar.show()
				progbar.value = Game.buildings[resource]
				building.frame = 0

func set_monument_in_progress(tierID):
	for building in get_children():
		var progbar = building.get_child(0)
		if building.name == "monument":
			if tierID - 1 < Game.buildings["monument"] < tierID:
				building.show()
				building.frame = tierID - 1
			pass # todo, somehow set the building frame or something, maybe (tierID - 1) * 2

func set_monument_tier(tierID):
	for building in get_children():
		if building.name == "monument":
			building.show()
			building.frame = (tierID -1) * 2 + 1; # * 2 + 1 if with in progress images included

func create_particles(resourcesByBuilding):
	for resources_for_building in resourcesByBuilding:
		for resource in resourcesByBuilding[resources_for_building]:
			# resourcesByBuilding[resources_for_building][resource] is the number , resource is the name
			var res_amount = resourcesByBuilding[resources_for_building][resource]
			if res_amount != 0:
				for building in get_children():
					if building.name == resources_for_building:
						var newparticleLabel = particle_label.instantiate()
						newparticleLabel.create_text(resource, res_amount)
						newparticleLabel.set_start_point(Vector2.ZERO)
						building.add_child(newparticleLabel)
	pass
