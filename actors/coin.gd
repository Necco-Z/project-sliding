extends Area3D

@onready var tween = create_tween() as Tween
@onready var sound = $CoinCatch

var death_animation_time = 0.3
var yes = false


func _ready() -> void:
	tween.set_loops()
	tween.tween_property($Model, "rotation:y", PI, 1.0).as_relative()


func _on_body_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		return
	
	body.collect_coin()
	sound.play()
	
	var death_tween = create_tween()
	death_tween.tween_property($Model, "position", Vector3.UP * 2, 0.1).as_relative()
	death_tween.set_parallel().tween_property($Model, "scale", Vector3.ZERO, 0.1).from_current()
	
	await death_tween.finished
	set_visible(false)
	tween.kill()
	await sound.finished
	queue_free()
