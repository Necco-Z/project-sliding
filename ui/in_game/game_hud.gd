extends "res://scripts/classes/menus.gd"

signal pause_pressed
signal countdown_finished

var prank_scene = preload("res://ui/prank.tscn")

@onready var coins_label := %CoinsLabel as Label
@onready var pranks_container := %PranksContainer as Control
@onready var star_counter := %StarContainer as HBoxContainer
@onready var countdown := %Countdown as Label
@onready var timer := $Timer as Timer


func _process(_delta: float) -> void:
	if not timer.is_stopped():
		countdown.text = "%d" % min(3, timer.time_left + 1)


func set_connections(game_scene: Node) -> void:
	pause_pressed.connect(game_scene._on_pause_pressed)
	countdown_finished.connect(game_scene._on_countdown_finished)
	ScoreData.coins_updated.connect(_on_coins_updated)


func show_menu(_instant := true) -> void:
	super.show_menu(true)


func hide_menu(_instant := true) -> void:
	super.hide_menu(true)


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func add_prank(score, text) -> void:
	var p = prank_scene.instantiate()
	pranks_container.add_label(p)
	p.start_anim("+" + str(score) + " " + text)


func start_countdown() -> void:
	countdown.visible = true
	timer.start()


func _on_coins_updated(value: int) -> void:
	coins_label.text = str(value)


func _on_object_achieved() -> void:
	star_counter.value += 1


func _on_pause_button_pressed() -> void:
	pause_pressed.emit()


func _on_timer_timeout() -> void:
	countdown.visible = false
	countdown_finished.emit()
