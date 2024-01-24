extends Area3D

@onready var anim = $AnimationPlayer


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.collect_coin()
		anim.play("coin_get")
		await anim.animation_finished
		queue_free()
