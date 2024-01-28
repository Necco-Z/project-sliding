extends Node3D

@export_node_path("CharacterBody3D") var player_node

var offset: Vector3
var is_following := true

@onready var player = get_node(player_node) as CharacterBody3D


# Built-in functions
func _ready() -> void:
	offset = player.global_position - global_position


func _process(_delta: float) -> void:
	if is_following:
		global_position = player.global_position - offset


