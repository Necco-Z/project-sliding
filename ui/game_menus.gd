extends CanvasLayer

signal pause_pressed
signal start_pressed
signal exit_pressed
signal restart_pressed
signal resume_pressed
signal countdown_finished

var current_menu: Control
var current_submenu: Control

@onready var game_hud := $GameHUD as Control
@onready var end_game := $EndGame as Control
@onready var pause_menu := $PauseMenu as Control


### Funções básicas
func _ready() -> void:
	for i in get_children():
		if i is Control:
			i.hide_menu(true)
	change_menu("StartMenu", true)


### Funções públicas
func change_menu(to: String, instant := false) -> void:
	if current_menu and current_menu.name == to:
		return
	for i in get_children():
		if i is Control and i.name == to:
			if current_menu:
				current_menu.hide_menu(instant)
			i.show_menu(instant)
			current_menu = i
			return

	printerr("Não existe menu chamado \"", to, "\"")


func open_submenu(submenu: String, instant := false) -> void:
	for i in get_children():
		if i is Control and i.name == submenu and i.is_submenu:
			i.show_menu(instant)
			current_submenu = i
			return

	printerr("Nenhum submenu chamado \"" + submenu + "\"")


func close_submenu(instant := false) -> void:
	if current_submenu:
		current_submenu.hide_menu(instant)
	else:
		printerr("Nenhum submenu aberto")


func update_coins(value: int) -> void:
	game_hud.update_coins(value)
	end_game.update_coins(value)
	pause_menu.update_coins(value)


func update_score(value: int) -> void:
	game_hud.update_score(value)
	end_game.update_score(value)
	pause_menu.update_score(value)


func start_countdown() -> void:
	game_hud.start_countdown()


func add_prank(score := 0, text := "") -> void:
	game_hud.add_prank(score, text)


### Funções de sinal dos menus
# GameHUD
func _on_pause_pressed() -> void:
	pause_pressed.emit()


func _on_countdown_finished() -> void:
	countdown_finished.emit()


# StartMenu
func _on_exit_pressed() -> void:
	exit_pressed.emit()


func _on_start_pressed() -> void:
	start_pressed.emit()


func _on_tutorial_closed() -> void:
	close_submenu()


# EndGame
func _on_restart_pressed() -> void:
	restart_pressed.emit()


# PauseMenu
func _on_resume_pressed() -> void:
	resume_pressed.emit()
