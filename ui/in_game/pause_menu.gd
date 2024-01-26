extends "res://scripts/classes/menus.gd"

signal resume_pressed
signal restart_pressed


func set_connections(game_scene: Node) -> void:
	resume_pressed.connect(game_scene._on_resume_pressed)
	restart_pressed.connect(game_scene._on_restart_pressed)
	#ScoreData.coins_updated.connect(update_coins)


func update_coins(_value: int) -> void:
	pass
	#coins_label.text = str(value)


func _on_resume_button_pressed() -> void:
	resume_pressed.emit()


func _on_restart_button_pressed() -> void:
	restart_pressed.emit()
