extends "res://ui/in_game/game_hud.gd"




func _on_disable_col_check_toggled(toggled_on: bool) -> void:
	var p = get_tree().get_nodes_in_group("player")[0] as CharacterBody3D
	p.get_node("CollisionShape3D").set_deferred("disabled", toggled_on)


func _on_curve_y_slider_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("curve_y", value)


func _on_curve_z_slider_value_changed(value: float) -> void:
	RenderingServer.global_shader_parameter_set("curve_z", value)
