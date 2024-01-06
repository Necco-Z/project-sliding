extends Node

var extra_screen: Node

@onready var menus = $GameMenus


func _on_start_pressed() -> void:
	menus.change_menu("GameHUD")
	menus.start_countdown()


func _on_resume_pressed() -> void:
	menus.change_menu("GameHUD")


func _on_restart_pressed() -> void:
	menus.change_menu("StartMenu")


func _on_pause_pressed() -> void:
	print("Pause pressed")
	menus.change_menu("PauseMenu")


func _on_credits_pressed() -> void:
	print("Credits pressed")


func _on_countdown_finished() -> void:
	menus.change_menu("EndGame")


func _on_configs_pressed() -> void:
	print("Configs pressed")


func _on_tutorial_pressed() -> void:
	if extra_screen:
		extra_screen.queue_free()
	extra_screen = load("res://scenes/como jogar.tscn").instantiate()
	menus.add_child(extra_screen)


func _on_exit_pressed() -> void:
	get_tree().quit()
