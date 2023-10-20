extends Node


var character
var camera
var node_enabler_detector
var punctuation_handler

var in_game_ui
var start_menu_ui
var end_game_ui
var pause_menu_ui

var animation_player

var como_jogar_scene = load("res://scenes/como jogar.tscn")
var config_scene = load("res://scenes/config_scene.tscn")
var credits_scene = load("res://scenes/credits_scene.tscn")

#var main_scene = preload("res://scenes/teste de menu.tscn")
#var run_scene = preload("res://scenes/run_scene.tscn")


func _ready():
	character = get_tree().get_nodes_in_group("player")[0]
	camera = get_tree().get_nodes_in_group("main_camera")[0]
	node_enabler_detector = get_tree().get_nodes_in_group("main_camera")[1]
	punctuation_handler = get_tree().get_nodes_in_group("handlers")[0]

	in_game_ui = get_tree().get_nodes_in_group("ui")[0]
	start_menu_ui = get_tree().get_nodes_in_group("ui")[1]
	end_game_ui = get_tree().get_nodes_in_group("ui")[2]
	pause_menu_ui = get_tree().get_nodes_in_group("ui")[3]

	animation_player = get_tree().get_nodes_in_group("animation_player")[0]
	animation_player.play("show_start_menu")


func start_button_pressed():
	in_game_ui.set_visible(true)
	start_menu_ui.set_visible(false)
	start_game_components()


func pause_button_pressed():
	pause_game_components()
	in_game_ui.set_visible(false)
	pause_menu_ui.set_visible(true)
	animation_player.play("show_pause_menu")


func unpause_button_pressed():
	animation_player.play("hide_pause_menu")

func unpause_button_pressed_animation_ended(animation_name):
	if !animation_name == "hide_pause_menu":
		return

	start_game_components()
	in_game_ui.set_visible(true)
	pause_menu_ui.set_visible(false)


func return_to_main_menu_pressed(menu = null):
	if menu == null:
		get_tree().reload_current_scene()
	elif menu == "pause_menu":
		animation_player.play("pause_menu_to_start")
	elif menu == "end_menu":
		animation_player.play("hide_end_menu")


func return_to_main_menu_animation_ended(animation_name = null):
	if animation_name == "pause_menu_to_start" or animation_name == "hide_end_menu":
		get_tree().reload_current_scene()


func restart_level_progress():
	restart_game_components()
	in_game_ui.set_visible(true)
	pause_menu_ui.set_visible(false)
	start_game_components()


func end_game(body = null):
	animation_player.play("show_end_menu")
	pause_game_components()
	punctuation_handler.result_score()
	in_game_ui.set_visible(false)
	end_game_ui.set_visible(true)


func start_game_components():
	character.begin_game()
	camera.begin_game()
	node_enabler_detector.begin_game()
	punctuation_handler.start_game()


func pause_game_components():
	character.end_game()
	camera.end_game()
	node_enabler_detector.end_game()
	punctuation_handler.stop_game()


func restart_game_components():
	get_tree().reload_current_scene()
	#get_tree().change_scene_to_packed(run_scene)



func como_jogar_pressed():
	get_tree().change_scene_to_packed(como_jogar_scene)


func exit_button_pressed():
	get_tree().quit()


func credits_button_pressed():
	get_tree().change_scene_to_packed(credits_scene)


func config_button_pressed():
	get_tree().change_scene_to_packed(config_scene)
