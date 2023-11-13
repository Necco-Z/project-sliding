extends "res://scripts/classes/menus.gd"

signal restart_pressed

@onready var obj1_bar = %Obj1Bar as ProgressBar
@onready var obj2_bar = %Obj2Bar as ProgressBar
@onready var coins_label = %CoinsLabel as Label
@onready var score_label = %ScoreLabel as Label


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func update_score(value: int) -> void:
	score_label.text = str(value)


func _on_restart_game_pressed() -> void:
	restart_pressed.emit()
