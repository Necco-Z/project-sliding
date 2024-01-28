extends Area3D

@onready var tween = create_tween() as Tween


func _ready() -> void:
	tween.set_loops()
	tween.tween_property($Model, "rotation:y", PI, 1.0).as_relative()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.collect_coin()
		tween.kill()
		queue_free()
