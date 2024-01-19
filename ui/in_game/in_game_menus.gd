extends CanvasLayer

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
func set_connections(game_scene: Node) -> void:
	for i in get_children():
		i.set_connections(game_scene)


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


func start_countdown() -> void:
	game_hud.start_countdown()


func add_prank(score := 0, text := "") -> void:
	game_hud.add_prank(score, text)
