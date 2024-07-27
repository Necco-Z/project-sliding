extends "res://scripts/classes/menus.gd"

signal start_pressed
signal return_pressed


@onready var buttons := %MenuButtons as Control


var focused = false


func _input(event):
	if is_visible():
		if event is InputEventMouseMotion:
			for i in buttons.get_children():
				i.release_focus()
			focused = false
		elif event is InputEventJoypadButton and !focused:
			%StartButton3.grab_focus()
			focused = true


func show_menu(instant := false) -> void:
	if instant:
		$ColorRect.modulate = Color(1,1,1,0.7)
	else:
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property($ColorRect, "modulate", Color(1,1,1,1), 0.2)
		await t.finished
	super.show_menu(instant)
	buttons.visible = true
	if Input.get_connected_joypads().size() > 0:
		%StartButton3.grab_focus()
		focused = true


func hide_menu(instant := false) -> void:
	if instant:
		$ColorRect.modulate = Color(1,1,1,0)
	else:
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		t.tween_property($ColorRect, "modulate", Color(1,1,1,0), 0.2)
		await t.finished
	super.hide_menu(instant)
	buttons.visible = false


func set_connections(game_scene: Node) -> void:
	start_pressed.connect(game_scene._on_start_pressed)
	return_pressed.connect(game_scene._on_return_pressed)


func _on_start_button_pressed() -> void:
	start_pressed.emit()


func _on_return_button_pressed() -> void:
	return_pressed.emit()
