extends "res://scripts/classes/menus.gd"

signal start_pressed
signal return_pressed


@onready var buttons := %MenuButtons as Control


func _ready() -> void:
	pass
	#anchor_left = -1
	#anchor_right = 0


func show_menu(instant := false) -> void:
	super.show_menu(instant)
	buttons.visible = true
	%StartButton3.grab_focus()


func hide_menu(instant := false) -> void:
	super.hide_menu(instant)
	buttons.visible = false


func set_connections(game_scene: Node) -> void:
	start_pressed.connect(game_scene._on_start_pressed)
	return_pressed.connect(game_scene._on_return_pressed)


func _on_start_button_pressed() -> void:
	start_pressed.emit()


func _on_return_button_pressed() -> void:
	return_pressed.emit()
