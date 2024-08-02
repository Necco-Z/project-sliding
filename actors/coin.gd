extends Area3D

@onready var tween = create_tween() as Tween

var death_animation_time = 0.3
var yes = false


func _ready() -> void:
	tween.set_loops()
	tween.tween_property($Model, "rotation:y", PI, 1.0).as_relative()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.collect_coin()
		
		var death_tween = create_tween() as Tween
		death_tween.tween_property($Model, "position", Vector3.UP * 2, death_animation_time * .75).as_relative().set_ease(Tween.EASE_IN)
		death_tween.tween_property($Model, "scale", Vector3.ZERO, death_animation_time).from_current().set_ease(Tween.EASE_OUT)
		death_tween.tween_callback(Callable(self, "_on_death_timer_timeout"))
		get_node("CoinCatch").play()

func _on_death_timer_timeout():
	tween.kill()
	queue_free()
