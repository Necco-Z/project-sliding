extends "res://scripts/classes/menus.gd"

signal pause_pressed

@onready var score_label := $ScoreBox/Container/Score as Label
@onready var coins_label := $CoinsBox/Container/Coins as Label
@onready var countdown := $Countdown as Label


func show_menu() -> void:
	visible = true


func hide_menu() -> void:
	visible = false


func update_score(value: int) -> void:
	score_label.text = str(value)


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func _on_pause_button_pressed() -> void:
	pause_pressed.emit()
