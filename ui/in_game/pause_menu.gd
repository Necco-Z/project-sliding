extends "res://scripts/classes/menus.gd"

signal resume_pressed
signal restart_pressed

@onready var coins_label := %CoinsLabel as Label
@onready var score_label := %ScoreLabel as Label


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func update_score(value: int) -> void:
	score_label.text = str(value)


func _on_resume_button_pressed() -> void:
	resume_pressed.emit()


func _on_restart_button_pressed() -> void:
	restart_pressed.emit()
