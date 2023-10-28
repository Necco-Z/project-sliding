extends CanvasLayer

signal pause_pressed
signal start_pressed
signal tutorial_pressed
signal credits_pressed
signal configs_pressed
signal exit_pressed
signal restart_pressed

var current_menu: Control

@onready var game_hud := $GameHUD as Control
@onready var start_menu := $StartMenu as Control
@onready var end_game := $EndGame as Control
@onready var pause_menu := $PauseMenu as Control


### Funções públicas
func change_menu(to: String) -> void:
	for i in get_children():
		if i is Control and i.name == to:
			current_menu.hide_menu()
			i.show_menu()
			return

	printerr("Não existe menu chamado \"", to, "\"")


### Funções de repasse aos menus
# GameHUD
func hud_update_score(value: int) -> void:
	game_hud.update_score(value)


func hud_update_coins(value: int) -> void:
	game_hud.update_coins(value)


func _on_pause_pressed() -> void:
	pause_pressed.emit()


# StartMenu
func _on_configs_pressed() -> void:
	configs_pressed.emit()


func _on_credits_pressed() -> void:
	credits_pressed.emit()


func _on_exit_pressed() -> void:
	exit_pressed.emit()


func _on_start_pressed() -> void:
	start_pressed.emit()


func _on_tutorial_pressed() -> void:
	tutorial_pressed.emit()


# EndGame
func end_update_coins(value: int) -> void:
	end_game.update_coins(value)


func end_update_score(value: int) -> void:
	end_game.update_score(value)


func _on_end_game_restart_pressed() -> void:
	restart_pressed.emit()
