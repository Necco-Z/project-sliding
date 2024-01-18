extends "res://scripts/classes/menus.gd"

signal tutorial_closed


func _init() -> void:
	is_submenu = true


func _on_go_back_pressed() -> void:
	tutorial_closed.emit()
