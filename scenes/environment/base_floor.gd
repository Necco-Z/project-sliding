extends Node3D

@onready var decorations := $Decorations as Node3D


func _ready() -> void:
	_randomize_decorations()


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
