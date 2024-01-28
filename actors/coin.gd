extends Area3D

@onready var anim = $AnimationPlayer


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.collect_coin()
		queue_free()
