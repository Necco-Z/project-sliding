extends Node

const MAIN_MENU = "res://ui/main_menu.tscn"

@export_node_path("CharacterBody3D") var player_node
@export var replacers: Array[ReplaceItem]

var is_running := false:
	set = _set_running

@onready var player := get_node(player_node) as CharacterBody3D
@onready var game_menus := $InGameMenus as CanvasLayer
@onready var floors := $Floors as Node3D


### Funções herdadas (_init, _ready e outras)
func _ready() -> void:
	Fader.fade_in()
	game_menus.set_connections(self)
	_replace_all_items()


### Funções públicas
func start_game() -> void:
	ScoreData.reset_data() # TODO: retirar essa chamada
	game_menus.start_countdown()


### Funções privadas
func _replace_all_items() -> void:
	var all_floors = floors.get_children()
	for r in replacers:
		for f in all_floors:
			f.replace_on_grid(r.name, r.replace_file)


# Setters e getters
func _set_running(value: bool) -> void:
	is_running = value
	player.can_control = value


# Funções de sinal
func _on_pause_pressed() -> void:
	game_menus.change_menu("PauseMenu")
	is_running = false


func _on_start_pressed():
	game_menus.change_menu("GameHUD")
	game_menus.start_countdown()


func _on_return_pressed():
	Fader.fade_out()
	await Fader.fade_finished
	get_tree().change_scene_to_file(MAIN_MENU)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_resume_pressed() -> void:
	game_menus.change_menu("GameHUD")
	is_running = true


func _on_coin_collected() -> void:
	ScoreData.add_coins()


func _on_player_collided() -> void:
	game_menus.change_menu("EndGame")


func _on_prank_executed(prank_score := 0, desc := "") -> void:
	ScoreData.prank_total += 1
	ScoreData.score += prank_score
	game_menus.add_prank(prank_score, desc)


func _on_countdown_finished() -> void:
	is_running = true


func _on_end_flag_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		is_running = false
		game_menus.change_menu("EndGame")
