class_name ShowPopup
static func show_popup(tree, title, text):
	if tree == null:
		return
	tree.get_first_node_in_group("PopupWindow").visible = true
	tree.get_first_node_in_group("PopupTitle").text = title
	tree.get_first_node_in_group("PopupText").text = text
	for n in tree.get_nodes_in_group("PopupWindowClose"):
		n.visible = true
