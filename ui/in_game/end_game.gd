extends "res://scripts/classes/menus.gd"

signal restart_pressed
signal return_pressed

@export var screen_title: String

#@onready var coins_label = %CoinsLabel as Label
@onready var star_counter = %StarContainer as HBoxContainer
@onready var coins_label = %CoinLabel as Label
@onready var buttons = $MainContainer/Buttons as HBoxContainer


var focused


func _input(event):
	if is_visible():
		if event is InputEventMouseMotion:
			for i in buttons.get_children():
				i.release_focus()
			focused = false
		elif event is InputEventJoypadButton and !focused:
			%RestartGame.grab_focus()
			focused = true


func set_connections(game_scene: Node) -> void:
	restart_pressed.connect(game_scene._on_restart_pressed)
	return_pressed.connect(game_scene._on_return_pressed)
	$MainContainer/Title.text = screen_title
	ScoreData.coins_updated.connect(update_coins)


func show_menu(_instant := false) -> void:
	super.show_menu(false)
	buttons.visible = true
	if Input.get_connected_joypads().size() > 0:
		%RestartGame.grab_focus()
		focused = true


func hide_menu(_instant := false) -> void:
	super.hide_menu()
	buttons.visible = false


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func _on_restart_game_pressed() -> void:
	restart_pressed.emit()


func _on_return_game_pressed() -> void:
	return_pressed.emit()
