extends Node  # or whatever your main scene extends from

func _ready() -> void:
	print("Main: Scene tree nodes:")
	print_scene_tree()
	
func print_scene_tree(node: Node = self, indent: String = "") -> void:
	print(indent + node.name + " (" + node.get_class() + ")")
	for child in node.get_children():
		print_scene_tree(child, indent + "  ")
