extends "res://scripts/classes/menus.gd"


func _init() -> void:
	is_submenu = true


func set_connections(_game_scene: Node) -> void:
	pass


func _on_go_back_pressed() -> void:
	owner.close_submenu()
