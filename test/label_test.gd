extends Control

var is_busy := false
var prank_base := load("res://ui/prank.tscn") as PackedScene


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and not is_busy:
		var p = prank_base.instantiate()
		$Container.add_child(p)
		p.start_anim("Teste nº" + str(randi_range(100, 900)))
