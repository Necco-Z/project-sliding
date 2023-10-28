extends Area3D

signal coin_collected

@onready var mesh = $mesh


func _ready() -> void:
	pass


func _physics_process(_delta) -> void:
	mesh.rotate_y(0.1)


func _on_body_entered(_body: Node3D) -> void:
	coin_collected.emit()
	queue_free()
