extends Control


var main_menu_scene = load("res://scenes/teste de menu.tscn")

func return_main_menu():
	get_tree().change_scene_to_packed(main_menu_scene)
