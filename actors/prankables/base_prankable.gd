extends StaticBody3D

@export var gui_name: String
@export var score: int
@export var anim_name: String
@export_node_path("Node3D") var model_node_path

@onready var model_node := get_node(model_node_path) as Node3D


func _ready() -> void:
	pass


func animate_prank() -> void:
	var anim := model_node.get_node_or_null("AnimationPlayer") as AnimationPlayer
	if anim == null or not anim.has_animation(anim_name):
		printerr("Player for ", model_node.name, " does not have this animation")
	else:
		anim.play(anim_name)
		set_collision_layer_value(4, false)

