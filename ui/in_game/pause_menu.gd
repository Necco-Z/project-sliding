extends "res://scripts/classes/menus.gd"

signal resume_pressed
signal restart_pressed
signal exit_pressed

@onready var buttons = %Buttons as HBoxContainer
@onready var coins_label = %CoinLabel as Label


var focused = false


func _input(event):
	if is_visible():
		if event is InputEventMouseMotion:
			for i in buttons.get_children():
				i.release_focus()
			focused = false
		elif event is InputEventJoypadButton and !focused:
			print("Olá")
			$MainContainer/Buttons/ResumeButton.grab_focus()
			focused = true


func set_connections(game_scene: Node) -> void:
	resume_pressed.connect(game_scene._on_resume_pressed)
	restart_pressed.connect(game_scene._on_restart_pressed)
	exit_pressed.connect(game_scene._on_return_pressed)
	ScoreData.coins_updated.connect(update_coins)


func show_menu(instant := false) -> void:
	super.show_menu(instant)
	buttons.visible = true
	if Input.get_connected_joypads().size() > 0:
		$MainContainer/Buttons/ResumeButton.grab_focus()
		focused = true


func hide_menu(instant := false) -> void:
	super.hide_menu(instant)
	buttons.visible = false


func update_coins(value: int) -> void:
	coins_label.text = str(value)

func _on_exit_button_pressed():
	hide_menu(false)
	exit_pressed.emit()


func _on_resume_button_pressed() -> void:
	hide_menu(false)
	resume_pressed.emit()


func _on_restart_button_pressed() -> void:
	hide_menu(false)
	restart_pressed.emit()
