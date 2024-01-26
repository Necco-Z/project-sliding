#extends Node3D
#
#@export_file("*.tscn") var replacer_path
#@export var replacers: Array[ReplaceItem]
#
#@onready var map := $GridMap as GridMap
#@onready var meshlib := map.mesh_library as MeshLibrary
#@onready var replacer := load(replacer_path) as PackedScene
#
#
#func _ready() -> void:
	##var lib_ids := meshlib.get_item_list()
	##for i in lib_ids:
		##print(i, ": ", meshlib.get_item_name(i))
	#for r in replacers:
		#replace_on_grid(r.name, r.replace_file)
#
#
#func replace_on_grid(item_name: String, change_to: PackedScene) -> void:
	#var id := meshlib.find_item_by_name(item_name)
	#if id < 0:
		#printerr(item_name, " not found on mesh library")
		#return
	#var used_cells := map.get_used_cells_by_item(id)
	#for i in used_cells:
		#var pos = map.map_to_local(i)
		#var rep = change_to.instantiate()
		#add_child(rep)
		#rep.position = pos
		#map.set_cell_item(i, GridMap.INVALID_CELL_ITEM)
