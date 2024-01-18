extends "res://scripts/classes/menus.gd"

signal restart_pressed

const BAR_FILL_DURATION = 1.0

@onready var obj1_bar = %Obj1Bar as ProgressBar
@onready var obj2_bar = %Obj2Bar as ProgressBar
@onready var coins_label = %CoinsLabel as Label
@onready var score_label = %ScoreLabel as Label


func show_menu(_instant := false) -> void:
	super.show_menu(false)
	var obj1_value = min(ScoreData.coins / 50.0, 1.0)
	var obj2_value = min(ScoreData.prank_total / 15.0, 1.0)
	var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_parallel()
	t.tween_property(obj1_bar, "value", obj1_value, BAR_FILL_DURATION)
	t.tween_property(obj2_bar, "value", obj2_value, BAR_FILL_DURATION)
	await t.finished
	if obj1_value == 1:
		ScoreData.score += 5000
	if obj2_value == 1:
		ScoreData.score += 5000


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func update_score(value: int) -> void:
	score_label.text = str(value)


func _on_restart_game_pressed() -> void:
	restart_pressed.emit()
