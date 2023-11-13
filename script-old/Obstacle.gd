extends StaticBody3D

signal player_collided


func _ready():
	owner.connect_obstacle(self)


func _on_body_collided(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_collided.emit()
