extends "res://scripts/classes/menus.gd"

signal start_pressed
signal return_pressed


func _ready() -> void:
	anchor_left = -1
	anchor_right = 0


func set_connections(game_scene: Node) -> void:
	start_pressed.connect(game_scene._on_start_pressed)
	return_pressed.connect(game_scene._on_return_pressed)


func _on_start_button_pressed() -> void:
	start_pressed.emit()


func _on_return_button_pressed() -> void:
	return_pressed.emit()
