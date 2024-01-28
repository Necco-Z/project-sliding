extends "res://scripts/classes/menus.gd"

signal resume_pressed
signal restart_pressed

@onready var buttons = %Buttons as HBoxContainer
@onready var coins_label = %CoinLabel as Label


func set_connections(game_scene: Node) -> void:
	resume_pressed.connect(game_scene._on_resume_pressed)
	restart_pressed.connect(game_scene._on_restart_pressed)
	ScoreData.coins_updated.connect(update_coins)


func show_menu(instant := false) -> void:
	super.show_menu(instant)
	buttons.visible = true
	%RestartButton.grab_focus()


func hide_menu(instant := false) -> void:
	super.hide_menu(instant)
	buttons.visible = false


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func _on_resume_button_pressed() -> void:
	resume_pressed.emit()


func _on_restart_button_pressed() -> void:
	restart_pressed.emit()
