extends Control

@export_file("*.tscn") var game_scene_path

var game_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Fader.fade_in()
	ResourceLoader.load_threaded_request(game_scene_path)


func _on_start_button_pressed() -> void:
	Fader.fade_out()
	await Fader.fade_finished
	game_scene = ResourceLoader.load_threaded_get(game_scene_path)
	get_tree().change_scene_to_packed(game_scene)
