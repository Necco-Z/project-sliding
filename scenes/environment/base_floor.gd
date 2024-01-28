extends Node3D

@onready var decorations := $Decorations as Node3D
@onready var map := $GridMap as GridMap
@onready var meshlib := map.mesh_library as MeshLibrary


func _ready() -> void:
	_randomize_decorations()


func replace_on_grid(item_name: String, change_to: PackedScene) -> void:
	var id := meshlib.find_item_by_name(item_name)
	if id < 0:
		printerr(item_name, " not found on mesh library")
		return
	var used_cells := map.get_used_cells_by_item(id)
	for i in used_cells:
		var pos = map.map_to_local(i)
		var rep = change_to.instantiate()
		map.add_child(rep)
		rep.position = pos
		map.set_cell_item(i, GridMap.INVALID_CELL_ITEM)


func _randomize_decorations(unwanted_type := -1) -> void:
	var rand := -1
	var decor_size := decorations.get_children().size()
	while rand < 0 or rand == unwanted_type:
		rand = randi() % decorations.get_children().size()
	for i in range(decor_size):
		var child := decorations.get_child(i) as Node3D
		if i == rand:
			child.visible = true
		else:
			child.visible = false
