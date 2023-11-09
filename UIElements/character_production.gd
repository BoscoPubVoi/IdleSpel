extends HBoxContainer

func _ready():
	for resource in get_children():
		resource.hide()
	

func update(newDict):
	for resource in get_children():
		resource.hide()
	for resource in newDict.keys():
		var resource_node = get_node(resource)
		if newDict[resource] > 0:
			resource_node.get_child(1).text = " +" + str(round(newDict[resource]))
		else:
			resource_node.get_child(1).text = " " +str(round(newDict[resource]))
		resource_node.show()

