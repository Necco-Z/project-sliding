extends "res://scripts/classes/menus.gd"

signal restart_pressed
signal return_pressed
signal next_level

@export var screen_title: String

#@onready var coins_label = %CoinsLabel as Label
@onready var star_counter = %StarContainer as HBoxContainer
@onready var coins_label = %CoinLabel as Label
@onready var buttons = $MainContainer/Buttons as HBoxContainer


var focused


func _ready():
	for star in star_counter.get_children():
		star.get_child(0).set_scale(Vector2.ZERO)
		star.get_child(0).set_pivot_offset(star.get_child(0).get_size() / 2)
		


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
	next_level.connect(game_scene._on_next_pressed)
	$MainContainer/Title.text = screen_title
	ScoreData.coins_updated.connect(update_coins)


func show_menu(_instant := false) -> void:
	if screen_title == "Derrota":
		$MainContainer/Buttons/NextLevel.set_visible(false)
		$MainContainer/StarContainer.set_visible(false)
	
	super.show_menu(false)
	buttons.visible = true
	
	await get_tree().create_timer(0.4).timeout
	
	
	var tween = create_tween()
	for star in star_counter.get_children():
		tween.tween_property(star.get_child(0), "scale", Vector2.ONE, 0.3)
	
	if Input.get_connected_joypads().size() > 0:
		%RestartGame.grab_focus()
		focused = true


func hide_menu(_instant := false) -> void:
	super.hide_menu()
	buttons.visible = false


func update_coins(value: int) -> void:
	coins_label.text = str(value)


func _on_restart_game_pressed() -> void:
	hide_menu(false)
	restart_pressed.emit()


func _on_return_game_pressed() -> void:
	hide_menu(false)
	return_pressed.emit()


func _next_level_pressed():
	hide_menu(false)
	next_level.emit()
