extends "res://scripts/classes/menus.gd"

signal start_pressed
signal tutorial_pressed
signal credits_pressed
signal configs_pressed
signal exit_pressed


func _ready() -> void:
	anchor_left = -1
	anchor_right = 0


func _on_start_button_pressed() -> void:
	start_pressed.emit()


func _on_tutorial_button_pressed() -> void:
	tutorial_pressed.emit()


func _on_credits_button_pressed() -> void:
	credits_pressed.emit()


func _on_config_button_pressed() -> void:
	configs_pressed.emit()


func _on_exit_button_pressed() -> void:
	exit_pressed.emit()
