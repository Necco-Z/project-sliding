extends "res://scripts/classes/menus.gd"

signal restart_pressed
signal return_pressed

@export var screen_title: String

#@onready var coins_label = %CoinsLabel as Label
@onready var star_counter = %StarContainer as HBoxContainer


func set_connections(game_scene: Node) -> void:
	restart_pressed.connect(game_scene._on_restart_pressed)
	return_pressed.connect(game_scene._on_return_pressed)
	$MainContainer/Title.text = screen_title
	#ScoreData.coins_updated.connect(update_coins)


func show_menu(_instant := false) -> void:
	super.show_menu(false)


func update_coins(_value: int) -> void:
	pass
	#coins_label.text = str(value)


func _on_restart_game_pressed() -> void:
	restart_pressed.emit()


func _on_return_game_pressed() -> void:
	return_pressed.emit()
