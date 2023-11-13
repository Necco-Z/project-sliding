extends Node

var coins := 0

@onready var game_menus := $GameMenus as CanvasLayer

# Variáveis para refatorar
@onready var character := $Jogador as CharacterBody3D
@onready var camera := $Camera3D as Camera3D
@onready var node_enabler_detector := $NodeEnablerDetector as Node3D
@onready var punctuation_handler := $Handlers/PunctuationHandler as Node


### Funções herdadas (_init, _ready e outras)
func _ready() -> void:
	pass


### Funções públicas
func connect_coin(coin: Area3D) -> void:
	coin.coin_collected.connect(_on_coin_collected)


func connect_obstacle(obstacle: StaticBody3D) -> void:
	obstacle.player_collided.connect(_on_player_collided)


# Funções para refatorar
func pause_components() -> void:
	character.end_game()
	camera.end_game()
	node_enabler_detector.end_game()
	punctuation_handler.stop_game()


func start_components() -> void:
	character.begin_game()
	camera.begin_game()
	node_enabler_detector.begin_game()
	punctuation_handler.start_game()


func _on_pause_pressed() -> void:
	game_menus.change_menu("PauseMenu")
	pause_components()


func _on_start_pressed():
	game_menus.change_menu("GameHUD")
	start_components()


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


func _on_coin_collected() -> void:
	Score.add_coins()
	game_menus.update_coins(Score.coins)


func _on_player_collided() -> void:
	print("Game ended")
