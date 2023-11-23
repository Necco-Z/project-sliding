extends StaticBody3D

signal player_collided
signal prank_executed

@export var score := 100
@export var desc := "Boneco de neve"


func _ready():
	owner.connect_obstacle(self)


func _on_body_collided(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_collided.emit()


func _on_prank_executed() -> void:
	prank_executed.emit(score, desc)
