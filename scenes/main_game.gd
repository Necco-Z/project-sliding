extends Node

var is_running := false :
	set = _set_running

@onready var game_menus := $GameMenus as CanvasLayer

# Variáveis para refatorar
@onready var player := $Player as CharacterBody3D
@onready var camera := $Camera3D as Camera3D
@onready var node_enabler_detector := $NodeEnablerDetector as Node3D


### Funções herdadas (_init, _ready e outras)
func _ready() -> void:
	ScoreData.coins_updated.connect(game_menus.update_coins)
	ScoreData.score_updated.connect(game_menus.update_score)


### Funções públicas
func connect_coin(coin: Area3D) -> void:
	coin.coin_collected.connect(_on_coin_collected)


func connect_obstacle(obstacle: StaticBody3D) -> void:
	obstacle.player_collided.connect(_on_player_collided)
	if obstacle.has_signal("prank_executed"):
		obstacle.prank_executed.connect(_on_prank_executed)


func start_game() -> void:
	ScoreData.reset_data()
	game_menus.start_countdown()


# Funções para refatorar
func pause_components() -> void:
	player.end_game()
	camera.end_game()
	node_enabler_detector.end_game()
	ScoreData.pause_score_timer()


func start_components() -> void:
	player.begin_game()
	camera.begin_game()
	node_enabler_detector.begin_game()
	ScoreData.start_score_timer()


# Funções setter
func _set_running(value: bool) -> void:
	is_running = value
	if value == true:
		start_components()
	else:
		pause_components()


# Funções de sinal
func _on_pause_pressed() -> void:
	game_menus.change_menu("PauseMenu")
	is_running = false


func _on_start_pressed():
	game_menus.change_menu("GameHUD")
	game_menus.start_countdown()


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/como jogar.tscn")) # Revisar depois


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/credits_scene.tscn")) # Revisar depois


func _on_configs_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://scenes/config_scene.tscn")) # Revisar depois


func _on_exit_pressed():
	get_tree().quit()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_resume_pressed() -> void:
	game_menus.change_menu("GameHUD")
	is_running = true


func _on_coin_collected() -> void:
	ScoreData.add_coins()


func _on_player_collided() -> void:
	pause_components()
	game_menus.change_menu("EndGame")


func _on_prank_executed(prank_score := 0, desc := "") -> void:
	ScoreData.score += prank_score
	game_menus.add_prank(prank_score, desc)


func _on_countdown_finished() -> void:
	is_running = true
