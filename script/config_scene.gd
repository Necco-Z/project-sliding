extends Node


var main_menu
var graphic_button


func _ready():
	main_menu = load("res://scenes/teste de menu.tscn")

	if get_name() == "ConfigScene":
		graphic_button = get_node("Control/PanelContainer/VBoxContainer/GraphicButton")
		if get_viewport().get_msaa_3d() == Viewport.MSAA_4X:
			graphic_button.set_pressed(true)
		elif get_viewport().get_msaa_3d() == Viewport.MSAA_DISABLED:
			graphic_button.set_pressed(false)


func return_to_main_menu():
	get_tree().change_scene_to_packed(main_menu)


func change_graphic_quality():
	if graphic_button.is_pressed():
		get_viewport().set_msaa_3d(Viewport.MSAA_4X)
	elif !graphic_button.is_pressed():
		get_viewport().set_msaa_3d(Viewport.MSAA_DISABLED)
